class User {
  String uid;
  String profilePicURL = 'default URL';
  String name;
  String email;
  String birthYear;
  String sex;

  User(
    this.uid,
    this.profilePicURL,
    this.name,
    this.email,
    this.birthYear,
    this.sex,
  );

  User.fromSnapshot(snapshot)
      : uid = snapshot.data()['uid'],
        profilePicURL = snapshot.data()['profilePicURL'],
        name = snapshot.data()['name'],
        email = snapshot.data()['email'],
        birthYear = snapshot.data()['birthYear'],
        sex = snapshot.data()['sex'];

  Map<String, dynamic> toJson() => {
        'uid': uid.toString(),
        'profilePicURL': profilePicURL.toString(),
        'name': name.toString(),
        'email': email.toString(),
        'birthYear': birthYear.toString(),
        'sex': sex.toString(),
      };
}
