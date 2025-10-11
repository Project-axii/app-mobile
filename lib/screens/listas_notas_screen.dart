import 'package:flutter/material.dart';

class ListasNotasScreen extends StatefulWidget {
  const ListasNotasScreen({super.key});

  @override
  State<ListasNotasScreen> createState() => _ListasNotasScreenState();
}

class _ListasNotasScreenState extends State<ListasNotasScreen> {
  final List<Map<String, dynamic>> _listas = [
    {
      'titulo': 'Materiais para Aula',
      'itens': ['Projetor', 'Cabos HDMI', 'Apostilas', 'Marcadores'],
      'cor': Colors.blue,
      'concluidos': 2,
    },
    {
      'titulo': 'Tarefas da Semana',
      'itens': [
        'Corrigir provas',
        'Preparar slides',
        'Reunião com coordenação'
      ],
      'cor': Colors.purple,
      'concluidos': 1,
    },
    {
      'titulo': 'Equipamentos com Problema',
      'itens': ['Computador 3', 'Mouse sala 201'],
      'cor': Colors.orange,
      'concluidos': 0,
    },
  ];

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
          'Listas e Notas',
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
              _mostrarDialogoNovaLista();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Organize suas tarefas e materiais',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          ..._listas.map((lista) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildListaCard(lista),
              )),
        ],
      ),
    );
  }

  Widget _buildListaCard(Map<String, dynamic> lista) {
    final totalItens = (lista['itens'] as List).length;
    final concluidos = lista['concluidos'] as int;
    final progresso = totalItens > 0 ? concluidos / totalItens : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _mostrarDetalhesLista(lista);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: lista['cor'] as Color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lista['titulo'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$concluidos de $totalItens concluídos',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progresso,
                    backgroundColor: const Color(0xFF2A2A2A),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(lista['cor'] as Color),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (lista['itens'] as List).take(3).map((item) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDetalhesLista(Map<String, dynamic> lista) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 30,
                    decoration: BoxDecoration(
                      color: lista['cor'] as Color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      lista['titulo'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: (lista['itens'] as List).length,
                  itemBuilder: (context, index) {
                    final item = (lista['itens'] as List)[index];
                    final isConcluido = index < lista['concluidos'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isConcluido,
                            onChanged: (value) {},
                            activeColor: lista['cor'] as Color,
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: isConcluido ? Colors.grey : Colors.white,
                                fontSize: 16,
                                decoration: isConcluido
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoNovaLista() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'Nova Lista',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Nome da lista',
            hintStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8B5CF6)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _listas.add({
                    'titulo': controller.text,
                    'itens': [],
                    'cor': Colors.blue,
                    'concluidos': 0,
                  });
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
            ),
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }
}
