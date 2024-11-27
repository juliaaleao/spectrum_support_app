import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class ConfigPage extends StatefulWidget {
  final Map<String, dynamic> usuario; // Dados do usuário

  ConfigPage({required this.usuario});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late TextEditingController nomeController;
  late TextEditingController emailController;
  bool isAluno = false;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.usuario['nome']);
    emailController = TextEditingController(text: widget.usuario['email']);
    isAluno = widget.usuario['isAluno'];
    _loadTheme(); // Carrega o tema salvo
  }

  // Carregar o tema salvo (claro ou escuro)
  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Salvar o tema escolhido
  void _saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  // Validar e salvar os dados de usuário e retornar à página anterior
  void _saveUserSettings() async {
    if (_formKey.currentState!.validate()) {
      // Salvar os dados
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('nome', nomeController.text);
      await prefs.setString('email', emailController.text);

      // Atualiza as informações do usuário e retorna à página anterior
      Navigator.pop(context, {
        'nome': nomeController.text,
        'email': emailController.text,
        'isAluno': isAluno,
        'isDarkMode': isDarkMode,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil e Configurações'),
        backgroundColor: Colors.orange.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informações Pessoais',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome de usuário'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um nome de usuário';
                  } else if (value.length < 3) {
                    return 'O nome de usuário deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um e-mail';
                  } else if (!value.contains('@')) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Tipo de usuário:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Text(
                    isAluno ? 'Aluno' : 'Professor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Configurações de Tema',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: Text('Modo Escuro'),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    _saveTheme(value);
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUserSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                ),
                child: Text('SALVAR ALTERAÇÕES'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
