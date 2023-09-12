import 'package:shop_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/screens/login/login.dart';
import 'package:shop_app/shared/SharedWidget.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';
import 'package:shop_app/shared/styles/constColors.dart';
import 'package:shop_app/shared/network/local/sharedPref.dart';

class settings_screen extends StatelessWidget {
  const settings_screen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? userModel;
    return BlocConsumer<shopCubit, shopState>(listener: (context, state) {
      if (state is GetUserSuccessState) {
           
          userModel = shopCubit.get(context).userModel!.data!;
          print("run am poor "+userModel!.name.toString());
      }
    }, builder: (context, state) {
    
      userModel = shopCubit.get(context).userModel!.data!;
          print("run am poor "+userModel!.name.toString());
      return Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Text(
            ' Account',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              const Image(
                image: AssetImage('assets/images/user.png'),
                width: 100,
                height: 100,
              ),
              Expanded(
                child: Container(
                  height: 100,
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          userModel!.name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'token is ${token}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          userModel!.email.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          userModel!.phone.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 205, 155, 231),
                  Color.fromARGB(158, 156, 16, 161)
                ], // List of colors
                begin:
                    Alignment.topLeft, // Optional: Start point of the gradient
                end: Alignment
                    .bottomRight, // Optional: End point of the gradient
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: baseColor),
            onPressed: () {
              CachHelper.removeKey(key: 'token').then((value) {
                print("is theeeeeeeeee remove token" +
                    CachHelper.getdata(key: 'token').toString());
                print("is theeeeeeeeee remove token" + token.toString());
                token = "";
                print("is theeeeeeeeee remove token" + token.toString());
                navigateandFinish(context, Login());
                shopCubit.get(context).currentIndex = 0;
              });
            },
            child: Text(
              "LOGOUT",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]),
      ));
    });
  }
}
