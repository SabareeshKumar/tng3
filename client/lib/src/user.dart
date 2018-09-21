class User {
  int id;
  String name;
  int age;
  String emailId;

  User(this.id, this.name, this.age, this.emailId);

  factory User.from(User user) {
    return User(user.id, user.name, user.age, user.emailId);
  }

  factory User.fromJson(Map<String, dynamic> userData) {
    var user = User(userData['id'], userData['name'],
                    userData['age'], userData['email_id']);
    return user;
  }

  void copy(User user) {
    this.id = user.id;
    this.name = user.name;
    this.age = user.age;
    this.emailId = user.emailId;
  }

  Map toJson() => {'id': id, 'name': name, 'age' : age, 'email_id': emailId};
}
