import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});
  @override
  State<AddProductPage> createState() => _AddProductPage();
}

class _AddProductPage extends State<AddProductPage> {
  final String apiUrl =
      'https://uiexercise.theproindia.com/api/Product/AddProduct';
  final productname = TextEditingController();
  final quantity = TextEditingController();

  bool _checkQauntity(String quantity) {
    int quan = int.parse(quantity);
    if (quan <= 0 || quan >= 10) {
      const snackdemo = SnackBar(
        content: Text("No zero or > 10"),
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

  bool _checkProductName(String productname) {
    if (productname.isEmpty) {
      const snackdemo = SnackBar(
        content: Text("productname is not entered"),
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

  void _postData(String productname, String qauntity) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "productName": productname,
        "quantity": int.parse(qauntity),
        "isActive": true
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
      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProduct'),
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: productname,
                  decoration: InputDecoration(
                    hintText: 'Enter ProductName',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 249, 251, 252),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 25.0,
                      horizontal: 30.0,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100)),
                  ),
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
                    if (_checkQauntity(quantity.text) &&
                        _checkProductName(productname.text)) {
                      _postData(productname.text, quantity.text);
                    }
                  },
                  child: const Text('AddProduct +'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
