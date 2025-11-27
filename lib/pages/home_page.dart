import 'package:flutter/material.dart';
import '../database/db.dart';
import '../model/exercicios.dart';
import 'form_exercicio_page.dart';
import 'intro_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Exercicio> exercicios = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future carregar() async {
    final data = await DB.getAll('exercicios');
    setState(() {
      exercicios = data.map((e) => Exercicio.fromMap(e)).toList();
    });
  }

  IconData getIconForEquipment(String equipamento) {
    switch (equipamento.toLowerCase()) {
      case "halteres":
      case "barra":
        return Icons.fitness_center;

      case "máquina":
        return Icons.settings;

      case "cabo":
        return Icons.cable;

      case "peso corporal":
        return Icons.accessibility;

      default:
        return Icons.fitness_center;
    }
  }

  void confirmarExclusao(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Excluir exercício?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Esta ação não pode ser desfeita.",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar", style: TextStyle(color: Colors.amber)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Excluir", style: TextStyle(color: Colors.redAccent)),
              onPressed: () async {
                await DB.delete('exercicios', id);
                Navigator.pop(context);
                carregar();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const IntroPage()),
            );
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Meus Recordes",
          style: TextStyle(
            color: Color(0xFFFFC107),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFC107),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormExercicioPage()),
          );
          carregar();
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: exercicios.isEmpty
            ? Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.fitness_center,
                        color: Colors.white24,
                        size: 90,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Comece a rastrear seu\nDesenvolvimento!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  final e = exercicios[index];

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                      color: Colors.amber,    // cor da borda
                      width: 2,               // espessura da borda
                    ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FormExercicioPage(exercicio: e),
                          ),
                        );
                        carregar();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ícone do equipamento
                            Icon(
                              getIconForEquipment(e.tipoEquipamento),
                              color: Colors.amber,
                              size: 34,
                            ),
                            const SizedBox(width: 14),

                            // COLUNA DE INFORMAÇÕES
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Nome
                                  Text(
                                    e.nome,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  // Grupo • Séries x Reps • Carga
                                  Text(
                                    "${e.grupoMuscular} • ${e.series} x ${e.repeticoes} • ${e.carga} kg",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  // Observações (se existirem)
                                  if (e.observacoes != null &&
                                      e.observacoes!.trim().isNotEmpty) ...[
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.sticky_note_2,
                                            size: 18, color: Colors.white38),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            e.observacoes!,
                                            style: const TextStyle(
                                              color: Colors.white38,
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                              height: 1.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // Botão de excluir
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.amber),
                              onPressed: () => confirmarExclusao(e.id!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

              ),
      ),
    );
  }
}
