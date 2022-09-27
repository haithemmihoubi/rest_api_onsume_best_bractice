import 'package:flutter/material.dart';
import 'package:rest_api_onsume_best_bractice/models/product.dart';

class ProductComponent extends Card {
ProductComponent({required Product product})
      : super(
          child: Card(
            child: Column(
              children: [
                Text(product.title??""),
                Text(product.price.toString()),
              ],
            ),
          ),
        );

}