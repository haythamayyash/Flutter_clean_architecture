import 'package:flutter_clean_architecure/common/exceptions.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_clean_architecure/domain/repository/user_repository.dart';
import 'package:flutter_clean_architecure/domain/usecase/get_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../data/dummydata/user_test_data.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

const USER_NAME = 'userName';

void main() {
  GetUserUseCase SUT;
  UserRepositoryMock userRepositoryMock;
  setUp(() {
    userRepositoryMock = UserRepositoryMock();
    SUT = GetUserUseCase(userRepositoryMock);
  });

  void getUserSuccess() {
    when(userRepositoryMock.getUser(USER_NAME))
        .thenAnswer((realInvocation) async => UserTestData.getUser());
  }

  void failure() {
    when(userRepositoryMock.getUser(USER_NAME)).thenThrow(ServerException());
  }

  group('getUser', () {
    test('pass correct id to UserRepository', () async {
      SUT.call(USER_NAME);
      expect(verify(userRepositoryMock.getUser(captureAny)).captured.single,
          equals(USER_NAME));
    });

    test('when success then return correct data', () async {
      getUserSuccess();
      final User resgiponse = await SUT.call(USER_NAME);
      expect(response, equals(UserTestData.getUser()));
    });

    test('when failure then throw NetworkException', () {
      failure();
      expect(
          () => SUT.call(USER_NAME), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
