// class CategoriesModel{
//  bool ?status;
//   CtegoryDataModel ?data;
//   CategoriesModel.fromjason(Map<String ,dynamic>jason){
//      status=jason['status'];
//      data=CtegoryDataModel.fromjason(jason['data']);
//   }

// }
// class CtegoryDataModel{
//   int ?page;
//   //access from index no value directly
//   List<DataModel> data=[];
// CtegoryDataModel.fromjason(Map<String ,dynamic>jason){
//      page= jason["current_page"];
//      //list
//      jason['data'].forEach((elementofDataList){
//       data.add(DataModel.fromjason( jason['data']));
//      })  ;  
// }
// }



// class DataModel{
//   int ?id;
//   String?name;
//   String?image;
//   DataModel.fromjason(Map<String ,dynamic>jason){
//     id=jason['id'];
//     name=jason['name'];
//     image=jason['image'];
// }
// }
class Category {
  int id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class CategoriesModel {
  bool status;
  List<Category> data;

  CategoriesModel({
    required this.status,
    required this.data,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    List<Category> categories = (json['data']['data'] as List)
        .map((categoryJson) => Category.fromJson(categoryJson))
        .toList();

    return CategoriesModel(
      status: json['status'],
      data: categories,
    );
  }
}