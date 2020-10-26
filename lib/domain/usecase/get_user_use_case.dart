import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_clean_architecure/domain/repository/user_repository.dart';

class GetUserUseCase {
  UserRepository userRepository;

  GetUserUseCase(this.userRepository);

  Future<User> call(String id) {
    return userRepository.getUser(id);
  }
}
