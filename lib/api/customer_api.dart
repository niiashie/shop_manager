import 'package:shop_manager/api/base_api.dart';
import 'package:shop_manager/constants/api.dart';
import 'package:shop_manager/models/api_response.dart';

class CustomerApi extends BaseApi {
  Future<ApiResponse> addCustomer(Map<String, dynamic> params) async {
    var response = await post(url: Api.addCustomer, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getCustomers({int? page = 1}) async {
    var response =
        await get(url: Api.getCustomer, queryParameters: {"page": page});
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getAllCustomers() async {
    var response = await get(url: Api.getAllCustomers);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> updateCustomer(Map<String, dynamic> params) async {
    var response = await post(url: Api.updateCustomer, data: params);
    return ApiResponse.parse(response);
  }
}
