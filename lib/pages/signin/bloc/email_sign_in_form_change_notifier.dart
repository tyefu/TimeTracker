import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/form_submit_button.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_exception_alert_dialog.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_time_tracker/pages/signin/model/email_sign_in_change_model.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }

  EmailSignInFormChangeNotifier({Key key, @required this.model}) : super(key: key);

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;
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
      await model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showExceptionAlertDialog(context, title: 'Sign in failed', exception: e);
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
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
        onChanged: model.updateEmail,
        onEditingComplete: () => _emailEditingComplete(),
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
        onChanged: model.updatePassword,
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
              !model.isLoading ? () => model.toggleFormType() : null,
          child: Text(model.secondaryButtonText))
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
