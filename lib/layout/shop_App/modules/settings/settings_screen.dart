import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_cubit.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_state.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey=GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) {
            var model = ShopCubit.get(context).userModel!;
            nameController.text = model.data!.name!;
            emailController.text = model.data!.email!;
            phoneController.text = model.data!.phone!;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    textField(
                      controller: nameController,
                      keytype: TextInputType.name,
                      input: 'Name',
                      icon: Icon(Icons.person),
                      validate: (value) {
                        if (value==null) {
                          return 'Name must not embty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      controller: emailController,
                      keytype: TextInputType.emailAddress,
                      input: 'Email',
                      icon: Icon(Icons.email),
                      validate: (value) {
                        if (value==null) {
                          return 'Email must not embty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      controller: phoneController,
                      keytype: TextInputType.phone,
                      input: 'Phone',
                      icon: Icon(Icons.phone),
                      validate: (value) {
                        if (value==null) {
                          return 'Phone must not embty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                        if (formkey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                        },
                        text: "Update"),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: "LogOut"),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
