import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_state.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_cubit.dart';
import 'package:flutter_application_1/layout/shop_App/models/categorise_model.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildCategories(ShopCubit.get(context).categoriesModel!.data!.data[index]),
        separatorBuilder: (context, index) => myDrevider(),
        itemCount: ShopCubit.get(context).
        categoriesModel!.data!.data.length),
     listener: (context, state) {
       
     },);
  }

  Padding buildCategories(DataModel model) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              model.image,
              ),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          SizedBox(
            width: 15,
          ),
          Text(model.name),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}


