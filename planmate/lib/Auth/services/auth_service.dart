import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// ฟัง auth state เปลี่ยน เช่น login/logout
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// สมัครสมาชิกด้วย email + password + name
  Future<String> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print('Starting registration for: $email'); // debug
      
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User created: ${cred.user?.uid}'); // debug

      await _firestore.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'name': name,
        'email': email,
        'createdAt': DateTime.now(),
      });

      print('User data saved to Firestore'); // debug
      return 'success';
    } catch (e) {
      print('Registration error: $e'); // debug
      return _handleAuthError(e);
    }
  }

  /// Login ด้วย email / password
  Future<String> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print('Starting login for: $email'); // debug
      
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      print('Login successful: ${result.user?.uid}'); // debug
      return 'success';
    } catch (e) {
      print('Login error: $e'); // debug
      return _handleAuthError(e);
    }
  }

  /// Login ด้วย Google
  Future<String> signInWithGoogle() async {
    try {
      print('Starting Google sign in'); // debug
      
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign in cancelled'); // debug
        return 'cancelled';
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);
      print('Google sign in successful: ${userCred.user?.uid}'); // debug

      final userDoc = await _firestore
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
        print('New Google user data saved'); // debug
      }

      return 'success';
    } catch (e) {
      print('Google sign in error: $e'); // debug
      return _handleAuthError(e);
    }
  }

  /// Logout ทั้ง email และ google
  Future<void> signOut() async {
    try {
      print('Starting sign out'); // debug
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      print('Sign out successful'); // debug
    } catch (e) {
      print('Sign out error: $e'); // debug
    }
  }

  /// จัดการ error → คืนข้อความที่เหมาะใช้แสดงใน UI
  String _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'Email is already registered.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'invalid-email':
          return 'Invalid email format.';
        case 'invalid-credential':
          return 'Invalid email or password.';
        case 'too-many-requests':
          return 'Too many failed attempts. Please try again later.';
        default:
          return e.message ?? 'Authentication error.';
      }
    }
    return 'An unknown error occurred.';
  }
}