import 'package:flutter/material.dart';

class ButtonNavBar extends StatelessWidget {
  final int indiceAtual;
  final Function(int) onTap;

  const ButtonNavBar({super.key, 
    required this.indiceAtual,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: indiceAtual,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1A6BFF),
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled) ,
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history) ,
          label: "History"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2) ,
          label: "Profile"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help) ,
          label: "Help"
        ),
      ],
    );
  }
}