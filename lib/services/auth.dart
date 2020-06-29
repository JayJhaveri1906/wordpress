import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soledesign/models/jwt.dart';

//Sending data to server
//Sending the url and the parameter through http.post in wordpress website for getting the
//Jwt token for authentication to Sign In
Future<JWT> createjwtToken(String username, String password) async {
  final String jwtToken = '/wp-json/jwt-auth/v1/token';
  final http.Response response =
      await http.post('https://soleentrepreneur.co.uk' + jwtToken, body: {
    'username': username,
    'password': password,
  });
//If token generation is succesful then decode the body
  if (response.statusCode == 200) {
    return JWT.fromJson(json.decode(response.body));
  } else {
    //if not successful then Through the Exception
throw Exception('Failed to create Login.');

  }
}
