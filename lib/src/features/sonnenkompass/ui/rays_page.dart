import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/models.dart';
import '../../../core/app_scope.dart';
import '../../../core/app_store.dart';
import 'ui_helpers.dart';

class RaysPage extends StatelessWidget {
  const RaysPage({
    this.rayId,
    super.key,
  });

  final String? rayId;

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final selectedRay = rayId == null ? store.rays.first : store.rayById(rayId!);
    final projects = store.projectsForRay(selectedRay.id);
    final ideas = store
        .ideasForRay(selectedRay.id)
        .where((idea) => idea.rayId == selectedRay.id)
        .toList();
    final tasks = store.tasksForRay(selectedRay.id);

    return buildPageScaffold(
      title: 'Strahlen',
      subtitle:
          'Jeder Strahl ist ein echter Arbeitsbereich mit Projekten, Ideen und Aufgaben.',
      child: Column(
        children: [
          panel(
            'Strahl wechseln',
            'Keine versteckten Bereiche mehr.',
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: store.rays
                  .map(
                    (ray) => ChoiceChip(
                      selected: selectedRay.id == ray.id,
                      label: Text(ray.name),
                      onSelected: (_) => context.go('/rays/${ray.id}'),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 18),
          panel(
            selectedRay.name,
            selectedRay.description,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Projekte',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                ...projects.map(
                  (project) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(project.name),
                    subtitle: Text(project.currentGoal),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/projects/${project.id}'),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Aufgaben',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                ...tasks.map(
                  (task) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(task.title),
                    subtitle: Text(task.description),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Ideen',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    FilledButton(
                      onPressed: () => _openIdeaDialog(context, store, selectedRay.id),
                      child: const Text('Idee anlegen'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...ideas.map(
                  (idea) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(idea.title),
                    subtitle: Text(idea.summary),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/ideas/${idea.id}'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openIdeaDialog(
    BuildContext context,
    SonnenkompassStore store,
    String rayId,
  ) async {
    final title = TextEditingController();
    final summary = TextEditingController();
    var monetization = MonetizationPotential.medium;

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Neue Idee'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'Titel'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: summary,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Kurzbeschreibung'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<MonetizationPotential>(
                  value: monetization,
                  items: MonetizationPotential.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => monetization = value);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () async {
                if (title.text.trim().isEmpty || summary.text.trim().isEmpty) {
                  return;
                }
                await store.addIdea(
                  rayId: rayId,
                  title: title.text.trim(),
                  summary: summary.text.trim(),
                  monetizationPotential: monetization,
                );
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
