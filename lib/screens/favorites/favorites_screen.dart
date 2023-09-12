import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';
import 'package:shop_app/models/getFavoritesModel.dart';
import 'package:shop_app/shared/styles/constColors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class favorites_screen extends StatelessWidget {
  const favorites_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var getFavoritesModel = shopCubit.get(context).getFavoritesModel;
        // late var homeModel = shopCubit.get(context).homeModel;
        var cubit = shopCubit.get(context);
        return Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) {
                  return buildFavItems(context, getFavoritesModel, index, cubit);
                },
                separatorBuilder: (context, index) => SizedBox(height: 1),
                itemCount:getFavoritesModel!=null? getFavoritesModel.data!.data!.length:0));
      },
    );
  }

  Padding buildFavItems(
    BuildContext context,
    GetFavoritesModel? getFavoritesModel,
   dynamic index,
    shopCubit cubit,
  ) {
    var product = getFavoritesModel?.data!.data![index].product;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 120,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage(product!.image.toString()),

                      width: MediaQuery.of(context).size.width * 0.4,
                      height:
                          MediaQuery.of(context).size.height, //120 container
                    ),
                    if (product.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: Color.fromARGB(255, 219, 65, 30),
                        child: const Text(
                          'Discount',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height,
              // height: 200,
              // width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      //_product.name.toString(),
                      product.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                      )),
                  Spacer(),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          product.price!.round().toString(),
                          style: TextStyle(color: baseColor, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (1 != 0)
                          Text(
                            product.oldPrice!.round().toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 77, 98, 109),
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 22.0,
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                              onPressed: () {
                                print("fav clicked!");

                                cubit.ChangeToFavorites(productId: product.id);
                                // print();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: (cubit.favoriteMap[product.id]!)
                                    ? Color.fromARGB(255, 219, 65, 30)
                                    : Colors.white,
                                size: 18,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
