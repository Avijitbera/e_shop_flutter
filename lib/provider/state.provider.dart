

import 'package:e_shop/respository/api.repository.dart';
import 'package:flutter/material.dart';

import '../model/product.model.dart';

class StateProvider extends ChangeNotifier{
  ApiRepository _repository;

  StateProvider(this._repository);

  List<String> categories = [];
  List<ProductModel> products = [];

 List<ProductModel> sortProducts({
    String sortBy = "most",
    required String category
  }){
    var list = products.where((element) => element.category == category).toList();
     list.sort((a, b) {
      return a.rating.compareTo(b.rating);
    });
    return sortBy == "most" ? list.reversed.toList() : list;
  }

 List<ProductModel> searchItem(String search){
    try {
      var data = products.where((element) => (element.title.toLowerCase()).contains(search.toLowerCase()));
      return data.map((e) => e).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductModel>> searchProduct({
    required String name,
    int minPrice = 0,
    int maxPrice = 500,
    double rating = 0.0,
    required String category
  })async{
    try {
      var data = products.where((element) => (element.title.toLowerCase()).contains(name.toLowerCase()) && element.category == category && 
      rating < element.rating && minPrice < element.price && maxPrice > element.price);
      return data.map((e) => e).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProducts({
    required String name,
    int minPrice = 0,
    int maxPrice = 500,
    double rating = 0.0
  })async{
    
    try {
      
      var data = products.where((element) => rating < element.rating && name == element.category && minPrice < element.price && maxPrice > element.price);
      return data.map((e) => e).toList();
    } catch (e) {
      return [];
    }

  }

  void getCategoryList()async{
    List<String> data = await _repository.getCategoryList();
    categories = data;
    notifyListeners();
  }


  Future<List<ProductModel>> getProducts()async{
    List<ProductModel> list = await _repository.getProductList();
    products = list;
    notifyListeners();
    return products;
  }



}