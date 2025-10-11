import 'package:flutter/material.dart';
import 'dart:async';

class MonitoramentoScreen extends StatefulWidget {
  const MonitoramentoScreen({super.key});

  @override
  State<MonitoramentoScreen> createState() => _MonitoramentoScreenState();
}

class _MonitoramentoScreenState extends State<MonitoramentoScreen> {
  Timer? _timer;
  int _segundos = 0;

  final List<Map<String, dynamic>> _computadores = [
    {'id': 1, 'status': 'online', 'cpu': 45, 'memoria': 62, 'problema': false},
    {'id': 2, 'status': 'online', 'cpu': 38, 'memoria': 55, 'problema': false},
    {'id': 3, 'status': 'offline', 'cpu': 0, 'memoria': 0, 'problema': true},
    {'id': 4, 'status': 'online', 'cpu': 92, 'memoria': 88, 'problema': true},
    {'id': 5, 'status': 'online', 'cpu': 41, 'memoria': 58, 'problema': false},
    {'id': 6, 'status': 'online', 'cpu': 35, 'memoria': 51, 'problema': false},
    {'id': 7, 'status': 'online', 'cpu': 48, 'memoria': 64, 'problema': false},
    {'id': 8, 'status': 'online', 'cpu': 52, 'memoria': 70, 'problema': false},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _segundos++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final computadoresOnline =
        _computadores.where((c) => c['status'] == 'online').length;
    final computadoresComProblema =
        _computadores.where((c) => c['problema'] == true).length;

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
          'Monitoramento em Tempo Real',
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
            // Status Geral
            Row(
              children: [
                Expanded(
                  child: _buildStatusCard(
                    'Online',
                    '$computadoresOnline/${_computadores.length}',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatusCard(
                    'Problemas',
                    '$computadoresComProblema',
                    Icons.warning,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Título da seção
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Computadores',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Atualizado há ${_segundos}s',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Lista de Computadores
            ..._computadores.map((comp) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildComputadorCard(comp),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComputadorCard(Map<String, dynamic> comp) {
    final isOnline = comp['status'] == 'online';
    final temProblema = comp['problema'] == true;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: temProblema ? Border.all(color: Colors.orange, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.computer,
                  color: isOnline ? Colors.green : Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Computador ${comp['id']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isOnline ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isOnline ? 'Online' : 'Offline',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (temProblema)
                const Icon(Icons.warning, color: Colors.orange, size: 24),
            ],
          ),
          if (isOnline) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMetricBar('CPU', comp['cpu'], comp['cpu'] > 80),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricBar(
                      'RAM', comp['memoria'], comp['memoria'] > 80),
                ),
              ],
            ),
          ],
          if (temProblema) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: Colors.orange, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isOnline ? 'Alto uso de recursos' : 'Sem conexão',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Resolver',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricBar(String label, int value, bool isHigh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
            Text(
              '$value%',
              style: TextStyle(
                color: isHigh ? Colors.orange : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: const Color(0xFF2A2A2A),
            valueColor: AlwaysStoppedAnimation<Color>(
              isHigh ? Colors.orange : const Color(0xFF8B5CF6),
            ),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
