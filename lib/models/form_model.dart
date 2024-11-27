class Form {
  final String pergunta;
  final List<String> alternativas;

  Form({
    required this.pergunta,
    required this.alternativas,
  });

  Map<String, dynamic> toMap() {
    return {
      'pergunta': pergunta,
      'alternativas': alternativas,
    };
  }
}
