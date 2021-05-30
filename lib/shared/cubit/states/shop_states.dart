import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingState extends ShopStates{}
class ShopSuccessState extends ShopStates{}
class ShopErrorState extends ShopStates{
  final Error error;
  ShopErrorState(this.error);
}


class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates{
  final Error error;
  CategoriesErrorState(this.error);
}

class ChangeFavoriteSuccessState extends ShopStates{
  ChangeFavoritesModel changeFavoritesModel;
  ChangeFavoriteSuccessState(this.changeFavoritesModel);
}
class ChangeFavoriteErrorState extends ShopStates{
  Error error;
  ChangeFavoriteErrorState(this.error);
}

class ChangeFavoriteState extends ShopStates{}
class ChangeGetFavoriteLoadingState extends ShopStates{

}
class ChangeGetFavoriteSuccessState extends ShopStates{

}
class ChangeGetFavoriteErrorState extends ShopStates{
  Error error;
  ChangeGetFavoriteErrorState(this.error);
}

class GetUserDataFaLoadingState extends ShopStates{

}
class GetUserDataSuccessState extends ShopStates{

}
class GetUserDataErrorState extends ShopStates{
  Error error;
  GetUserDataErrorState(this.error);
}