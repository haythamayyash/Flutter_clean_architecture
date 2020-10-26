import 'package:flutter_clean_architecure/common/exceptions.dart';
import 'package:flutter_clean_architecure/data/datasource/user_remote_data_source.dart';
import 'package:flutter_clean_architecure/data/repository/user_repository_impl.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../dummydata/user_test_data.dart';

class UserRemoteDataSourceMock extends Mock implements UserRemoteDataSource {}

const USER_NAME = 'userName';

void main() {
  UserRepositoryImpl SUT;
  UserRemoteDataSourceMock dataSourceMock;

  setUp(() {
    dataSourceMock = UserRemoteDataSourceMock();
    SUT = UserRepositoryImpl(dataSourceMock);
  });

  void successGetUsers() {
    when(dataSourceMock.getUsers())
        .thenAnswer((_) async => UserTestData.getUsers());
  }

  void successGetUser() {
    when(dataSourceMock.getUser(USER_NAME))
        .thenAnswer((_) async => UserTestData.getUser());
  }

  void failureGetUsers404() {
    when(dataSourceMock.getUsers()).thenThrow(ServerException());
  }

  void failureGetUser404() {
    when(dataSourceMock.getUser(any)).thenThrow(ServerException());
  }

  group('getUsers', () {
    test('when success then return correct data', () async {
      successGetUsers();
      final List<User> result = await SUT.getUsers();
      expect(result, equals(UserTestData.getUsers()));
    });

    test('when failure then throw ServerException', () async {
      failureGetUsers404();
      expect(() => SUT.getUsers(), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getUser', () {
    test('pass correct id to dataSourceMock', () async {
      SUT.getUser(USER_NAME);
      expect(verify(dataSourceMock.getUser(captureAny)).captured.single,
          equals(USER_NAME));
    });

    test('when success then return correct data', () async {
      successGetUser();
      final User result = await SUT.getUser(USER_NAME);
      expect(result, equals(UserTestData.getUser()));
    });

    test('when failure then throw ServerException', () async {
      failureGetUser404();
      expect(() => SUT.getUser(USER_NAME),
          throwsA(TypeMatcher<ServerException>()));
    });
  });
}
