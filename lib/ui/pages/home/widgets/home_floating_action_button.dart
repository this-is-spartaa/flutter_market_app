import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/home_view_model.dart';
import 'package:flutter_market_app/ui/pages/product_write/product_write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        if (ref.watch(homeViewModel) != 0) {
          return const SizedBox();
        }
        return FloatingActionButton.extended(
          label: const Text(
            "상품 등록",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ProductWritePage();
              },
            ));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Theme.of(context).highlightColor,
          foregroundColor: Colors.white,
        );
      },
    );
  }
}
