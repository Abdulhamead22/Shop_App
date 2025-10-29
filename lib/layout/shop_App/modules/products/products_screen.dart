import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_cubit.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_state.dart';
import 'package:flutter_application_1/layout/shop_App/models/categorise_model.dart';
import 'package:flutter_application_1/layout/shop_App/models/shop_model.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
        options: CarouselOptions(
              height: 250,
              initialPage: 0,:رقم بداية الصفحة
              viewportFraction: 1.0, نسبة عرض الصفحة
              enableInfiniteScroll: true,التكرار في العرض
              reverse: false,عكس الاتجاه
              autoPlay: true,يمشي تلقائيا
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,شكل الحركة
              scrollDirection: Axis.horizontal,اتجاه الحركة
 */

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {
        if (state is ShopChangeFavoritesState) {
          if (state.model.status==false) {
            toast(state.model.message!, Colors.red);
            
          }
          
        }
      },
      builder: (BuildContext context, ShopState state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) {
            return productBuilder(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context);
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget productBuilder(
      HomeShopModel? model, CategoriesModel? categoriesModel, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data.banners.map(
              (e) {
                return Image(
                  image: NetworkImage(e.image),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ).toList(),
            // استخدمت map لتحويل كل عنصر من نوع BannerModel إلى Widget (صورة)، وبعدين حولتهم إلى List<Widget> باستخدام toList() عشان يتوافق
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categorise',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoriseItem(
                          categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel!.data!.data.length),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Container(
              color: Colors.grey[200],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.5,
                children: List.generate(
                  model!.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductsModel? product, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(product!.image),
              width: double.infinity,
              height: 200,
              //fit: BoxFit.cover,
            ),
            if (product.discount != 0)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        Row(
          children: [
            Text(
              '${product.price.round()}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
            if (product.discount != 0)
              Text(
                '${product.oldPrice.round()}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  // textBaseline: TextBaseline.alphabetic,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            Spacer(),
            IconButton(
              onPressed: () {
                ShopCubit.get(context).chageFavorites(product.id);
              },
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: ShopCubit.get(context).favorite[product.id]!
                    ? Colors.blue
                    : Colors.grey,
                child: Icon(
                  Icons.favorite,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget buildCategoriseItem(DataModel model) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
