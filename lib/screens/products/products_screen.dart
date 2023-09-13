import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';
import 'package:shop_app/shared/styles/constColors.dart';
//single

class produts_screen extends StatelessWidget {
  const produts_screen({super.key});

  @override
  Widget build(BuildContext context) {
    MyHomeModel? homeModel;
    return BlocConsumer<shopCubit, shopState>(
      listener: (context, state) {
        if (state is ChangeToFavoritesSuccessState) {
          if (state.model.status == false) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: baseColor,
                content: Text(
                  state.model.message.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )));
          }
        }
        // TODO: implement listener

        //❌ if (state is shopHomeSuccessgState) {
        //   if (state.model != null) {
        //     homeModel = state.model;
        //   }
        // }   no that way is not good❌
        //print(homeModel!.data?.banners?.map((e) => e.id)) ;
        // print(homeModel!.data.banners.map((e) => e.image));
      },
      builder: (context, state) {
        var cubit = shopCubit.get(context);
        late var homeModel = shopCubit.get(context).homeModel;
        late var categoriesModel = shopCubit.get(context).categoriesModel;
        return ConditionalBuilder(
            condition: homeModel != null,
            builder: (context) =>
                productsBuilder(context, homeModel!, categoriesModel!, cubit),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
        // Center(child: Text('produts screen')),
      },
    );
  }

  Widget productsBuilder(context, MyHomeModel homeModel,
      CategoriesModel categoriesModel, shopCubit cubit) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), // oonscrolling bouncing :🏄‍♀️
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items:
                  // 1-items type ==list ✅
                  // 2-loop on banner list contain map to get image from it "banners.map((e)"✅
                  // 3-convert image to list  ✅
                  homeModel.data.banners
                      .map((e) => Image(
                            image: NetworkImage(e.image.toString()),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ))
                      .toList(),
              options: CarouselOptions(
                enableInfiniteScroll: true, //loop
                initialPage: 0, //frist page
                height: MediaQuery.of(context).size.height * 0.25,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              )),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height:
                      120, // it doesn't work with singlechild if havn't size so we use container
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var category = categoriesModel.data[index];
                        return CategoryItemBuilder(context, category);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel.data.length),
                ),

                //CategoryItemBuilder(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'New products',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              childAspectRatio: 1 / 1.67, //spaces between row in grid
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(homeModel.data.banners.length, (index) {
                var product = homeModel.data.products[index];
                return BuildgridviewItem(product, context, cubit);
              }),
            ),
          )
        ],
      ),
    );
  }

  Container BuildgridviewItem(ProductsModel product, context, shopCubit cubit) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(product.image.toString()),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              if (product.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(product.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.4,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      product.price.round().toString(),
                      style: TextStyle(color: baseColor, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    if (product.discount != 0)
                      Text(
                        product.old_price.round().toString(),
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

                            cubit.ChangeToFavorites(productId: product.id!);
                            // print();
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: (cubit.favoriteMap[product.id]!)
                                ? const Color.fromARGB(255, 219, 65, 30)
                                : Colors.white,
                            size: 18,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CategoryItemBuilder(context, Category category) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image(
            width: 120,
            height: 120,
            image: NetworkImage(category.image.toString())),
        Container(
          width: 120,
          height: 25,
          alignment: Alignment.center,
          color: baseColor,
          child: Text(
            category.name.toString(),
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: 18),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
