import '../models/user_model.dart';

abstract class UserEvent {}

class SubmitUser extends UserEvent {
  final UserModel user;
  SubmitUser(this.user);
}
