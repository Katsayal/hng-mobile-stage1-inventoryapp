import 'dart:io';
import 'package:flutter/material.dart';
import '../data/database.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'package:intl/intl.dart';
import '../screens/add_edit_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final NumberFormat formatCurrency = NumberFormat.currency(symbol: '₦', decimalDigits: 2);

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: product.imagePath != null && product.imagePath!.isNotEmpty
            ? Image.file(File(product.imagePath!), width: 50, height: 50, fit: BoxFit.cover)
            : Container(width: 50, height: 50, color: Colors.grey[300], child: const Icon(Icons.image)),
        title: Text(product.name),
        subtitle: Text(
          'Qty: ${product.quantity} | ${formatCurrency.format(product.price)}\nCategory: ${product.category}',
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddEditScreen(product: product)),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Delete ${product.name}?'),
                    content: const Text('Are you sure you want to remove this product?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () {
                          provider.deleteProduct(product.id);
                          Navigator.pop(context);
                        },
                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
