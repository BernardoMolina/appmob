import 'package:appmedico/app-core/persistence/paciente_db.dart';
import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';
import '../medico/usuario_medico.dart';


class User_paciente extends StatefulWidget {
  @override
  State<User_paciente> createState() => _User_pacienteState();
}

class _User_pacienteState extends State<User_paciente> {

  List<Map<String, dynamic>> _allPaciente = [];

  bool _isLoading = true;

  void _refreshPaciente() async {
    final paciente = await PacienteDb.getAllPaciente();
    setState(() {
      _allPaciente = paciente;
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _refreshPaciente();
  }



  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void showBottomSheet(int? idpac) async{
    //if id is not null then it will updata se nao vai add
    //quando press o edit vai pro bootm shet e att
    if(idpac!=null){
      final existingPaciente =
      _allPaciente.firstWhere((element) => element['idpac'] == idpac);
      _nomeController.text = existingPaciente['nome'];
      _emailController.text = existingPaciente['email'];

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
                  if(idpac == null){
                    await _addPaciente();
                  }
                  if(idpac != null){
                    await _updatePaciente(idpac);
                  }

                  _nomeController.text = "";
                  _emailController.text = "";

                  Navigator.of(context).pop();
                  print("Data Added");
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(idpac == null ? "Add Data" : "Update",
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
  Future<void> _addPaciente() async{
    await PacienteDb.createPaciente(_nomeController.text,_emailController.text);
    _refreshPaciente();
  }
  //update
  Future<void> _updatePaciente(int idpac) async{
    await PacienteDb.updatePaciente(idpac, _nomeController.text, _emailController.text);
    _refreshPaciente();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Cria paciente'),
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
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _allPaciente.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(15),
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _allPaciente[index]['nome'],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            subtitle: Text(_allPaciente[index]['email']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: (){
                    showBottomSheet(_allPaciente[index]['idpac']);
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
