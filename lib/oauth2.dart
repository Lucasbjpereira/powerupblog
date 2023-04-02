import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordpressAuth {
  final String clientId;
  final String redirectUri;
  final String scope;

  WordpressAuth(
      {required this.clientId, required this.redirectUri, required this.scope});

  Future<String> authorize() async {
    final authUrl =
        'https://public-api.wordpress.com/oauth2/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=$scope';

    final result = await FlutterWebAuth.authenticate(
        url: authUrl, callbackUrlScheme: 'powerupblog3');
    debugPrint(result.toString());
    final code = Uri.parse(result).queryParameters['code'];
    debugPrint(code);
    if (code == null) {
      throw Exception('Failed to authorize with Wordpress.');
    }

    const tokenUrl = 'https://public-api.wordpress.com/oauth2/token';
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'client_secret':
            'MI1GcsKBSgo3dDvb9YI2HOD10YQ5lqF5ifcFcSQU5PexFI6R1vnbWVcSKESSpt1X',
        'code': code,
        'grant_type': 'authorization_code'
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve access token from Wordpress.');
    }
    final accessToken = json.decode(response.body)['access_token'];
    return accessToken;
  }
}
