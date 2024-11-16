class Api {
  static const int connectionTimeout = 35;
  static const int receiveTimeout = 30;
  static String baseUrl =
      "http://shop_manager.test/api"; //"https://pitt.com.frankatsongh.com/api"
  static const auth = "/auth";
  static const login = "/login";
  static const register = '/register';
  static const users = '/getUsers';
  static const branches = '/getBranches';
  static const addBranch = '/addBranch';
  static const updateUser = '/updateUser';
  static const addProduct = '/addProduct';
  static const getCustomer = '/getCustomer';
  static const getAllCustomers = '/getAllCustomers';
  static const addCustomer = '/addCustomer';
  static const updateCustomer = '/updateCustomer';
  static const getProducts = "/getProducts";
  static const getAllProduct = "/getAllProduct";
  static const updateProduct = "/updateProduct";
  static const sendRequisition = "/receiveRequisition";
  static const pendingRequisition = "/getPendingRequisition";
  static const acceptRequisition = "/acceptRequisition";
  static const rejectRequisition = "/rejectRequisition";
  static const makeTransaction = "/makeTransaction";
  static const getTransactions = "/getTransactions";
  static const getDashboardValues = "/getDashboardValues";
  static const searchProduct = "/searchProduct";
  static const getTransactionRange = "/getTransactionRange";
  static const getRequisitions = "/getRequisitions";
  static const getUnpaidTransactions = "/getUnpaidTransactions";
  static const confirmCreditSalePayment = "/confirmCreditSalePayment";
  static const reverseCreditSale = "/reverseCreditSale";
}
