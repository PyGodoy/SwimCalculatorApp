import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swimcalculator/home/home_view_model.dart';
import 'package:swimcalculator/shared/widgets/app_button.dart';
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
        
        children: [
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(Icons.timer_sharp, color: Color(0xFF00C6FF),),
                    SizedBox(width: 8),
                    Text(
                      "Tempo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    Expanded(
                      child: TimeCard(
                        controller: vm.hoursController,
                        label: 'Hours',
                        onChanged: () => context.read<HomeViewModel>().calculate(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TimeCard(
                        controller: vm.minutesController,
                        label: 'Minutes',
                        onChanged: () => context.read<HomeViewModel>().calculate(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TimeCard(
                        controller: vm.secondsController,
                        label: 'Seconds',
                        onChanged: () => context.read<HomeViewModel>().calculate(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.straighten_outlined, color: Color(0xFF00C6FF)),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                AppButton(
                  text: "Calcular", 
                  icon: Icons.bar_chart_outlined, 
                  onPressed: () => context.read<HomeViewModel>().calculate(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}