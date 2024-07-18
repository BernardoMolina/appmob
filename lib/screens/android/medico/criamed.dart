import 'package:appmedico/app-core/persistence/autenticacao.dart';
import 'package:appmedico/app-core/persistence/medico_db.dart';
import 'package:appmedico/screens/android/_comum/meu_snackbar.dart';
import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';

class User_medicoo extends StatefulWidget {
  @override
  State<User_medicoo> createState() => _User_medicooState();
}

class _User_medicooState extends State<User_medicoo> {

  List<Map<String, dynamic>> _allMedico = [];

  bool _isLoading = true;

  void _refreshMedico() async {
    final medico = await MedicoDb.getAllMedico();
    setState(() {
      _allMedico = medico;
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _refreshMedico();
  }

  CollectionReference _medicos = FirebaseFirestore.instance.collection("medico");







  Autenticacao _autenticacao = Autenticacao();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _registroController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();



  void showBottomSheet(int? idmed) async{
    //if id is not null then it will updata se nao vai add
    //quando press o edit vai pro bootm shet e att
    if(idmed!=null){
      final existingMedico =
      _allMedico.firstWhere((element) => element['idmed'] == idmed);
      _nomeController.text = existingMedico['nome'];
      _emailController.text = existingMedico['email'];
      _telefoneController.text = existingMedico['telefone'];
      _registroController.text = existingMedico['registro'];
      _cpfController.text = existingMedico['cpf'];
      _senhaController.text = existingMedico['senha'];

    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "nome",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "senha",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _cpfController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "cpf",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "telefone",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _registroController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "registro",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "email",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if(idmed == null){
                    await _addMedico();
                  }
                  if(idmed != null){
                    await _updateMedico(idmed);
                  }

                  _nomeController.text = "";
                  _senhaController.text = "";
                  _cpfController.text = "";
                  _registroController.text = "";
                  _telefoneController.text = "";
                  _emailController.text = "";

                  Navigator.of(context).pop();
                  print("Data Added");
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(idmed == null ? "Add Data" : "Update",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteMedico(String medicoId){
    _medicos.doc(medicoId).delete();
  }
  //add
  Future<void> _addMedico() async{
    await MedicoDb.createMedico(_nomeController.text, _cpfController.text,_registroController.text,_telefoneController.text,_emailController.text,_senhaController.text);
    _autenticacao.cadastrarMedico(nome: _nomeController.text, senha: _senhaController.text, email: _emailController.text,cpf: _cpfController.text,

      telefone: _telefoneController.text,
      registro: _registroController.text).then((String? erro){
        if(erro != null){
          mostrarSnackBar(context: context, texto: erro);
        }else{
          mostrarSnackBar(context: context, texto: "Cadastro com sucesso", isErro: false);
        }
    },);
    _refreshMedico();
  }
  //update
  Future<void> _updateMedico(int idmed) async{
    await MedicoDb.updateMedico(idmed, _nomeController.text, _cpfController.text
        , _registroController.text, _telefoneController.text, _emailController.text);
    _refreshMedico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent.shade100,
          title: Text('Cria medico'),
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
                      builder: (context) => User_medicoo()
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
        body: Expanded(
            child: StreamBuilder(

              stream: _medicos.snapshots(),
            builder: (context,snapshot){
                if(!snapshot.hasData){
                  Center(
                    child: CircularProgressIndicator(),
                  );
                }

            return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index){
            var medico = snapshot.data!.docs[index];
            return Dismissible(
                key: Key(medico.id),
                background: Container(
                  color: Colors.redAccent,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
                onDismissed: (direction){
                  _deleteMedico(medico.id);
                },
                direction: DismissDirection.endToStart,
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      medico['nome'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      medico['email'],
                      style: TextStyle(
                        color: Colors.green
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),);
          },
        );
},
    )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),

    );
    }
}