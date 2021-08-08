import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:news/src/models/item_model.dart';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    Response response = await client.get(Uri.parse("$_root/maxitem.json"));
    final ids = await json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(Uri.parse("$_root/item/$id.json"));
    final parsedJson = await json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}

final newsApiProvider = NewsApiProvider();
