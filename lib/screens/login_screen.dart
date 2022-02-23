import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_application/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:todo_application/screens/home_screen.dart';
import 'package:todo_application/screens/register_screen.dart';
import 'package:todo_application/utils/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: basepadding,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_to_queue_outlined,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email'),
                        const SizedBox(
                          height: 5,
                        ),
                        GeneralTextField(
                          title: 'email',
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validate: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Password'),
                        const SizedBox(
                          height: 5,
                        ),
                        GeneralTextField(
                          title: 'password',
                          controller: passwordController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          validate: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final email = emailController.text;
                                final password = passwordController.text;

                                final user = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                );
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                    //InkWell
                    //GestureDetector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print('Hello google');
                            //call signIn method of Google sign in
                            final googleSignIn = GoogleSignIn();
                            final user = await googleSignIn.signIn();
                            print(user);

                            if (user != null) {
                              print(user.photoUrl);
                              final authenticatedUser =
                                  await user.authentication;
                              //add to firebase
                              // authenticatedUser.accessToken;
                              // authenticatedUser.idToken;
                              final authProvider =
                                  GoogleAuthProvider.credential(
                                idToken: authenticatedUser.idToken,
                                accessToken: authenticatedUser.accessToken,
                              );
                              await FirebaseAuth.instance
                                  .signInWithCredential(authProvider);

                              //Navi
                              //
                              //gate to home
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: ImageConstants.googleImageUrl,
                                width: 50,
                                placeholder: (_, __) => Container(
                                  width: 50,
                                  height: 50,
                                ),
                              ),

                              // Image.network(
                              //   ImageConstants.googleImageUrl,
                              //   width: 50,
                              //   cacheWidth: 50,
                              // ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final user = await FirebaseAuth.instance
                                    .signInAnonymously();
                                // print('The email is: ${user.user!.email}');
                                // print(user.user!.email ?? 'no mail');

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Login as Guest',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Or'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          
        ),
      ),

    
    );
  }
}