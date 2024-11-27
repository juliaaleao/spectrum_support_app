import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spectrum_support/views/cadastro_view.dart'
import 'package:spectrum_support/views/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool manterConectado = false;

  @override
  void initState() {
    super.initState();
    _carregaDadosUsuario(); // Carregar dados salvo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text(
                  'CONECTE-SE!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade400,
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'E-mail'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, insira um email';
                          } else if (!value.contains('@')) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: senhaController,
                        decoration: InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, insira uma senha';
                          } else if (value.length < 8) {
                            return 'Por favor, insira uma senha com pelo menos 8 caracteres';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: manterConectado,
                            onChanged: (value) {
                              setState(() {
                                manterConectado = value ?? false;
                              });
                            },
                          ),
                          Text('Manter-se conectado'),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade400,
                        ),
                        child: Text('ENTRAR'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CadastroPage()),
                          );
                        },
                        child: Text('NÃO TEM UMA CONTA? CADASTRE-SE!'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      // Realiza o login com Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  email: emailController.text,
  password: senhaController.text,
);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login realizado com sucesso!'),
        ),
      );

      // Salva as credenciais caso "manter conectado" esteja marcado
      if (manterConectado) {
        await _salvaDadosUsuario();
      }

      // Vai para a página inicial após o login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Erro ao realizar login";
      if (e.code == 'user-not-found') {
        errorMessage = "Usuário não encontrado.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Senha incorreta.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future<void> _salvaDadosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', senhaController.text);
  }

  Future<void> _carregaDadosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email != null && password != null) {
      emailController.text = email;
      senhaController.text = password;
      setState(() {
        manterConectado = true;
      });
    }
  }
}
