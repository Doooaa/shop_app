import 'package:bloc/bloc.dart';
import 'package:shop_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/network/remote/endpoint.dart';
import 'package:shop_app/shared/network/remote/Dio_helper.dart';
import 'package:shop_app/screens/search/searchCubit/searchState.dart';

class SearchShopCubit extends Cubit<shopSearchState> {
  SearchShopCubit() : super(SearchShopInitial());

  static SearchShopCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  getSearch({required String textForSearch}) {
    emit(searchLoadingstate());
    dio_helper
        .postData(
            url: 'products/search',//SEARCH,
            
            data: {
              'text': textForSearch,
            },
            token: token)
        .then((value) {
      
      searchModel = SearchModel.fromjason(value!.data);
      
      print("انا في السيرش يبوووي${searchModel!.data!.listOfProducts[0].name}");
      print("انا في السيرش يبوووي${searchModel!.data!.listOfProducts[0].id}");
      print("انا في السيرش يبوووي${searchModel!.data!.listOfProducts[0].price}");
    //print(value!.data);
      emit(searchSuccessState(searchModel!));
    }).catchError((e) {
      print(e.toString());
      emit(searchErrorState(e.toString()));
    });
  }
  
}
