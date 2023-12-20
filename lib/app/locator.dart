import 'package:shop_manager/services/local_storage.service.dart';

import '../services/app_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerSingleton<DialogService>(DialogService());
  // locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<AppService>(AppService());
  // locator.registerSingleton<PrintService>(PrintService());
  locator.registerSingleton<LocalStorageService>(LocalStorageService());
}
