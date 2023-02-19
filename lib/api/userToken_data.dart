class UserWithToken {
  final int id;
  final String email;
  final String name;
  final String token;

  const UserWithToken({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
  });

  factory UserWithToken.fromJson(Map<dynamic, dynamic> json) {
    return UserWithToken(
      id: json['id'] as int,
      email: json['email'].toString(),
      name: json['name'].toString(),
      token:json["token"] as String,
    );
  }
}