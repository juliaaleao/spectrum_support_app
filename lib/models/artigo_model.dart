class ArtigoModel {
  String titulo;
  String descricao;
  String pdfUrl; 

  ArtigoModel({
    required this.titulo,
    required this.descricao,
    required this.pdfUrl,
  });

  // Converte o ArticleModel para um mapa
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'pdfUrl': pdfUrl,
    };
  }

  // Cria um ArticleModel a partir de um mapa
  factory ArtigoModel.fromMap(Map<String, dynamic> map) {
    return ArtigoModel(
      titulo: map['titulo'],
      descricao: map['descricao'],
      pdfUrl: map['pdfUrl'],
    );
  }
}
