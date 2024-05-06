import 'dart:convert';
import 'package:hello_flutter/AddProductPage.dart';
import 'package:hello_flutter/orderpage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_flutter/ProductDatamodel.dart';

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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductData> products = [];
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void _servererror() async {
    const snackdemo = SnackBar(
      content: Text("server error"),
      backgroundColor: Colors.red,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://uiexercise.theproindia.com/api/Product/GetAllProduct'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        products = jsonData.map((data) => ProductData.fromJson(data)).toList();
      });
    } else {
      _servererror();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Addproduct');
              },
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  alignment: Alignment.center,
                  textStyle: const TextStyle(fontSize: 15),
                  backgroundColor: Colors.deepOrange),
              child: const Text('Add Products'),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset('assets/images/default.jpg',
                      height: 40, width: 40),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      "${products[index].ProductName}   ${products[index].Quantity}",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderPage(product: products[index]),
                        ),
                      ).then((value) {
                        setState(() async {
                          final response = await http.get(Uri.parse(
                              'https://uiexercise.theproindia.com/api/Product/GetAllProduct'));
                          if (response.statusCode == 200) {
                            List<dynamic> jsonData = json.decode(response.body);
                            setState(() {
                              products = jsonData
                                  .map((data) => ProductData.fromJson(data))
                                  .toList();
                            });
                          } else {
                            _servererror();
                          }
                        });
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      alignment: Alignment.center,
                      textStyle: const TextStyle(fontSize: 15),
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: const Text('Purchase'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
