import 'dart:math' as math;

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
            'Die Strahlen sind der aeussere Orientierungskreis des Sonnenkompasses.',
            Column(
              children: [
                _RayCompass(
                  rays: store.rays,
                  selectedRayId: selectedRay.id,
                  onSelect: (ray) => context.go('/rays/${ray.id}'),
                ),
                const SizedBox(height: 18),
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
              ],
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

class _RayCompass extends StatelessWidget {
  const _RayCompass({
    required this.rays,
    required this.selectedRayId,
    required this.onSelect,
  });

  final List<Ray> rays;
  final String selectedRayId;
  final ValueChanged<Ray> onSelect;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, 520.0);
        final radius = size * 0.34;
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size * 0.9,
                  height: size * 0.9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF232323)),
                  ),
                ),
                Container(
                  width: size * 0.55,
                  height: size * 0.55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF34281C)),
                  ),
                ),
                Container(
                  width: size * 0.24,
                  height: size * 0.24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE47B38),
                  ),
                  child: const Center(
                    child: Text(
                      'Strahlen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                for (var i = 0; i < rays.length; i++)
                  Transform.translate(
                    offset: Offset(
                      math.cos((-math.pi / 2) + (i * (2 * math.pi / rays.length))) *
                          radius,
                      math.sin((-math.pi / 2) + (i * (2 * math.pi / rays.length))) *
                          radius,
                    ),
                    child: _RayNode(
                      ray: rays[i],
                      selected: rays[i].id == selectedRayId,
                      onTap: () => onSelect(rays[i]),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RayNode extends StatelessWidget {
  const _RayNode({
    required this.ray,
    required this.selected,
    required this.onTap,
  });

  final Ray ray;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 120),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF59E0B) : const Color(0xFF111111),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xFFF59E0B)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Text(
          ray.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? const Color(0xFF111111) : Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
