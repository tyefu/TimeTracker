import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<User> authStateChanges();

  User get currentUser;

  Future<User> signInAnonymously();

  Future<void> signOut();

  Future<User> signWithGoogle();


  Future<User> signInWithEmailAndPassword(String email,String password);

  Future<User> createUserWithEmailAndPassword(String email,String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;

  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<User> signInWithEmailAndPassword(String email,String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }
  Future<User> createUserWithEmailAndPassword(String email,String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }

  Future<User> signWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    final googleUser = await _googleSignIn.signIn();

    if(googleUser != null) {
      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null) {
        // クレデンシャルを新しく作成
        final credential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));

        return credential.user;
      } else {
        throw FirebaseAuthException(code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google ID Token');
      }
    }else{
      throw FirebaseAuthException(code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user');
    }
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
    print('success signout');
  }
}
