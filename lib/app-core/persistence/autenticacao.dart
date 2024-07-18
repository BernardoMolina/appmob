import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Autenticacao{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference _medico = FirebaseFirestore.instance.collection("medico");
  Future<String?> cadastrarMedico ({
    required String nome,
    required String senha,
    required String email,
    required String telefone,
    required String cpf,
    required String registro,

})async{
    try {
      UserCredential medico = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha,);
      await medico.user!.updateDisplayName(nome);
      final String? userId = await medico.user?.uid;

      await _medico.add({
        'id': userId,
        'nome': nome,
        'cpf': cpf,
        'email': email,
        'telefone': telefone,
        'registro': registro,

        'createdAt': FieldValue.serverTimestamp(),
      });
      return null;
    }on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        return "O usuario ja esta cadastrado";
      }
      return "Erro desconheco";
    }
}

  Future<String?> logarMedico({
    required String email,
    required String senha,}) async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<void> deslogar(){
    return _firebaseAuth.signOut();
  }

}