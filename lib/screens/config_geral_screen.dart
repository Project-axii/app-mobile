import 'package:flutter/material.dart';

class ConfigGeralScreen extends StatefulWidget {
  const ConfigGeralScreen({super.key});

  @override
  State<ConfigGeralScreen> createState() => _ConfigGeralScreenState();
}

class _ConfigGeralScreenState extends State<ConfigGeralScreen> {
  bool _notificacoesAtivadas = true;
  bool _modoEconomiaEnergia = false;
  bool _inicioAutomatico = true;
  double _volumeAlertas = 0.7;
  String _idiomaAtual = 'Português (Brasil)';

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
                    'Configurações Gerais',
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
                  // Notificações
                  _buildSectionTitle(context, 'Notificações'),
                  _buildSwitchTile(
                    context,
                    title: 'Ativar notificações',
                    subtitle: 'Receber alertas e lembretes',
                    value: _notificacoesAtivadas,
                    onChanged: (value) {
                      setState(() {
                        _notificacoesAtivadas = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Sistema
                  _buildSectionTitle(context, 'Sistema'),
                  _buildSwitchTile(
                    context,
                    title: 'Modo economia de energia',
                    subtitle: 'Reduz consumo de bateria',
                    value: _modoEconomiaEnergia,
                    onChanged: (value) {
                      setState(() {
                        _modoEconomiaEnergia = value;
                      });
                    },
                  ),
                  _buildSwitchTile(
                    context,
                    title: 'Início automático',
                    subtitle: 'Iniciar ao ligar dispositivos',
                    value: _inicioAutomatico,
                    onChanged: (value) {
                      setState(() {
                        _inicioAutomatico = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Volume
                  _buildSectionTitle(context, 'Áudio'),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Volume de alertas',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.volume_down, color: Colors.grey),
                            Expanded(
                              child: Slider(
                                value: _volumeAlertas,
                                onChanged: (value) {
                                  setState(() {
                                    _volumeAlertas = value;
                                  });
                                },
                                activeColor: Colors.blue,
                                inactiveColor: Colors.grey.shade700,
                              ),
                            ),
                            const Icon(Icons.volume_up, color: Colors.grey),
                          ],
                        ),
                        Text(
                          '${(_volumeAlertas * 100).round()}%',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Idioma
                  _buildSectionTitle(context, 'Idioma e Região'),
                  _buildSelectTile(
                    context,
                    title: 'Idioma',
                    value: _idiomaAtual,
                    onTap: () {
                      _showIdiomaDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
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
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade400,
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectTile(
    BuildContext context, {
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade400,
                      ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showIdiomaDialog(BuildContext context) {
    final idiomas = [
      'Português (Brasil)',
      'English (US)',
      'Español',
      'Français',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text(
            'Selecionar idioma',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: idiomas.map((idioma) {
              return ListTile(
                title: Text(
                  idioma,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: _idiomaAtual == idioma
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() {
                    _idiomaAtual = idioma;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
