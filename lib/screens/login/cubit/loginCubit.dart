import 'loginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/shared/network/remote/Dio_helper.dart';




class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
   late loginModel model;
   static LoginCubit get(context)=>BlocProvider.of(context);
   //  static SearchCubit get(context) =>BlocProvider.of(context);
   void userlogin({required String email,required String password}){
    emit(LoginLoadingState());
        dio_helper.postData(url:'login', data:{
          'email':email,
          'password':password,
        }
        ).then((value) {
          print(value!.data);
           //pass data to model
        model= loginModel.fromjason(value.data);
        
         print(model.message);
          emit(LoginSuccessgState(model));  //send model to use in lisner
        }).catchError((Error){
          print(Error);
            emit(LoginErrorState(Error.toString()));
        });
   }

   //VisiablityIconState
    bool isvisiable=false;
    IconData icon= Icons.visibility;
    void ChangeVisiablityIcon(){
       if(isvisiable) 
       {
        icon=Icons.visibility_off;
        isvisiable=!isvisiable; //false
       }
       else{
        icon= Icons.visibility;
        isvisiable=!isvisiable;
       }
       emit(VisiablityIconState());
    }


}