import 'package:shop_manager/api/base_api.dart';
import 'package:shop_manager/constants/api.dart';
import 'package:shop_manager/models/api_response.dart';

class ProductApi extends BaseApi {
  Future<ApiResponse> addProduct(Map<String, dynamic> params) async {
    var response = await post(url: Api.addProduct, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getProducts({int? page = 1}) async {
    var response =
        await get(url: Api.getProducts, queryParameters: {"page": page});
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> updateProduct(Map<String, dynamic> params) async {
    var response = await post(url: Api.updateProduct, data: params);
    return ApiResponse.parse(response);
  }
}
