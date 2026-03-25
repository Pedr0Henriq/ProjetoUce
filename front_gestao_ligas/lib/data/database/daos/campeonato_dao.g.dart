// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campeonato_dao.dart';

// ignore_for_file: type=lint
mixin _$CampeonatoDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsuariosTable get usuarios => attachedDatabase.usuarios;
  $CampeonatosTable get campeonatos => attachedDatabase.campeonatos;
  $TimesTable get times => attachedDatabase.times;
  $ClassificacoesTable get classificacoes => attachedDatabase.classificacoes;
  CampeonatoDaoManager get managers => CampeonatoDaoManager(this);
}

class CampeonatoDaoManager {
  final _$CampeonatoDaoMixin _db;
  CampeonatoDaoManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db.attachedDatabase, _db.usuarios);
  $$CampeonatosTableTableManager get campeonatos =>
      $$CampeonatosTableTableManager(_db.attachedDatabase, _db.campeonatos);
  $$TimesTableTableManager get times =>
      $$TimesTableTableManager(_db.attachedDatabase, _db.times);
  $$ClassificacoesTableTableManager get classificacoes =>
      $$ClassificacoesTableTableManager(
        _db.attachedDatabase,
        _db.classificacoes,
      );
}
