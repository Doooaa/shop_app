import 'package:shop_app/models/loginModel.dart';

abstract class LoginState{}
 class LoginInitial extends LoginState{}

  class LoginLoadingState extends LoginState{}
  class LoginSuccessgState extends LoginState{
     loginModel? model;
   LoginSuccessgState(this.model);
  }
  
  class LoginErrorState extends LoginState{
    final String error;
    LoginErrorState(this.error);
  }
   class VisiablityIconState extends LoginState{}