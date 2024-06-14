import 'package:flutter/material.dart';

import '../login_screen.dart';
import '../medico/usuario_medico.dart';
import 'paciente_list.dart';

class RegistrarConsulta extends StatelessWidget {

  final TextEditingController _sintomaController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();
  final TextEditingController _prescricaoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Registrar Consulta'),
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
                child: Text('Sexo: Masculino',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18)
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Data de Nascimento: 15/03/2002',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Sintoma obrigatório';
                    }
                    return null;
                  },
                  controller: this._sintomaController,
                  decoration: const InputDecoration(
                    labelText: "Sintomas"
                  ),
                   style: const TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Observação obrigatória';
                    }
                    return null;
                  },
                  controller: this._observacaoController,
                  decoration: const InputDecoration(
                      labelText: "Observações"
                  ),
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Prescrição obrigatória';
                    }
                    return null;
                  },
                  controller: this._prescricaoController,
                  decoration: const InputDecoration(
                      labelText: "Prescrição"
                  ),
                  style: TextStyle(fontSize: 24),
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
                        debugPrint('Sintoma ' +this._sintomaController.text);
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
