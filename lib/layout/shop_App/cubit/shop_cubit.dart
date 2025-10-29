import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_state.dart';
import 'package:flutter_application_1/layout/shop_App/dio/dio_helper.dart';
import 'package:flutter_application_1/layout/shop_App/models/categorise_model.dart';
import 'package:flutter_application_1/layout/shop_App/models/change_favorite_model.dart';
import 'package:flutter_application_1/layout/shop_App/models/shop_login_model.dart';
import 'package:flutter_application_1/layout/shop_App/models/shop_model.dart';
import 'package:flutter_application_1/layout/shop_App/modules/catogires/catogires_screen.dart';
import 'package:flutter_application_1/layout/shop_App/modules/favorites/favorites_screen.dart';
import 'package:flutter_application_1/layout/shop_App/modules/products/products_screen.dart';
import 'package:flutter_application_1/layout/shop_App/modules/settings/settings_screen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> type = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  int currentIndex = 0;
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeIndexNavBarState());
  }

  List<BottomNavigationBarItem> typeOfNavBar = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Products",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: "Category",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Setings",
    ),
  ];

  HomeShopModel? homeModel;
  Map<int, bool> favorite = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelperShop.getData(
      url: 'home',
      token: isToken,
    ).then(
      (value) {
        homeModel = HomeShopModel.fromJson(value!.data);
        //print("Response data: ${value!.data}");
        print(homeModel!.status);
        homeModel!.data.products.forEach(
          (element) {
            favorite.addAll({element.id: element.isFavorites});
          },
        );
        print(favorite.toString());
        emit(ShopSuccessHomeDataState());
      },
    ).catchError((error) {
      emit(ShopErorrHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriseData() {
    DioHelperShop.getData(
      url: 'categories',
    ).then(
      (value) {
        categoriesModel = CategoriesModel.fromJson(value!.data);
        //print("Response data: ${value!.data}");
        print(homeModel!.status);
        emit(ShopSuccessCatogiresState());
      },
    ).catchError((error) {
      emit(ShopErorrCatogiresState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void chageFavorites(int productId) {
    favorite[productId] = !favorite[productId]!;
    emit(ShopChangeFavoritesState(changeFavoriteModel!));
    DioHelperShop.postData(
      url: 'favorites',
      token: isToken,
      data: {'product_id': productId},
    ).then(
      (value) {
        changeFavoriteModel = ChangeFavoriteModel.fromjosn(value!.data);
        if (changeFavoriteModel!.status == false) {
          favorite[productId] = !favorite[productId]!;
        }
        emit(ShopSuccessFavoritesState());
      },
    ).catchError((error) {
      favorite[productId] = !favorite[productId]!;
      emit(ShopErorrFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelperShop.getData(
      url: 'profile',
      token: isToken,
    ).then(
      (value) {
        userModel = ShopLoginModel.fromJson(value!.data);

        emit(ShopSuccessUserDataState());
      },
    ).catchError((error) {
      emit(ShopErorrUserDataState());
    });
  }

  void updateUserData({required String name,required String email,required String phone,}) {
      emit(ShopLoadingUpdateUserState());
    DioHelperShop.putData(
      url: 'update-profile',
      token: isToken, 
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then(
      (value) {
        userModel = ShopLoginModel.fromJson(value!.data);

        emit(ShopSuccessUpdateUserState(userModel!));
      },
    ).catchError((error) {
      emit(ShopErorrUpdateUserState());
    });
  }
}
