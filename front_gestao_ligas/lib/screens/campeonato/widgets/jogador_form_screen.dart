import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../state/jogador_provider.dart';

/// Tela de cadastro de jogador (RF 06)
class JogadorFormScreen extends StatefulWidget {
  final int timeId;

  const JogadorFormScreen({super.key, required this.timeId});

  @override
  State<JogadorFormScreen> createState() => _JogadorFormScreenState();
}

class _JogadorFormScreenState extends State<JogadorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _numeroController = TextEditingController();
  String _posicao = 'Atacante';

  @override
  void dispose() {
    _nomeController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  Future<void> _criar() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<JogadorProvider>();
    final success = await provider.criar(widget.timeId, {
      'nome': _nomeController.text.trim(),
      'numero': _numeroController.text.trim().isNotEmpty
          ? int.tryParse(_numeroController.text.trim())
          : null,
      'posicao': _posicao,
      'time_id': widget.timeId,
    });

    if (mounted) {
      if (success) {
        DialogHelper.showSuccess(context, 'Jogador cadastrado com sucesso!');
        context.pop();
      } else if (provider.error != null) {
        DialogHelper.showError(context, provider.error!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JogadorProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Jogador')),
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
                  labelText: 'Nome Completo',
                  prefixIcon: Icon(Icons.person_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numeroController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número da Camisa (opcional)',
                  prefixIcon: Icon(Icons.tag),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _posicao,
                decoration: const InputDecoration(
                  labelText: 'Posição',
                  prefixIcon: Icon(Icons.sports_soccer),
                ),
                items: const [
                  DropdownMenuItem(value: 'Goleiro', child: Text('Goleiro')),
                  DropdownMenuItem(value: 'Zagueiro', child: Text('Zagueiro')),
                  DropdownMenuItem(value: 'Lateral', child: Text('Lateral')),
                  DropdownMenuItem(value: 'Volante', child: Text('Volante')),
                  DropdownMenuItem(value: 'Meia', child: Text('Meia')),
                  DropdownMenuItem(value: 'Atacante', child: Text('Atacante')),
                ],
                onChanged: (v) => setState(() => _posicao = v!),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: provider.isLoading ? null : _criar,
                  icon: const Icon(Icons.check),
                  label: const Text('Cadastrar Jogador'),
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
