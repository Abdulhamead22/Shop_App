import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_cubit.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_state.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildfavoritesItem(),
            separatorBuilder: (context, index) => myDrevider(),
            itemCount: 10,
            );
      },
      listener: (context, state) {},
    );
  }
}

Widget buildfavoritesItem() {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              if (1 != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Discount",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "name",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '2000',
                      style: const TextStyle(
                          fontSize: 16, color: Colors.blueAccent),
                    ),
                    if (1 != 0) const SizedBox(width: 5),
                    if (1 != 0)
                      Text(
                        '3000',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey,
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
            ),
          ),
        ],
      ),
    ),
  );
}
