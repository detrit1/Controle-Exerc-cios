import 'package:flutter/material.dart';
import '../database/db.dart';
import '../model/exercicios.dart';

class FormExercicioPage extends StatefulWidget {
  final Exercicio? exercicio;

  const FormExercicioPage({super.key, this.exercicio});

  @override
  State<FormExercicioPage> createState() => _FormExercicioPageState();
}

class _FormExercicioPageState extends State<FormExercicioPage> {
  final _formKey = GlobalKey<FormState>();

  final nome = TextEditingController();
  final series = TextEditingController();
  final repeticoes = TextEditingController();
  final carga = TextEditingController();

  String grupoMuscular = "Peito";
  String equipamento = "Halteres";

  final grupos = [
    "Peito",
    "Costas",
    "Ombros",
    "Bíceps",
    "Tríceps",
    "Quadríceps",
    "Glúteos",
    "Posterior"
  ];

  final equipamentos = [
    "Halteres",
    "Barra",
    "Máquina",
    "Cabo",
    "Peso corporal"
  ];

  @override
  void initState() {
    super.initState();
    if (widget.exercicio != null) {
      nome.text = widget.exercicio!.nome;
      series.text = widget.exercicio!.series.toString();
      repeticoes.text = widget.exercicio!.repeticoes.toString();
      carga.text = widget.exercicio!.carga.toString();
      grupoMuscular = widget.exercicio!.grupoMuscular;
      equipamento = widget.exercicio!.tipoEquipamento;
    }
  }

  void salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final novo = Exercicio(
      nome: nome.text,
      grupoMuscular: grupoMuscular,
      tipoEquipamento: equipamento,
      series: int.parse(series.text.trim()),
      repeticoes: int.parse(repeticoes.text.trim()),
      carga: double.parse(carga.text.trim()),
    );


    if (widget.exercicio == null) {
      // INSERT
      await DB.insert('exercicios', novo.toMap());
    } else {
      // UPDATE
      await DB.update(
        'exercicios',
        widget.exercicio!.id!,
        novo.toMapUpdate(),
      );
    }
    Navigator.pop(context, true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercicio == null ? "Novo Exercício" : "Editar Exercício")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nome,
                decoration: const InputDecoration(labelText: "Nome do exercício"),
                validator: (v) => v!.isEmpty ? "Informe um nome" : null,
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField(
                value: grupoMuscular,
                items: grupos.map((g) => DropdownMenuItem(
                  value: g,
                  child: Text(g),
                )).toList(),
                onChanged: (v) => setState(() => grupoMuscular = v!),
                decoration: const InputDecoration(labelText: "Grupo Muscular"),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField(
                value: equipamento,
                items: equipamentos.map((g) => DropdownMenuItem(
                  value: g,
                  child: Text(g),
                )).toList(),
                onChanged: (v) => setState(() => equipamento = v!),
                decoration: const InputDecoration(labelText: "Equipamento"),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: series,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Séries"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: repeticoes,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Repetições"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: carga,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Carga (kg)"),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvar,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
