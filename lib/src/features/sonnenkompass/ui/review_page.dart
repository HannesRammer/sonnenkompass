import 'package:flutter/material.dart';

import '../../../core/app_scope.dart';
import 'ui_helpers.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController? dailyNoteController;
  TextEditingController? distractionController;
  TextEditingController? reviewController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (dailyNoteController != null) return;
    final store = AppScope.of(context);
    dailyNoteController =
        TextEditingController(text: store.focusDay.dailyNote ?? '');
    distractionController =
        TextEditingController(text: store.focusDay.distractionLog ?? '');
    reviewController =
        TextEditingController(text: store.focusDay.dayReview ?? '');
  }

  @override
  void dispose() {
    dailyNoteController?.dispose();
    distractionController?.dispose();
    reviewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return buildPageScaffold(
      title: 'Review',
      subtitle:
          'Der Tag endet nicht im Vergessen. Fokus, Ablenkungen und Ergebnis bleiben sichtbar.',
      actions: [
        FilledButton(
              onPressed: () async {
                await store.updateReview(
                  dailyNote: dailyNoteController!.text.trim(),
                  distractionLog: distractionController!.text.trim(),
                  dayReview: reviewController!.text.trim(),
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Review gespeichert')),
                );
              },
          child: const Text('Review speichern'),
        ),
        OutlinedButton(
          onPressed: () => store.resetToSeed(),
          child: const Text('Auf Seed-Stand zuruecksetzen'),
        ),
      ],
      child: panel(
        'Tagesrueckblick',
        'Hier wird der Tag auswertbar statt nur abgehakt.',
        Column(
          children: [
            TextField(
              controller: dailyNoteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Tagesnotiz',
                hintText: 'Was war heute der Plan und was ist wirklich passiert?',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: distractionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Ablenkungen / Stoerfaktoren',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reviewController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Review',
                hintText: 'Was war gut, was muss morgen anders laufen?',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
