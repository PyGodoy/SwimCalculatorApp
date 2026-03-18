import 'package:flutter/material.dart';
import 'package:swimcalculator/shared/widgets/app_button.dart';

class ResultCard extends StatelessWidget {
  final String pace;
  final String speed;
  final VoidCallback onSave;

  const ResultCard({
    super.key,
    required this.pace,
    required this.speed,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Topo azul
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A6BFF), Color(0xFF1A6BFF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.grid_view_outlined, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Result',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Corpo branco
          Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(59, 26, 106, 255),
                        ),
                        child: Column(
                          children: [
                            const Text('Pace', style: TextStyle(fontSize: 14)),
                            Text(
                              pace,
                              style: const TextStyle(
                                color: Color(0xFF1A6BFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('min/100m', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(59, 26, 106, 255),
                        ),
                        child: Column(
                          children: [
                            const Text('Speed', style: TextStyle(fontSize: 14)),
                            Text(
                              speed,
                              style: const TextStyle(
                                color: Color(0xFF1A6BFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('km/h', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppButton(
                  text: 'Save',
                  icon: Icons.save_alt_outlined,
                  onPressed: onSave,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}