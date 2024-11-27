import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';


class ArtigosEDicasPage extends StatelessWidget {
  // Lista de URLs ou caminhos locais dos PDFs
  final List<Map<String, String>> artigos = [
    {
      'titulo': 'Artigo 1: Entendendo o Autismo',
      'url': 'assets/pdfs/artigo1.pdf',
      'descricao': 'Este artigo fornece uma visão geral sobre o autismo e como ele afeta as pessoas.',
      'imagem': 'assets/imagens/artigo1.jpg',
    },
    {
      'titulo': 'Artigo 2: Inclusão na Sala de Aula',
      'url': 'assets/pdfs/artigo2.pdf',
      'descricao': 'Este artigo discute a importância da inclusão na sala de aula e como ela pode ser implementada.',
      'imagem': 'assets/imagens/artigo2.jpg',
    },
    // Adicione mais artigos conforme necessário
  ];

  // Método para abrir o PDF
  void _abrirPDF(BuildContext context, String path) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFViewerPage(path: path)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artigos e Dicas sobre Autismo'),
        backgroundColor: Colors.orange.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: artigos.length,
          itemBuilder: (context, index) {
            final artigo = artigos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(artigo['titulo']!),
                subtitle: Text(artigo['descricao']!),
                leading: Image.asset(artigo['imagem']!),
                trailing: Icon(Icons.picture_as_pdf, color: Colors.red),
                onTap: () {
                  _abrirPDF(context, artigo['url']!);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String path;

  PDFViewerPage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizando PDF'),
        backgroundColor: Colors.orange.shade400,
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}