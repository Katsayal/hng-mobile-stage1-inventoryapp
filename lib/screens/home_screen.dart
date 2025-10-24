import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import '../providers/product_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/product_card.dart';
import 'add_edit_screen.dart';
import '../data/database.dart';
import '../utils/export_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    final filteredProducts = _searchController.text.isEmpty
        ? productProvider.products
        : productProvider.products
            .where((p) => p.name.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();

    IconData themeIcon = themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Keeper App'),
        actions: [
          // CSV Export
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              final csvData = await productProvider.generateCSV(); // Your CSV generation function
              await exportInventoryCSV(csvData);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('CSV exported and ready to share!')),
              );
            },
          ),

          // Theme toggle
          IconButton(
            icon: Icon(themeIcon),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search products...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text('No products found'))
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (_, index) => ProductCard(product: filteredProducts[index]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditScreen()),
        ),
      ),
    );
  }

}
