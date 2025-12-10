import 'package:flutter/material.dart';
import 'database_instance.dart';
import 'product_model.dart';
import 'product_form.dart';
import 'product_edit.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final db = DatabaseInstance();
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future loadProducts() async {
    final database = await db.database;
    final List<Map<String, dynamic>> result =
        await database.query(db.table, orderBy: "id DESC");

    setState(() {
      products = result.map((e) => ProductModel.fromMap(e)).toList();
    });
  }

  Future deleteProduct(int id) async {
    final database = await db.database;
    await database.delete(db.table, where: "id = ?", whereArgs: [id]);
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Produk"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductForm()),
          );
          loadProducts();
        },
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return Card(
            child: ListTile(
              title: Text(p.name ?? ""),
              subtitle: Text("Kategori: ${p.category}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductEdit(product: p),
                          ),
                        );
                        loadProducts();
                      }),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteProduct(p.id!),
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
