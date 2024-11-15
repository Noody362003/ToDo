import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utilities/assets_manager.dart';
import '../../../core/utilities/dialogs/dialogs.dart';
import '../../../core/utilities/email_validation.dart';
import '../../../core/utilities/routes_manager.dart';
import '../../../database_Manager/user_model.dart';
import 'custom_elevatedButton.dart';
import 'custom_textfield.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Image(image: AssetImage(AssetsManager.logo),width: 200,height: 200,),

              Text('Email'),
              SizedBox(height: 12.h,),
              CustomFormField(
                hintText: 'Enter Your Email',
                validator: (input){
                  if(input==null || input.trim().isEmpty)
                  {
                    return 'please enter email';
                  }
                  if(!isValidEmail(input))
                  {
                    return 'email bad format';
                  }
                  return null;
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              Text('Password'),
              SizedBox(height: 12.h,),
              CustomFormField(
                hintText: 'Enter Your Password',
                validator: (input){
                  if(input==null || input.trim().isEmpty)
                  {
                    return 'please enter password';
                  }
                  return null;
                },
                controller: passwordController,
                isPassword: true,
              ),

              CustomButton(onPress: login, label: 'Login')
            ],
          ),
        ),
      ),
    );
  }
  void login()async
  {
    if(formKey.currentState?.validate()==false) return;

    try {
      Dialogs.showLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if(mounted)
      {
        Dialogs.hide(context);
      }
      if(mounted)
      {
        Dialogs.showMessage(context,body: 'User Logged in',posActionTitle: 'ok',posAction: (){Navigator.pushReplacementNamed(context, RoutesManager.home);});
      }
    } on FirebaseAuthException catch (e) {
      if(mounted)
      {
        Dialogs.hide(context);
      }
      late String message;
      if (e.code == 'invalid-credential') {
        message= 'Wrong email or password';
      }
      if(mounted){
        Dialogs.showMessage(
            context,
            title: 'Error',
            body: message,
            posActionTitle: 'ok',
            posAction: (){
              Dialogs.hide(context);
            });
      }
    } catch (e) {
      if(mounted){
        Dialogs.hide(context);
        Dialogs.showMessage(context,title: 'Error',body: e.toString(),posActionTitle: 'try again');
      }
    }
  }

  void readUserFromFirebase(String uid)
  {
    CollectionReference users=FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference user=users.doc(uid);
  }
}
