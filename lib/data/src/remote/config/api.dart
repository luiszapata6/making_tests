import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  final Map<String, String> _headers = {};

  Future<void> setHeaders() async {
    _headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  void clearHeaders() {
    _headers.clear();
  }

  // Parsea un json en formato string a un Map
  // Returns. Map String, dynamic
  dynamic decode(String response) => json.decode(response);

  // Encode un json en formato Map a un String
  // Returns. Map String, dynamic
  String encode(Map<String, dynamic> response) => json.encode(response);

  //Realiza peticiones tipo GET al backend al endpoint pasado por parámetro
  //Returns Future con el resultado de la consulta
  Future<dynamic> get(String path) async {
    await setHeaders();
    Uri uri = Uri.parse(path);
    final response = await http.get(
      uri,
      headers: _headers,
    );
    debugPrint("response: ${response.body}");
    return response;
  }

  //Realiza peticiones tipo POST al backend al endpoint pasado por parámetro
  //Returns Future con el resultado de la consulta
  Future<dynamic> post(String path, Map<String, dynamic> data) async {
    await setHeaders();
    final body = encode(data);
    Uri uri = Uri.parse(path);
    try {
      final response = await http.post(
        uri,
        body: body,
        headers: _headers,
      );
      debugPrint("response: ${response.body}");
      return decode(response.body);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
