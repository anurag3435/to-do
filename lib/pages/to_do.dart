import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/comp/my_textfield.dart';

final TextEditingController _controller = TextEditingController();

class ToDO extends StatefulWidget {
  const ToDO({super.key});
  @override
  State<ToDO> createState() => _ToDOState();
}

class _ToDOState extends State<ToDO> {
  late Box<Map> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Map>('box'); // make sure same name in main.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My To-Do List")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Map> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("no notes yet"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: box.length,
            itemBuilder: (context, index) {
              final todo = box.getAt(index)!;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: Checkbox(
                    value: todo["completed"] as bool,
                    onChanged: (value) {
                      box.putAt(index, {
                        "text": todo["text"],
                        "completed": value,
                      });
                    },
                  ),
                  title: Text(
                    todo["text"] as String,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: (todo["completed"] as bool)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.clear();
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
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        box.add({
                          "text": _controller.text.trim(),
                          "completed": false,
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
