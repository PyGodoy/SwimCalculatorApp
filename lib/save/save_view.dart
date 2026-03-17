import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swimcalculator/save/save_view_model.dart';
import 'package:swimcalculator/shared/models/saves_model.dart';
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
    ? const Center(child: CircularProgressIndicator())
    : ListView.builder(
        itemCount: vm.saves.length,
        itemBuilder: (context, index) {
          final save = SavesModel.fromJson(vm.saves[index]);
          return SavesCard(save: save, onDelete: () => vm.deleteSave(save.id));
        },
      ),
    );
  }
}
