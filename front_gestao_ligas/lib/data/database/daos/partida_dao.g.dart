// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partida_dao.dart';

// ignore_for_file: type=lint
mixin _$PartidaDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsuariosTable get usuarios => attachedDatabase.usuarios;
  $CampeonatosTable get campeonatos => attachedDatabase.campeonatos;
  $TimesTable get times => attachedDatabase.times;
  $PartidasTable get partidas => attachedDatabase.partidas;
  $ResultadosTable get resultados => attachedDatabase.resultados;
  $JogadoresTable get jogadores => attachedDatabase.jogadores;
  $EventosPartidasTable get eventosPartidas => attachedDatabase.eventosPartidas;
  PartidaDaoManager get managers => PartidaDaoManager(this);
}

class PartidaDaoManager {
  final _$PartidaDaoMixin _db;
  PartidaDaoManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db.attachedDatabase, _db.usuarios);
  $$CampeonatosTableTableManager get campeonatos =>
      $$CampeonatosTableTableManager(_db.attachedDatabase, _db.campeonatos);
  $$TimesTableTableManager get times =>
      $$TimesTableTableManager(_db.attachedDatabase, _db.times);
  $$PartidasTableTableManager get partidas =>
      $$PartidasTableTableManager(_db.attachedDatabase, _db.partidas);
  $$ResultadosTableTableManager get resultados =>
      $$ResultadosTableTableManager(_db.attachedDatabase, _db.resultados);
  $$JogadoresTableTableManager get jogadores =>
      $$JogadoresTableTableManager(_db.attachedDatabase, _db.jogadores);
  $$EventosPartidasTableTableManager get eventosPartidas =>
      $$EventosPartidasTableTableManager(
        _db.attachedDatabase,
        _db.eventosPartidas,
      );
}
