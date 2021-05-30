class HomeModel {
  bool status;
  HomeDataModel data;

  HomeModel.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJSON(json['data']);
  }
}

class HomeDataModel {

  List<dynamic> banners = [];
  List<dynamic> products = [];

  HomeDataModel.fromJSON(Map<String, dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJSON(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJSON(element));
    });
  }
}

class BannerModel {
  int id;
  String image;

  BannerModel.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  ProductModel.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inCart = json['in_cart'];
    inFavorites = json['in_favorites'];
  }
}