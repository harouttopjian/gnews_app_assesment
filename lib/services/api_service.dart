import 'dart:convert';
import 'package:http/http.dart';
import '../model/article_model.dart';

class ApiService{

  final endPointUrl =
      "https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=us&max=10&apikey=e4c9dab7ce59671ece326ce80b098e7b";

  Future<List<Article>> getArticle() async{
    Response res = await get(endPointUrl);

    if (res.statusCode == 200){
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];
      
      List<Article> articles =
      body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
  }