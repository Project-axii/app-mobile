import 'package:flutter/material.dart';

class ControleSalaScreen extends StatefulWidget {
  const ControleSalaScreen({super.key});

  @override
  State<ControleSalaScreen> createState() => _ControleSalaScreenState();
}

class _ControleSalaScreenState extends State<ControleSalaScreen> {
  bool _todosComputadoresLigados = false;
  bool _projetorLigado = false;
  double _iluminacao = 70.0;
  bool _arCondicionadoLigado = true;
  double _temperatura = 22.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Controle da Sala',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controle de Computadores
            _buildSectionTitle('Computadores'),
            const SizedBox(height: 12),
            _buildControlCard(
              icon: Icons.computer,
              title: 'Todos os Computadores',
              subtitle:
                  _todosComputadoresLigados ? '15 ligados' : '15 desligados',
              value: _todosComputadoresLigados,
              onChanged: (value) {
                setState(() {
                  _todosComputadoresLigados = value;
                });
              },
            ),
            const SizedBox(height: 12),
            _buildQuickActionButtons(),

            const SizedBox(height: 24),

            // Controle de Projetor
            _buildSectionTitle('Projetor'),
            const SizedBox(height: 12),
            _buildControlCard(
              icon: Icons.videocam,
              title: 'Projetor Principal',
              subtitle: _projetorLigado ? 'Ligado - HDMI 1' : 'Desligado',
              value: _projetorLigado,
              onChanged: (value) {
                setState(() {
                  _projetorLigado = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Controle de Iluminação
            _buildSectionTitle('Iluminação'),
            const SizedBox(height: 12),
            _buildSliderCard(
              icon: Icons.lightbulb_outline,
              title: 'Intensidade da Luz',
              value: _iluminacao,
              onChanged: (value) {
                setState(() {
                  _iluminacao = value;
                });
              },
              suffix: '%',
            ),

            const SizedBox(height: 24),

            // Controle de Ar Condicionado
            _buildSectionTitle('Climatização'),
            const SizedBox(height: 12),
            _buildControlCard(
              icon: Icons.ac_unit,
              title: 'Ar Condicionado',
              subtitle: _arCondicionadoLigado
                  ? '${_temperatura.toInt()}°C'
                  : 'Desligado',
              value: _arCondicionadoLigado,
              onChanged: (value) {
                setState(() {
                  _arCondicionadoLigado = value;
                });
              },
            ),
            if (_arCondicionadoLigado) ...[
              const SizedBox(height: 12),
              _buildSliderCard(
                icon: Icons.thermostat,
                title: 'Temperatura',
                value: _temperatura,
                min: 16,
                max: 30,
                onChanged: (value) {
                  setState(() {
                    _temperatura = value;
                  });
                },
                suffix: '°C',
              ),
            ],

            const SizedBox(height: 24),

            // Botão de Ação Rápida
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _mostrarDialogoIniciarAula();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Iniciar Aula Automaticamente',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildControlCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF8B5CF6), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF8B5CF6),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCard({
    required IconData icon,
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
    required String suffix,
    double min = 0,
    double max = 100,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF8B5CF6), size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${value.toInt()}$suffix',
                style: const TextStyle(
                  color: Color(0xFF8B5CF6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color(0xFF8B5CF6),
              inactiveTrackColor: const Color(0xFF2A2A2A),
              thumbColor: const Color(0xFF8B5CF6),
              overlayColor: const Color(0xFF8B5CF6).withOpacity(0.2),
              trackHeight: 4,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            'Ligar Todos',
            Icons.power_settings_new,
            () {
              setState(() {
                _todosComputadoresLigados = true;
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionButton(
            'Desligar Todos',
            Icons.power_off,
            () {
              setState(() {
                _todosComputadoresLigados = false;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
      String label, IconData icon, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF8B5CF6),
        side: const BorderSide(color: Color(0xFF8B5CF6)),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _mostrarDialogoIniciarAula() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'Iniciar Aula',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Isso irá:\n• Ligar todos os computadores\n• Ligar o projetor\n• Ajustar iluminação para 70%\n• Ligar ar condicionado em 22°C',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _todosComputadoresLigados = true;
                _projetorLigado = true;
                _iluminacao = 70;
                _arCondicionadoLigado = true;
                _temperatura = 22;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sala preparada para aula!'),
                  backgroundColor: Color(0xFF8B5CF6),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
            ),
            child: const Text('Iniciar'),
          ),
        ],
      ),
    );
  }
}
