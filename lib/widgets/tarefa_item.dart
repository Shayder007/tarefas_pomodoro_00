import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class TarefaItem extends StatelessWidget {
  final Tarefa tarefa;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TarefaItem({
    super.key,
    required this.tarefa,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: tarefa.concluida,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          tarefa.titulo,
          style: TextStyle(
            decoration:
            tarefa.concluida ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
