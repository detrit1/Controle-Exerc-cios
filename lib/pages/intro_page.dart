import 'package:flutter/material.dart';
import 'package:exercicios/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            const SizedBox(height: 40),

            Column(
              children: const [
                Text(
                  "TrackFit Records",
                  style: TextStyle(
                    color: Color(0xFFFFB800),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Acompanhe sua evolução, um treino por vez",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: Center(
                child: Icon(
                  Icons.fitness_center,
                  size: 120,
                  color: Color(0xFFFFB800),
                ),
              ),
            ),

            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA800),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                                          },
                    child: const Text(
                      "Começar",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _FeatureCard(icon: Icons.local_fire_department, text: "Recordes"),
                    _FeatureCard(icon: Icons.bar_chart, text: "Evolução"),
                    _FeatureCard(icon: Icons.bolt, text: "Insights"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFB800), width: 1.2),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Color(0xFFFFA800)),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
