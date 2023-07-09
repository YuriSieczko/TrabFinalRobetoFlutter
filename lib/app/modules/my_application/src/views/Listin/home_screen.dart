import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/Produtos/produto_screen.dart';
import 'package:uuid/uuid.dart';
import 'listin.dart';
import 'listin_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Listin> listListins = [];

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  ListinService listinService = ListinService();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listin - Feira Colaborativa"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormModal();
        },
        child: const Icon(Icons.add),
      ),
      body: (listListins.isEmpty)
          ? const Center(
              child: Text(
                "Nenhuma lista ainda.\nVamos criar a primeira?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          //atualizar page puxando tela para baixo
          : RefreshIndicator(
              onRefresh: () {
                return refresh();
              },
              child: ListView(
                children: List.generate(
                  listListins.length,
                  (index) {
                    Listin model = listListins[index];
                    //arrastar para o lado para excluir as listas do bd
                    return Dismissible(
                      key: ValueKey<Listin>(model),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8.0),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        remove(model);
                      },
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProdutoScreen(listin: model)),
                          );
                        },
                        onLongPress: () {
                          showFormModal(model: model);
                        },
                        leading: const Icon(Icons.list_alt_rounded),
                        title: Text(model.name),
                        subtitle: Text(model.id),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  showFormModal({Listin? model}) {
    // Labels à serem mostradas no Modal
    String labelTitle = "Adicionar Listin";
    String labelConfirmationButton = "Salvar";
    String skipButton = "Cancelar";

    // Controlador do campo que receberá o nome do Listin
    TextEditingController nameController = TextEditingController();
    // caso esteja editando
    if (model != null) {
      labelTitle = "Editando ${model.name}";
      nameController.text = model.name;
    }
    // Função do Flutter que mostra o modal na tela
    showModalBottomSheet(
      context: context,

      // Define que as bordas verticais serão arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32.0),

          // Formulário com Título, Campo e Botões
          child: ListView(
            children: [
              Text(labelTitle,
                  style: Theme.of(context).textTheme.headlineSmall),
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(label: Text("Nome do Listin")),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(skipButton),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //criar objeto
                      //
                      Listin listin = Listin(
                        id: const Uuid().v1(),
                        name: nameController.text,
                      );

                      // Usar id do model
                      if (model != null) {
                        listin.id = model.id;
                      }

                      // Salvar no Firestore
                      listinService.adicionarListin(listin: listin);

                      // Atualizar a lista
                      refresh();

                      // Fechar o Modal
                      Navigator.pop(context);
                    },
                    child: Text(labelConfirmationButton),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // refresh() async {
  //   List<Listin> temp = [];

  //   QuerySnapshot<Map<String, dynamic>> snapshot =
  //       await firestore.collection("listins").get();

  //   for (var doc in snapshot.docs) {
  //     temp.add(Listin.fromMap(doc.data()));
  //   }

  //   setState(() {
  //     listListins = temp;
  //   });
  // }

  // void remove(Listin model) {
  //   firestore.collection('listins').doc(model.id).delete();
  //   refresh();
  // }

  refresh() async {
    List<Listin> listaListins = await listinService.lerListins();
    setState(() {
      listListins = listaListins;
    });
  }

  void remove(Listin model) async {
    await listinService.removerListin(listinId: model.id);
    refresh();
  }
}
