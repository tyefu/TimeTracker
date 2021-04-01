import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/custom_button.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_exception_alert_dialog.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/signin_button.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/social_signin_button.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';
import 'package:provider/provider.dart';

import 'email_signin_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _isLoading = false;
  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } catch (e) {
      _showSignInError(context, e);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signWithGoogle();

    } catch (e) {
      _showSignInError(context, e);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black54,
            onPressed: () =>
             _isLoading ? null : _signInWithGoogle(context),
            assetName: 'assets/images/google-logo.png',
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: 'Sign in with Facebook',
            color: Colors.indigo,
            textColor: Colors.white,
            onPressed: () {},
            assetName: 'assets/images/facebook-logo.png',
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
              text: 'Sign in with Email',
              color: Colors.teal,
              textColor: Colors.white,
              onPressed: () =>
              _isLoading ? null :
              _signInWithEmail(context),
              ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
              text: 'Go anoymas',
              color: Colors.lightGreen,
              textColor: Colors.black87,
              onPressed: () =>
              _isLoading ? null :
              _signInAnonymously(context),
              ),
        ],
      ),
    );
  }
  Widget _buildHeader(){
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );

    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    );
  }
}
