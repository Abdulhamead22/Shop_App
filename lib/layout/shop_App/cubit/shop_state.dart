import 'package:flutter_application_1/layout/shop_App/models/change_favorite_model.dart';
import 'package:flutter_application_1/layout/shop_App/models/shop_login_model.dart';

abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopChangeIndexNavBarState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErorrHomeDataState extends ShopState {}

class ShopSuccessCatogiresState extends ShopState {}

class ShopErorrCatogiresState extends ShopState {}

class ShopChangeFavoritesState extends ShopState {
  ChangeFavoriteModel model;
  ShopChangeFavoritesState(this.model);
}

class ShopSuccessFavoritesState extends ShopState {}

class ShopErorrFavoritesState extends ShopState {}

class ShopLoadingUserDataState extends ShopState {}

class ShopSuccessUserDataState extends ShopState {}

class ShopErorrUserDataState extends ShopState {}

class ShopLoadingUpdateUserState extends ShopState {}

class ShopSuccessUpdateUserState extends ShopState {
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErorrUpdateUserState extends ShopState {}
