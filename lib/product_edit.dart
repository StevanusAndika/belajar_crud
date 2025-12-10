import 'package:flutter/material.dart';
import 'database_instance.dart';
import 'product_model.dart';

class ProductEdit extends StatefulWidget {
  final ProductModel product;

  const ProductEdit({required this.product, super.key});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final db = DatabaseInstance();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name ?? "";
    categoryController.text = widget.product.category ?? "";
  }

  Future updateProduct() async {
    final database = await db.database;

    await database.update(
      db.table,
      {
        "name": nameController.text,
        "category": categoryController.text,
        "updated_at": DateTime.now().toIso8601String(),
      },
      where: "id = ?",
      whereArgs: [widget.product.id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Produk"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Kategori"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateProduct();
                Navigator.pop(context);
              },
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
