import 'package:appmedico/screens/android/medico/usuario_medico.dart';
import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';
import 'package:flutter/material.dart';
import 'package:appmedico/app-core/persistence/db_helper.dart';
import 'package:appmedico/app-core/persistence/consulta_db.dart';
import 'package:appmedico/app-core/persistence/medico_db.dart';
import 'package:sqflite/sqflite.dart';

import '../login_screen.dart';
import '../medico/criamed.dart';


class VisualizaConsultaList extends StatefulWidget {

  final int idpaciente;

  VisualizaConsultaList({required this.idpaciente});



  @override
  State<VisualizaConsultaList> createState() => _VisualizaConsultaListState();
}

  
  class _VisualizaConsultaListState extends State<VisualizaConsultaList>{

    List<Map<String, dynamic>> _allConsulta = [];

    bool _isLoading = true;



    //pega do banco
    void _refreshConsulta() async {
      final consulta = await ConsultaDb.getConsultaFromPaciente(widget.idpaciente);
      setState(() {
        _allConsulta = consulta;
        _isLoading = false;
      });
    }

    @override
    void initState(){
      super.initState();
      _refreshConsulta();
    }



    final TextEditingController _sintomaController = TextEditingController();
    final TextEditingController _obsController = TextEditingController();
    final TextEditingController _prescController = TextEditingController();


    void showBottomSheet(int? id) async{
      // se for not null vai update se nao vai add
      //quando press o edit vai pro bottomm sheet e atualiza
      if(id!=null){
        final existingConsulta =
        _allConsulta.firstWhere((element) => element['id'] == id);
        _sintomaController.text = existingConsulta['sintoma'];
        _obsController.text = existingConsulta['obs'];
        _prescController.text = existingConsulta['presc'];
      }

      showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _sintomaController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Sintomas',
                  border: OutlineInputBorder(),
                  hintText: "Sintomas",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _obsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Observações',
                  border: OutlineInputBorder(),
                  hintText: "Observações",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _prescController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Prescrição',
                  border: OutlineInputBorder(),
                  hintText: "Prescrição",
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if(id == null){
                      await _addConsulta();
                    }
                    if(id != null){
                      await _updateConsulta(id);
                    }

                    _sintomaController.text = "";
                    _obsController.text = "";
                    _prescController.text = "";

                    Navigator.of(context).pop();
                    print("Consulta Adicionada");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(id == null ? "Nova Consulta" : "Atualizar",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,
                      color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    //add
    Future<void> _addConsulta() async{
      await ConsultaDb.createConsulta(_sintomaController.text, _obsController.text, _prescController.text,widget.idpaciente);
      _refreshConsulta();
    }
    //update
    Future<void> _updateConsulta(int id) async{
      await ConsultaDb.updateConsulta(id, _sintomaController.text, _obsController.text, _prescController.text);
      _refreshConsulta();
    }
    //delete
    void _deleteConsulta(int id) async{
      await ConsultaDb.deleteConsulta(id);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Consulta Deleted"),
      ));
      _refreshConsulta();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent.shade100,
          title: Text('Consultas'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login()
                ));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 25, left: 25),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Fixed
          backgroundColor: Colors.lightBlueAccent.shade100, // <-- This works for fixed
          selectedItemColor: Colors.blue.shade900,
          unselectedItemColor: Colors.black,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => List_paciente()
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 25,left: 25),
                  child: Icon(Icons.people),
                ),
              ),
              label: 'Pacientes',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => User_medico()
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 25,left: 25),
                  child: Icon(Icons.person),
                ),
              ),
              label: 'Usuário',
            ),
          ],
        ),
  
        body: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: _allConsulta.length,
          itemBuilder: (context, index) => Card(
            margin: EdgeInsets.all(15),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  _allConsulta[index]['createdAt'],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              subtitle: Text(_allConsulta[index]['sintoma']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){
                      showBottomSheet(_allConsulta[index]['id']);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.indigo,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      _deleteConsulta(_allConsulta[index]['id']);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent.shade100,
          onPressed: () => showBottomSheet(null),
          child: Icon(Icons.add),
        ),
      );
    }
  }
