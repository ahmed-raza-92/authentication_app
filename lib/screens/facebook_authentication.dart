import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FaceBookAuthentication extends StatefulWidget {
  const FaceBookAuthentication({Key? key}) : super(key: key);

  @override
  State<FaceBookAuthentication> createState() => _FaceBookAuthenticationState();
}

class _FaceBookAuthenticationState extends State<FaceBookAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FaceBook Authentication"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  facebookLogin();
                },
              )),
              ElevatedButton(
                child: const Text("Logout"),
                onPressed: () {

                },
              )
            ],
          ),
        ),
      ),
    );
  }
  facebookLogin() async {
    print("FaceBook");
    try {
      final result =
      await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
      }
    } catch (error) {
      print(error);
    }
  }
}
