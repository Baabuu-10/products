import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/controllers/authController.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  AuthController auth = Get.find<AuthController>();
  TextEditingController name = TextEditingController();
  TextEditingController decription = TextEditingController();
  TextEditingController price = TextEditingController();

  Future<void> addProduct() async {
    try {
      var url =
          Uri.parse("https://flutter-test-server.onrender.com/api/products");
      var res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorizatio': 'Bearer ${auth.getToken}'
        },
        body: jsonEncode({
          'name': name.text,
          'description': decription.text,
          'price': price.text
        }),
      );
      if (res.statusCode == 201) {
        Get.snackbar("Product", "added successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "Error adding product");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "Name"),
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),
            TextField(
              controller: decription,
              decoration: const InputDecoration(labelText: "Description"),
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),
            TextField(
              controller: price,
              decoration: const InputDecoration(labelText: "Price"),
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB9E453),
                  foregroundColor: Colors.black,
                ),
                onPressed: addProduct,
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
