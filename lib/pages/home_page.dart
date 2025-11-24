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

  void deletar(int id) async {
    await DB.delete('exercicios', id);
    carregar();
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
        child: ListView.builder(
          itemCount: exercicios.length,
          itemBuilder: (context, index) {
            final e = exercicios[index];
            return Card(
              color: const Color(0xFF2A2A2A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  e.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "${e.grupoMuscular} • ${e.series} x ${e.repeticoes}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => deletar(e.id!),
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FormExercicioPage(exercicio: e),
                    ),
                  );
                  carregar();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
