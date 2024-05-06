import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hello_flutter/orderpage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hello_flutter/ProductDatamodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<ProductData> products = [];
  late bool _isloading = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isloading = false;
      });
    });
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
          titleTextStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Addproduct');
                },
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    alignment: Alignment.center,
                    backgroundColor: Colors.deepOrange),
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )
          ],
        ),
        body: _isloading
            ? const Center(
                child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 240, 158, 4)),
                strokeWidth: 10,
              ))
            : Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("hello")),
                          Text("vanakkam")
                        ],
                      )),
                  Expanded(
                    child: ListView.builder(
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${products[index].ProductName} ",
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "${products[index].Quantity}",
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderPage(product: products[index]),
                                      ),
                                    ).then((value) {
                                      fetchProducts();
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    alignment: Alignment.center,
                                    textStyle: const TextStyle(
                                        fontSize: 15, color: Colors.white),
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
                  )
                ],
              ));
  }
}
