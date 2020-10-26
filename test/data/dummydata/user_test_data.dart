import 'package:flutter_clean_architecure/domain/model/user.dart';

class UserTestData {
  static User getUser() => User(login: "login33", id: 33);

  static List<User> getUsers() =>
      [User(login: "login1", id: 1), User(login: "login2", id: 2)];
}
