
import 'package:appmedico/app-core/persistence/paciente_db.dart';
import 'package:appmedico/screens/android/paciente/visualizar_consultaList.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../app-core/persistence/db_helper.dart';
import '../login_screen.dart';
import '../medico/usuario_medico.dart';


class List_paciente extends StatefulWidget {
  @override
  State<List_paciente> createState() => _List_pacienteState();
}

class _List_pacienteState extends State<List_paciente> {

  List<Map<String, dynamic>> _allPaciente = [];

  bool _isLoading = true;

  void _refreshPaciente() async {
    final paciente = await PacienteDb.getAllPaciente();
    setState(() {
      _allPaciente = paciente;
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _refreshPaciente();
  }


  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Pacientes'),
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
        itemCount: _allPaciente.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(15),
          child: ListTile(
            onTap: () {
              debugPrint('navegar para o visualizar consulats');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VisualizaConsultaList(
                    idpaciente: _allPaciente[index]['idpac'],
                  )
              ));
            },
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _allPaciente[index]['nome'],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            subtitle: Text(_allPaciente[index]['email']),
          ),
        ),
      ),
    );
  }


}
