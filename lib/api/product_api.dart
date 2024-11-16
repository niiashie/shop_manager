import 'package:shop_manager/api/base_api.dart';
import 'package:shop_manager/constants/api.dart';
import 'package:shop_manager/models/api_response.dart';

class ProductApi extends BaseApi {
  Future<ApiResponse> addProduct(Map<String, dynamic> params) async {
    var response = await post(url: Api.addProduct, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getProducts(String branchId, {int? page = 1}) async {
    var response = await get(
        url: "${Api.getProducts}/$branchId", queryParameters: {"page": page});
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getAllProducts(String branchId) async {
    var response = await get(
      url: "${Api.getAllProduct}/$branchId",
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

  Future<ApiResponse> getPendingRequisition(String branchId) async {
    var response = await get(url: "${Api.pendingRequisition}/$branchId");
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

  Future<ApiResponse> getAllRequisitions(int page, String branchId) async {
    var response = await get(
        url: "${Api.getRequisitions}/$branchId",
        queryParameters: {"page": page});
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getUnpaidTransactions(String branchId) async {
    var response = await get(url: "${Api.getUnpaidTransactions}/$branchId");
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> confirmUnpaidTransactions(
      Map<String, dynamic> data) async {
    var response = await post(url: Api.confirmCreditSalePayment, data: data);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> reverseUnpaidTransactions(
      Map<String, dynamic> data) async {
    var response = await post(url: Api.reverseCreditSale, data: data);
    return ApiResponse.parse(response);
  }
}
