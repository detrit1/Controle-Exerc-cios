class Exercicio {
  int? id;
  String nome;
  String grupoMuscular;
  String tipoEquipamento;
  int series;
  int repeticoes;
  double carga;

  Exercicio({
    this.id,
    required this.nome,
    required this.grupoMuscular,
    required this.tipoEquipamento,
    required this.series,
    required this.repeticoes,
    required this.carga,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'grupoMuscular': grupoMuscular,
      'tipoEquipamento': tipoEquipamento,
      'series': series,
      'repeticoes': repeticoes,
      'carga': carga,
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
    );
  }
}
