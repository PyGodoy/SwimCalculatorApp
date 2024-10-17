import 'package:flutter/material.dart';

class SavesPage extends StatefulWidget {
  final List<Map<String, String>> initialSavedData;
  final Function(int) onDelete;

  const SavesPage({Key? key, required this.initialSavedData, required this.onDelete}) : super(key: key);

  @override
  _SavesPageState createState() => _SavesPageState();
}

class _SavesPageState extends State<SavesPage> {
  late List<Map<String, String>> savedData;

  @override
  void initState() {
    super.initState();
    savedData = List.from(widget.initialSavedData);
  }

  void _deleteItem(int index) {
    setState(() {
      savedData.removeAt(index);
    });
    widget.onDelete(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saves'),
      ),
      body: ListView.builder(
        itemCount: savedData.length,
        itemBuilder: (context, index) {
          final data = savedData[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, // Alinhamento vertical
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'] ?? 'Título não disponível',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Distance: ${data['distance']}', style: const TextStyle(color: Colors.white)),
                      Text('Time: ${data['time']}', style: const TextStyle(color: Colors.white)),
                      Text('Pace: ${data['pace']}', style: const TextStyle(color: Colors.white)),
                      Text('Speed: ${data['speed']}', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteItem(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
