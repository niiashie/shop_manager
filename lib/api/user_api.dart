import 'package:shop_manager/api/base_api.dart';
import 'package:shop_manager/constants/api.dart';
import 'package:shop_manager/models/api_response.dart';

class UsersApi extends BaseApi {
  Future<ApiResponse> updateUser(Map<String, dynamic> data) async {
    var response = await post(url: Api.updateUser, data: data);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getUsers() async {
    var response = await get(url: Api.users);
    return ApiResponse.parse(response);
  }
}
