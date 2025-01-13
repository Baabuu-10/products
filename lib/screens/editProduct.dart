import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/controllers/authController.dart';
import 'package:products/controllers/productController.dart';

class EditProduct extends StatefulWidget {
  final String id;
  final String name;
  final String? description;
  final double price;

  const EditProduct(
      {super.key,
      required this.id,
      required this.name,
      this.description,
      required this.price});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  AuthController auth = Get.find<AuthController>();
  ProductController product = Get.find<ProductController>();

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  Future<void> editProduct() async {
    try {
      var url = Uri.parse(
          "https://flutter-test-server.onrender.com/api/products/${widget.id}");
      var res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${auth.getToken}'
        },
        body: jsonEncode({
          'name': name.text,
          'description': description.text,
          'price': price.text
        }),
      );
      if (res.statusCode == 200) {
        Get.snackbar("Product", "edited successfully");
        product.fetchProducts(auth.getToken);
        Navigator.pop(context);
      }
    } catch (e) {
      Get.snackbar("Error", "Error adding product");
    }
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    description = TextEditingController(text: widget.description);
    price = TextEditingController(text: widget.price.toString());
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
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
              controller: description,
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
                onPressed: editProduct,
                child: const Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
