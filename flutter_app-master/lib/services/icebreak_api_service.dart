import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class IcebreakAPIService {
  static const String _API_URL = 'http://localhost:8000/api/dev';
  static const _headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static Map<String, String> _authHeaders(String token) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token'
    };
  }

  /// Logs the User into Icebreak
  ///
  /// Returns an Either object with the Token in the left on success,
  /// and an Exception on the right if an error occurs
  static Future<Either<String, Exception>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        _API_URL + '/user/login',
        headers: _headers,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      if (_goodResponse(response.statusCode)) {
        final parsed = jsonDecode(response.body);
        return Left(parsed['token']);
      } else {
        return Right(
          Exception('Unexpected status code on login: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Right(e);
    }
  }

  /// Creates a new user profile
  ///
  /// Returns an Either object with the token in the left on success,
  /// and an Exception on the right if an error occurs
  static Future<Either<String, Exception>> register(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        _API_URL + '/user/register',
        headers: _headers,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      if (_goodResponse(response.statusCode)) {
        final parsed = jsonDecode(response.body);
        return Left(parsed['token']);
      } else {
        return Right(
          Exception(
              'Unexpected status code on register: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Right(e);
    }
  }

  /**
   * The following methods require authorization headers
   */
  /// Creates a profile for registered user
  ///
  /// Returns an Either object with the id of the user in the left on success,
  /// and an Exception on the right if an error occurs
  static Future<Either<int, Exception>> createProfile(
    String token,
    String name,
    String birthday,
    Map<String, double> location,
    String bio,
    String gender,
    String interestedIn,
    int searchArea,
    int acceptedAgeMin,
    int acceptedAgeMax,
  ) async {
    try {
      final response = await http.post(
        _API_URL + '/user',
        headers: _authHeaders(token),
        body: jsonEncode({
          "name": name,
          "birthday": birthday,
          "location": location,
          "bio": bio,
          "gender": gender,
          "interested_in": interestedIn,
          "search_area": searchArea,
          "accepted_age_min": acceptedAgeMin,
          "accepted_age_max": acceptedAgeMax,
        }),
      );
      if (_goodResponse(response.statusCode)) {
        final parsed = jsonDecode(response.body);
        return Left(parsed['id']);
      } else {
        return Right(
          Exception(
              'Unexpected status code on create account: ${response.statusCode} (${response.body})'),
        );
      }
    } catch (e) {
      return Right(e);
    }
  }

  static bool _goodResponse(int statusCode) =>
      statusCode >= 200 && statusCode < 300;
}
