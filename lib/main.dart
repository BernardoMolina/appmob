import 'package:appmedico/screens/android/appmedico.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if(Platform.isAndroid){
    debugPrint('app no Android');
    runApp(AppMedico());
  }
  if(Platform.isIOS){
    debugPrint('app no IOS');
  }

  //runApp(const MyApp());
}


