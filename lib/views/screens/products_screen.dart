import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_onsume_best_bractice/views/components/product_conmponent.dart';

import '../../controller/product_controller.dart';
import '../../models/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productContrroller = Get.put(ProductController());
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Product Screen'),
      ),
      body: FutureBuilder(
        future: productContrroller.getProductById(1),
        builder: (context, snapshot) {
         return  ProductComponent(product: snapshot.data as Product);
        },
      ),
    );
  }
}
