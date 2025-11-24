class Exercicio {
  int? id;
  String nome;
  String grupoMuscular;
  String tipoEquipamento;
  int series;
  int repeticoes;
  double carga;
  String? observacoes;

  Exercicio({
    this.id,
    required this.nome,
    required this.grupoMuscular,
    required this.tipoEquipamento,
    required this.series,
    required this.repeticoes,
    required this.carga,
    this.observacoes
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'grupoMuscular': grupoMuscular,
      'tipoEquipamento': tipoEquipamento,
      'series': series,
      'repeticoes': repeticoes,
      'carga': carga,
      'observacoes': observacoes
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'nome': nome,
      'grupoMuscular': grupoMuscular,
      'tipoEquipamento': tipoEquipamento,
      'series': series,
      'repeticoes': repeticoes,
      'carga': carga,
      'observacoes': observacoes
    };
  }

  factory Exercicio.fromMap(Map<String, dynamic> map) {
    return Exercicio(
      id: map['id'],
      nome: map['nome'],
      grupoMuscular: map['grupoMuscular'],
      tipoEquipamento: map['tipoEquipamento'],
      series: map['series'],
      repeticoes: map['repeticoes'],
      carga: map['carga'],
      observacoes: map['observacoes']
    );
  }
}
