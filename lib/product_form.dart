import 'package:flutter/material.dart';
import 'database_instance.dart';
import 'product_model.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final db = DatabaseInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Data Produk"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Kategori",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final product = ProductModel(
                  name: nameController.text,
                  category: categoryController.text,
                  createdAt: DateTime.now().toIso8601String(),
                  updatedAt: DateTime.now().toIso8601String(),
                );

                await db.insertProduct(product);
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
