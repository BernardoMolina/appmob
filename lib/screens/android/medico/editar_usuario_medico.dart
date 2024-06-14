import 'package:flutter/material.dart';

import '../login_screen.dart';
import '../medico/usuario_medico.dart';
import '../paciente/paciente_list.dart';


class EditarUsuarioMedico extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Editar Usuário'),
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
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 9),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'E-mail obrigatório';
                    }
                    return null;
                  },
                  controller: this._emailController,
                  decoration: const InputDecoration(
                      labelText: "E-mail"
                  ),
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Telefone obrigatório';
                    }
                    return null;
                  },
                  controller: this._telefoneController,
                  decoration: const InputDecoration(
                      labelText: "Telefone"
                  ),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 19.0),
                child: MaterialButton(
                  color: Colors.green,
                  elevation: 7,
                  height: 55,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      debugPrint('Email ' +this._emailController.text);
                    }else{
                      debugPrint('formulário inválido');
                    }

                  },
                  child: const Text('Salvar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}