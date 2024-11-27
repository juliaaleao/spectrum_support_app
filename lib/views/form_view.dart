import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  // Variáveis para armazenar respostas do questionário
  String? _iluminacaoResposta;
  String? _iluminacaoPreferida;
  String? _ruidoResposta;
  String? _ruidoAjustes;
  String? _organizacaoEspaco;
  String? _interacaoSocial;
  String? _materiaisDidaticos;
  String? _tarefasEAtividades;
  String? _rotinaMudancas;
  String? _sensibilidadeSensorial;
  String? _suporteAdicional;
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário do Aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

//  Iluminação
              Text('Você se incomoda com a luz fluorescente da sala de aula?'),
              RadioListTile(
                title: Text('Sim'),
                value: 'Sim',
                groupValue: _iluminacaoResposta,
                onChanged: (value) {
                  setState(() {
                    _iluminacaoResposta = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text('Não'),
                value: 'Não',
                groupValue: _iluminacaoResposta,
                onChanged: (value) {
                  setState(() {
                    _iluminacaoResposta = value.toString();
                  });
                },
              ),
              if (_iluminacaoResposta == 'Sim') ...[
                Text('Qual tipo de iluminação seria mais confortável?'),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Escolha uma opção'),
                  items: [
                    DropdownMenuItem(value: 'Luz natural', child: Text('Luz natural')),
                    DropdownMenuItem(value: 'Luz suave', child: Text('Luz suave')),
                    DropdownMenuItem(value: 'Lâmpadas de LED', child: Text('Lâmpadas de LED')),
                    DropdownMenuItem(value: 'Filtros de luz', child: Text('Filtros de luz')),
                    DropdownMenuItem(value: 'Outras', child: Text('Outras')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _iluminacaoPreferida = value;
                    });
                  },
                ),
              ],

// Ruído
              SizedBox(height: 20),
              Text('O nível de ruído na sala de aula é confortável para você?'),
              RadioListTile(
                title: Text('Sim'),
                value: 'Sim',
                groupValue: _ruidoResposta,
                onChanged: (value) {
                  setState(() {
                    _ruidoResposta = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text('Não'),
                value: 'Não',
                groupValue: _ruidoResposta,
                onChanged: (value) {
                  setState(() {
                    _ruidoResposta = value.toString();
                  });
                },
              ),
              if (_ruidoResposta == 'Não') ...[
                Text('Que tipo de ajustes ajudariam?'),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Escolha uma opção'),
                  items: [
                    DropdownMenuItem(value: 'Fones de ouvido', child: Text('Fones de ouvido')),
                    DropdownMenuItem(value: 'Áreas de silêncio', child: Text('Áreas de silêncio')),
                    DropdownMenuItem(value: 'Redução de barulho', child: Text('Redução de barulho')),
                    DropdownMenuItem(value: 'Absorvedores de som', child: Text('Absorvedores de som')),
                    DropdownMenuItem(value: 'Outras', child: Text('Outras sugestões')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _ruidoAjustes = value;
                    });
                  },
                ),
              ],


              // Botão para Enviar as respostas
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Armazena as respostas no Firestore
                    try {
                      await FirebaseFirestore.instance
                          .collection('alunos')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        'iluminacaoResposta': _iluminacaoResposta,
                        'iluminacaoPreferida': _iluminacaoPreferida,
                        'ruidoResposta': _ruidoResposta,
                        'ruidoAjustes': _ruidoAjustes,
                        // Adicione aqui as outras respostas do formulário
                        'feedback': _feedbackController.text,
                      });

                      // Exibir mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Respostas enviadas com sucesso!')),
                      );

                      // Limpa os campos após o envio
                      _limparCampos();
                    } catch (e) {
                      // Exibir mensagem de erro
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao enviar respostas. Tente novamente.')),
                      );
                    }
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para limpar os campos após o envio
  void _limparCampos() {
    setState(() {
      _iluminacaoResposta = null;
      _iluminacaoPreferida = null;
      _ruidoResposta = null;
      _ruidoAjustes = null;
      _feedbackController.clear();
    });
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
