class SearchModel {
  bool? status;
  dynamic message;
  Data? data;

  SearchModel.fromjason(Map<String, dynamic> jason) {
    status = jason['status'];
    message = jason['message'];
    //data1
    data =Data.fromjason(jason['data']);
  }
}

class Data {
  List<Product> listOfProducts = [];
  Data.fromjason(Map<String, dynamic> jason) {
    //data2
    if (jason['data'] != null) {
      jason['data'].forEach((e) {
        listOfProducts.add(Product.fromJson(e));
      });
    }
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
