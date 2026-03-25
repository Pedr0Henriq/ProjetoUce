import 'package:drift/drift.dart';

class Usuarios extends Table {
  IntColumn get id => integer()();
  TextColumn get nome => text()();
  TextColumn get email => text()();
  TextColumn get perfil => text()();
  DateTimeColumn get criadoEm => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Campeonatos extends Table {
  IntColumn get id => integer()();
  TextColumn get nome => text()();
  TextColumn get modalidade => text()();
  TextColumn get tipo => text()();
  IntColumn get numEquipes => integer()();
  DateTimeColumn get dataInicio => dateTime()();
  TextColumn get status => text()();
  IntColumn get criadoPor =>
      integer().references(Usuarios, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Times extends Table {
  IntColumn get id => integer()();
  TextColumn get nome => text()();
  TextColumn get localidade => text()();
  TextColumn get escudoUrl => text().nullable()();
  IntColumn get campeonatoId =>
      integer().references(Campeonatos, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Jogadores extends Table {
  IntColumn get id => integer()();
  TextColumn get nome => text()();
  IntColumn get numero => integer().nullable()();
  TextColumn get posicao => text()();
  IntColumn get timeId =>
      integer().references(Times, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Partidas extends Table {
  IntColumn get id => integer()();
  IntColumn get campeonatoId =>
      integer().references(Campeonatos, #id, onDelete: KeyAction.cascade)();
  IntColumn get rodada => integer()();
  IntColumn get timeMandanteId =>
      integer().references(Times, #id, onDelete: KeyAction.cascade)();
  IntColumn get timeVisitanteId =>
      integer().references(Times, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get data => dateTime().nullable()();
  TextColumn get horario => text().nullable()();
  TextColumn get local => text().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Classificacoes extends Table {
  IntColumn get id => integer()();
  IntColumn get campeonatoId =>
      integer().references(Campeonatos, #id, onDelete: KeyAction.cascade)();
  IntColumn get timeId =>
      integer().references(Times, #id, onDelete: KeyAction.cascade)();
  IntColumn get pontos => integer()();
  IntColumn get jogos => integer()();
  IntColumn get vitorias => integer()();
  IntColumn get empates => integer()();
  IntColumn get derrotas => integer()();
  IntColumn get golsPro => integer()();
  IntColumn get golsContra => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class EventosPartidas extends Table {
  IntColumn get id => integer()();
  IntColumn get partidaId =>
      integer().references(Partidas, #id, onDelete: KeyAction.cascade)();
  TextColumn get tipo => text()();
  IntColumn get minuto => integer().nullable()();
  IntColumn get jogadorId =>
      integer().references(Jogadores, #id, onDelete: KeyAction.cascade)();
  IntColumn get timeId =>
      integer().references(Times, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Resultados extends Table {
  IntColumn get id => integer()();
  IntColumn get partidaId =>
      integer().references(Partidas, #id, onDelete: KeyAction.cascade)();
  IntColumn get golsMandante => integer()();
  IntColumn get golsVisitante => integer()();
  IntColumn get registradoPor =>
      integer().references(Usuarios, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get registradoEm => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
