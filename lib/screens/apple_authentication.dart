import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';



class AppleAuthentication extends StatefulWidget {
  const AppleAuthentication({Key? key}) : super(key: key);

  @override
  State<AppleAuthentication> createState() => _AppleAuthenticationState();
}

class _AppleAuthenticationState extends State<AppleAuthentication> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkLoggedInState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apple Authentication"),

      ),
      body: (
          SafeArea(
            child: Center(
              child: ElevatedButton(
                child: const Text("Sign in with Apple"),
                onPressed: () async {

                  var nonc = getNonce();
                  final validCred = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                    nonce: sha256.convert(utf8.encode(nonc)).toString(),
                  );
                  String email = validCred.email ?? '';
                  String name = validCred.givenName ?? '';
                  AuthCredential credential = OAuthProvider("apple.com").credential(
                    idToken: validCred.identityToken,
                    accessToken: validCred.authorizationCode,
                    rawNonce: nonc,
                  );
                  print(validCred.email);
                  print(validCred.givenName);

                  FirebaseAuth.instance.signInWithCredential(credential).then((value){
                    print("success");
                  }).catchError((error){
                    print(error);
                  });

                },
              ),
            )
          )
      ),
    );
  }
  String getNonce({int length = 32}) {
    String _allValues =
    ("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz");

    String finalString = "";
    Random rand = Random.secure();
    for (int i = 0; i < length; i++) {
      finalString += _allValues[rand.nextInt(_allValues.length - 1)];
    }
    return finalString;
  }
}
