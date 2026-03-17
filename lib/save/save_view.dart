import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swimcalculator/save/save_view_model.dart';
import 'package:swimcalculator/shared/models/saves_model.dart';
import 'package:swimcalculator/shared/widgets/app_button_nav_bar.dart';
import 'package:swimcalculator/shared/widgets/saves_card.dart';

class SaveView extends StatelessWidget {
  const SaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaveViewModel()..getSaves(),
      child: const _SaveView(),
    );
  }
}

class _SaveView extends StatelessWidget {
  const _SaveView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SaveViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Saves')),
      body: vm.isLoading
    ? const Center(child: CircularProgressIndicator(color: Color(0xFF1A6BFF),))
    : ListView.builder(
        itemCount: vm.saves.length,
        itemBuilder: (context, index) {
          final save = SavesModel.fromJson(vm.saves[index]);
          return SavesCard(save: save, onDelete: () => vm.deleteSave(save.id));
        },
      ),
      bottomNavigationBar: ButtonNavBar(
        indiceAtual: 1,
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
