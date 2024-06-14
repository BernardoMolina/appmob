

import 'package:appmedico/screens/android/medico/usuario_medico.dart';
import 'package:appmedico/screens/android/paciente/visualiza_consulta.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../login_screen.dart';
import 'paciente_list.dart';

class VisualizaConsultaList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Consultas - Bernado Molina'),
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
                    builder: (context) => PacienteList()
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

      body: Column(
        children: <Widget>[
          Container(
            child: const TextField(
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                suffixIconColor: Colors.blue,
                labelText: "Pesquisar",
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Container(height: 25,),
          Expanded(
            child: Container(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VisualizaConsulta()
                        )),
                    title: const Text('17/02/2024',
                        style: TextStyle(fontSize: 24)),
                    subtitle: const Text('15:03:01',
                        style: TextStyle(fontSize: 12)),
                  ),
                  Divider(
                    color: Colors.lightBlueAccent.shade200,
                    endIndent: 30,
                    thickness: 1.9,
                    height: 13.0,
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VisualizaConsulta()
                        )),
                    title: const Text('07/01/2024',
                        style: TextStyle(fontSize: 24)),
                    subtitle: const Text('16:33:01',
                        style: TextStyle(fontSize: 12)),
                  ),
                  Divider(
                    color: Colors.lightBlueAccent.shade200,
                    endIndent: 30,
                    thickness: 1.9,
                    height: 13.0,
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VisualizaConsulta()
                        )),
                    title: const Text('29/12/2023',
                        style: TextStyle(fontSize: 24)),
                    subtitle: const Text('10:03:31',
                        style: TextStyle(fontSize: 12)),
                  ),
                  Divider(
                    color: Colors.lightBlueAccent.shade200,
                    endIndent: 30,
                    thickness: 1.9,
                    height: 13.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}