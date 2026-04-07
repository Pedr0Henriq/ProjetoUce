import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../state/time_provider.dart';

/// Tela de criação de time (RF 05)
class CriarTimeScreen extends StatefulWidget {
  final int campeonatoId;

  const CriarTimeScreen({super.key, required this.campeonatoId});

  @override
  State<CriarTimeScreen> createState() => _CriarTimeScreenState();
}

class _CriarTimeScreenState extends State<CriarTimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _localidadeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _localidadeController.dispose();
    super.dispose();
  }

  Future<void> _criar() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<TimeProvider>();
    final success = await provider.criar(widget.campeonatoId, {
      'nome': _nomeController.text.trim(),
      'localidade': _localidadeController.text.trim(),
      'campeonato_id': widget.campeonatoId,
    });

    if (mounted) {
      if (success) {
        DialogHelper.showSuccess(context, 'Time cadastrado com sucesso!');
        context.pop();
      } else if (provider.error != null) {
        DialogHelper.showError(context, provider.error!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Time')),
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
                  labelText: 'Nome do Time',
                  prefixIcon: Icon(Icons.shield_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _localidadeController,
                validator: (v) => Validators.obrigatorio(v, 'Localidade'),
                decoration: const InputDecoration(
                  labelText: 'Localidade',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  hintText: 'Ex: João Pessoa - PB',
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: provider.isLoading ? null : _criar,
                  icon: const Icon(Icons.check),
                  label: const Text('Cadastrar Time'),
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
