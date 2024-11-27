import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Enum para o tema
enum Tema { light, dark }

class ConfigController {
  // Construtor padrão
  ConfigController({
    this.nomeController = TextEditingController(),
    this.emailController = TextEditingController(),
    this.isAluno = false,
  });

  // Campos
  final TextEditingController nomeController;
  final TextEditingController emailController;
  bool isAluno;
  Tema tema = Tema.light;

  // Método para validar os dados do usuário
  bool validarDadosUsuario(Map<String, dynamic> usuario) {
    // Valide os dados do usuário aqui
    return true;
  }

  // Método para carregar as preferências de tema
  Future<void> carregarPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tema = prefs.getBool('isDarkMode') ?? false ? Tema.dark : Tema.light;
  }

  // Método para salvar as preferências de tema
  Future<void> salvarPreferencias(bool darkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', darkMode);
  }

  // Método para alterar o tema
  void alterarTema(Tema novoTema) {
    tema = novoTema;
    salvarPreferencias(novoTema == Tema.dark);
  }

  // Método para atualizar os dados do usuário
  void atualizarUsuario(Map<String, dynamic> usuarioAtualizado) {
    nomeController.text = usuarioAtualizado['nome'];
    emailController.text = usuarioAtualizado['email'];
    isAluno = usuarioAtualizado['isAluno'];
  }

  // Método para limpar os controladores
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
  }
}

// Exemplo de uso do FutureBuilder
FutureBuilder(
  future: ConfigController().carregarPreferencias(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return // ...
    } else {
      return CircularProgressIndicator();
    }
  },
);