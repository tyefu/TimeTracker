import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/bloc/email_sign_in_bloc.dart';
import 'package:flutter_app_time_tracker/pages/signin/model/email_sign_in_model.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/form_submit_button.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_alert_dialog.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_exception_alert_dialog.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/validators.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';
import 'package:provider/provider.dart';

class EmailSignInFormBlocBase extends StatefulWidget {
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBase(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  EmailSignInFormBlocBase({Key key, @required this.bloc}) : super(key: key);

  @override
  _EmailSignInFormBlocBaseState createState() =>
      _EmailSignInFormBlocBaseState();
}

class _EmailSignInFormBlocBaseState extends State<EmailSignInFormBlocBase> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

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
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showExceptionAlertDialog(context, title: 'Sign in failed', exception: e);
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@test.com',
            errorText: model.emailErrorText),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: widget.bloc.updateEmail,
        onEditingComplete: () => _emailEditingComplete(model),
        enabled: model.isLoading == false,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
            labelText: 'Password', errorText: model.passwordErrorText),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onChanged: widget.bloc.updatePassword,
        onEditingComplete: _submit,
        enabled: model.isLoading == false,
      ),
      SizedBox(
        height: 8.0,
      ),

      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,

      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
          onPressed:
              !model.isLoading ? () => widget.bloc.toggleFormType(model) : null,
          child: Text(model.secondaryButtonText))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {

          final EmailSignInModel model = snapshot.data;
          print('email:${model.email},password:${model.password}');
          print('${model.submitted}:submitted');
          print('${model.canSubmit}');
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
