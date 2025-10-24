import 'package:flutter/material.dart';
import '../data/database.dart';
import '../data/product_dao.dart';

class ProductProvider extends ChangeNotifier {
  final ProductDao dao;
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductProvider(this.dao) {
    dao.watchAllProducts().listen((event) {
      _products = event;
      notifyListeners();
    });
  }

  Future<void> addProduct(ProductsCompanion product) async {
    await dao.insertProduct(product);
  }

  Future<void> updateProduct(Product product) async {
    await dao.updateProduct(product);
  }

  Future<void> deleteProduct(int id) async {
    await dao.deleteProduct(id);
  }

  Future<String> generateCSV() async {
    if (_products.isEmpty) {
      return '';
    }

    final csvData = StringBuffer();
    csvData.writeln('ID,Name,Quantity,Price,Category'); 
    
    for (var p in _products) {
      csvData.writeln('${p.id},"${p.name}",${p.quantity},${p.price},"${p.category}"');
    }
    return csvData.toString();
  }

}