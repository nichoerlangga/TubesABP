class User {
  final String email;
  final String password;
  final String name;
  final String location;
  final String? image;
  final int? id;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.location,
    this.image,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'], // Anda mungkin ingin menghapus ini atau menyandikannya tergantung pada keamanan aplikasi Anda
      image: json['image'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password, // Anda mungkin ingin menghapus ini atau menyandikannya tergantung pada keamanan aplikasi Anda
      'image': image,
      'location': location,
    };
  }
}
