import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  final response = await http.get(
      'https://soleentrepreneur.co.uk/wp-json/w/v1/trending?_fields=title,content,excerpt,featured_image.large,guid',
      headers: {"Accept": "application/json"});
  var convertDatattoJson = jsonDecode(response.body);
  return convertDatattoJson;
}

Future<List> fetchFeatured() async {
  final response = await http.get(
      'https://soleentrepreneur.co.uk/wp-json/w/v1/posts?_fields=title,content,excerpt,featured_image.large,guid',
      headers: {"Accept": "application/json"});
  var convertDatattoJson = jsonDecode(response.body);
  // print('$convertDatattoJson');
  return convertDatattoJson;
}

Future<List> fetchCategory() async {
  final response = await http.get(
      'https://soleentrepreneur.co.uk/wp-json/wp/v2/categories?per_page=40',
      headers: {"Accept": "application/json"});
  var convertDatattoJson = jsonDecode(response.body);
  return convertDatattoJson;
}
