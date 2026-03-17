import 'package:flutter/material.dart';

class AppButton extends StatelessWidget{
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  AppButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1A6BFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white,),
          const SizedBox(width: 8,),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      )
    );
    
  }

}