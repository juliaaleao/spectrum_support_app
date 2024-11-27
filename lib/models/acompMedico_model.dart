class AcompanhamentoMedico {
  final String id;
  final String nome;
  final String configuracao;
  final String interacaoSocial;
  final String materiaisDidaticos;
  final String tarefasEAtividades;
  final String rotinaEMudancas;
  final String sensibilidadeSensorial;
  final String suporteAdicional;

  AcompanhamentoMedico({
    required this.id,
    required this.nome,
    required this.configuracao,
    required this.interacaoSocial,
    required this.materiaisDidaticos,
    required this.tarefasEAtividades,
    required this.rotinaEMudancas,
    required this.sensibilidadeSensorial,
    required this.suporteAdicional,
  });

  factory AcompanhamentoMedico.fromMap(Map<String, dynamic> data, String documentId) {
    return AcompanhamentoMedico(
      id: documentId,
      nome: data['nome'],
      configuracao: data['configuracao'],
      interacaoSocial: data['interacaoSocial'],
      materiaisDidaticos: data['materiaisDidaticos'],
      tarefasEAtividades: data['tarefasEAtividades'],
      rotinaEMudancas: data['rotinaEMudancas'],
      sensibilidadeSensorial: data['sensibilidadeSensorial'],
      suporteAdicional: data['suporteAdicional'],
    );
  }
}
