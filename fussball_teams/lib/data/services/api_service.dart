import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';

/// Die Klasse wird genutzt, um HTTP Requests auszuführen und
/// liefert das dekodierte JSON Objekt zurück.
class APIService {
  APIService(this.api);
  final API api;

  Future<List<dynamic>> erhalteEndpointData({
    required Endpoint endpoint,
  }) async {
    final uri = api.endpointUri(endpoint);

    final response = await http.get(
      uri,
      // headers: {
      //   HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      // },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      if (data.isNotEmpty) {
        return data;
      }
    }
    throw response;
  }
}
