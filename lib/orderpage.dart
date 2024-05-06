import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_flutter/ProductDatamodel.dart';

import 'package:http/http.dart' as http;

class OrderPage extends StatelessWidget {
  final quantity = TextEditingController();
  final ProductData product;
  final String apiUrl = 'https://uiexercise.theproindia.com/api/Order/AddOrder';

  OrderPage({super.key, required this.product});
  Future<void> _postproduct(BuildContext context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "customerId": "f9e86959-d568-44b9-2087-08dc44a8c8ef",
        "productId": product.ProductId,
        "quantity": int.parse(quantity.text)
      }),
    );

    if (response.statusCode == 200) {
      const snackdemo = SnackBar(
        content: Text("successfully added"),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      Navigator.pop(context, true);
    } else {
      const snackdemo = SnackBar(
        content: Text("server error"),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }
  }

  bool _checkQauntity(BuildContext context, String quantity) {
    int quan = int.parse(quantity);
    if (quan <= 0) {
      const snackdemo = SnackBar(
        content: Text("No zero"),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderPage'),
        titleTextStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 245, 149, 120),
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 400,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 250, 167, 142),
            border: Border.all(
                color: const Color.fromARGB(255, 245, 159, 67),
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${product.ProductName}",
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              Image.asset('assets/images/default.jpg', height: 60, width: 60),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Quantity:-${product.Quantity}",
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: quantity,
                  decoration: InputDecoration(
                    hintText: 'Enter Quantity',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 249, 251, 252),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 25.0,
                      horizontal: 40.0,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.deepOrange),
                  onPressed: () {
                    if (_checkQauntity(context, quantity.text)) {
                      _postproduct(context);
                    }
                  },
                  child: const Text('Confirm Purchase'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
