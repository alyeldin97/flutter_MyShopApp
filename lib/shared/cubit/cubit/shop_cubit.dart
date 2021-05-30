import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/components.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';
import 'package:shop_app/shared/dio_helper.dart';
import 'package:shop_app/shared/network/shared_preferneces.dart';

import '../../end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;

  List<Widget> screens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    //print(homeModel.data.products[0].oldPrice);
    print(token);
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorite(int id) {
    favorites[id] = !favorites[id];
    emit(ChangeFavoriteState());

    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': id,
            },
            token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print('data:${value.data}');
      if (!changeFavoritesModel.status) {
        favorites[id] = !favorites[id];
      }else{
        getFavorites();
      }
      emit(ChangeFavoriteSuccessState(changeFavoritesModel));
    }).catchError((error) {
      favorites[id] = !favorites[id];
      emit(ChangeFavoriteErrorState(error));
    });
  }

  LoginModel loginModel;
  
  void getUserData(){
    emit(GetUserDataFaLoadingState());
    DioHelper.getData(url: PROFILE, token:token).then((value) {
      loginModel= LoginModel.fromJSON(value.data);
      //print('USER DATA arrow down');
      //print(value.data);
      emit(GetUserDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetUserDataErrorState(error));
    });
  }

  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(ChangeGetFavoriteLoadingState());
    DioHelper.getData(url: FAVORITES,token: token)
        .then((value)  {

          favoritesModel= FavoritesModel.fromJson(value.data);
          //print(value.data.toString());
          emit(ChangeGetFavoriteSuccessState());
    })
        .catchError((error) {
          print(error.toString());
      emit(ChangeGetFavoriteErrorState(error));
    });
  }

  void getHomeData() async {
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJSON(value.data);
      //print(homeModel.data.banners[0].image);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      //print(favorites);

      emit(ShopSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error));
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() async {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJSON(value.data);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorState(error));
    });
  }
}
