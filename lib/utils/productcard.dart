import 'package:flutter/material.dart';
import 'package:hello_flutter/ProductDatamodel.dart';
import 'package:hello_flutter/orderpage.dart';

class ProductCard extends StatelessWidget {
  final ProductData product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(product.ProductName),
              subtitle: Text('${product.Quantity} '),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(product: product)));
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        alignment: Alignment.center,
                        textStyle: const TextStyle(fontSize: 15),
                        backgroundColor: Colors.deepOrange),
                    child: const Text('Purchase'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
