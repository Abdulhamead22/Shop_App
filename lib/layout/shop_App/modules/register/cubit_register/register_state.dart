import 'package:flutter_application_1/layout/shop_App/models/shop_login_model.dart';

abstract class ShopeRegisterState {}

class ShopRegisterInitialState extends ShopeRegisterState {}

class ShopRegisterLodingState extends ShopeRegisterState {}

class ShopRegisterSuccesState extends ShopeRegisterState {
  final  ShopLoginModel loginModel;
  ShopRegisterSuccesState(this.loginModel);
}

class ShopRegisterErrorState extends ShopeRegisterState {}

class ShopRegisterChangeIconSuffixState extends ShopeRegisterState {}
