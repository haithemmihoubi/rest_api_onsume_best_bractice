import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../models/product.dart';
import '../networking/dio_networking.dart';

class ProductController extends GetxController {
  // initialize logger nd teh dio client class
  final Dio dio = Dio();
  RxBool internetConnection = true.obs;

  // initialize the  internet connection function
  void isInternetConnected() async {
    internetConnection.value = await SimpleConnectionChecker.isConnectedToInternet();
  }
// on ninit function to ninitialize all the  services
  @override
  void onInit() {
    isInternetConnected();
    super.onInit();
  }
  var logger = Logger();
  Future getProductById(int id) async {
    Product? product ;
    try{
      final response = await dio.get('https://fakestoreapi.com/products/$id');
      if (response.statusCode == 200) {
        product = Product.fromJson(response.data);
        //logger.i(product);
        return product;
      }
      } on DioError catch (e) {
      product = null;
      if (e.response != null) {
       /* logger.w('Dio error!');
        logger.w('STATUS: ${e.response?.statusCode}');
        logger.w('DATA: ${e.response?.data}');
        logger.w('HEADERS: ${e.response?.headers}');*/
      } else {
        // Error due to setting up or sending the request

       // logger.wtf(e.message);
      }
    }
    return product ;
  }
  var ListOfProducts = <Product>[].obs;
  Future getAllPruducts() async {
    final response = await dio.get('https://fakestoreapi.com/products');
    try {
      if (response.statusCode == 200) {
        ListOfProducts.value =
            (response.data as List).map((e) => Product.fromJson(e)).toList();
        logger.i(ListOfProducts);
        return ListOfProducts;
      }

    }
    on DioError catch (e) {
      if (e.response != null) {
        logger.wtf('Dio error whiole fetching products list  !');
        logger.w('STATUS code : ${e.response?.statusCode}');
        logger.w('DATA  from the error  : ${e.response?.data}');
        logger.w('HEADERS of the request: ${e.response?.headers}');
      }
      logger.w(" error while fetching products list   ${e.message}") ;

    }
  }

}