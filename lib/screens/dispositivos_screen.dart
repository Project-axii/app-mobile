import 'package:flutter/material.dart';

class DispositivosScreen extends StatelessWidget {
  const DispositivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dispositivos',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onBackground,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Grupos Section
          Text(
            'Grupos',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),

          // Groups Row
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildGroupCard(context, 'Lab1', Icons.bed, false),
                const SizedBox(width: 16),
                _buildGroupCard(context, 'Novo grupo', Icons.add, true),
                const SizedBox(width: 16),
                _buildGroupCard(
                    context, 'Combine speakers', Icons.speaker_group, false),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Dispositivos Section
          Text(
            'Dispositivos',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),

          // Devices List
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.lightbulb, color: Colors.yellow),
                    title: const Text('Lâmpada WiFi'),
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('Desativada'),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade700,
                      child: const Icon(Icons.speaker, color: Colors.white),
                    ),
                    title: const Text('Esp8266 lab 1'),
                    subtitle: const Text('On-line'),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.phone_android, color: Colors.grey),
                    title: const Text('Neste telefone'),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(
      BuildContext context, String title, IconData icon, bool isDashed) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: isDashed ? Colors.transparent : Theme.of(context).cardColor,
        border: isDashed
            ? Border.all(color: Colors.grey.shade600, style: BorderStyle.solid)
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: isDashed ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
