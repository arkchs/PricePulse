import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

bool? authSignedIn;
String? uid;
String? userEmail;

Future<String?> registerWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBQQxwxLsizuBc99TkEG2kRMnfU0UWoo_E",
        appId: "1:337794451410:web:00ab4fc4d8a0592526ea0b",
        messagingSenderId: "337794451410",
        projectId: "pricecomparisonwebsite-4c723"),
  );

  final UserCredential userCredential = await _auth
      .createUserWithEmailAndPassword(email: email, password: password);

  final User? user = userCredential.user;

  if (user != null) {
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    return 'Succesfully registered, User ID: ${user.uid}';
  }
  return 'Error: User Registration failed! Please, try again';
}

Future<String> signInWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User? user = userCredential.user;

  if (user != null) {
    // checking if uid or email is null
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email!;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    return 'Successfully logged in, User UID: ${user.uid}';
  }

  return 'Login Attempt Failed. Please, try again.';
}

Future<String> signOut() async {
  await _auth.signOut();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}

final GoogleSignIn googleSignIn = GoogleSignIn();
String? name;
String? imageUrl;

Future<String> signInWithGoogle() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;

  if (user != null) {
    // Checking if email and name is null1
    assert(user.uid != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    return 'Google sign in successful, User UID: ${user.uid}';
  }

  return 'Google sign in failed, Please try again.';
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print("User signed out of Google account");
}
