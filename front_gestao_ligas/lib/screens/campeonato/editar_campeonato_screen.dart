import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/utils/validators.dart';
import '../../core/utils/dialog_helper.dart';
import '../../state/campeonato_provider.dart';

/// Tela de edição de campeonato (RF 03)
class EditarCampeonatoScreen extends StatefulWidget {
  final int campeonatoId;

  const EditarCampeonatoScreen({super.key, required this.campeonatoId});

  @override
  State<EditarCampeonatoScreen> createState() => _EditarCampeonatoScreenState();
}

class _EditarCampeonatoScreenState extends State<EditarCampeonatoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final camp = context.read<CampeonatoProvider>().campeonatoAtual;
      if (camp != null) {
        _nomeController.text = camp.nome;
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CampeonatoProvider>();
    final success = await provider.editar(widget.campeonatoId, {
      'nome': _nomeController.text.trim(),
    });

    if (mounted) {
      if (success) {
        DialogHelper.showSuccess(context, 'Campeonato atualizado!');
        context.pop();
      } else if (provider.error != null) {
        DialogHelper.showError(context, provider.error!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampeonatoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Campeonato')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                validator: Validators.nome,
                decoration: const InputDecoration(
                  labelText: 'Nome do Campeonato',
                  prefixIcon: Icon(Icons.emoji_events_outlined),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: provider.isLoading ? null : _salvar,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Alterações'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
