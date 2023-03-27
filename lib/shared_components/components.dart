import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo ({
  required BuildContext context ,
  required Widget widget
})
{
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish ({
  required BuildContext context ,
  required Widget widget,
})
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void showToast({
  required String msg,
  required MsgState state,
})
{
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColor(state: state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum MsgState {success,warning ,error}

Color chooseColor({
  required MsgState state,
})
{
  if(state == MsgState.success)
  {
    return Colors.green;
  }else if(state == MsgState.warning)
  {
    return Colors.amber;
  }else

  {
    return Colors.red;
  }

}