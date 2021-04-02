import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';

class SignInManager{
  SignInManager({@required this.auth,@required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod)async{
    try{
      isLoading.value = true;
      return await signInMethod();
    }catch(e){
      isLoading.value = false;
      rethrow;

    }
  }
  Future<User> signInAnonymously()async{
await _signIn(() => auth.signInAnonymously());
  }


  Future<User> signWithGoogle()async =>
     await _signIn(auth.signWithGoogle);


  // Future<User> signInWithEmailAndPassword(String email,String password);
  //
  // Future<User> createUserWithEmailAndPassword(String email,String password);
}