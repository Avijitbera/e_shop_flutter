

import 'package:dio/dio.dart';
import 'package:e_shop/model/product.model.dart';

class ApiRepository{
  final Dio _dio = Dio();
  String category_api = "https://dummyjson.com/products/categories";
  String product_api = "https://dummyjson.com/products";

  Future<List<ProductModel>> getProductsByCategory(String name)async{
    try {
      var result = await _dio.get("${product_api}/category/${name}");
     List<ProductModel> products = [];
      for(var item in result.data['products']){
        products.add(ProductModel(
          brand: item['brand'],
          category: item['category'],
          description: item['description'],
          id: item['id'],
          images: (item['images'] as List<dynamic>).map((e) => e.toString()).toList(),
          thumbnail: item['thumbnail'],
          title: item['title'],
           discount: item['discountPercentage'] is double ? item['discountPercentage'] : (item['discountPercentage'] is int) ? (item['discountPercentage'] as int).toDouble() : item['discountPercentage'],
          price: item['price'] is int ? item['price'] : item['price'] is double ? (item['price'] as double).toInt() : item['price'],
          rating: item['rating'] is int ? (item['rating'] as int).toDouble() : item['rating'] is double ? item['rating'] : item['rating'],
          stock: item['stock'] is int ? item['stock'] : item['stock'] is double ? (item['stock'] as double).toInt() : item['stock']
        ));
      }
      return products;
    } catch (e) {
      return [];
    }
  }


  Future<List<ProductModel>> getProductList()async{
    try {
      var result = await _dio.get(product_api);
      List<ProductModel> products = [];
      for(var item in result.data['products']){
        products.add(ProductModel(
          brand: item['brand'],
          category: item['category'],
          description: item['description'],
          id: item['id'],
          images: (item['images'] as List<dynamic>).map((e) => e.toString()).toList(),
          thumbnail: item['thumbnail'],
          title: item['title'],
          discount: item['discountPercentage'] is double ? item['discountPercentage'] : (item['discountPercentage'] is int) ? (item['discountPercentage'] as int).toDouble() : item['discountPercentage'],
          price: item['price'] is int ? item['price'] : item['price'] is double ? (item['price'] as double).toInt() : item['price'],
          rating: item['rating'] is int ? (item['rating'] as int).toDouble() : item['rating'] is double ? item['rating'] : item['rating'],
          stock: item['stock'] is int ? item['stock'] : item['stock'] is double ? (item['stock'] as double).toInt() : item['stock']
        ));
      }
      return products;
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getCategoryList()async{
    try {
      var result = await _dio.get(category_api);
      List<String> list = (result.data as List<dynamic>).map((e) => e.toString()).toList();
      // List<String> categories = list.map((e) {
      //  String data =  e.replaceAll('-', ' ');
      //  return allWordsCapitilize(data);
      // }).toList();
      return list;

    } catch (e) {
      return [];
    }
  }

}

String allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
}