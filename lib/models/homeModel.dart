// class HomeModel{

//   bool? status;
//   late dataModel data;
//   HomeModel.fromjson(Map<String,dynamic>json)
//   {
//     status=json['status'];
//     //pass to assin value
//     data= dataModel.fromjson(json['data']);
//   }
// }
// class dataModel
// {
//   late List<dynamic>banners=[];
//   late List<dynamic>products=[];
//    dataModel.fromjson(Map<String,dynamic>json)
//    {
//        // json['banners'] is return a 💥 "list" of map<str,dyn>
//        json['banners'].forEach((element) { 
//           banners.add(element);
//           // print("from for loop");
//           // print(element);

//        });
//           json['products'].forEach((element) { 
//           products.add(element);
//        });

//    }
  
// }
// class bannersModel{
//  int? id;
//   String? image;
//   String? category;
//   String? product;
//   bannersModel.fromjson(Map<String,dynamic>json)
//   {
//      id=json['id'];
//      image=json['image'];
//     category=json['category'];
//     product=json['product'];
//   }
// } 

// class productsModel{
//   int? id;
//   dynamic price;
//   dynamic old_price;
//   dynamic discount;
//   String? image;
//   String? name;
//   String? description;
//   bool?in_favorites;
//   bool?in_cart;
//   productsModel.fromjson(Map<String,dynamic>json){
//    id=json['id'];
//    price=json['price'];
//    old_price=json['old_price'];
//    discount=json['discount'];
//    image=json['image'];
//    name=json['name'];
//    in_favorites=json['in_favorites'];
//    in_cart=json['in_cart'];
//   }
// }

class MyHomeModel {
  bool? status;
  late DataModel data;

  MyHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  late List<BannersModel> banners;
  late List<ProductsModel> products;

  DataModel.fromJson(Map<String, dynamic> json) {
    banners = (json['banners'] as List)
        .map((banner) => BannersModel.fromJson(banner))
        .toList();
    products = (json['products'] as List)
        .map((product) => ProductsModel.fromJson(product))
        .toList();
  }
}

class BannersModel {
  int? id;
  String? image;
  String? category;
  String? product;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}


