import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            title: 'Cadastro de Dados',
            description:
                'Permite que os usuários cadastrem suas atividades esportivas, incluindo distância, tempo, ritmo e velocidade.',
          ),
          _buildFeatureCard(
            title: 'Cálculo de Desempenho',
            description:
                'O aplicativo calcula automaticamente o ritmo e a velocidade com base nos dados inseridos, ajudando a acompanhar o progresso.',
          ),
          _buildFeatureCard(
            title: 'Dados Salvos',
            description:
                'Os usuários podem salvar seus dados de atividades, permitindo acesso fácil e rápido para consultas futuras.',
          ),
          _buildFeatureCard(
            title: 'Edição e Exclusão',
            description:
                'Possibilidade de editar ou excluir dados salvos, garantindo que as informações estejam sempre atualizadas.',
          ),
          _buildFeatureCard(
            title: 'Interface Intuitiva',
            description:
                'O aplicativo apresenta uma interface amigável e fácil de navegar, tornando a experiência do usuário mais agradável.',
          ),
          _buildFeatureCard(
            title: 'Armazenamento Persistente',
            description:
                'Todos os dados salvos permanecem disponíveis mesmo após o fechamento do aplicativo, garantindo que nenhuma informação seja perdida.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required String title, required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
