class MyUser {
  static Map<String, dynamic>? currentUser;

  static bool isAdmin() {
    return MyUser.currentUser != null && MyUser.currentUser!['role'] == 0;
  }
}
