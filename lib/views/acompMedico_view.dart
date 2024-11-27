import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class AcompMedicoPage extends StatefulWidget {
  @override
  _AcompMedicoPageState createState() => _AcompMedicoPageState();
}

class _AcompMedicoPageState extends State<AcompMedicoPage> {
  String _searchText = '';
  String _sortBy = 'nome'; // Ordenar por nome por padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acompanhamento Médico'),
      ),
      body: Column(
        children: [
          // Campo de pesquisa
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar aluno ou resposta',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase(); // Filtro em minúsculas para facilitar a busca
                });
              },
            ),
          ),
          // Menu para ordenar por nome ou resposta
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _sortBy,
              items: [
                DropdownMenuItem(value: 'nome', child: Text('Ordenar por Nome')),
                DropdownMenuItem(value: 'configuracao', child: Text('Ordenar por Configuração')),
              ],
              onChanged: (value) {
                setState(() {
                  _sortBy = value!;
                });
              },
            ),
          ),
          Expanded(
            child: _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('alunos')
          .orderBy(_sortBy) // Ordenar pela seleção atual
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var alunos = snapshot.data!.docs.where((document) {
          var nome = document['nome'].toLowerCase();
          var respostas = document['configuracao'].toLowerCase() +
              document['interacaoSocial'].toLowerCase() +
              document['materiaisDidaticos'].toLowerCase() +
              document['tarefasEAtividades'].toLowerCase() +
              document['rotinaEMudancas'].toLowerCase() +
              document['sensibilidadeSensorial'].toLowerCase() +
              document['suporteAdicional'].toLowerCase();

          return nome.contains(_searchText) || respostas.contains(_searchText);
        }).toList();

        return ListView.builder(
          itemCount: alunos.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = alunos[index];
            return ListTile(
              title: Text(document['nome']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Idade: ${document['idade']}'), // Exibe a idade do aluno
                  Text('Turma: ${document['turma']}'), // Exibe a turma
                  Text('Configuração: ${document['configuracao']}'),
                  Text('Interação Social: ${document['interacaoSocial']}'),
                  Text('Materiais Didáticos: ${document['materiaisDidaticos']}'),
                  Text('Tarefas e Atividades: ${document['tarefasEAtividades']}'),
                  Text('Rotina e Mudanças: ${document['rotinaEMudancas']}'),
                  Text('Sensibilidade Sensorial: ${document['sensibilidadeSensorial']}'),
                  Text('Suporte Adicional: ${document['suporteAdicional']}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.note_add),
                onPressed: () {
                  _adicionarComentario(context, document.id);
                },
              ),
            );
          },
        );
      },
    );
  }

  // Diálogo para adicionar um comentário ou nota sobre o aluno
  void _adicionarComentario(BuildContext context, String alunoId) {
    TextEditingController _comentarioController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Comentário ou Nota'),
          content: TextField(
            controller: _comentarioController,
            decoration: InputDecoration(labelText: 'Escreva um comentário ou nota'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_comentarioController.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('alunos')
                      .doc(alunoId)
                      .update({
                        'comentarios': FieldValue.arrayUnion([_comentarioController.text])
                      });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}