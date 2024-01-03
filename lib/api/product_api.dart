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

  Future<ApiResponse> getAllProducts() async {
    var response = await get(
      url: Api.getAllProduct,
    );
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> updateProduct(Map<String, dynamic> params) async {
    var response = await post(url: Api.updateProduct, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> sendRequisition(Map<String, dynamic> data) async {
    var response = await post(url: Api.sendRequisition, data: data);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getPendingRequisition() async {
    var response = await get(url: Api.pendingRequisition);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> acceptRequisition(String id) async {
    var response = await get(url: "${Api.acceptRequisition}/$id");
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> rejectRequisition(String id) async {
    var response = await get(url: "${Api.rejectRequisition}/$id");
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> makeTransaction(Map<String, dynamic> data) async {
    var response = await post(url: Api.makeTransaction, data: data);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getTransactions(Map<String, dynamic> data) async {
    var response = await post(url: Api.getTransactions, data: data);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getDashboardValues(Map<String, dynamic> data2) async {
    var response = await post(url: Api.getDashboardValues, data: data2);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> searchProduct(Map<String, dynamic> data2) async {
    var response = await post(url: Api.searchProduct, data: data2);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getTransactionRange(Map<String, dynamic> data2) async {
    var response = await post(url: Api.getTransactionRange, data: data2);
    return ApiResponse.parse(response);
  }
}
