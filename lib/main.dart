import 'package:appmedico/screens/android/appmedico.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {

  if(Platform.isAndroid){
    debugPrint('app no Android');
    runApp(AppMedico());
  }
  if(Platform.isIOS){
    debugPrint('app no IOS');
  }

  //runApp(const MyApp());
}


