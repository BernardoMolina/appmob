import 'package:flutter/material.dart';

import '../login_screen.dart';
import '../medico/usuario_medico.dart';
import 'paciente_list.dart';

class RespostaFeedback extends StatelessWidget {

  final TextEditingController _respostaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Resposta Feedback'),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Nome Completo: Bernardo Pires Molina',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Feedback: Tomei o remédio durante o tempo estipulado e não melhorei',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18)
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Resposta obrigatória';
                    }
                    return null;
                  },
                  controller: this._respostaController,
                  decoration: const InputDecoration(
                      labelText: "Resposta"
                  ),
                  style: const TextStyle(fontSize: 24),
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
                      debugPrint('Sintoma ' +this._respostaController.text);
                    }else{
                      debugPrint('formulário inválido');
                    }

                  },
                  child: const Text('Enviar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}