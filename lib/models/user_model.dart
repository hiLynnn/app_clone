enum UserRole { tenant, landlord }

class User {
  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
  });

  static List<User> dummyUsers = [
    User(id: '1', fullName: 'John Doe', email: 'e@gmail.com'),
  ];
}
