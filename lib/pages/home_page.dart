import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../widgets/tarefa_item.dart';
import '../widgets/pomodoro_widget.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Tarefa> tarefas = [];
  final TextEditingController controller = TextEditingController();

  void adicionarTarefa() {
    if (controller.text.isNotEmpty) {
      setState(() {
        tarefas.add(Tarefa(controller.text, false));
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas & Pomodoro'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo de nova tarefa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: adicionarTarefa,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Lista de tarefas
            Expanded(
              child: tarefas.isEmpty
                  ? const Center(
                child: Text(
                  'Nenhuma tarefa adicionada ',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return TarefaItem(
                    tarefa: tarefas[index],
                    onToggle: () {
                      setState(() {
                        tarefas[index].concluida =
                        !tarefas[index].concluida;
                      });
                    },
                    onDelete: () {
                      setState(() => tarefas.removeAt(index));
                    },
                  );
                },
              ),
            ),

            // Pomodoro
            const PomodoroWidget(),
          ],
        ),
      ),
    );
  }
}
