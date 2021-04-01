import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/form_submit_button.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_alert_dialog.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_exception_alert_dialog.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/validators.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';
import 'package:provider/provider.dart';


enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators{

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}


class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  bool _submitted = false;
  bool _isLoading = false;

  int a = 3;


  @override
  void dispose() {
    // TODO: implement dispose

    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context,listen: false);
      if (_formType == EmailSignInFormType.signIn) {

        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    }on FirebaseAuthException catch (e) {
      print(e.toString());
      showExceptionAlertDialog(context, title: 'Sign in failed');
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }


  void _updateState() {
    print('email:$_email,password:$_password');
    setState(() {

    });
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toogleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
  }

  List<Widget> _buildChildren() {

    bool emailValid = _submitted && !widget.emailValidator.isValid(_email);
    bool passwordValid = _submitted && !widget.passwordValidator.isValid(_password);

    print('email:$emailValid');
    print('password:$passwordValid}');
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';

    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    bool submitEnabled = widget.emailValidator.isValid(_email) && widget.passwordValidator.isValid(_password) && !_isLoading;


    return [
      TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration:
        InputDecoration(labelText: 'Email', hintText: 'test@test.com',
        errorText: emailValid ? widget.invalidEmailErrorText : null ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (email) => _updateState(),
        onEditingComplete: _emailEditingComplete,
        enabled: _isLoading == false,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
        errorText: passwordValid ? widget.invalidPasswordErrorText : null),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onChanged: (password) => _updateState(),
        onEditingComplete: _submit,
        enabled: _isLoading == false,
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
          onPressed: !_isLoading ? _toogleFormType : null,
          child: Text(secondaryText))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
