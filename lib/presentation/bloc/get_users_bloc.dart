import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecure/domain/model/user.dart';

class GetUsersBloc extends Cubit<List<User>> {
  GetUsersBloc(List<User> state) : super(state);
}
