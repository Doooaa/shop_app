import 'package:shop_app/models/search_model.dart';

class shopSearchState {}

class SearchShopInitial extends shopSearchState {}

class searchLoadingstate extends shopSearchState {}


class searchSuccessState extends shopSearchState {
  SearchModel model;
  searchSuccessState(this.model);
}

class searchErrorState extends shopSearchState {
  final String error;
  searchErrorState(this.error);
}
