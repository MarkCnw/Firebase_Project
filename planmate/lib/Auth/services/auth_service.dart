import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// ฟัง auth state เปลี่ยน เช่น login/logout
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// สมัครสมาชิกด้วย email + password + name
  Future<String> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'name': name,
        'email': email,
        'createdAt': DateTime.now(),
      });

      return 'success';
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  Future<String> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success';
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return 'cancelled';

      final GoogleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);

      final userDoc =
          await _firestore
              .collection('users')
              .doc(userCred.user!.uid)
              .get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCred.user!.uid).set({
          'uid': userCred.user!.uid,
          'name': userCred.user?.displayName ?? '',
          'email': userCred.user?.email ?? '',
          'photoUrl': userCred.user?.photoURL ?? '',
          'createdAt': DateTime.now(),
        });
      }
      return 'success';
    } catch (e) {
      return _handleAuthError(e);
    }
  }
}
