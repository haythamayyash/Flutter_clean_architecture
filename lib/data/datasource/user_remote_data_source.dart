import 'package:flutter_clean_architecure/domain/model/user.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers();

  Future<User> getUser(String userName);
}