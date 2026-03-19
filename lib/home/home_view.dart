import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swimcalculator/home/home_view_model.dart';
import 'package:swimcalculator/shared/widgets/app_button_nav_bar.dart';
import 'package:swimcalculator/shared/widgets/result_card.dart';
import 'package:swimcalculator/shared/widgets/time_card.dart';

class HomeView extends StatelessWidget{
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeView(),
    );
  } 

}

class _HomeView extends StatelessWidget{
  const _HomeView();
  
  
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text('Swim Pace')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                      Icon(Icons.timer_sharp, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Tempo',
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
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: TimeCard(
                              controller: vm.hoursController,
                              label: 'Horas',
                              onChanged: () => context.read<HomeViewModel>().calculate(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TimeCard(
                              controller: vm.minutesController,
                              label: 'Minutos',
                              onChanged: () => context.read<HomeViewModel>().calculate(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TimeCard(
                              controller: vm.secondsController,
                              label: 'Segundos',
                              onChanged: () => context.read<HomeViewModel>().calculate(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.straighten_outlined, color: Color(0xFF1A6BFF)),
                              SizedBox(width: 8),
                              Text(
                                'Distância (km)',
                                style: TextStyle(color: Color.fromARGB(255, 80, 80, 80), fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: vm.distanceController,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => context.read<HomeViewModel>().calculate(),
                            decoration: InputDecoration(
                              hintText: 'Ex: 10',
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFF1A6BFF), width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ResultCard(
            pace: '${vm.paceMinutes}:${vm.paceSeconds}', 
            speed: vm.speed,
            onSave: () {
              final titleController = TextEditingController();
              showDialog(
                context: context, 
                builder: (_)=> AlertDialog(
                  title: const Text("Insira um título"),
                  content: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Ex: Campeonato Brasileiro'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        if(titleController.text.isNotEmpty) {
                          context.read<HomeViewModel>().saveActivity(titleController.text);
                          Navigator.pop(context);
                        }
                      }, 
                      child: const Text("Salvar")
                    ),
                  ],
                )
              );
            },
          )
        ],
      ),
      bottomNavigationBar: ButtonNavBar(
        indiceAtual: 0,
        onTap: (indice) {
          switch(indice) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/save');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
            case 3:
              Navigator.pushNamed(context, '/help');
              break;
          }
        }
      ),
    );
  }
}