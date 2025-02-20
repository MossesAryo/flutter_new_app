import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/screens/homescreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

Future<void> signInWithGoogle(BuildContext context) async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        "850921503143-p6bpqak14s5hqr0ik3pl000dob1kifdv.apps.googleusercontent.com",
    scopes: ['email', 'profile'],
  );

  GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser == null) return; // User canceled sign-in

  GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  User? user = userCredential.user; // Get the authenticated user

  if (user != null) {
    String? userName = user.displayName; // Get username
    String? userEmail = user.email; // Get email

    // Navigate to HomeScreen and pass the username & email
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(
                username: userName ?? "No Name",
                email: userEmail ?? "No Email",
              )),
    );
  }
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(color: Colors.white),
              child: Expanded(
                child: Column(
                  children: [
                    TextField(
                        decoration: InputDecoration(
                      labelText: "Username",
                    )),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                        decoration: InputDecoration(
                      labelText: "Email",
                    )),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Submit")),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        signInWithGoogle(context);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://banner2.cleanpng.com/20180413/rfe/avfci721i.webp'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
