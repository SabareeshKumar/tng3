class User {
  final int id;
  String name;
  int age;
  String email_id;
    
  User(this.id, this.name, this.age, this.email_id);

  factory User.fromJson(Map<String, dynamic> userData) {
    var user = User(userData['id'], userData['name'],
                    userData['age'], userData['email_id']);
    return user;
  }

  Map toJson() => {'id': id, 'name': name, 'age' : age, 'email_id': email_id};
  
}
int _toInt(id) => id is int ? id : int.parse(id);
