import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecure/common/exceptions.dart';
import 'package:flutter_clean_architecure/domain/repository/user_repository.dart';
import 'package:flutter_clean_architecure/presentation/bloc/users_state.dart';

class GetUsersBloc extends Cubit<UsersState> {
  UserRepository _userRepository;

  GetUsersBloc(this._userRepository) : super(UsersInitial());

  void getUserList() async {
    try {
      emit(UsersLoading());
      final userList = await _userRepository.getUsers();
      emit(UsersLoaded(userList));
    } on ServerException {
      emit(UsersError('Server Error'));
    }
  }
}
