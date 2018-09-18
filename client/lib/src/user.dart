class User {
  final int id;
  String name;
  int age;
  String emailId;
    
  User(this.id, this.name, this.age, this.emailId);

  factory User.fromJson(Map<String, dynamic> userData) {
    var user = User(userData['id'], userData['name'],
                    userData['age'], userData['email_id']);
    return user;
  }

  Map toJson() => {'id': id, 'name': name, 'age' : age, 'email_id': emailId}; 
}
