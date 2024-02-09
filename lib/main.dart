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

  get searchController => null;
  get newsController => null;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            margin: const EdgeInsets.symmetric(
                horizontal: 18.0, vertical: 16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search News"),
                      onChanged: (val) {
                        newsController.searchNews.value = val;
                        newsController.update();
                      },
                      onSubmitted: (value) async {
                        newsController.searchNews.value = value;
                        newsController.getAllNews(
                            searchKey: newsController.searchNews.value);
                        searchController.clear();
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.grey,
                      onPressed: () async {
                        newsController.getAllNews(
                            searchKey: newsController.searchNews.value);
                        searchController.clear();
                      },
                      icon: const Icon(Icons.search_sharp)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: client.getArticle(),
              builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
                if (snapshot.hasData) {
                  List<Article>? articles = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
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
          ),
        ],
      ),
    );
  }
}
