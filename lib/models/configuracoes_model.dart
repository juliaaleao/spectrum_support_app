class Configuracoes {
  final bool notificarNovosRecursos;
  final bool modoEscuro;

  Configuracoes({
    this.notificarNovosRecursos = true,
    this.modoEscuro = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificarNovosRecursos': notificarNovosRecursos,
      'modoEscuro': modoEscuro,
    };
  }
}
