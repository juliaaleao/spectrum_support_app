import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool isAluno = false;
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController repetirSenhaController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Future<void> _saveUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', senhaController.text);
  }

  Future<void> _loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email != null && password != null) {
      emailController.text = email;
      senhaController.text = password;
      setState(() {
        isAluno = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'CADASTRO',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade400,
                    ),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: nomeController,
                    decoration: InputDecoration(labelText: 'Nome de usuário:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um nome de usuário';
                      } else if (value.length < 3) {
                        return 'O nome de usuário deve ter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'E-mail:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um e-mail';
                      } else if (!value.contains('@')) {
                        return 'Por favor, insira um e-mail válido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: senhaController,
                    decoration: InputDecoration(labelText: 'Criar senha:'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma senha';
                      } else if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: repetirSenhaController,
                    decoration: InputDecoration(labelText: 'Repita a Senha:'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, repita a senha';
                      } else if (value != senhaController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isAluno,
                        onChanged: (value) {
                          setState(() {
                            isAluno = value ?? false;
                          });
                        },
                      ),
                      Text('Sou aluno'),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          // Cadastro do usuário usando Firebase Auth
                          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: senhaController.text,
                          );

                          User? user = userCredential.user;
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cadastro realizado com sucesso!'),
                              ),
                            );

                            // Redirecionar para a página home
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );

                            // Limpar campos e estado
                            nomeController.clear();
                            emailController.clear();
                            senhaController.clear();
                            repetirSenhaController.clear();
                            setState(() {
                              isAluno = false;
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          String errorMessage = "Erro ao cadastrar usuário";
                          if (e.code == 'weak-password') {
                            errorMessage = "A senha é muito fraca.";
                          } else if (e.code == 'email-already-in-use') {
                            errorMessage = "Já existe um usuário com esse e-mail.";
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                    ),
                    child: Text('CADASTRAR-SE'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
