import 'package:flutter/material.dart';

class SobreAutismoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o Autismo e Sobre Nós'),
        backgroundColor: Colors.orange.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Seção sobre o Autismo
            _buildSectionTitle('O que é Autismo?', Colors.orange.shade400),
            SizedBox(height: 10),
            _buildText(
              'O Transtorno do Espectro Autista (TEA) é uma condição do desenvolvimento neurológico que afeta '
              'a comunicação, comportamento e interação social. Os sintomas podem variar amplamente em intensidade '
              'e as características incluem dificuldade de comunicação, interesses restritos e comportamentos repetitivos.',
            ),
            SizedBox(height: 20),
            
            // Sinais e Sintomas
            _buildSectionTitle('Sinais e Sintomas:', Colors.orange.shade400),
            SizedBox(height: 10),
            _buildText(
              '- Dificuldade em manter contato visual\n'
              '- Preferência por rotinas rígidas\n'
              '- Dificuldades em interações sociais\n'
              '- Interesses restritos e focados em temas específicos',
            ),
            SizedBox(height: 20),

            // Como apoiar uma pessoa com autismo
            _buildSectionTitle('Como apoiar uma pessoa com autismo?', Colors.orange.shade400),
            SizedBox(height: 10),
            _buildText(
              'O apoio a pessoas com autismo envolve promover ambientes inclusivos, respeitar as preferências '
              'individuais e garantir que os serviços educacionais e de saúde estejam adaptados às necessidades específicas '
              'do indivíduo. A conscientização e o treinamento de educadores são passos fundamentais nesse processo.',
            ),
            SizedBox(height: 40),

            // Seção "Sobre Nós"
            _buildSectionTitle('Sobre Nós', Colors.orange.shade400),
            SizedBox(height: 10),
            _buildText(
              'O Spectrum Support nasceu da paixão por melhorar a educação inclusiva para pessoas com Transtorno do Espectro '
              'Autista. O projeto foi idealizado para oferecer ferramentas aos educadores, proporcionando recursos práticos e '
              'informações valiosas para apoiar alunos com TEA em suas jornadas educacionais.',
            ),
            SizedBox(height: 20),
            
            // Nossa História
            _buildSectionTitle('Nossa História:', Colors.orange.shade400),
            SizedBox(height: 10),
            _buildText(
              'O desenvolvimento do Spectrum Support começou em 2024, inspirado pela necessidade de maior suporte e '
              'informação para professores que trabalham com alunos autistas. Ao longo dos meses, o projeto cresceu, '
              ' e continua sempre focado em tornar o ambiente de aprendizado '
              'mais inclusivo e eficiente.',
            ),
            SizedBox(height: 20),
            
            // Missão
            _buildSectionTitle('Missão:', Colors.orange.shade400),
            SizedBox(height: 10),
            _buildText(
              'Nossa missão é facilitar a educação inclusiva, garantindo que educadores tenham acesso a ferramentas, '
              'conhecimentos e suporte necessários para oferecer uma educação de qualidade a alunos com Transtorno do Espectro Autista.',
            ),
            SizedBox(height: 40),

            // Seção de Contato (opcional)
            _buildSectionTitle('Entre em Contato Conosco:', Colors.orange.shade400),
            SizedBox(height: 10),
            _buildText(
              'Se você tem perguntas ou gostaria de colaborar com o projeto, envie-nos um e-mail: contato@spectrum.com.br',
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para construir um título de seção
  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  // Função auxiliar para construir um parágrafo de texto
  Widget _buildText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
