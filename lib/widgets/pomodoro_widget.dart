import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroWidget extends StatefulWidget {
  const PomodoroWidget({super.key});

  @override
  State<PomodoroWidget> createState() => _PomodoroWidgetState();
}

class _PomodoroWidgetState extends State<PomodoroWidget> {
  int tempoRestante = 25 * 60;
  bool rodando = false;
  StreamSubscription? ticker;

  void iniciar() {
    if (rodando) return;

    rodando = true;
    ticker = Stream.periodic(const Duration(seconds: 1)).listen((_) {
      if (tempoRestante > 0) {
        setState(() => tempoRestante--);
      } else {
        ticker?.cancel();
        rodando = false;
      }
    });
  }

  void pausar() {
    ticker?.cancel();
    rodando = false;
  }

  void resetar() {
    ticker?.cancel();
    setState(() {
      tempoRestante = 25 * 60;
      rodando = false;
    });
  }

  String formatarTempo() {
    final min = tempoRestante ~/ 60;
    final seg = tempoRestante % 60;
    return '${min.toString().padLeft(2, '0')}:${seg.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Pomodoro',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              formatarTempo(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(onPressed: iniciar, child: const Text('Iniciar')),
                FilledButton.tonal(
                    onPressed: pausar, child: const Text('Pausar')),
                OutlinedButton(
                    onPressed: resetar, child: const Text('Resetar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
