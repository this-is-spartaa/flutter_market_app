import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_app/data/model/product_summary.dart';
import 'package:flutter_market_app/ui/pages/product_detail/product_detail_page.dart';
import 'package:intl/intl.dart';

class ProductListItem extends StatelessWidget {
  ProductListItem(this.product);

  final ProductSummary product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailPage(product.id);
          },
        ));
      },
      child: Container(
        height: 120,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.thumbnail.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  // intl 의 숫자 포매팅 클래스
                  NumberFormat('###,###원').format(product.price),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(CupertinoIcons.heart, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '${product.likeCnt}',
                      style: TextStyle(fontSize: 12, height: 1),
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
