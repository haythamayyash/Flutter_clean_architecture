import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_clean_architecure/domain/repository/user_repository.dart';

class GetUsersUseCase{
  UserRepository userRepository;

  GetUsersUseCase(this.userRepository);

  Future<List<User>> call() {
    return userRepository.getUsers();
  }
}
