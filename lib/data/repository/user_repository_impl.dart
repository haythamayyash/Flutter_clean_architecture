import 'package:flutter_clean_architecure/data/datasource/user_remote_data_source.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_clean_architecure/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRemoteDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<User> getUser(String id) {
    return dataSource.getUser(id);
  }

  @override
  Future<List<User>> getUsers() {
    return dataSource.getUsers();
  }
}
