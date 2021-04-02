import 'package:flutter_app_time_tracker/pages/signin/email_sign_in_form.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators{
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  String get primaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit{
    return emailValidator.isValid(email) && passwordValidator.isValid(password) && !isLoading;

  }

  String get emailErrorText{
     bool showErrorText = submitted && emailValidator.isValid(email);
     return showErrorText ? invalidEmailErrorText : null;
  }
  String get passwordErrorText{
    bool showErrorText = submitted && passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  EmailSignInModel({this.email = '', this.password = '', this.formType = EmailSignInFormType.signIn, this.isLoading = false,
      this.submitted = false});
EmailSignInModel copyWith({
  String email,
  String password,
  EmailSignInFormType formType,
  bool isLoading,
  bool submitted,
}){
  return EmailSignInModel(
    email: email ?? this.email,
    password: password ?? this.password,
    formType: formType ?? this.formType,
    isLoading: isLoading ?? this.isLoading,
    submitted: submitted ?? this.submitted,
  );
}

}