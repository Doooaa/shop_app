import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/shared/network/remote/Dio_helper.dart';

import 'loginState.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? model;
  void userlogin({required String email, required String password}) {
    emit(LoginLoadingState());
    dio_helper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value!.data);
      //pass data to model
      model = LoginModel.fromjason(value.data);

      print(model!.message);
      emit(LoginSuccessgState(model));
    }).catchError((Error) {
      print(Error);
      emit(LoginErrorState(Error.toString()));
    });
  }

  //VisiablityIconState
  bool isvisiable = false;
  IconData icon = Icons.visibility;
  void ChangeVisiablityIcon() {
    if (isvisiable) {
      icon = Icons.visibility_off;
      isvisiable = !isvisiable; //false
    } else {
      icon = Icons.visibility;
      isvisiable = !isvisiable;
    }
    emit(VisiablityIconState());
  }
  // register
}
