import 'dart:io';
import 'package:appmedico/app-core/persistence/medico_db.dart';
import 'package:appmedico/screens/android/paciente/listar_pacientes.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../login_screen.dart';


class User_medico extends StatefulWidget {
  @override
  State<User_medico> createState() => _User_medicoState();
}

class _User_medicoState extends State<User_medico> {

  List<Map<String, dynamic>> _userMedico = [];

  bool _isLoading = true;

  void _refreshMedico() async {
    final medico = await MedicoDb.getSingleMedico(1);
    setState(() {
      _userMedico = medico;
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
  final TextEditingController _fotoController = TextEditingController();

  void showBottomSheet(int? idmed) async{
    //if id is not null then it will updata se nao vai add
    //quando press o edit vai pro bootm shet e att
    if(idmed!=null){
      final existingMedico =
      _userMedico.firstWhere((element) => element['idmed'] == idmed);
      _nomeController.text = existingMedico['nome'];
      _emailController.text = existingMedico['email'];
      _telefoneController.text = existingMedico['telefone'];
      _registroController.text = existingMedico['registro'];
      _cpfController.text = existingMedico['cpf'];
      _fotoController.text = existingMedico['foto'];

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
                labelText: 'Nome Completo',
                border: OutlineInputBorder(),
                hintText: "Nome Completo",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _cpfController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'CPF',
                border: OutlineInputBorder(),
                hintText: "CPF",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
                hintText: "Telefone",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _registroController,
              decoration: InputDecoration(
                labelText: 'Registro',
                border: OutlineInputBorder(),
                hintText: "Registro",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                hintText: "E-mail",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
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
                  child: Text(idmed == null ? "Add Data" : "Atualizar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,
                    color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //update
  Future<void> _updateMedico(int idmed) async{
    await MedicoDb.updateMedico(idmed, _nomeController.text, _cpfController.text
      , _registroController.text, _telefoneController.text, _emailController.text);
    _refreshMedico();
  }

  //update
  Future<void> _updateMedicofoto(int idmed) async{
    await MedicoDb.updateMedicofoto(idmed, _fotoController.text);
    _refreshMedico();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        title: Text('Usuário'),
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
        itemCount: _userMedico.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                onTap: (){
                  alertTirarFoto(context);
                  debugPrint('tira foto');
                  },
                    child: CircleAvatar(
                      radius: 120,
                      child: ClipOval(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: _userMedico[index]['foto'] != null
                              ? Image.file(
                            File(_userMedico[index]['foto']),
                          )
                              : Image.asset(
                            'imagens/cam.jpg',
                          ),
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8,top: 35,right: 8,bottom: 8),
                child: Row(
                  children: [
                    const Text(
                      'Nome completo: ',
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    Text(_userMedico[index]['nome'], textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'CPF: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(_userMedico[index]['cpf'], textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Email: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(_userMedico[index]['email'], textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Telefone: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(_userMedico[index]['telefone'], textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Registro: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(_userMedico[index]['registro'], textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: MaterialButton(
                  color: Colors.lightBlueAccent.shade100,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () {
                    showBottomSheet(_userMedico[index]['idmed']);
                  },
                  child:  const Text('Editar'),
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }

  alertTirarFoto(BuildContext context){
    AlertDialog alert = AlertDialog(
      title: Text('Sua foto de perfil!', style: TextStyle(fontWeight: FontWeight.bold),),
      content: Text('Escolha entre camera e galeria para sua nova foto de perfil!'),
      elevation: 5.0,
      actions: <Widget>[
        ElevatedButton(
          child: Text('Camera'),
          onPressed: (){
            debugPrint('usuario escolheu galria');
            _obterImage(ImageSource.camera);
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Galeria'),
          onPressed: (){
            debugPrint('usuario escolheu galria');
            _obterImage(ImageSource.gallery);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alert;
    }
    );
  }

  _obterImage(ImageSource source) async{
    final image = await ImagePicker().pickImage(source: source);

    if( image != null){
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: 'CORTAR IMAGEM',
          statusBarColor: Colors.lightBlueAccent,
          backgroundColor: Colors.white
          )
        ]
      );
      setState(() {
        _fotoController.text = croppedFile!.path;
        _updateMedicofoto(1);
      });
    }
  }

}
