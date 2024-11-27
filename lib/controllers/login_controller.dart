import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool manterConectado = false;

  // Função para realizar o login
  Future<void> login(BuildContext context) async {
    String email = emailController.text;
    String senha = passwordController.text;

    if (_validarCampos(email, senha)) {
      // Lógica de autenticação aqui (ex: chamar o Firebase)
      if (email == "professor@spectrum.com" && senha == "senha123") {
        // Se autenticação for bem-sucedida, vá para a página inicial
        salvarCredenciais();
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _mostrarErro(context, "E-mail ou senha incorretos.");
      }
    }
  }

  bool _validarCampos(String email, String senha) {
    return email.isNotEmpty && senha.isNotEmpty;
  }

  // Mostrar uma mensagem de erro
  void _mostrarErro(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.red,
    ));
  }

  // Atualiza o estado da checkbox "Manter conectado"
  void toggleManterConectado(bool value) {
    manterConectado = value;
  }

  // Limpar os controladores ao sair da tela de login
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  // Salvar as credenciais do usuário
  void salvarCredenciais() async {
    if (manterConectado) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text);
      await prefs.setString('senha', passwordController.text);
    }
  }

  // Carregar as credenciais do usuário
  void carregarCredenciais() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final senha = prefs.getString('senha');
    if (email != null && senha != null) {
      emailController.text = email;
      passwordController.text = senha;
      manterConectado = true;
    }
  }

  LoginController() {
    carregarCredenciais();
  }
}