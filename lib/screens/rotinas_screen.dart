import 'package:flutter/material.dart';

class RotinasScreen extends StatefulWidget {
  const RotinasScreen({super.key});

  @override
  State<RotinasScreen> createState() => _RotinasScreenState();
}

class _RotinasScreenState extends State<RotinasScreen> {
  final List<Map<String, dynamic>> _rotinas = [
    {
      'nome': 'Iniciar Aula',
      'descricao': 'Liga todos os equipamentos e prepara a sala',
      'ativa': true,
      'acoes': 5,
      'icon': Icons.school,
    },
    {
      'nome': 'Encerrar Aula',
      'descricao': 'Desliga equipamentos e salva trabalhos',
      'ativa': true,
      'acoes': 4,
      'icon': Icons.logout,
    },
    {
      'nome': 'Modo Apresentação',
      'descricao': 'Otimiza iluminação e projetor',
      'ativa': false,
      'acoes': 3,
      'icon': Icons.present_to_all,
    },
    {
      'nome': 'Intervalo',
      'descricao': 'Bloqueia computadores e reduz iluminação',
      'ativa': true,
      'acoes': 3,
      'icon': Icons.coffee,
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
          'Rotinas',
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
              // Adicionar nova rotina
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Automatize tarefas repetitivas e economize tempo',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          ..._rotinas.map((rotina) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildRotinaCard(rotina),
              )),
        ],
      ),
    );
  }

  Widget _buildRotinaCard(Map<String, dynamic> rotina) {
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
            _mostrarDetalhesRotina(rotina);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    rotina['icon'],
                    color: const Color(0xFF8B5CF6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rotina['nome'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rotina['descricao'],
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.flash_on,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${rotina['acoes']} ações',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Switch(
                      value: rotina['ativa'],
                      onChanged: (value) {
                        setState(() {
                          rotina['ativa'] = value;
                        });
                      },
                      activeColor: const Color(0xFF8B5CF6),
                    ),
                    TextButton(
                      onPressed: () {
                        _executarRotina(rotina);
                      },
                      child: const Text(
                        'Executar',
                        style: TextStyle(
                          color: Color(0xFF8B5CF6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDetalhesRotina(Map<String, dynamic> rotina) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(rotina['icon'], color: const Color(0xFF8B5CF6), size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    rotina['nome'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              rotina['descricao'],
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ações:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildAcaoItem('Ligar todos os computadores'),
            _buildAcaoItem('Ligar projetor'),
            _buildAcaoItem('Ajustar iluminação para 70%'),
            if (rotina['acoes'] > 3) ...[
              _buildAcaoItem('Ligar ar condicionado'),
              if (rotina['acoes'] > 4) _buildAcaoItem('Abrir software padrão'),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _executarRotina(rotina);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Executar Agora'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcaoItem(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF8B5CF6), size: 18),
          const SizedBox(width: 12),
          Text(
            texto,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _executarRotina(Map<String, dynamic> rotina) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Executando rotina: ${rotina['nome']}'),
        backgroundColor: const Color(0xFF8B5CF6),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
