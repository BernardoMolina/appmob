import 'package:appmedico/app-core/persistence/medico_db.dart';
import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';
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



  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _registroController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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

  //add
  Future<void> _addMedico() async{
    await MedicoDb.createMedico(_nomeController.text, _cpfController.text,_registroController.text,_telefoneController.text,_emailController.text);
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
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _allMedico.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(15),
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _allMedico[index]['nome'],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            subtitle: Text(_allMedico[index]['cpf']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: (){
                    showBottomSheet(_allMedico[index]['idmed']);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }


}
