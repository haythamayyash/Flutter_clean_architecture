import 'dart:convert';

import 'package:flutter_clean_architecure/common/exceptions.dart';
import 'package:flutter_clean_architecure/data/datasource/user_remote_data_source.dart';
import 'package:flutter_clean_architecure/data/datasource/user_remote_data_source_impl.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../dummydata/user_test_data.dart';

class MockClient extends Mock implements http.Client {}

const SUCCESS_RESPONSE = 'success response';

void main() {
  UserRemoteDataSourceImpl SUT;
  MockClient client;
  setUp(() {
    client = MockClient();
    SUT = UserRemoteDataSourceImpl(client: client);
  });

  void successGetUsers() {
    when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async =>
            http.Response(jsonEncode(UserTestData.getUsers()), 200));
  }

  void successGetUser() {
    when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async =>
            http.Response(jsonEncode(UserTestData.getUser()), 200));
  }

  void failure404() {
    when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => http.Response('Something went wrong', 404));
  }

  group('getUsers', () {
    test('when success then return correct data', () async {
      successGetUsers();
      final List<User> result = await SUT.getUsers();
      expect(result, equals(UserTestData.getUsers()));
    });

    test('when failure then return 404', () async {
      failure404();
      final result = SUT.getUsers();
      expect(() => result, throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getUser', () {
    test('when success then return correct data', () async {
      successGetUser();
      final User result = await SUT.getUser('');
      expect(result, equals(UserTestData.getUser()));
    });

    test('when failure then return 404', () async {
      failure404();
      final result = SUT.getUser('');
      expect(result, throwsA(TypeMatcher<ServerException>()));
    });
  });
}
