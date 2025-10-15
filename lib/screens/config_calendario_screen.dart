import 'package:flutter/material.dart';

class ConfigCalendarioScreen extends StatefulWidget {
  const ConfigCalendarioScreen({super.key});

  @override
  State<ConfigCalendarioScreen> createState() => _ConfigCalendarioScreenState();
}

class _ConfigCalendarioScreenState extends State<ConfigCalendarioScreen> {
  bool _sincronizarGoogle = true;
  bool _mostrarFeriados = true;
  bool _notificarEventos = true;
  int _tempoAntecedencia = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  Text(
                    'Configurações de Calendário',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Sincronização
                  Text(
                    'Sincronização',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sincronizar com Google Calendar',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Importar eventos do Google',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey.shade400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _sincronizarGoogle,
                          onChanged: (value) {
                            setState(() {
                              _sincronizarGoogle = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Exibição
                  Text(
                    'Exibição',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mostrar feriados',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Exibir feriados nacionais',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey.shade400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _mostrarFeriados,
                          onChanged: (value) {
                            setState(() {
                              _mostrarFeriados = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Notificações
                  Text(
                    'Notificações',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Notificar eventos',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Receber lembretes de eventos',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey.shade400,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _notificarEventos,
                              onChanged: (value) {
                                setState(() {
                                  _notificarEventos = value;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                        if (_notificarEventos) ...[
                          const Divider(color: Colors.grey, height: 32),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tempo de antecedência',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                children: [5, 10, 15, 30, 60].map((minutos) {
                                  return ChoiceChip(
                                    label: Text('$minutos min'),
                                    selected: _tempoAntecedencia == minutos,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() {
                                          _tempoAntecedencia = minutos;
                                        });
                                      }
                                    },
                                    selectedColor: Colors.blue,
                                    backgroundColor: Colors.grey.shade800,
                                    labelStyle: TextStyle(
                                      color: _tempoAntecedencia == minutos
                                          ? Colors.white
                                          : Colors.grey.shade400,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
