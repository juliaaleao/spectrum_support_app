class Cadastro {
  final String nome;
  final String email;
  final String senha;
  final bool isAluno;

  Cadastro({
    required this.nome,
    required this.email,
    required this.senha,
    this.isAluno = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'isAluno': isAluno,
    };
  }
}
