import 'package:shop_app/models/login_model.dart';

abstract class Loginstates {}

class InitialLoginstate extends Loginstates {}

class LoginLoadingstate extends Loginstates {}

class LoginSuccesstate extends Loginstates {
  LoginModel loginModel;
  LoginSuccesstate(this.loginModel);
}

class LoginErrorstate extends Loginstates {
  final String error;

  LoginErrorstate(this.error);
}

class ChangePasswordVisibilitystate extends Loginstates {}
