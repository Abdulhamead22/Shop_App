// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/layout/shop_App/modules/login/cubit_login/login_state.dart';
// import 'package:flutter_application_1/layout/shop_App/dio/dio_helper.dart';
// import 'package:flutter_application_1/layout/shop_App/models/shop_login_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ShopLoginCubit extends Cubit<ShopeLoginState> {
//   ShopLoginCubit() : super(ShopLoginInitialState());

//   static ShopLoginCubit get(context) => BlocProvider.of(context);
//   ShopLoginModel? loginModel;

//   void userLogin({required String email, required String password}) {
//     emit(ShopLoginLodingState());
//     DioHelperShop.postData(
//       url: 'login',
//       data: {
//         'email': email,
//         'password': password,
//       },
//     ).then(
//       (value) {
//         print(value?.data);
//       loginModel=  ShopLoginModel.fromJson(value?.data);
      
//         emit(ShopLoginSuccesState(loginModel!));
//       },
//     ).catchError((error) {
//       print(error.toString());
//       emit(ShopLoginErrorState());
//     });
//   }

//   Widget suffixIcon = const Icon(Icons.visibility_outlined);
//   bool isPassword = true;
//   void changeSuffixIcon() {
//     isPassword = !isPassword;
//     suffixIcon = isPassword
//         ? const Icon(Icons.visibility_outlined)
//         : const Icon(Icons.visibility_off_outlined);
//     emit(ShopChangeIconSuffixState());
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/shop_App/dio/dio_helper.dart';
import 'package:flutter_application_1/layout/shop_App/models/shop_login_model.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/layout/shop_App/modules/login/cubit_login/login_state.dart';

class ShopLoginCubit extends Cubit<ShopeLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  // دالة تسجيل الدخول
  void userLogin({required String email, required String password}) {
    emit(ShopLoginLodingState()); // بدء التحميل
    DioHelperShop.postData(
      url: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        // التحقق من حالة الاستجابة (status code)
        if (value?.statusCode == 200) {
          print(value?.data); // طباعة البيانات المستلمة من الـ API
          loginModel = ShopLoginModel.fromJson(value?.data);

          // التحقق من استجابة الـ API (إذا كانت حالة النجاح true)
          if (loginModel != null && loginModel!.status) {
            CacheHelper.saveData(key: "token", value: loginModel?.data?.token); // تخزين الـ token
            emit(ShopLoginSuccesState(loginModel!)); // تغيير الحالة إلى نجاح
          } else {
            emit(ShopLoginErrorState()); // إذا كان الـ status في الـ loginModel غير ناجح
            toast(loginModel?.message ?? "Login failed", Colors.red); // إظهار رسالة الخطأ
          }
        } else {
          // إذا كانت حالة الاستجابة غير 200
          emit(ShopLoginErrorState());
          toast("Something went wrong. Please try again later.", Colors.red);
        }
      },
    ).catchError((error) {
      // التعامل مع الأخطاء في حال حدوث خطأ في الاتصال
      print(error.toString());
      emit(ShopLoginErrorState());
      toast("Error: ${error.toString()}", Colors.red);
    });
  }

  // التعامل مع الأيقونة الخاصة بكلمة المرور
  Widget suffixIcon = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(ShopChangeIconSuffixState()); // تغيير الحالة للأيقونة
  }
}
