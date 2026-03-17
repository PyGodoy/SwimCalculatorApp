import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget{
  late String label;
  final TextEditingController controller;
  final VoidCallback onChanged;

  TimeCard({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Color.fromARGB(255, 80, 80, 80),
            fontSize: 14,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: '00',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            )
          ),
        ),
      ],
    );
  }
}