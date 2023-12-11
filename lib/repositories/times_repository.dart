import 'dart:collection';
import 'dart:convert';
// ignore: unused_import
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/time.dart';
import '../models/titulo.dart';
import 'package:n3/database/db.dart';
import 'package:http/http.dart' as http;

class TimesRepository extends ChangeNotifier {
  final List<Time> _times = [];
  final loading = ValueNotifier(false);

  // ignore: unnecessary_this
  UnmodifiableListView<Time> get times => UnmodifiableListView(_times);

  Future<void> addTitulo({required Time time, required Titulo titulo}) async {
    var db = await DB.get();
    int id = await db.insert('titulos', {
      'campeonato': titulo.campeonato,
      'ano': titulo.ano,
      'time_id': time.id
    });
    titulo.id = id;
    time.titulos.add(titulo);
    notifyListeners();
  }

  void editTitulo(
      {required Titulo titulo,
      required String ano,
      required String campeonato}) async {
    var db = await DB.get();
    await db.update(
      'titulos',
      {'campeonato': campeonato, 'ano': ano},
      where: 'id = ?',
      whereArgs: [titulo.id],
    );

    titulo.campeonato = campeonato;
    titulo.ano = ano;
    notifyListeners();
  }

  static setupTimes() {
    return [
      Time(
        nome: 'Palmeiras',
        pontos: 0,
        brasao: 'assets/images/palmeiras.png',
        cor: const Color.fromARGB(255, 2, 94, 43),
        titulos: [],
        idAPI: 56,
      ),
      Time(
        nome: 'Grêmio',
        pontos: 0,
        brasao: 'assets/images/gremio.png',
        cor: const Color.fromARGB(255, 5, 136, 217),
        titulos: [],
        idAPI: 45,
      ),
      Time(
        nome: 'Atletico Mineiro',
        pontos: 0,
        brasao: 'assets/images/mineiro.png',
        cor: const Color.fromARGB(255, 0, 0, 0),
        titulos: [],
        idAPI: 30,
      ),
      Time(
        nome: 'Flamengo',
        pontos: 0,
        brasao: 'assets/images/flamengo.png',
        cor: const Color.fromARGB(255, 172, 5, 5),
        titulos: [],
        idAPI: 18,
      ),
      Time(
        nome: 'Botafogo',
        pontos: 0,
        brasao: 'assets/images/botafogo.png',
        cor: const Color.fromARGB(255, 0, 0, 0),
        titulos: [],
        idAPI: 22,
      ),
      Time(
        nome: 'Bragantino',
        pontos: 0,
        brasao: 'assets/images/braga.png',
        cor: const Color.fromARGB(255, 123, 119, 119),
        titulos: [],
        idAPI: 64,
      ),
      Time(
        nome: 'Fluminense',
        pontos: 0,
        brasao: 'assets/images/flu.png',
        cor: const Color.fromARGB(255, 2, 94, 43),
        titulos: [],
        idAPI: 26,
      ),
      Time(
        nome: 'Athletico Paranaense',
        pontos: 0,
        brasao: 'assets/images/pr.png',
        cor: const Color.fromARGB(255, 172, 5, 5),
        titulos: [],
        idAPI: 185,
      ),
      Time(
        nome: 'Internacional',
        pontos: 0,
        brasao: 'assets/images/inter.png',
        cor: const Color.fromARGB(255, 172, 5, 5),
        titulos: [],
        idAPI: 44,
      ),
      Time(
        nome: 'Fortaleza',
        pontos: 0,
        brasao: 'assets/images/leao.png',
        cor: const Color.fromARGB(255, 5, 136, 217),
        titulos: [],
        idAPI: 131,
      ),
      Time(
        nome: 'São Paulo',
        pontos: 0,
        brasao: 'assets/images/spfc.png',
        cor: const Color.fromARGB(255, 172, 5, 5),
        titulos: [],
        idAPI: 57,
      ),
      Time(
        nome: 'Cuiabá',
        pontos: 0,
        brasao: 'assets/images/cuiaba.png',
        cor: const Color.fromARGB(255, 186, 152, 16),
        titulos: [],
        idAPI: 204,
      ),
      Time(
        nome: 'Corinthians',
        pontos: 0,
        brasao: 'assets/images/cor.png',
        cor: const Color.fromARGB(255, 0, 0, 0),
        titulos: [],
        idAPI: 65,
      ),
      Time(
        nome: 'Cruzeiro',
        pontos: 0,
        brasao: 'assets/images/cru.png',
        cor: const Color.fromARGB(255, 4, 33, 128),
        titulos: [],
        idAPI: 37,
      ),
      Time(
        nome: 'Vasco',
        pontos: 0,
        brasao: 'assets/images/vasco.png',
        cor: const Color.fromARGB(255, 0, 0, 0),
        titulos: [],
        idAPI: 23,
      ),
      Time(
        nome: 'Bahia',
        pontos: 0,
        brasao: 'assets/images/bahia.png',
        cor: const Color.fromARGB(255, 5, 136, 217),
        titulos: [],
        idAPI: 68,
      ),
      Time(
        nome: 'Santos',
        pontos: 0,
        brasao: 'assets/images/santos.png',
        cor: const Color.fromARGB(255, 0, 0, 0),
        titulos: [],
        idAPI: 63,
      ),
      Time(
        nome: 'Goiás',
        pontos: 0,
        brasao: 'assets/images/goias.png',
        cor: const Color.fromARGB(255, 2, 94, 43),
        titulos: [],
        idAPI: 115,
      ),
      Time(
        nome: 'Coritiba',
        pontos: 0,
        brasao: 'assets/images/coritiba.png',
        cor: const Color.fromARGB(255, 2, 94, 43),
        titulos: [],
        idAPI: 84,
      ),
      Time(
        nome: 'América MG',
        pontos: 0,
        brasao: 'assets/images/america.png',
        cor: const Color.fromARGB(255, 2, 94, 43),
        titulos: [],
        idAPI: 33,
      ),
    ];
  }

