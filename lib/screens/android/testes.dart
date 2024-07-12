import 'package:appmedico/screens/android/login_screen.dart';
import 'package:appmedico/screens/android/medico/criamed.dart';
import 'package:appmedico/screens/android/paciente/criapaciente.dart';
import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';

import 'package:flutter/material.dart';

class Testes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Página Inicial'),
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
        body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(height: 200),
                  Container(
                    child: MaterialButton(
                      color: Colors.lightBlue.shade200,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      onPressed: () {
                        debugPrint('navegar para o registrar consultas');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => User_medicoo()
                        ));
                      },
                      child:  Text('Novo medico'),
                    ),
                  ),
                  Container(height: 20),
                  Container(
                    child: MaterialButton(
                      color: Colors.lightBlue.shade200,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      onPressed: () {
                        debugPrint('navegar para o visualizar consulats');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => User_paciente()
                        ));
                      },
                      child:  Text('Novo paciente'),
                    ),
                  ),
                  Container(height:300),
                  Container(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Material(
                            color: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)
                            ),
                            elevation: 10,
                            child: InkWell(
                              onTap: (){
                                debugPrint('navegando para home');
                              },
                              child: Container(
                                width: 150,
                                padding: EdgeInsets.all(8.0),
                                child: const Column(
                                  children: <Widget>[
                                    Icon(Icons.home,
                                      color: Colors.white,),
                                    Text('Página inicial',style: TextStyle(
                                        color: Colors.white, fontSize: 16
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 30)),
                        Padding(
                          padding: const EdgeInsets.all(10),

                          child: Material(

                            color: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)
                            ),
                            elevation: 10,

                            child: InkWell(

                              onTap: (){
                                debugPrint('navegando para user');
                              },
                              child: Container(
                                width: 150,

                                padding: EdgeInsets.all(8.0),
                                child: const Column(
                                  children: <Widget>[

                                    Icon(Icons.person,
                                      color: Colors.white,),
                                    Text('Usuário',style: TextStyle(
                                        color: Colors.white, fontSize: 16
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ),
        );
    }
}