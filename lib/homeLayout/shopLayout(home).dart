import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/SharedWidget.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';
import 'package:shop_app/screens/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = shopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text("Shop App", style:  TextStyle(
                     // color: Color.fromARGB(255, 72, 77, 79),
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ), 
                    ),
                  actions: [
                    IconButton(onPressed: (){
                   navigateToScreen(context,Search_screen());
                    }, icon:const Icon(Icons.search)),
                  //  IconButton(onPressed: (){cubit.ChangeThemeMode();},
                  //   icon: Icon(Icons.brightness_6_outlined))
                  ],
            ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.BottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.ChangeBottomNavigateBar(index: index);
            },
          ),
          body:cubit.Screen[cubit.currentIndex]
        );
      },
    );
  }
}
