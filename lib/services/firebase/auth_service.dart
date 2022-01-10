import 'dart:convert';
import 'package:baemin/screen/home/home.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<void> signUpWithPhoneNumber(
      String phoneNumber, String name, String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'phoneNumber': phoneNumber,
        'name': name,
        'password': sha256.convert(utf8.encode(password)).toString(),
        'mailboxID': [
          "6Ca0xyQKQ6xpF5dnrw3P" //! Test data, remove in production
        ],
        'orderID': [
          "dBd5w8Of554d7krwXqog" //! Test data, remove in production
        ],
        'lovedShopID': [],
      });
    } catch (e) {
      print(e);
    }
  }

  void signInWithFacebook({
    required BuildContext context,
    required Function beginState,
    required Function endState,
  }) async {
    FireStoreDB db = FireStoreDB();
    db.initialize();

    try {
      beginState();
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
        facebookLoginResult.accessToken!.token,
      );
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      User? user = FirebaseAuth.instance.currentUser;

      db.checkAccountExists(userData['email']).then((value) async {
        if (!value) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .set({
            'uid': user.uid,
            'email': userData['email'],
            'imageUrl': userData['picture']['data']['url'],
            'name': userData['name'],
            'mailboxID': [
              "6Ca0xyQKQ6xpF5dnrw3P" //! Test data, remove in production
            ],
            'orderID': [
              "dBd5w8Of554d7krwXqog" //! Test data, remove in production
            ],
            'lovedShopID': [],
          });
        }
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      String content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = 'This account exists with a different sign in provider';
          break;
        case 'invalid-credential':
          content = 'Unknown error has occurred';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'The user you tried to log into is disabled';
          break;
        case 'user-not-found':
          content = 'The user you tried to log into does not exist';
          break;
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Log in with Facebook failed'),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
        ),
      );
    } finally {
      endState();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
