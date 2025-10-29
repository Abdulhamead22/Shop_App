/*
josn['products'].forEach((element) {
      products.add(element);
    }); 
    معناها خود كل عنصر من القائمة هاي وضيفلي اياه على على القائمة الي من الكلاس
 */
class HomeShopModel {
  late bool status;
  late ShopDataModel data;

  HomeShopModel.fromJson(Map<String, dynamic> josn) {
    status = josn["status"];
    data = ShopDataModel.fromJson(josn['data']);
  }
}

class ShopDataModel {
  late List<BannerModel> banners = [];
  late List<ProductsModel> products = [];
  ShopDataModel.fromJson(Map<String, dynamic> josn) {
    josn['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    josn['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String, dynamic> josn) {
    id = josn['id'];
    image = josn['image'];
  }
}

class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String name;
  late String image;
  late bool isFavorites;
  late bool isCart;
  ProductsModel.fromJson(Map<String, dynamic> josn) {
    id = josn['id'];
    price = josn['price'];
    oldPrice = josn['old_price'];
    discount = josn['discount'];
    name = josn['name'];
    image = josn['image'];
    isFavorites = josn['in_favorites'];
    isCart = josn['in_cart'];
  }
}
