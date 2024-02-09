//let's start by making the source model class
// it will be easier to parse the Json

class Source {
   String name;
   String url;

  // creating the constructor
  Source({required this.name, required this.url});

  //factory function to map the json
  factory Source.fromJson(Map<String, dynamic> json){
    return Source(
        name: json['name'],
        url: json['url']
    );
  }
}