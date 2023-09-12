import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';

class categories_screen extends StatelessWidget {
  const categories_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
     var categoriesModel=shopCubit.get(context).categoriesModel;
        return Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) {
                   
                  return BuildCategoriesItems(categoriesModel!.data[index]);
                },
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: categoriesModel!.data.length));
      },
    );
  }

  Widget BuildCategoriesItems(Category categoriesModel) {
    
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              categoriesModel.image.toString()),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(  categoriesModel.name.toString()),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
