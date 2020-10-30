import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecure/data/datasource/user_remote_data_source_impl.dart';
import 'package:flutter_clean_architecure/data/repository/user_repository_impl.dart';
import 'package:flutter_clean_architecure/presentation/bloc/get_users_bloc.dart';
import 'package:flutter_clean_architecure/presentation/bloc/users_state.dart';
import 'package:flutter_clean_architecure/presentation/page/user_list_tile.dart';
import 'package:flutter_clean_architecure/presentation/widget/progress_bar_widget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserListPage(title: 'Flutter Demo Home Page'),
    );
  }
}


