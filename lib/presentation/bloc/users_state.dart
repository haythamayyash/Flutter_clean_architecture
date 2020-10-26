import 'package:flutter_clean_architecure/domain/model/user.dart';

abstract class UsersState {
  const UsersState();
}

class UsersInitial extends UsersState {
  const UsersInitial();
}

class UsersLoading extends UsersState {
  const UsersLoading();
}

class UsersLoaded extends UsersState {
  final List<User> userList;

  const UsersLoaded(this.userList);
}

class UsersError extends UsersState {
  final String message;

  const UsersError(this.message);
}
