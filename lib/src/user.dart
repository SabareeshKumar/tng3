class User {
      final int id;
      String name;
      int age;
      String email_id;

      User(this.id, this.name, this.age, this.email_id);

      factory User.fromJson(Map<String, dynamic> user) =>
        User(_toInt(user['id']), user['name'], _toInt(user['age']), user['email_id']);

      //Map toJson() => {'id': id, 'name': name};
}

int _toInt(id) => id is int ? id : int.parse(id);
