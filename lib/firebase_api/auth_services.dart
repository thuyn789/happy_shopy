/// This class will handle all the authentication with firebase services
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final String _urlDefaultAvatar =
      "https://firebasestorage.googleapis.com/v0/b/supercool-rental.appspot.com/o/profile_photos%2Fdefault_profile_photo.jpg?alt=media&token=e4a7ba40-4b36-49b4-a13c-a83c46f11b42";

  //After creating user's login credential, initialize user's database
  Future<void> initializeUserDB() async {
    try {
      await _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .set({
        'cartCount' : 0,
        'cartSubtotal' : 0,
        'orderCount' : 0,
      });
    } catch (e) {
      print(e);
    }
  }

  //Login with existing username and password credential
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  //Login with google credential
  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
    await _auth.signInWithCredential(credential);

    final gUser = userCredential.user;

    if (userCredential.additionalUserInfo!.isNewUser) {
      await _database.collection("users").doc(gUser!.uid).set({
        'user_id': gUser.uid.trim(),
        'first_name': gUser.displayName!.trim(),
        'last_name': ''.trim(),
        'email': gUser.email!.trim(),
        'user_role': 'customer'.trim(),
        'reg_date_time': gUser.metadata.creationTime,
        'urlAvatar': _urlDefaultAvatar.trim()
      });
      await initializeUserDB();
    }

    // Once signed in, return the google user
    // back to login screen for further processing
    return gUser;
  }

  //Anonymous sign-in
  Future<User?> signInAnon() async {
    UserCredential userCredential =
    await FirebaseAuth.instance.signInAnonymously();

    final anonUser = userCredential.user;

    if (userCredential.additionalUserInfo!.isNewUser) {
      await _database.collection("users").doc(anonUser!.uid).set({
        'user_id': anonUser.uid.trim(),
        'first_name': 'Valued'.trim(),
        'last_name': 'Guest'.trim(),
        'email': 'N/A'.trim(),
        'user_role': 'customer'.trim(),
        'reg_date_time': anonUser.metadata.creationTime,
        'urlAvatar': _urlDefaultAvatar.trim()
      });
      await initializeUserDB();
    }

    // Once signed in, return the google user
    // back to login screen for further processing
    return anonUser;
  }

  //Register and store new user information
  Future<bool> signUp(
      String firstName, String lastName, String email, String password) async {
    try {
      await _signUpHelper(
        email.trim(),
        password.trim(),
      ).then((value) async {
        User? user = _auth.currentUser;
        await _database.collection("users").doc(user!.uid).set({
          'user_id': user.uid.trim(),
          'first_name': firstName.trim(),
          'last_name': lastName.trim(),
          'email': email.trim(),
          'user_role': 'customer'.trim(),
          'reg_date_time': user.metadata.creationTime,
          'urlAvatar': _urlDefaultAvatar.trim()
        });
        await initializeUserDB();
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Register new user with user name and password
  Future<void> _signUpHelper(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Update Username and Password
  Future<bool> updateLoginCredential(String email, String password) async {
    try {
      await _auth
          .currentUser!
          .updatePassword(password);
      await _auth
          .currentUser!
          .updateEmail(email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Update Username
  Future<void> updateUsername(String email) async {
    try {
      await _auth
          .currentUser!
          .updateEmail(email);
    } catch (e) {
      print(e);
    }
  }

  //Update Password
  Future<void> updatePassword(String password) async {
    try {
      await _auth
          .currentUser!
          .updatePassword(password);
    } catch (e) {
      print(e);
    }
  }

  //Signing user out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
