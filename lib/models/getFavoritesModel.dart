class GetFavoritesModel {
  bool? status;
  dynamic message;
  Data? data;



 GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  fromjason(data) {}


}

class Data {
  int? currentPage;
  List<DataOfFavProduct>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;
  int? total;

 

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    //condition
    if (json['data'] != null) {
      data = <DataOfFavProduct>[];
      json['data'].forEach((v) {
        data!.add( DataOfFavProduct.fromJson(v) );
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

 
}

class DataOfFavProduct {
 dynamic id;
  Product? product;

  DataOfFavProduct({this.id, this.product});

  DataOfFavProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

 
}

class Product {
  dynamic id;
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
