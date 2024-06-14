
import 'package:appmedico/screens/android/medico/editar_usuario_medico.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
import '../paciente/paciente_list.dart';

class User_medico extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Usuário'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Login()
              ));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 25,left: 25),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Nome Completo: Bernardo Pires Molina',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('CPF: 999.999.999-09',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18)
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('E-mail: bernarodomolina@gmail.com',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Telefone: (55) 99933-0987',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Registro: 3247AS873',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: MaterialButton(
                  color: Colors.blue,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () {
                    debugPrint('navegar para o registrar consultas');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditarUsuarioMedico()
                    ));
                  },
                  child:  const Text('Editar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
