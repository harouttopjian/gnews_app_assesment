import 'package:flutter/material.dart';
import 'components/customListTile.dart';
import 'model/article_model.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
          if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;
            return ListView.builder(
                itemCount: articles!.length,
                itemBuilder: (context, index) =>
                  customListTile(articles[index], context),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
