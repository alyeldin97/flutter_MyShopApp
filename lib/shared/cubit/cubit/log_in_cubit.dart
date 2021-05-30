import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cubit/states/log_in_states.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/dio_helper.dart';

import '../../end_points.dart';

class LoginCubit extends Cubit<Loginstates> {
  LoginCubit() : super(InitialLoginstate());

  static LoginCubit get(context) {
    return BlocProvider.of(context);
  }



  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilitystate());
  }

  LoginModel loginModel;

  void userLogin

  (

  {@required String email,@required String password
}){
    emit(LoginLoadingstate());
DioHelper.postData(url:LOGIN, data: {
'email':email,
'password':password
}).then((value) {
  loginModel=LoginModel.fromJSON(value.data);
  print(loginModel.status);
  emit(LoginSuccesstate(loginModel));
}).catchError((error){
  print(email);
  print(password);
  print(error.toString());
  emit(LoginErrorstate(error.toString()));
});
}
}
