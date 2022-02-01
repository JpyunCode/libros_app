import 'package:http/http.dart' as http;
import 'dart:convert';

class Book {
  String title;
  String autor;
  String imgUrl;

  Book({
    required this.title,
    required this.autor,
    required this.imgUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return new Book(
      autor: json["author"],
      imgUrl: json["thumbnail"],
      title: json["title"],
    );
  }
}

var url = Uri.parse("https://www.etnassoft.com/api/v1/get/?order=newest");

Future<List<Book>> getData() async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonArray = json.decode(response.body) as List;
    return jsonArray.map(decode).toList();
  } else {
    return [];
  }
}

Book decode(dynamic element) {
  return Book.fromJson(element);
}
