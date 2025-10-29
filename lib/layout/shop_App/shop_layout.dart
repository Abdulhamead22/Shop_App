import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_App/modules/search/search_screen.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_cubit.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_state.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {},
      builder: (BuildContext context, ShopState state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Shop App"),
            actions: [
              IconButton(
                onPressed: () {
                  navigatTo(context, const SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: cubit.typeOfNavBar,
          ),
          body: cubit.type[cubit.currentIndex],
        );
      },
    );
  }
}
