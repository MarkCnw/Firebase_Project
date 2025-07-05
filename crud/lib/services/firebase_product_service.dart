import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/product_model.dart';
import 'product_service.dart';

class FirebaseProductService implements ProductService {
  final productRef = FirebaseFirestore.instance.collection('products');

  @override
  Future<void> createProduct(Product product, File? imageFile) async {
    String imageUrl = '';
    if (imageFile != null) {
      final ref = FirebaseStorage.instance.ref().child('product_images/${product.id}.jpg');
      await ref.putFile(imageFile);
      imageUrl = await ref.getDownloadURL();
    }

    final productWithImage = product.copyWith(imageUrl: imageUrl);
    await productRef.doc(product.id).set(productWithImage.toMap());
  }

  @override
  Future<void> updateProduct(Product product, File? newImageFile) async {
    String imageUrl = product.imageUrl;
    if (newImageFile != null) {
      final ref = FirebaseStorage.instance.ref().child('product_images/${product.id}.jpg');
      await ref.putFile(newImageFile);
      imageUrl = await ref.getDownloadURL();
    }

    final updatedProduct = product.copyWith(imageUrl: imageUrl);
    await productRef.doc(product.id).update(updatedProduct.toMap());
  }

  @override
  Future<void> deleteProduct(String id) async {
    await productRef.doc(id).delete();
    await FirebaseStorage.instance.ref().child('product_images/$id.jpg').delete();
  }

  @override
  Stream<List<Product>> getProducts() {
    return productRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    });
  }
}
