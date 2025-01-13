import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/controllers/authController.dart';
import 'package:products/controllers/productController.dart';

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
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.inventory),
                  title: Text(
                    products.products[index].name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(products.products[index].price.toString()),
                  trailing: Placeholder(),
                  onTap: () {},
                );
              },
              itemCount: products.products.length,
              padding: EdgeInsets.all(0),
            ),
          ),
        )
      ],
    );
  }
}
