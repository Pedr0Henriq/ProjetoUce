import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/utils/date_formatters.dart';
import '../../core/utils/dialog_helper.dart';
import '../../state/auth_provider.dart';
import '../../state/campeonato_provider.dart';
import '../../models/campeonato.dart';
import '../widgets/state_widgets.dart';
import '../widgets/status_chip.dart';

/// Tela Principal – Lista de Campeonatos (Seção 4.2 - RF 03, RF 12, RF 15)
class CampeonatosScreen extends StatefulWidget {
  const CampeonatosScreen({super.key});

  @override
  State<CampeonatosScreen> createState() => _CampeonatosScreenState();
}

class _CampeonatosScreenState extends State<CampeonatosScreen> {
  final _buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carregar campeonatos ao entrar na tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CampeonatoProvider>().listar();
    });
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final campProvider = context.watch<CampeonatoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Ligas'),
        actions: [
          // Botão de perfil (RF 12)
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Meu Perfil',
            onPressed: () => context.push('/perfil'),
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Sair',
              onPressed: () async {
                final confirm = await DialogHelper.showConfirmation(
                  context,
                  title: 'Sair',
                  message: 'Deseja encerrar sua sessão?',
                  confirmText: 'Sair',
                );
                if (confirm && context.mounted) {
                  await auth.logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Saudação
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.05),
            child: Text(
              'Olá, ${auth.usuario?.nome ?? 'Usuário'}! 👋',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),

          // Campo de busca (RF 15)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _buscaController,
              onChanged: (value) {
                campProvider.listar(busca: value);
              },
              decoration: InputDecoration(
                hintText: 'Buscar campeonato...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _buscaController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _buscaController.clear();
                          campProvider.listar();
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Lista de campeonatos
          Expanded(child: _buildContent(campProvider)),
        ],
      ),

      // FAB visível apenas para Administradores (RF 02, RF 03)
      floatingActionButton: auth.isAdmin
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/campeonatos/criar'),
              icon: const Icon(Icons.add),
              label: const Text('Novo Campeonato'),
            )
          : null,
    );
  }

  Widget _buildContent(CampeonatoProvider provider) {
    if (provider.isLoading) {
      return const LoadingState(message: 'Carregando campeonatos...');
    }

    if (provider.error != null) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.listar(),
      );
    }

    if (provider.campeonatos.isEmpty) {
      final isAdmin = context.read<AuthProvider>().isAdmin;
      final isBusca = provider.busca.isNotEmpty;
      return EmptyState(
        icon: Icons.emoji_events_outlined,
        title: 'Nenhum campeonato encontrado',
        subtitle: isBusca
            ? 'Tente buscar com outros termos'
            : isAdmin
                ? 'Crie o primeiro campeonato para começar!'
                : 'Aguarde o administrador criar um campeonato.',
        // Botão de ação para admins quando não há busca ativa
        action: isAdmin && !isBusca
            ? ElevatedButton.icon(
                onPressed: () => context.push('/campeonatos/criar'),
                icon: const Icon(Icons.add),
                label: const Text('Criar Campeonato'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : null,
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.listar(busca: provider.busca),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: provider.campeonatos.length,
        itemBuilder: (context, index) {
          final camp = provider.campeonatos[index];
          return _CampeonatoCard(campeonato: camp);
        },
      ),
    );
  }
}

class _CampeonatoCard extends StatelessWidget {
  final Campeonato campeonato;

  const _CampeonatoCard({required this.campeonato});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/campeonato/${campeonato.id}'),
        onLongPress: () async {
          final isAdmin = context.read<AuthProvider>().isAdmin;
          if (!isAdmin) {
            DialogHelper.showError(
              context,
              'Apenas administradores podem excluir campeonatos.',
            );
            return;
          }

          final confirm = await DialogHelper.showConfirmation(
                  context,
                  title: 'Remover',
                  message: 'Deseja apagar esse campeonato?',
                  confirmText: 'Apagar',
          );
          if(confirm &&  context.mounted){
            context.read<CampeonatoProvider>().excluir(campeonato.id);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Ícone do campeonato
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campeonato.nome,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${campeonato.tipoFormatado} • ${campeonato.numEquipes} equipes',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Início: ${DateFormatters.data(campeonato.dataInicio)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // Status
              StatusChip(
                status: StatusCampeonato.values.firstWhere(
                  (value) => value.name == campeonato.status,
                ),
              ),

              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
