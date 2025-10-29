// class CategoriesModel {
//   bool? status;
//   CategoriesData? data;
//   CategoriesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = CategoriesData.fromJson(json['data']);
//   }
// }

// class CategoriesData {
//   late int currentPage;
//   List<DataModel> data = [];
//   CategoriesData.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     json['data'].forEach((element) {
//       data.add(DataModel.fromJson(element));
//     });
//   }
// }

// class DataModel {
//   late int id;
//   late String name;
//   late String image;
//   DataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//   }
// }

class CategoriesModel {
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = CategoriesData.fromJson(json['data']);
    } else {
      data = CategoriesData.empty(); // تفادي null
    }
  }
}

class CategoriesData {
  late int currentPage;
  List<DataModel> data = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 1;
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(DataModel.fromJson(element));
      });
    }
  }

  // كونستركتور بديل في حال data null
  CategoriesData.empty() {
    currentPage = 1;
    data = [];
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
  }
}
