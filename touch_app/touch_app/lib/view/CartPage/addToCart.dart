// ignore_for_file: file_names

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/product.dart';

class AddToCart {
  static addToCart(Product data, BuildContext context) {
    bool contains = itemsOnCart.contains(data);
    try {
      if (contains == true) {
        const AdvanceSnackBar(
          textSize: 14.0,
          bgColor: Colors.red,
          message: 'You have added this item to cart before',
          mode: Mode.ADVANCE,
          duration: Duration(seconds: 5),
        ).show(context);
        Navigator.pop(context);
      } else {
        itemsOnCart.add(data);
        const AdvanceSnackBar(
          textSize: 14.0,
          bgColor: Colors.red,
          message: 'Successful added to your cart',
          mode: Mode.ADVANCE,
          duration: Duration(seconds: 5),
        ).show(context);
        Navigator.pop(context);
      }
    } catch (e) {
      rethrow;
    }
  }
}
