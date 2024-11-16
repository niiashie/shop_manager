import 'package:shop_manager/api/base_api.dart';

import '../constants/api.dart';
import '../models/api_response.dart';

class AuthApi extends BaseApi {
  Future<ApiResponse> login(Map<String, dynamic> params) async {
    var response = await post(url: Api.login, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> register(Map<String, dynamic> params) async {
    var response = await post(url: Api.register, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getUsers() async {
    var response = await get(url: Api.users);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getBranches() async {
    var response = await get(url: Api.branches);
    return ApiResponse.parse(response);
  }
}
