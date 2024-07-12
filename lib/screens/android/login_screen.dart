import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';
import 'package:appmedico/screens/android/testes.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 190,
                child: Image.asset('imagens/logoclinica.jpg'),
              ),
              Container(height: 40),
              Container(
                child: Text('Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              Container(height: 40),
              Container(
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(height: 20),
              Container(
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              Container(height: 20),
              Container(
                child: MaterialButton(
                      color: Colors.lightBlue.shade100,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      onPressed: () {
                        debugPrint('navegar para o home');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => List_paciente()
                        ));
                        print('Email: ${_emailController.text}');
                        print('Senha: ${_passwordController.text}');
                      },
                      child:  Text('Acessar'),
                  ),
                ),
              Container(
                child: MaterialButton(
                  color: Colors.lightBlue.shade100,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () {
                    debugPrint('navegar para o home');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Testes()
                    ));
                    print('Email: ${_emailController.text}');
                    print('Senha: ${_passwordController.text}');
                  },
                  child:  Text('TESTES'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
