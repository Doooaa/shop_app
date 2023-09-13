class FavoritesModel {
  bool? status;
  String? message;
  FavoritesModel.fromjason(Map<String, dynamic> jason) {
    message = jason['message'];
    status = jason['status'];
  }
}
