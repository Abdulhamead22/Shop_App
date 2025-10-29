import 'package:flutter_application_1/layout/shop_App/models/shop_login_model.dart';

abstract class ShopeLoginState {}

class ShopLoginInitialState extends ShopeLoginState {}

class ShopLoginLodingState extends ShopeLoginState {}

class ShopLoginSuccesState extends ShopeLoginState {
  final  ShopLoginModel loginModel;
  ShopLoginSuccesState(this.loginModel);
}

class ShopLoginErrorState extends ShopeLoginState {}

class ShopChangeIconSuffixState extends ShopeLoginState {}
