import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import '../repositories/times_repository.dart';
import '../models/titulo.dart';

// ignore: must_be_immutable
class EditTituloPage extends StatefulWidget {
  Titulo titulo;
  EditTituloPage({required Key key, required this.titulo})  : super(key:key);

  @override
  // ignore: library_private_types_in_public_api
  _EditTituloPageState createState() => _EditTituloPageState();
}

class _EditTituloPageState extends State<EditTituloPage> {
    
    final _campeonato = TextEditingController();
    final _ano = TextEditingController();
    final _formkey = GlobalKey<FormState>();
  
  
  @override
  void initState(){
    super.initState();
    _ano.text = widget.titulo.ano;
    _campeonato.text = widget.titulo.campeonato;
  }

  editar(){
    Provider.of<TimesRepository>(context, listen: false).editTitulo(
      titulo: widget.titulo,
      campeonato: _campeonato.text,
      ano: _ano.text,
    );

    Get.back();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Título'),
        backgroundColor: Colors.grey,
        actions: [IconButton(icon: const Icon(Icons.check), onPressed: editar)],
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
            padding:const EdgeInsets.all(24),
            child: TextFormField(
              controller: _ano,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ano',
              ),
              keyboardType: TextInputType.number,
              validator: (value){
                if(value!.isEmpty){
                  return 'Informe o ano do titulo!';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: TextFormField(
              controller: _campeonato,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Campeonato',
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'Informe qual é o campeonato!';
                }
                return null;
              },
            ),
           ),
          ],
        ),
      ),
    );
  }
}