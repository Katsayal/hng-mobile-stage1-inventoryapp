import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;
import 'dart:io';
import '../data/database.dart';
import '../providers/product_provider.dart';

class AddEditScreen extends StatefulWidget {
  final Product? product;
  const AddEditScreen({super.key, this.product});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late String _name;
  late int _quantity;
  late double _price;
  late String _category;
  XFile? _imageFile;

  final List<String> _categories = ['General', 'Electronics', 'Clothes', 'Food'];

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!.name;
      _quantity = widget.product!.quantity;
      _price = widget.product!.price;
      _category = widget.product!.category;
      if (widget.product!.imagePath != null && widget.product!.imagePath!.isNotEmpty) {
        _imageFile = XFile(widget.product!.imagePath!);
      }
    } else {
      _name = '';
      _quantity = 0;
      _price = 0.0;
      _category = 'General';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v!.isEmpty ? 'Enter name' : null,
                onSaved: (v) => _name = v!,
              ),
              TextFormField(
                initialValue: _quantity.toString(),
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Enter quantity' : null,
                onSaved: (v) => _quantity = int.parse(v!),
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Enter price' : null,
                onSaved: (v) => _price = double.parse(v!),
              ),
              DropdownButtonFormField<String>(
                value: _category,
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              _imageFile == null
                  ? Container(height: 150, color: Colors.grey[200], child: const Center(child: Text('No Image')))
                  : Image.file(File(_imageFile!.path), height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    onPressed: () async {
                      final picked = await _picker.pickImage(source: ImageSource.camera);
                      if (picked != null) setState(() => _imageFile = picked);
                    },
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                    onPressed: () async {
                      final picked = await _picker.pickImage(source: ImageSource.gallery);
                      if (picked != null) setState(() => _imageFile = picked);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final productCompanion = ProductsCompanion(
                      id: widget.product != null ? Value(widget.product!.id) : Value.absent(),
                      name: Value(_name),
                      quantity: Value(_quantity),
                      price: Value(_price),
                      category: Value(_category),
                      imagePath: Value(_imageFile?.path ?? ''),
                    );

                    if (widget.product == null) {
                      await provider.addProduct(productCompanion);
                    } else {
                      await provider.updateProduct(
                        Product(
                          id: widget.product!.id,
                          name: _name,
                          quantity: _quantity,
                          price: _price,
                          category: _category,
                          imagePath: _imageFile?.path ?? '',
                        ),
                      );
                    }

                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
