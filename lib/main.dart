import 'package:n3/pages/login.dart';
import 'package:n3/controller/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:n3/repositories/times_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:n3/routes/app_routes.dart';
import 'pages/home_page.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());

  runApp(ChangeNotifierProvider(
    create: (context) => TimesRepository(),
    child: const MeuAplicativo(),
  ));
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();

    return GetMaterialApp(
      title: 'Brasileirão',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.grey,
        colorScheme: const ColorScheme.dark(
          primary: Colors.grey, // Cor primária para tema escuro
          secondary: Colors.purple, // Cor secundária para tema escuro
          surface: Colors.black, // Superfície para tema escuro
          onSurface: Colors.white, // Cor do texto na superfície escura
        ),
      ),
      routes: {
        AppRoutes.LOGIN: (_) => const Login(),
        AppRoutes.HOME: (_) => const HomePage(),
      },
    );
  }
}
