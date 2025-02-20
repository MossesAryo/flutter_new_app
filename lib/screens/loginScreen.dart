import 'package:firebase_auth/firebase_auth.dart';
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

  try {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: user.displayName ?? "No Name",
            email: user.email ?? "No Email",
          ),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign in failed. Please try again.')),
    );
  }
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or App Name
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Login Form Card
                  Container(
                    constraints: BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // Handle login
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade600,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'Or continue with',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            SizedBox(height: 24),
                            InkWell(
                              onTap: () => signInWithGoogle(context),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/google.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
