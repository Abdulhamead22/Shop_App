import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/shop_App/modules/login/cubit_login/login_cubit.dart';
import 'package:flutter_application_1/layout/shop_App/modules/login/cubit_login/login_state.dart';
import 'package:flutter_application_1/layout/shop_App/modules/register/shop_register_screen.dart';
import 'package:flutter_application_1/layout/shop_App/shop_layout.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Key formkey= GlobalKey<FormState>();: عشان اتحكم في form تبعي واقدر اتاكد انو بعت
 */
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    final FocusNode emailfocusNode = FocusNode();
    final FocusNode passwordfocusNode = FocusNode();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopeLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccesState) {
            if (state.loginModel.status) {
              print(state.loginModel.data?.token);
              CacheHelper.saveData(
                      key: "token",
                      value: state.loginModel.data?.token)
                  .then(
                (value) {
                  //عملتها عشان لما اعمل تسجيل خروج ثم اعاود تسجيل الدخول يقوم يدخل الجديد معاه مش يضل على القديم
                  isToken = state.loginModel.data?.token;
                  toast(state.loginModel.message, Colors.green);
                  navigatFinish(context, const ShopLayout());
                },
              );
            } else {
              toast(state.loginModel.message, Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          "Login now to browse",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        textField(
                          controller: emailController,
                          input: "Email",
                          icon: const Icon(Icons.email_outlined),
                          validate: (value) {
                            if (value==null) {
                              return "must have email";
                            }
                            return null;
                          },
                          focusNode: emailfocusNode,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        textField(
                          controller: passwordController,
                          input: "Password",
                          icon: const Icon(Icons.lock_outline),
                          validate: (value) {
                            if (value==null) {
                              return "password is short";
                            }
                            return null;
                          },
                          onsubmit: (value) {
                            //عملتها هنا كمان عشان لما اضغط ينتقل مباشرة للي بعدها
                            if (formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          keytype: TextInputType.visiblePassword,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixIcons: IconButton(
                            onPressed:
                                ShopLoginCubit.get(context).changeSuffixIcon,
                            icon: ShopLoginCubit.get(context).suffixIcon,
                          ),
                          focusNode: passwordfocusNode,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: "Login",
                              isuper: true,
                            );
                          },
                          condition: state is! ShopLoginLodingState,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account? "),
                            defaultTextButton(
                              function: () {
                                navigatTo(context, const RegisterScreen());
                              },
                              text: "Register",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
