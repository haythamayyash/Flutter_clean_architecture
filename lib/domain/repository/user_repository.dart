import 'package:flutter_clean_architecure/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getUser(String id);

  Future<List<User>> getUsers();
}
