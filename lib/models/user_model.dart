enum UserRole { tenant, landlord }

class User {
  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  final UserRole role;
  final List<String>? ownedPropertyIds; //only for landlords

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    required this.role,
    this.ownedPropertyIds,
  });

  static List<User> dummyUsers = [
    User(
      id: '1',
      fullName: 'John Doe',
      email: 'e@gmail.com',
      role: UserRole.tenant,
    ),
    User(
      id: '1',
      fullName: 'Jame',
      email: 'j@gmail.com',
      role: UserRole.landlord,
      ownedPropertyIds: ['1', '2'],
    ),
  ];
}
