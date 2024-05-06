import 'package:hello_flutter/AddProductPage.dart';
import 'package:hello_flutter/myhomepage.dart';
import 'package:hello_flutter/orderpage.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ProductDatamodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crusade Retail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Crusade Retail'),
      routes: {
        '/Addproduct': (context) => const AddProductPage(),
        '/Orderpage': (context) => OrderPage(
            product: ProductData(
                ProductId: "", ProductName: "", IsActive: true, Quantity: 0)),
      },
      builder: EasyLoading.init(),
    );
  }
}
