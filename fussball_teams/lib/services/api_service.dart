import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';

class APIService {
  APIService(this.api);
  final API api;

  Future<List<dynamic>> erhalteEndpointData({
    required Endpoint endpoint,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri,
      // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data;
      }
    }
    throw response;
  }
}
