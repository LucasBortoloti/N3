import 'package:n3/controller/theme.controller.dart';
import 'package:n3/pages/time_page.dart';
import 'package:n3/repositories/times_repository.dart';
import 'package:n3/widgets/brasao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'home_controller.dart';
import '../models/time.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var controller = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Consumer<TimesRepository>(builder: (context, repositorio, child) {
          return repositorio.loading.value
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    Text(' Atualizando'),
                  ],
                )
              : const Text('Tabela Brasileirão');
        }),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Obx(() => controller.isDark.value
                      ? const Icon(Icons.brightness_7)
                      : const Icon(Icons.brightness_2)),
                  title: Obx(() => controller.isDark.value
                      ? const Text('Light')
                      : const Text('Dark')),
                  onTap: () => controller.changeTheme(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<TimesRepository>(builder: (context, repositorio, child) {
        return RefreshIndicator(
            child: ListView.separated(
              itemCount: repositorio.times.length,
              // ignore: non_constant_identifier_names
              itemBuilder: (BuildContext BuildContext, int time) {
                final List<Time> tabela = repositorio.times;
                return ListTile(
                  leading: Brasao(
                    image: tabela[time].brasao,
                    width: 50,
                    key: UniqueKey(),
                  ),
                  title: Text(tabela[time].nome),
                  subtitle: Text('Títulos: ${tabela[time].titulos.length}'),
                  trailing: Text(tabela[time].pontos.toString()),
                  onTap: () {
                    Get.to(() => TimePage(
                          key: Key(tabela[time].nome),
                          time: tabela[time],
                        ));
                  },
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              padding: const EdgeInsets.all(16),
            ),
            onRefresh: () => repositorio.updateTabela());
      }),
    );
  }
}
