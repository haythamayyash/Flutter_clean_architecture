import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_architecure/domain/repository/user_repository.dart';
import 'package:flutter_clean_architecure/presentation/bloc/get_users_bloc.dart';
import 'package:flutter_clean_architecure/presentation/bloc/users_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/dummydata/user_test_data.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  GetUsersBloc SUT;
  UserRepositoryMock userRepositoryMock;
  setUp(() {
    userRepositoryMock = UserRepositoryMock();
    SUT = GetUsersBloc(userRepositoryMock);

    blocTest('when success emit [initialState, loadingState, loadedState]',
        build: () {
          when(userRepositoryMock.getUsers())
              .thenAnswer((realInvocation) async => UserTestData.getUsers());
        },
        act: (SUT) => SUT.getUserList(),
        expect: [
          UsersInitial(),
          UsersLoading(),
          UsersLoaded(UserTestData.getUsers())
        ]);
  });
}
