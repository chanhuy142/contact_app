import '../models/user.dart';

class UserRepository {
  final List<User> _users = [];

  Future<void> registerUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _users.add(user);
  }

  Future<bool> authenticate(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users
        .any((user) => user.username == username && user.password == password);
  }
}
