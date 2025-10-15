import 'package:flutter/material.dart';

class ConfigInformacoesScreen extends StatelessWidget {
  const ConfigInformacoesScreen({super.key});

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
                    'Informações',
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
                  // Logo/Icon
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // App Info
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Sistema de Gerenciamento',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Versão 1.0.0',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade400,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Info Items
                  _buildInfoCard(
                    context,
                    icon: Icons.info_outline,
                    title: 'Sobre o aplicativo',
                    subtitle:
                        'Sistema centralizado para gerenciamento de sala de aula',
                  ),

                  _buildInfoCard(
                    context,
                    icon: Icons.description_outlined,
                    title: 'Termos de uso',
                    subtitle: 'Leia os termos e condições',
                    onTap: () {},
                  ),

                  _buildInfoCard(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Política de privacidade',
                    subtitle: 'Como tratamos seus dados',
                    onTap: () {},
                  ),

                  _buildInfoCard(
                    context,
                    icon: Icons.help_outline,
                    title: 'Ajuda e suporte',
                    subtitle: 'Precisa de ajuda? Entre em contato',
                    onTap: () {},
                  ),

                  _buildInfoCard(
                    context,
                    icon: Icons.update,
                    title: 'Verificar atualizações',
                    subtitle: 'Você está usando a versão mais recente',
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // Footer
                  Center(
                    child: Text(
                      '© 2025 Sistema de Gerenciamento\nTodos os direitos reservados',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
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

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade600,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
