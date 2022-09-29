import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rest_api_onsume_best_bractice/views/screens/all_the_products.dart';
import 'package:rest_api_onsume_best_bractice/views/screens/home_screen.dart';

// import get storage
import 'package:get_storage/get_storage.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

void main() async {
 /* await initServices();*/
  runApp(MyApp());
}
// initializing all the services which has to be running in the background always using getx
 initServices() async {
  print('starting services internet connection testing ...');
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => InternetConnected().checkInternetConnection());
  InternetConnected internetConnected = Get.putAsync(()=>InternetConnected().checkInternetConnection()) as InternetConnected;
  final isConnected = await internetConnected.._isConnected;
  print('thisbis the status of the initernet connect ion  $isConnected');

  print('All services started for this application...');
}
// initializing all the controllers which has to be running in the background always using getx
class InternetConnected extends GetxService  {

  var _isConnected =  true.obs;
// initializing the internet connection checker
  @override
  void onInit() {
    SimpleConnectionChecker.isConnectedToInternet();
    super.onInit();
  }
// function to check the internet connection
  Future<bool> checkInternetConnection() async {
    _isConnected.value = await SimpleConnectionChecker.isConnectedToInternet();
    return _isConnected.value;
  }

}

class MyApp extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // You can optionally redirect all the logging messages from Get. If you want to use your own, favourite logging package, and want to capture the logs there:
    void localLogWriter(String text, {bool isError = false}) {
      Logger().i(text);
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: localLogWriter,
      getPages: [
        GetPage(
            name: '/',
            page: () {
              return box.hasData('token') ? HomePage() : AllProducts();
            }),
        GetPage(name: '/products', page: () => AllProducts()),
      ],
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}
