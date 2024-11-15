import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utilities/assets_manager.dart';
import 'package:todo/core/utilities/colors_manager.dart';
import 'package:todo/core/utilities/dialogs/dialogs.dart';
import 'package:todo/core/utilities/routes_manager.dart';
import 'package:todo/database_Manager/user_model.dart';
import 'package:todo/presentation/screens/Auth/custom_elevatedButton.dart';
import 'package:todo/presentation/screens/Auth/custom_textfield.dart';

import '../../../core/utilities/email_validation.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fullNameController=TextEditingController();

  TextEditingController phoneController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmController=TextEditingController();
GlobalKey<FormState> formKey=GlobalKey();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmController.dispose();
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
              Text('Full Name'),
              SizedBox(height: 12.h,),
              CustomFormField(
                  hintText: 'Enter Your Full Name',
                  validator: (input){
                    if(input==null || input.trim().isEmpty)
                      {
                        return 'please enter your name';
                      }
                    return null;
                  },
                  controller: fullNameController),
              Text('Phone'),
              SizedBox(height: 12.h,),
              CustomFormField(
                  hintText: 'Enter Your Phone',
                  validator: (input){
                    if(input==null || input.trim().isEmpty)
                    {
                      return 'please enter phone';
                    }
                    return null;
                  },
                  controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
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
              Text('Confirm Password'),
              SizedBox(height: 12.h,),
              CustomFormField(
                  hintText: 'Confirm Password',
                  validator: (input){
                    if(input==null || input.trim().isEmpty)
                    {
                      return 'please enter your name';
                    }
                    if(input!= passwordController.text)
                      {
                        return "password doesn't match";
                      }
                    return null;
                  },
                  controller: confirmController,
                isPassword: true,
              ),
              CustomButton(onPress: SignUp, label: 'Sign Up')
            ],
          ),
        ),
      ),
    );

  }

  void SignUp()async
  {
    if(formKey.currentState?.validate()==false) return;

    try {
      Dialogs.showLoading(context);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      addUserToFireStore(credential.user!.uid);
      if(mounted)
        {
          Dialogs.hide(context);
        }
      if(mounted)
        {
          Dialogs.showMessage(context,body: 'User Registered',posActionTitle: 'ok',posAction: (){Navigator.pushReplacementNamed(context, RoutesManager.login);});
        }
    } on FirebaseAuthException catch (e) {
      if(mounted)
      {
        Dialogs.hide(context);
      }
      late String message;
      if (e.code == 'weak-password') {
        message= 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message= 'The account already exists for that email.';
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

  void addUserToFireStore(String userId)async{
    UserDM user=UserDM(
        id: userId,
        fullName: fullNameController.text,
        email: emailController.text,
        phone: phoneController.text);
    CollectionReference usersCollection=FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDoc=usersCollection.doc(userId);
    await userDoc.set(user.toFirebase());
  }
}
