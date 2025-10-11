import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configItems = [
      'Esportes',
      'Finanças',
      'Tipos de restaurante',
      'Calendário',
      'Lembretes',
      'Detecção de dispositivos',
      'Geral',
      'Informações',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with back button
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              Text(
                'Configurações',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Configuration Items
          Expanded(
            child: ListView.separated(
              itemCount: configItems.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                height: 1,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    configItems[index],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                );
              },
            ),
          ),

          // Bottom Section
          const Divider(color: Colors.grey, height: 1),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Não é Pedro?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade400,
                    ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
