// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_dao.dart';

// ignore_for_file: type=lint
mixin _$TimeDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsuariosTable get usuarios => attachedDatabase.usuarios;
  $CampeonatosTable get campeonatos => attachedDatabase.campeonatos;
  $TimesTable get times => attachedDatabase.times;
  $JogadoresTable get jogadores => attachedDatabase.jogadores;
  TimeDaoManager get managers => TimeDaoManager(this);
}

class TimeDaoManager {
  final _$TimeDaoMixin _db;
  TimeDaoManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db.attachedDatabase, _db.usuarios);
  $$CampeonatosTableTableManager get campeonatos =>
      $$CampeonatosTableTableManager(_db.attachedDatabase, _db.campeonatos);
  $$TimesTableTableManager get times =>
      $$TimesTableTableManager(_db.attachedDatabase, _db.times);
  $$JogadoresTableTableManager get jogadores =>
      $$JogadoresTableTableManager(_db.attachedDatabase, _db.jogadores);
}
