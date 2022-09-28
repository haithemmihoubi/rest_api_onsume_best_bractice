import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: FutureBuilder(
        future: _productController.getAllPruducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(snapshot.data?[index].title ?? ""),
                    subtitle:
                        Text(snapshot.data?[index].price.toString() ?? ""),
                    leading: Image.network(
                      snapshot.data?[index].image ?? "",
                      width: 50,
                      height: 50,
                    ),
                  ),
                );
              },
              itemExtent: Get.height*0.11,
              controller: ScrollController(
                  keepScrollOffset: true, initialScrollOffset: 0),
              cacheExtent: 10,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
