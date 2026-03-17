import 'package:flutter/material.dart';
import 'package:swimcalculator/shared/models/saves_model.dart';

class SavesCard extends StatelessWidget{
  final SavesModel save;
  final VoidCallback onDelete;

  const SavesCard({
    super.key,
    required this.save,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C6FF), Color(0xFF1A6BFF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.white, size: 18,),
                    const SizedBox(width: 8,),
                    Text(
                      save.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white,),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(47, 0, 200, 255),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Pace",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              save.pace,
                              style: const TextStyle(
                                color:  Color.fromARGB(255, 20, 94, 114),
                                fontSize: 18
                              ),
                            ),
                            const Text(
                              "min/100m",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(50, 26, 106, 255),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Speed",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              save.speed,
                              style: const TextStyle(
                                color:  Color(0xFF1A6BFF),
                                fontSize: 18
                              ),
                            ),
                            const Text(
                              "km/h",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                const Divider(
                  color: Color.fromARGB(48, 158, 158, 158),
                  radius:BorderRadius.all(Radius.circular(24)),
                  thickness: 2,
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.straighten_outlined, color: const Color.fromARGB(255, 26, 171, 255)),
                    
                    Text(save.distance),
                    SizedBox(width: 24,),
                    Icon(Icons.timer_outlined, color: const Color.fromARGB(255, 26, 171, 255)),
                    Text(save.time),
                    SizedBox(width: 24,),
                    Icon(Icons.date_range_outlined, color: Colors.grey),
                    Text(save.createdAt),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}