class User {
  String uid;
  String profilePicURL = 'default URL';
  String name;
  String email;
  String birthYear;
  bool sex;

  User({
    required this.uid,
    required this.profilePicURL,
    required this.name,
    required this.email,
    required this.birthYear,
    required this.sex,
  });
}
