class Login {
  final String email;
  final String senha;

  Login({
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha': senha,
    };
  }
}
