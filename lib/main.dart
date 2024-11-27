import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'views/home_page.dart';
import 'views/cadastro_page.dart';
import 'views/login_page.dart';
import 'views/form_page.dart'; 
import 'views/home_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa o Firebase
  runApp(SpectrumSupportApp());
}

class SpectrumSupportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spectrum Support',
      theme: ThemeData(primaryColor: Colors.blue.shade700),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthWrapper(), // Redireciona conforme o estado de autenticação
        '/cadastro': (context) => CadastroPage(),
      },
    );
  }
}

// Widget para verificar o estado de autenticação e redirecionar para a tela de login ou home
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Exibe um loading enquanto verifica o estado
        } else if (snapshot.hasData) {
          // Usuário está logado, então vamos buscar o papel do usuário no Firestore
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('usuários').doc(snapshot.data!.uid).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // Exibe um loading enquanto busca o papel do usuário
              } else if (userSnapshot.hasError) {
                return Center(child: Text("Erro ao carregar dados do usuário"));
              } else if (userSnapshot.hasData && userSnapshot.data!.exists) {
                // Verifica o papel do usuário
                String role = userSnapshot.data!['role'];
                if (role == 'student') {
                  return FormPage(); 
                } else if (role == 'teacher') {
                  return HomePage(); 
                }
              }
              return Center(child: Text("Usuário não encontrado."));
            },
          );
        } else {
          return LoginPage(); // Usuário não está logado, redireciona para a tela de login
        }
      },
    );
  }
}
