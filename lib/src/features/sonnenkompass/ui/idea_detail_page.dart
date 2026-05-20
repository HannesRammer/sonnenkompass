import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../core/app_scope.dart';
import 'ui_helpers.dart';

class IdeaDetailPage extends StatelessWidget {
  const IdeaDetailPage({
    required this.ideaId,
    super.key,
  });

  final String ideaId;

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final idea = store.ideaById(ideaId);
    if (idea == null) {
      return buildPageScaffold(
        title: 'Idee nicht gefunden',
        subtitle: 'Die angeforderte Idee existiert nicht.',
        child: const SizedBox.shrink(),
      );
    }

    return buildPageScaffold(
      title: idea.title,
      subtitle: idea.summary,
      actions: [
        FilledButton(
          onPressed: idea.convertedToProjectId == null
              ? () => store.convertIdeaToProject(idea.id)
              : null,
          child: Text(
            idea.convertedToProjectId == null
                ? 'In Projekt umwandeln'
                : 'Schon umgewandelt',
          ),
        ),
      ],
      child: Column(
        children: [
          panel(
            'Einordnung',
            'Status, Klarheit und Potenzial dieser Idee.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(idea.description),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    pill('Status ${idea.status.name}'),
                    pill('Markt ${idea.monetizationPotential.name}'),
                    pill('Tempo ${idea.timeToFirstVersion.name}'),
                    pill('Beweis ${idea.proofOfOutput.name}'),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: IdeaStatus.values
                      .map(
                        (status) => ChoiceChip(
                          selected: idea.status == status,
                          label: Text(status.name),
                          onSelected: (_) =>
                              store.updateIdeaStatus(idea.id, status),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          panel(
            'Naechster sinnvoller Schritt',
            'Eine Idee bleibt nur relevant, wenn der naechste Schritt klar ist.',
            Text(
              idea.suggestedNextStep,
              style: const TextStyle(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
