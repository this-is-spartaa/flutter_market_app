import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/product_write/product_write_page.dart';

class ProductDetailActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            print("delete");
          },
          child: Container(
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Icon(Icons.delete),
          ),
        ),
        GestureDetector(
          onTap: () {
            MaterialPageRoute(
              builder: (context) {
                return ProductWritePage();
              },
            );
          },
          child: Container(
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Icon(Icons.edit),
          ),
        )
      ],
    );
  }
}
