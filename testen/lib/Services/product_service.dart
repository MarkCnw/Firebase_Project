import 'dart:io';

import 'package:testen/models/product_model.dart';


abstract class ProductService {
  Future<void> createProduct(Product product, File? imageFile);
  Future<void> updateProduct(Product product, File? newImageFile);
  Future<void> deleteProduct(String id);
  Stream<List<Product>> getProducts();
}
