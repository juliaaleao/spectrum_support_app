import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController repetirSenhaController = TextEditingController();
  bool isAluno = false; // Ver se o usuário é aluno

  // Validando os campos
  bool _validarCampos(String nome, String email, String senha, String repetirSenha) {
    return nome.isNotEmpty &&
        email.isNotEmpty &&
        senha.isNotEmpty &&
        repetirSenha.isNotEmpty &&
        _validarEmail(email) &&
        senha == repetirSenha; // Verifica se as senhas são iguais
  }

  // Validando email
  bool _validarEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'); //String com o formato de um email válido (letra maiuscula e minuscula, numeros de 0 a 9, @ e etc)
    return emailRegex.hasMatch(email);
  }

  // Mostrar erro
  void _mostrarErro(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.red,
    ));
  }

  // Fazer o cadastro
  Future<void> cadastrar(BuildContext context) async {
    String nome = nomeController.text;
    String email = emailController.text;
    String senha = senhaController.text;
    String repetirSenha = repetirSenhaController.text;

    if (_validarCampos(nome, email, senha, repetirSenha)) {
      try {

        // Criação do usuário no banco 
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: senha,
        );

        // Salva os dados do usuário no banco
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'nome': nome,
          'email': email,
          'tipoUuario': isAluno ? 'aluno' : 'professor', // Definindo se é aluno ou professor
        });

        // Direcionar para as páginas corretas
        if (isAluno) {
          Navigator.pushReplacementNamed(context, '/form_page.dart'); // Direciona o aluno para a página de formulário
        } else {
          Navigator.pushReplacementNamed(context, '/home_page.dart'); // Direciona o professor para a home dos professores
        }
      } catch (e) {
        // Mostra erro caso ocorra algum problema
        _mostrarErro(context, "Erro ao cadastrar: ${e.toString()}");
      }
    } else {
      _mostrarErro(context, "Preencha todos os campos corretamente!");
    }
  }

  // Limpar os campos
  void limparCampos() {
    nomeController.clear();
    emailController.clear();
    senhaController.clear();
    repetirSenhaController.clear();
  }

  // Excluir os campos
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    repetirSenhaController.dispose();
  }
}
