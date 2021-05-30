class CategoriesModel{
  bool status;
  CategoriesModelData data;

  CategoriesModel.fromJSON(Map<String,dynamic> json){
    status=json['status'];
    data= CategoriesModelData.fromJSON(json['data']);
  }
}

class CategoriesModelData {
  int currentPage;
  List<dynamic> dataModels=[];

  CategoriesModelData.fromJSON(Map<String ,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      dataModels.add(DataModel.fromJSON(element));
    });
  }
}

class DataModel{
  int id;
  String name;
  String image;

  DataModel.fromJSON(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}