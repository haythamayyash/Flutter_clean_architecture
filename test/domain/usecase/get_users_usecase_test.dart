import 'package:flutter_clean_architecure/common/exceptions.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_clean_architecure/domain/repository/user_repository.dart';
import 'package:flutter_clean_architecure/domain/usecase/get_users_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../data/dummydata/user_test_data.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

const USER_NAME = 'userName';

void main() {
  GetUsersUseCase SUT;
  UserRepositoryMock userRepositoryMock;
  setUp(() {
    userRepositoryMock = UserRepositoryMock();
    SUT = GetUsersUseCase(userRepositoryMock);
  });

  void getUserSuccess() {
    when(userRepositoryMock.getUsers())
        .thenAnswer((realInvocation) async => UserTestData.getUsers());
  }

  void failure() {
    when(userRepositoryMock.getUsers()).thenThrow(ServerException());
  }

  group('getUsers', () {
    test('when success then return correct data', () async {
      getUserSuccess();
      final List<User> response = await SUT.call();
      expect(response, equals(UserTestData.getUsers()));
    });
    test('when failure then throw NetworkException', () {
      failure();
      expect(() => SUT.call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
