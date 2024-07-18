import 'package:appmedico/screens/android/login_screen.dart';
import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppMedico extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoteadorTela(
      ),
    );
  }


}

class RoteadorTela extends StatelessWidget{
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context){
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.userChanges(),
    builder: (context, snapshot){
      if(snapshot.hasData){
        return List_paciente();
      }else{
        return Login();
      }
    },
    );
}}
