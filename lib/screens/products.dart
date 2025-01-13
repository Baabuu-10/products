import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/controllers/authController.dart';
import 'package:products/controllers/productController.dart';
import 'package:products/screens/addProduct.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  AuthController auth = Get.find<AuthController>();
  final ProductController products = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    products.fetchProducts(auth.getToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProduct());
        },
        child: Text("+"),
      ),
    );
  }
}
