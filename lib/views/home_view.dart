import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir link

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo à Página Inicial!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            SizedBox(height: screenHeight * 0.05), // Espaço entre o texto e os próximos widgets
            BallWithNumber(
              number: 1,
              moduleName: 'Módulo 1: Como lidar com jovens autistas',
              moduleDescription: 'Neste módulo, você aprenderá como lidar com jovens autistas de forma eficaz.',
              videoUrl: 'https://www.youtube.com/watch?v=https://youtu.be/txdYFA1enCY?si=TXP8LSNPfoMHSz2B',
              
            ),
            DashedLine(),
            BallWithNumber(
              number: 2,
              moduleName: 'Módulo 2: Ferramentas para auxiliar a comunicação',
              moduleDescription: 'Aqui você conhecerá ferramentas de comunicação inclusiva.',
              videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID',
            ),
            DashedLine(),
            BallWithNumber(
              number: 3,
              moduleName: 'Módulo 3: Estratégias de ensino adaptadas',
              moduleDescription: 'Estratégias para adaptar o ensino para alunos com TEA.',
              videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID',
            ),
            DashedLine(),
            BallWithNumber(
              number: 4,
              moduleName: 'Módulo 4: Inclusão escolar',
              moduleDescription: 'Como promover a inclusão escolar de alunos com TEA.',
              videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID',
            ),
          ],
        ),
      ),
    );
  }
}

class BallWithNumber extends StatelessWidget {
  final int number;
  final String moduleName;
  final String moduleDescription;
  final String videoUrl;

  const BallWithNumber({
    required this.number,
    required this.moduleName,
    required this.moduleDescription,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModulePage(
              moduleName: moduleName,
              moduleDescription: moduleDescription,
              videoUrl: videoUrl,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.shade700,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class ModulePage extends StatelessWidget {
  final String moduleName;
  final String moduleDescription;
  final String videoUrl;

  const ModulePage({
    required this.moduleName,
    required this.moduleDescription,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(moduleName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              moduleDescription,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (await canLaunch(videoUrl)) {
                  await launch(videoUrl);
                } else {
                  throw 'Não foi possível abrir o link: $videoUrl';
                }
              },
              child: Text('Assistir ao vídeo'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DashedLine({this.height = 1, this.color = Colors.orange});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
