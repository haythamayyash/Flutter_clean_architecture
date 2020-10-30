import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecure/data/datasource/user_remote_data_source_impl.dart';
import 'package:flutter_clean_architecure/data/repository/user_repository_impl.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';
import 'package:flutter_clean_architecure/presentation/bloc/get_users_bloc.dart';
import 'package:flutter_clean_architecure/presentation/bloc/users_state.dart';
import 'package:flutter_clean_architecure/presentation/widget/progress_bar_widget.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  UserListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  var getUserBloc = GetUsersBloc(
      UserRepositoryImpl(UserRemoteDataSourceImpl(client: http.Client())));

  @override
  void initState() {
    super.initState();
    getUserBloc.getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) => getUserBloc,
        child: Center(
          child: BlocBuilder<GetUsersBloc, UsersState>(
            // cubit: BlocProvider.of(context),
            builder: (context, state) {
              if (state is UsersLoading) {
                return ProgressBarWidget();
              } else if (state is UsersLoaded) {
                return UserListView(
                  userList: state.userList,
                );
              } else if (state is UsersError) {
                return Text(
                  state.message,
                );
              }
              return Text(
                'text123',
              );
            },
          ),
        ),
      ),
    );
  }
}

class UserListView extends StatelessWidget {
  final List<User> userList;

  const UserListView({Key key, this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        User user = userList[index];
        return UserListTile(urlImage: user.avatarUrl, title: user.login);
      },
      itemCount: userList.length,
      itemExtent: 80,
    );
  }
}

class UserListTile extends StatelessWidget {
  final String urlImage;
  final String title;

  const UserListTile({Key key, this.urlImage, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(urlImage),
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
