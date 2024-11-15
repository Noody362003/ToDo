import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs{
  static void showLoading(context){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          content: Row(
            children: [
              Text('Loading...'),
              CircularProgressIndicator()
            ],
          ),
        )
    );
  }

  static void hide(context){
    Navigator.pop(context);
  }

  static void showMessage(context,{String? title,String? body,String? posActionTitle,String? negActionTitle,VoidCallback? posAction,VoidCallback? negAction}){
    showDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: body != null ? Text(body) : null,
        actions: [
          if(posActionTitle!=null)
            MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  posAction?.call();
                  },
                child: Text(posActionTitle)),
          if(negActionTitle!=null)
            MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  negAction?.call();
                },
                child: Text(negActionTitle)),
        ],
      );
    });
  }
}