  TimesRepository() {
    initRepository();
  }

  showLoading(bool valor) {
    loading.value = valor;
    notifyListeners();
  }

  updateTabela() async {
    showLoading(true);
    var response = await http.get(
      Uri.parse('https://api.api-futebol.com.br/v1/campeonatos/10/tabela'),
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer live_c9d6ae6076455e16b4cab06fb76d6c"
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Database db = await DB.get();

      // ignore: avoid_function_literals_in_foreach_calls
      json.forEach((linha) async {
        try {
          final idAPI = linha['time']['time_id'];
          final pontos = linha['pontos'];

          await db.update(
            'times',
            {'pontos': pontos},
            where: 'idAPI = ?',
            whereArgs: [idAPI],
          );

          for (var time in _times) {
            if (time.idAPI == idAPI) {
              time.pontos = pontos;
            }
          }

          Time time = _times.firstWhere((time) => time.idAPI == idAPI);
          time.pontos = pontos;
        } catch (error) {
          // ignore: avoid_print
          print(error);
        }
      });
    } else {
      throw Exception('Falha de Comunicação com a API');
    }
    showLoading(false);
    notifyListeners();
  }

  initRepository() async {
    var db = await DB.get();
    // ignore: unused_local_variable
    List ts = await db.query('times', orderBy: 'pontos DESC');
    // Equivalente a db.rawQuerry('Select * from times');

    // ignore: unused_local_variable
    for (var t in ts) {
      var time = Time(
          id: t['id'],
          nome: t['nome'],
          brasao: t['brasao'],
          pontos: t['pontos'],
          idAPI: t['idAPI'],
          cor: Color(int.parse(t['cor'])),
          titulos: await getTitulos(t['id']));
      _times.add(time);
    }
    updateTabela();
    notifyListeners();
  }

  getTitulos(timeId) async {
    var db = await DB.get();
    var results =
        await db.query('titulos', where: 'time_id = ?', whereArgs: [timeId]);
    List<Titulo> titulos = [];
    for (var titulo in results) {
      titulos.add(Titulo(
          id: titulo['id'],
          campeonato: titulo['campeonato'],
          ano: titulo['ano']));
    }
    return titulos;
  }
}
