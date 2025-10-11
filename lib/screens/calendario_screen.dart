import 'package:flutter/material.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({super.key});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  DateTime _selectedDate = DateTime.now();

  final Map<DateTime, List<Map<String, dynamic>>> _eventos = {
    DateTime(2025, 1, 7): [
      {'titulo': 'Aula de Matemática', 'hora': '08:00', 'sala': 'Sala 101'},
      {
        'titulo': 'Reunião Pedagógica',
        'hora': '14:00',
        'sala': 'Sala dos Professores'
      },
    ],
    DateTime(2025, 1, 8): [
      {'titulo': 'Aula de Física', 'hora': '09:00', 'sala': 'Laboratório'},
    ],
    DateTime(2025, 1, 10): [
      {'titulo': 'Prova de História', 'hora': '10:00', 'sala': 'Sala 203'},
      {
        'titulo': 'Correção de Provas',
        'hora': '15:00',
        'sala': 'Sala dos Professores'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final eventosHoje = _eventos[DateTime(
            _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
        [];

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
          'Calendário',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF8B5CF6)),
            onPressed: () {
              _adicionarEvento();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendarioHeader(),
          _buildCalendarioGrid(),
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          Expanded(
            child: eventosHoje.isEmpty
                ? _buildSemEventos()
                : _buildListaEventos(eventosHoje),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarioHeader() {
    final meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${meses[_selectedDate.month - 1]} ${_selectedDate.year}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _selectedDate =
                        DateTime(_selectedDate.year, _selectedDate.month - 1);
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _selectedDate =
                        DateTime(_selectedDate.year, _selectedDate.month + 1);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarioGrid() {
    final diasSemana = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: diasSemana
                .map((dia) => SizedBox(
                      width: 40,
                      child: Text(
                        dia,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          _buildDiasDoMes(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDiasDoMes() {
    final primeiroDia = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final ultimoDia = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    final diasNoMes = ultimoDia.day;
    final diaSemanaInicio = primeiroDia.weekday % 7;

    final dias = <Widget>[];

    for (int i = 0; i < diaSemanaInicio; i++) {
      dias.add(const SizedBox(width: 40, height: 40));
    }

    for (int dia = 1; dia <= diasNoMes; dia++) {
      final data = DateTime(_selectedDate.year, _selectedDate.month, dia);
      final temEventos = _eventos.containsKey(data);
      final isHoje = data.day == DateTime.now().day &&
          data.month == DateTime.now().month &&
          data.year == DateTime.now().year;
      final isSelecionado = data.day == _selectedDate.day;

      dias.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = data;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelecionado ? const Color(0xFF8B5CF6) : null,
              border: isHoje
                  ? Border.all(color: const Color(0xFF8B5CF6), width: 2)
                  : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '$dia',
                  style: TextStyle(
                    color: isSelecionado ? Colors.white : Colors.grey[300],
                    fontWeight:
                        isSelecionado ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (temEventos)
                  Positioned(
                    bottom: 4,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelecionado
                            ? Colors.white
                            : const Color(0xFF8B5CF6),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: dias,
    );
  }

  Widget _buildSemEventos() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum evento neste dia',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListaEventos(List<Map<String, dynamic>> eventos) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Eventos do dia ${_selectedDate.day}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...eventos.map((evento) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildEventoCard(evento),
            )),
      ],
    );
  }

  Widget _buildEventoCard(Map<String, dynamic> evento) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF8B5CF6), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.event,
              color: Color(0xFF8B5CF6),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evento['titulo'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      evento['hora'],
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      evento['sala'],
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
        ],
      ),
    );
  }

  void _adicionarEvento() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Adicionar novo evento'),
        backgroundColor: Color(0xFF8B5CF6),
      ),
    );
  }
}
