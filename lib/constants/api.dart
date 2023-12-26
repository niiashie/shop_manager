class Api {
  static const int connectionTimeout = 35;
  static const int receiveTimeout = 30;
  static String baseUrl = "http://shop_manager.test/api";
  static const auth = "/auth";
  static const login = "/login";
  static const register = '/register';
  static const addProduct = '/addProduct';
  static const getProducts = "/getProducts";
  static const getAllProduct = "/getAllProduct";
  static const updateProduct = "/updateProduct";
  static const sendRequisition = "/receiveRequisition";
  static const pendingRequisition = "/getPendingRequisition";
  static const acceptRequisition = "/acceptRequisition";
  static const rejectRequisition = "/rejectRequisition";
}
