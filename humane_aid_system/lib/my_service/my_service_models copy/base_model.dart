class BaseModel<T> {
  const BaseModel({
    this.succeeded = false,
    this.message = "In Class Error",
    this.data,
  });

  final bool? succeeded;
  final String? message;
  final T? data;


  factory BaseModel.fromJson({Map<String, dynamic> json = const {}, T? d}) =>
      BaseModel(
        succeeded: json["succeeded"] ??json["Succeeded"]?? false,
        message: json["message"]??json["Message"]?? "In Json Error",
        data: d,
      );
}
/*
class Base2Model<T> {
  const Base2Model({
    this.error,
    this.data,
  });

  final ErrorModel? error;
  final T? data;

  bool get suc => error != null || error!.statusCode == null
      ? false
      : error!.statusCode == 200;

  factory Base2Model.fromJson({Map<String, dynamic> json = const {}, T? d}) =>
      Base2Model(
        data: d,
        error: ErrorModel.fromJson(json),
      );
}
*/