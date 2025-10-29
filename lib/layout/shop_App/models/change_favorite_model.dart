class ChangeFavoriteModel {
  bool? status;
  String? message;
  ChangeFavoriteModel.fromjosn(Map<String, dynamic> josn) {
    status = josn['status'];
    message = josn['message'];
  }
}
