import 'package:flutter/material.dart';
import 'package:to_do/comp/my_textfield.dart';

final List<String> storage = [];
final TextEditingController _controller = TextEditingController();

class ToDO extends StatefulWidget {
  const ToDO({super.key});

  @override
  State<ToDO> createState() => _ToDOState();
}

class _ToDOState extends State<ToDO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My To-Do List")),
      body: storage.isEmpty
          ? const Center(
              child: Text(
                "No todos yet. Add one!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: storage.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.indigo,
                    ),
                    title: Text(
                      storage[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          storage.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.clear(); // clear old text
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: const Text("Add To-Do"),
                content: MyTextfield(controller: _controller),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          storage.add(_controller.text);
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
