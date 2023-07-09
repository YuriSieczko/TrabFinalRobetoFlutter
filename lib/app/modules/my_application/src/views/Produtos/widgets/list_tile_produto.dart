import 'package:flutter/material.dart';
import '../produto.dart';

class ListTileProduto extends StatelessWidget {
  final Produto produto;
  final bool isComprado;
  final Function showModal;
  final Function iconClick;

  const ListTileProduto({
    super.key,
    required this.produto,
    required this.isComprado,
    required this.showModal,
    required this.iconClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModal(model: produto);
      },
      leading:IconButton(
        onPressed: () {
          iconClick(produto);
        },
        icon: Icon(
          (isComprado) ? Icons.shopping_basket : Icons.check,
        ),
      ),
      title: Text(
        (produto.amount == null)
            ? produto.name
            : "${produto.name} (x${produto.amount!.toInt()})",
      ),
      subtitle: Text(
        (produto.price == null)
            ? "Clique para adicionar preço"
            : "R\$ ${produto.price!}",
      ),
    );
  }
}
