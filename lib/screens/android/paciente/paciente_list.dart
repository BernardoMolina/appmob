import 'package:appmedico/screens/android/medico/usuario_medico.dart';
import 'package:appmedico/screens/android/paciente/visualizar_consultaList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';


class PacienteList extends StatelessWidget {


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
                    children: <Widget> [
                      ListTile(
                          title: const Text('Bernardo Molina',
                              style: TextStyle(fontSize: 24)),
                          subtitle: const Text('CPF: 999.999.999-09',
                              style: TextStyle(fontSize: 12)),
                        onTap: (){
                          debugPrint('navegar para o registrar consulats');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VisualizaConsultaList()
                          ));
                        },
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
    ) ;
  }
  
  Widget _menu(){
    return PopupMenuButton(

      onSelected: (ItensMenuListPaciente selecionado){
        debugPrint('selecionado ... $selecionado');
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ItensMenuListPaciente>>[
         PopupMenuItem(
            value: ItensMenuListPaciente.Registrar_Consultas,
            onTap: (){
              debugPrint('navegar para o registrar consulats');
              //Navigator.of(context).push(MaterialPageRoute(
                  //builder: (context) => RegistrarConsulta()
              //));
            },
            child: Text('Registrar Consulta'),

        ),
        PopupMenuItem(
          value: ItensMenuListPaciente.Visualizar_Consultas,
          onTap: (){
            debugPrint('navegar para o registrar consulats');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VisualizaConsultaList()
            ));
          },
          child: Text('Visualizar Consultas'),
        ),
      ],
    );


  }
}
enum ItensMenuListPaciente{Registrar_Consultas,Visualizar_Consultas }