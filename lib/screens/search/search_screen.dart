import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/screens/search/searchCubit/searchCubit.dart';
import 'package:shop_app/screens/search/searchCubit/searchState.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';
import 'package:shop_app/shared/styles/constColors.dart';

class Search_screen extends StatelessWidget {
  const Search_screen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchModel? Model;
    List<Product> list = [];
    var controller = TextEditingController();
    return BlocProvider(
      create: (context) => SearchShopCubit(),
      child: BlocConsumer<shopCubit, shopState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocConsumer<SearchShopCubit, shopSearchState>(
            listener: (context, state) {
              if (state is searchSuccessState) {
                if (state.model.status == true) {
                  Model = state.model;
                  list = Model!.data!.listOfProducts;
                  print("iam very good");
                  print("وااااااااااااااااااااء");
                  print(state.model.data!.listOfProducts[0].name);
                }
              }
            },
            builder: (context, state) {
              var cubit = SearchShopCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "search",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 30,
                      // ),
                      TextField(
                        style: Theme.of(context).textTheme.bodyMedium, //
                        controller: controller,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          label: Text('search'),
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          cubit.getSearch(textForSearch: value);
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemBuilder: (context, index) {
                          return buildProductItems(context, list, index, cubit);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 1),
                        itemCount: list.isNotEmpty ? list.length : 0,
                      ))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  InkWell buildProductItems(
    BuildContext context,
    List<Product>? listOfProduct,
    dynamic index,
    SearchShopCubit cubit,
  ) {
    var product = listOfProduct![index];
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 120,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image(
                        image: NetworkImage(product.image.toString()),

                        width: MediaQuery.of(context).size.width * 0.4,
                        height:
                            MediaQuery.of(context).size.height, //120 container
                      ),
                      if (shopCubit
                              .get(context)
                              .homeModel!
                              .data
                              .products[index]
                              .discount !=
                          0)
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
                        product.name.toString(),
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
                            product.price!.round().toString(),
                            style: TextStyle(color: baseColor, fontSize: 14),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 22.0,
                            backgroundColor: Colors.grey[300],
                            child: IconButton(
                                onPressed: () {
                                  print("fav clicked!");
                                  shopCubit.get(context).ChangeToFavorites(
                                      productId: product.id!);
                                  shopCubit
                                      .get(context)
                                      .favoriteMap[product.id];
                                  // print();
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: (shopCubit
                                          .get(context)
                                          .favoriteMap[product.id]!)
                                      ? const Color.fromARGB(255, 219, 65, 30)
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
      ),
    );
  }
}
