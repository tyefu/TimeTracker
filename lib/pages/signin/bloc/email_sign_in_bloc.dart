// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_app_time_tracker/pages/signin/model/email_sign_in_change_model.dart';
// import 'package:flutter_app_time_tracker/services/auth.dart';
//
// class EmailSignInChangeModel {
//   final AuthBase auth;
//   final StreamController<EmailSignInChangeModel> _modelController =
//       StreamController();
//
//   EmailSignInChangeModel({@required this.auth});
//
//   Stream<EmailSignInChangeModel> get modelStream => _modelController.stream;
//   EmailSignInChangeModel _model = EmailSignInChangeModel();
//
//   void dispose() {
//     _modelController.close();
//   }
//
//   Future<void> submit() async {
//     // updateWith(submitted: true, isLoading: true);
//     try {
//       if (_model.formType == EmailSignInFormType.signIn) {
//         await auth.signInWithEmailAndPassword(_model.email, _model.password);
//       } else {
//         await auth.createUserWithEmailAndPassword(
//             _model.email, _model.password);
//       }
//     } catch (e) {
//       // updateWith(isLoading: false);
//       rethrow;
//     }
//   }
//
//   void toggleFormType(EmailSignInChangeModel model) {
//     final formType = model.formType == EmailSignInFormType.signIn
//         ? EmailSignInFormType.register
//         : EmailSignInFormType.signIn;
//     // updateWith(isLoading: false, submitted: false, formType: formType);
//   }
  //
  // void updateEmail(String email) => updateWith(email: email);
  //
  // void updatePassword(String password) => updateWith(password: password);

  // void updateWith({
  //   String email,
  //   String password,
  //   EmailSignInFormType formType,
  //   bool isLoading,
  //   bool submitted,
  // }) {
  //   _model = _model.copyWith(
  //     email: email,
  //     password: password,
  //     formType: formType,
  //     isLoading: isLoading,
  //     submitted: submitted,
  //   );
  //   _modelController.add(_model);
  // }
// }
