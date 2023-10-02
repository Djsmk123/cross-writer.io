import 'package:equatable/equatable.dart';

class ApiResponseModel extends Equatable {
  final String? message;
  final String? error;
  const ApiResponseModel({required this.message, this.error});
  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(message: json['Message'], error: json['Error']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'error': error};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
