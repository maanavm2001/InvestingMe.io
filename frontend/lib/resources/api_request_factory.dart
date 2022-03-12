import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:investing_me_io/utils/local_resources.dart';
import 'package:investing_me_io/utils/settings.dart';

class ApiRequest {
  Future<Map<String, dynamic>> getUser() async {
    Map<String, String> isAuthHeaders = apiCallHeaders;

    isAuthHeaders.addAll({'x-access-token': jwt});

    String url = (API_URL + '/user/' + id);

    log('Pinging (preset- GET USER): ' + url);

    final response = await http.get(Uri.parse(url), headers: isAuthHeaders);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);

      responseBody = _responseBodyProcessor(responseBody);

      log('Call Finished');
      return responseBody;
    } else {
      throw Exception('Unable to fetch user');
    }
  }

  Future<Map<String, dynamic>> post(
      String resource, String action, dynamic params,
      {bool auth = false}) async {
    Map<String, String> isAuthHeaders = apiCallHeaders;
    String url = (API_URL + '/' + resource + '/' + action);

    log('Pinging (POST): ' + url);

    if (auth) {
      isAuthHeaders.addAll({'x-access-token': jwt});
    }

    final response = await http.post(Uri.parse(url),
        headers: isAuthHeaders, body: jsonEncode(params));

    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      responseBody = _responseBodyProcessor(responseBody);

      log('Call Finished');
      return responseBody;
    } else {
      throw Exception('Error Pinging (POST): ' + url);
    }
  }

  Future<Map<String, dynamic>> get(String resource, String action,
      {List params = const [], bool auth = false}) async {
    Map<String, String> isAuthHeaders = apiCallHeaders;
    String url = (API_URL + '/' + resource + '/' + action);

    if (params.isNotEmpty) {
      for (String param in params) {
        url += '/' + param;
      }
    }

    log('Pinging (GET): ' + url);

    if (auth) {
      isAuthHeaders.addAll({'x-access-token': jwt});
      url += '/' + id.toString();
    }

    final response = await http.get(Uri.parse(url), headers: isAuthHeaders);

    log(response.statusCode.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      responseBody = _responseBodyProcessor(responseBody);

      log('Call Finished');
      return responseBody;
    } else {
      throw Exception('Error Pinging (GET): ' + url);
    }
  }

  Map<String, dynamic> _responseBodyProcessor(
      Map<String, dynamic> responseBody) {
    box.write('jwt', responseBody['jwt']);
    box.write('id', responseBody['_id']);
    responseBody.remove('jwt');
    responseBody.remove('_id');
    return responseBody;
  }
}
