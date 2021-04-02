import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';

class SignInBloc{
  SignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<bool> _isLocadingController = StreamController<bool>();


  Stream<bool> get isLoadingStream => _isLocadingController.stream;

  void dispose(){
    _isLocadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLocadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod)async{
    try{
      _setIsLoading(true);
      return await signInMethod();
    }catch(e){
      _setIsLoading(false);
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