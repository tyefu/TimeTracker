import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/bloc/email_sign_in_form_change_notifier.dart';
import 'package:flutter_app_time_tracker/pages/signin/email_sign_in_form.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child:EmailSignInFormChangeNotifier.create(context) ,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

}
