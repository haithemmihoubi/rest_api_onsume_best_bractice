import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/product.dart';
import '../networking/dio_networking.dart';

class ProductController extends GetxController {
  // initialize logger nd teh dio client class
  final Dio dio = Dio();

  var logger = Logger();
  Future getProductById(int id) async {
    Product? product ;
    try{
      final response = await dio.get('https://fakestoreapi.com/products/$id');
      if (response.statusCode == 200) {
        product = Product.fromJson(response.data);
        logger.i(product);
        return product;
      }
      } on DioError catch (e) {
      product = null;
      if (e.response != null) {
        logger.w('Dio error!');
        logger.w('STATUS: ${e.response?.statusCode}');
        logger.w('DATA: ${e.response?.data}');
        logger.w('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request

        logger.wtf(e.message);
      }
    }
    return product ;
  }


}