import 'dart:convert';

import 'package:fake_api/models/Product_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/Post_Model.dart';
import '../models/Quote_Model.dart';

class ApiServices {
  final baseUrl = "https://dummyjson.com/";

  Future<ProductModel> getProducts() async {
    ProductModel products = ProductModel();
    var response = await http.get(Uri.parse("${baseUrl}products"));

    if (response.statusCode == 200) {
      debugPrint('Response status: ${response.body}');
      products = ProductModel.fromJson(jsonDecode(response.body));

      return products;
    } else {
      return products;
    }
  }

  Future<PostModels> getPosts()async{
    PostModels posts = PostModels();
    var response = await http.get(Uri.parse("${baseUrl}posts"));

    if (response.statusCode == 200) {
      debugPrint('Response status: ${response.body}');
      posts = PostModels.fromJson(jsonDecode(response.body));

      return posts;
    } else {
      return posts;
    }
  }

  Future<QuotesModel> getQuotes()async{
    QuotesModel quotes = QuotesModel();
    var response = await http.get(Uri.parse("${baseUrl}quotes"));

    if (response.statusCode == 200) {
      debugPrint('Response status: ${response.body}');
      quotes = QuotesModel.fromJson(jsonDecode(response.body));

      return quotes;
    } else {
      return quotes;
    }
  }
}
