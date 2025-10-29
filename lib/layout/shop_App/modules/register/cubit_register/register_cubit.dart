
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/shop_App/dio/dio_helper.dart';
import 'package:flutter_application_1/layout/shop_App/models/shop_login_model.dart';
import 'package:flutter_application_1/layout/shop_App/modules/register/cubit_register/register_state.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopRegisterCubit extends Cubit<ShopeRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({required String name,required String email, required String password,required String phone}) {
    emit(ShopRegisterLodingState()); 
    DioHelperShop.postData(
      url: 'register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
      (value) {
        // التحقق من حالة الاستجابة (status code)
        if (value?.statusCode == 200) {
          print(value?.data); 
          loginModel = ShopLoginModel.fromJson(value?.data);

          // التحقق من استجابة الـ API (إذا كانت حالة النجاح true)
          if (loginModel != null && loginModel!.status) {
            CacheHelper.saveData(key: "token", value: loginModel?.data?.token); // تخزين الـ token
            emit(ShopRegisterSuccesState(loginModel!)); 
          } else {
            emit(ShopRegisterErrorState()); // إذا كان الـ status في الـ loginModel غير ناجح
            toast(loginModel?.message ?? "Login failed", Colors.red); 
          }
        } else {
          emit(ShopRegisterErrorState());
          toast("Something went wrong. Please try again later.", Colors.red);
        }
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState());
      toast("Error: ${error.toString()}", Colors.red);
    });
  }

  Widget suffixIcon = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(ShopRegisterChangeIconSuffixState()); 
  }
}
