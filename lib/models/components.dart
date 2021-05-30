import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/network/shared_preferneces.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

void navigateandFinish(BuildContext context, Widget screen) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => screen));
}

Widget defaultFormField(
    {Function onSubmit,
    bool isPassword=false,
    Function onChanged,
    TextEditingController controller,
    String title,
    Icon icon,
    Function validate,
    TextInputType type,
    Function onTap,
    IconButton suffix}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffix,
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
        labelText: title,
        labelStyle: TextStyle(color: Colors.teal),
        icon: icon,
      ),
      validator: validate,
      keyboardType: type,
      onTap: onTap,
      onChanged: onChanged,
    ),
  );
}


 void showToast({String message,Color color}){
   Fluttertoast.showToast(
       msg: message,
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 5,
       backgroundColor: color,
       textColor: Colors.white,
       fontSize: 16.0,);
 }


 Widget buildSignOutButton(BuildContext context){
    return TextButton(
     child: Text('Sign out'),
     onPressed: (){
       CacheHelper.removeData(key:'token').then((value) {
         navigateandFinish(context, LoginScreen());
       });
     },
   );
 }

void printFullString(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token='';