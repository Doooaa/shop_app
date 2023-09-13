import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favorites_model.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';
import 'package:shop_app/shared/image_manegar.dart';
import 'package:shop_app/shared/styles/constColors.dart';

class favorites_screen extends StatelessWidget {
  const favorites_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopState>(
      listener: (context, state) {},
      builder: (context, state) {
        shopCubit cubit = shopCubit.get(context);
        return Scaffold(
          body: cubit.getAllFavorite.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    FavoriteModel favoriteModel = cubit.getAllFavorite[index];
                    return _buildFavItems(context, favoriteModel);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 1),
                  itemCount: cubit.getAllFavorite.length,
                )
              : Center(
                  child: TextButton(
                      onPressed: () {
                        cubit.getFavoritesData();
                      },
                      child: const Text("No Favorites")),
                ),
        );
      },
    );
  }

  Widget _buildFavItems(BuildContext context, FavoriteModel model) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 120,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage(model.product.image.toString() ??
                          ImgManager.defaultImage),

                      width: MediaQuery.of(context).size.width * 0.4,
                      height:
                          MediaQuery.of(context).size.height, //120 container
                    ),
                    if (model.product.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        color: const Color.fromARGB(255, 219, 65, 30),
                        child: const Text(
                          'Discount',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
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
                      model.product.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                      )),
                  const Spacer(),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          model.product.price.round().toString(),
                          style: TextStyle(color: baseColor, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (1 != 0)
                          Text(
                            model.product.oldPrice.round().toString(),
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
                              BlocProvider.of<shopCubit>(context)
                                  .ChangeToFavorites(
                                      productId: model.product.id);
                              //  cubit.ChangeToFavorites(productId: product.id);
                              // print();
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: (BlocProvider.of<shopCubit>(context)
                                      .favoriteMap[model.product.id]!)
                                  ? const Color.fromARGB(255, 219, 65, 30)
                                  : Colors.white,
                              size: 18,
                            ),
                          ),
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
