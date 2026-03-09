import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/utils/validators.dart';
import '../../core/utils/dialog_helper.dart';
import '../../state/campeonato_provider.dart';
import '../../models/campeonato.dart';

/// Tela de criação de campeonato (RF 03)
class CriarCampeonatoScreen extends StatefulWidget {
  const CriarCampeonatoScreen({super.key});

  @override
  State<CriarCampeonatoScreen> createState() => _CriarCampeonatoScreenState();
}

class _CriarCampeonatoScreenState extends State<CriarCampeonatoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _numEquipesController = TextEditingController();
  String _modalidade = 'Futebol de Campo';
  TipoCampeonato _tipo = TipoCampeonato.pontoCorrido;
  DateTime _dataInicio = DateTime.now();

  @override
  void dispose() {
    _nomeController.dispose();
    _numEquipesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataInicio,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _dataInicio = picked);
    }
  }

  Future<void> _criar() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CampeonatoProvider>();
    final success = await provider.criar({
      'nome': _nomeController.text.trim(),
      'modalidade': _modalidade,
      'tipo': _tipo == TipoCampeonato.pontoCorrido
          ? 'ponto_corrido'
          : 'eliminatoria',
      'num_equipes': int.parse(_numEquipesController.text.trim()),
      'data_inicio': _dataInicio.toIso8601String(),
    });

    if (mounted) {
      if (success) {
        DialogHelper.showSuccess(context, 'Campeonato criado com sucesso!');
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
      appBar: AppBar(
        title: const Text('Novo Campeonato'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nome
              TextFormField(
                controller: _nomeController,
                validator: Validators.nome,
                decoration: const InputDecoration(
                  labelText: 'Nome do Campeonato',
                  prefixIcon: Icon(Icons.emoji_events_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Modalidade
              DropdownButtonFormField<String>(
                initialValue: _modalidade,
                decoration: const InputDecoration(
                  labelText: 'Modalidade',
                  prefixIcon: Icon(Icons.sports_soccer),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Futebol de Campo',
                    child: Text('Futebol de Campo'),
                  ),
                  DropdownMenuItem(
                    value: 'Futsal',
                    child: Text('Futsal'),
                  ),
                ],
                onChanged: (v) => setState(() => _modalidade = v!),
              ),
              const SizedBox(height: 16),

              // Tipo de competição
              DropdownButtonFormField<TipoCampeonato>(
                initialValue: _tipo,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Competição',
                  prefixIcon: Icon(Icons.format_list_numbered),
                ),
                items: const [
                  DropdownMenuItem(
                    value: TipoCampeonato.pontoCorrido,
                    child: Text('Pontos Corridos'),
                  ),
                  DropdownMenuItem(
                    value: TipoCampeonato.eliminatoria,
                    child: Text('Eliminatória'),
                  ),
                ],
                onChanged: (v) => setState(() => _tipo = v!),
              ),
              const SizedBox(height: 16),

              // Número de equipes
              TextFormField(
                controller: _numEquipesController,
                keyboardType: TextInputType.number,
                validator: (v) => Validators.numeroPositivo(v, 'Nº de equipes'),
                decoration: const InputDecoration(
                  labelText: 'Número de Equipes',
                  prefixIcon: Icon(Icons.groups),
                  hintText: 'Ex: 8, 16, 32',
                ),
              ),
              const SizedBox(height: 16),

              // Data de início
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data de Início',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    '${_dataInicio.day.toString().padLeft(2, '0')}/'
                    '${_dataInicio.month.toString().padLeft(2, '0')}/'
                    '${_dataInicio.year}',
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Botão criar
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: provider.isLoading ? null : _criar,
                  icon: provider.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label: const Text('Criar Campeonato'),
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
