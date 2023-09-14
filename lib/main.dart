import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/homeLayout/shopLayout(home).dart';
import 'package:shop_app/screens/login/login.dart';
import 'package:shop_app/screens/onboarding.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/blocObservser.dart';
import 'package:shop_app/shared/network/local/sharedPref.dart';
import 'package:shop_app/shared/network/remote/Dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  dio_helper.init();
  await CachHelper.init();

  var IsEndBoarding = CachHelper.getdata(key: 'onBoarding');
  token = CachHelper.getdata(key: 'token');
  print(token);
  // handeling start screen (login or baord)
  Widget widget;
  // user seew onboarding ✅
  if (IsEndBoarding != null) {
    //user already login ✅
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = Login();
    }
  } //user Satrt app for  frist time ✅
  else {
    widget = BoardingScreen();
  }

  runApp(MyApp(IsEndBoarding: IsEndBoarding, startScreen: widget));
}

class MyApp extends StatelessWidget {
  var IsEndBoarding;
  var startScreen;
  MyApp({super.key, this.IsEndBoarding, this.startScreen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => shopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData()
        ..getFavoritesData(),
      child: MaterialApp(
        darkTheme: darkTheme(),
        theme: liteTheme(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: startScreen,
      ),
    );
  }
}

String? token;
