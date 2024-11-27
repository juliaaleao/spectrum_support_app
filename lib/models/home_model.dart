class Home {
  final String id;
  final String nome;
  final String turma;

  Home({
    required this.id,
    required this.nome,
    required this.turma,
  });

  factory Home.fromMap(Map<String, dynamic> data, String documentId) {
    return Home(
      id: documentId,
      nome: data['nome'],
      turma: data['turma'],
    );
  }
}
