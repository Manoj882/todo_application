import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/utils/general_text_field.dart';
import '/widgets/general_alert_dialog.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: basepadding,
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Register with email and password",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                  isObscure: true,
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
                      GeneralAlertDialog().customLoadingDialog(context);
                      if (formKey.currentState!.validate()) {
                        final email = emailController.text;
                        final password = passwordController.text;

                        try{
                        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        }
                        on FirebaseAuthException catch(e){
                          print(e.code);
                          String message = "";
                          if(e.code == "email-already-in-use"){
                           message = "The email address is already used";
                          }
                          else if(e.code == "invalid-email"){
                            message = "The email address is invalid";
                          }
                          else if(e.code == "weak-password"){
                            message = "Your password is too weak, try adding alphaneumeric characters";
                          }

                           Navigator.of(context).pop();             
                          GeneralAlertDialog().customAlertDialog(context, message);
                        }
                          catch(ex){
                          Navigator.of(context).pop();
                          GeneralAlertDialog().customAlertDialog(context, ex.toString());
                          // print("The error is: ${ex.toString()}");
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
