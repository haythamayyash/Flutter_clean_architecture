import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecure/common/exceptions.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:http/http.dart' as http;

import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  var client = http.Client();

  UserRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<User>> getUsers() =>
      _getUsersFromUrl('https://api.github.com/users');

  @override
  Future<User> getUser(String userName) {
    return _getUserFromUrl('api.github.com/Users/$userName');
  }

  Future<List<User>> _getUsersFromUrl(String url) async {
    final http.Response response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      List<User> users = (json.decode(response.body) as List)
          .map((i) => User.fromJson(i))
          .toList();
      return users;
    } else {
      throw ServerException();
    }
  }

  Future<User> _getUserFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      User user = User.fromJson(json.decode(response.body));
      return user;
    } else {
      throw ServerException();
    }
  }
}
