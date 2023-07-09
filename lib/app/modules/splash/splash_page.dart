import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app_module.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();

    return info.version;
  }

  Future<void> _startSplashPage() async {
    await Future.wait([
      Modular.isModuleReady<AppModule>(),
      Future.delayed(const Duration(seconds: 5)),
    ]).then(
      (value) => Modular.to.navigate('/myapplication/'),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.height * 0.6,
                    width: size.width * 0.8,
                    child: Image.asset(
                      'assets/images/ifpr.png',
                      fit: BoxFit.contain,
                    ),
                    // child: Lottie.asset(
                    //   'assets/animations/144509-ese-loading-website.json',
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Lottie.asset(
                      'assets/animations/144136-loading-animation-horizen.json',
                      fit: BoxFit.contain,
                      height: size.height * 0.15,
                      repeat: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FutureBuilder<String>(
                      future: _getVersion(),
                      builder: (context, snapshot) {
                        var verInfo = '';
                        if (snapshot.hasData) {
                          verInfo = 'v ${snapshot.data}';
                        }

                        return Container(
                          margin: EdgeInsets.only(top: size.height * 0.05),
                          child: Text(
                            verInfo,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
