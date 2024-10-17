import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_page.dart';
import 'help_page.dart';
import 'saves_page.dart';

class SwimCalculatorPage extends StatefulWidget {
  @override
  _SwimCalculatorPageState createState() => _SwimCalculatorPageState();
}

class _SwimCalculatorPageState extends State<SwimCalculatorPage> {
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  String paceMinutes = '--';
  String paceSeconds = '--';
  String speed = '--';
  bool canSave = false;

  List<Map<String, String>> savedData = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('savedData');
    if (data != null) {
      setState(() {
        savedData = data.map((item) {
          final parts = item.split('|');
          return {
            'title': parts[0],
            'distance': parts[1],
            'time': parts[2],
            'pace': parts[3],
            'speed': parts[4],
          };
        }).toList();
      });
    }
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = savedData.map((item) {
      return '${item['title']}|${item['distance']}|${item['time']}|${item['pace']}|${item['speed']}';
    }).toList();
    await prefs.setStringList('savedData', data);
  }

  void calculate() {
    int hours = int.tryParse(hoursController.text) ?? 0;
    int minutes = int.tryParse(minutesController.text) ?? 0;
    int seconds = int.tryParse(secondsController.text) ?? 0;
    double distance = double.tryParse(distanceController.text) ?? 0;

    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    if (totalSeconds > 0 && distance > 0) {
      double pacePer100m = totalSeconds / (distance * 10);
      int paceMin = (pacePer100m / 60).floor();
      int paceSec = (pacePer100m % 60).round();

      double speedKmPerHr = distance / (totalSeconds / 3600);

      setState(() {
        paceMinutes = paceMin.toString().padLeft(2, '0');
        paceSeconds = paceSec.toString().padLeft(2, '0');
        speed = speedKmPerHr.toStringAsFixed(2);
        canSave = true; // Habilita o botão de salvar
      });
    } else {
      setState(() {
        paceMinutes = '--';
        paceSeconds = '--';
        speed = '--';
        canSave = false; // Desabilita o botão de salvar
      });
    }
  }

  void _logout() {
    SystemNavigator.pop();
  }

  void _showTitleDialog() {
  final TextEditingController titleController = TextEditingController();
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Digite o Título'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: "Título"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                _saveToSaves(titleController.text);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}

void _saveToSaves(String title) async {
    setState(() {
      savedData.add({
        'title': title,
        'distance': distanceController.text + ' KM',
        'time': '${hoursController.text}:${minutesController.text}:${secondsController.text}',
        'pace': '$paceMinutes:$paceSeconds',
        'speed': speed,
      });
    });
    _saveData(); // Salva os dados no SharedPreferences

    // Exibe o SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dados salvos com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Limpa os campos após salvar
    hoursController.clear();
    minutesController.clear();
    secondsController.clear();
    distanceController.clear();
    setState(() {
      paceMinutes = '--';
      paceSeconds = '--';
      speed = '--';
      canSave = false;
    });
  }


  void _showSavesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavesPage(
          initialSavedData: savedData,
          onDelete: (index) {
            setState(() {
              savedData.removeAt(index);
              _saveData(); // Salva os dados após a exclusão
            });
          },
        ),
      ),
    ).then((_) {
      setState(() {}); // Atualiza o estado ao voltar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Swim Calculator Pace',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 340,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.pool, size: 40, color: Colors.black),
                        const SizedBox(width: 8),
                        Expanded(child: _buildTimeFields()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDistanceSection(),
                    const SizedBox(height: 16),
                    _buildPaceSection(),
                    const SizedBox(height: 16),
                    _buildSpeedSection(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: canSave ? _showTitleDialog : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canSave ? Colors.blue : Colors.grey,
                      ),
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Espaçamento entre a calculadora e os ícones
              _buildIconButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFields() {
    return Row(
      children: [
        Expanded(child: _buildTimeField(hoursController, 'Hour')),
        const SizedBox(width: 4),
        Expanded(child: _buildTimeField(minutesController, 'Minutes')),
        const SizedBox(width: 4),
        Expanded(child: _buildTimeField(secondsController, 'Seconds')),
      ],
    );
  }

  Widget _buildTimeField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      keyboardType: TextInputType.number,
      onChanged: (_) => calculate(),
    );
  }

  Widget _buildDistanceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Distance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('km', style: TextStyle(fontSize: 14)),
          ],
        ),
        SizedBox(
          width: 220,
          height: 40,
          child: TextField(
            controller: distanceController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: '0',
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            keyboardType: TextInputType.number,
            onChanged: (_) => calculate(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Pace',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              'min/100m',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            _buildResultBox(paceMinutes, width: 108),
            const SizedBox(width: 4),
            _buildResultBox(paceSeconds, width: 108),
          ],
        ),
      ],
    );
  }

  Widget _buildSpeedSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Speed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              'km/hr',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
        _buildResultBox(speed, width: 220),
      ],
    );
  }

  Widget _buildResultBox(String value, {double width = 50}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Text(
        value,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildIconButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.help),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
          },
        ),
        IconButton(
        icon: const Icon(Icons.save),
        onPressed: _showSavesPage, // Chame o método aqui
      ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _logout,
        ),
      ],
    );
  }
}