import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../core/app_scope.dart';
import 'ui_helpers.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final project = store.projectById(projectId);
    if (project == null) {
      return buildPageScaffold(
        title: 'Projekt nicht gefunden',
        subtitle: 'Die angeforderte Projektansicht existiert nicht.',
        child: const SizedBox.shrink(),
      );
    }

    final tasks = store.tasksForProject(project.id);
    final ideas =
        store.ideas.where((idea) => idea.projectId == project.id).toList();
    final isPrimary = store.primaryProject.id == project.id;
    final isSecondary =
        store.secondaryProjects.any((candidate) => candidate.id == project.id);

    return buildPageScaffold(
      title: project.name,
      subtitle: project.description,
      actions: [
        FilledButton(
          onPressed: () => store.setPrimaryProject(project.id),
          child: Text(isPrimary ? 'Ist Kern' : 'Zum Kern machen'),
        ),
        OutlinedButton(
          onPressed:
              isPrimary ? null : () => store.toggleSecondaryProject(project.id),
          child: Text(isSecondary ? 'Aus Orbit entfernen' : 'In Orbit setzen'),
        ),
      ],
      child: Column(
        children: [
          panel(
            'Projektstatus',
            'Ziel, Status und Marktreife dieses Projekts.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.currentGoal),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    pill('Status ${project.status.name}'),
                    pill('Markt ${project.monetizationPotential.name}'),
                    pill('Tempo ${project.timeToFirstVersion.name}'),
                    pill('Beweis ${project.proofOfOutput.name}'),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ProjectStatus.values
                      .map(
                        (status) => ChoiceChip(
                          selected: project.status == status,
                          label: Text(status.name),
                          onSelected: (_) =>
                              store.updateProjectStatus(project.id, status),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          panel(
            'Aufgaben',
            'Konkrete Arbeitsschritte, nicht nur Projektkarten.',
            Column(
              children: tasks
                  .map(
                    (task) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                        value: task.status == TaskStatus.done,
                        onChanged: (_) => store.toggleTaskDone(task.id),
                      ),
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: DropdownButton<TaskStatus>(
                        value: task.status,
                        underline: const SizedBox.shrink(),
                        items: TaskStatus.values
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            store.updateTaskStatus(task.id, value);
                          }
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 18),
          panel(
            'Verknuepfte Ideen',
            'Ideen bleiben mit dem Projekt verbunden und enden nicht im Nichts.',
            Column(
              children: ideas
                  .map(
                    (idea) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(idea.title),
                      subtitle: Text(idea.suggestedNextStep),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
