// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _perfilMeta = const VerificationMeta('perfil');
  @override
  late final GeneratedColumn<String> perfil = GeneratedColumn<String>(
    'perfil',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _criadoEmMeta = const VerificationMeta(
    'criadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
    'criado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nome, email, perfil, criadoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('perfil')) {
      context.handle(
        _perfilMeta,
        perfil.isAcceptableOrUnknown(data['perfil']!, _perfilMeta),
      );
    } else if (isInserting) {
      context.missing(_perfilMeta);
    }
    if (data.containsKey('criado_em')) {
      context.handle(
        _criadoEmMeta,
        criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta),
      );
    } else if (isInserting) {
      context.missing(_criadoEmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      perfil: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}perfil'],
      )!,
      criadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}criado_em'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nome;
  final String email;
  final String perfil;
  final DateTime criadoEm;
  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.perfil,
    required this.criadoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['email'] = Variable<String>(email);
    map['perfil'] = Variable<String>(perfil);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nome: Value(nome),
      email: Value(email),
      perfil: Value(perfil),
      criadoEm: Value(criadoEm),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      email: serializer.fromJson<String>(json['email']),
      perfil: serializer.fromJson<String>(json['perfil']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'email': serializer.toJson<String>(email),
      'perfil': serializer.toJson<String>(perfil),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
    };
  }

  Usuario copyWith({
    int? id,
    String? nome,
    String? email,
    String? perfil,
    DateTime? criadoEm,
  }) => Usuario(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    email: email ?? this.email,
    perfil: perfil ?? this.perfil,
    criadoEm: criadoEm ?? this.criadoEm,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      email: data.email.present ? data.email.value : this.email,
      perfil: data.perfil.present ? data.perfil.value : this.perfil,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('perfil: $perfil, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, email, perfil, criadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.perfil == this.perfil &&
          other.criadoEm == this.criadoEm);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> email;
  final Value<String> perfil;
  final Value<DateTime> criadoEm;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.perfil = const Value.absent(),
    this.criadoEm = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String email,
    required String perfil,
    required DateTime criadoEm,
  }) : nome = Value(nome),
       email = Value(email),
       perfil = Value(perfil),
       criadoEm = Value(criadoEm);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? email,
    Expression<String>? perfil,
    Expression<DateTime>? criadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (perfil != null) 'perfil': perfil,
      if (criadoEm != null) 'criado_em': criadoEm,
    });
  }

  UsuariosCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? email,
    Value<String>? perfil,
    Value<DateTime>? criadoEm,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      perfil: perfil ?? this.perfil,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (perfil.present) {
      map['perfil'] = Variable<String>(perfil.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('perfil: $perfil, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }
}

class $CampeonatosTable extends Campeonatos
    with TableInfo<$CampeonatosTable, Campeonato> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampeonatosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modalidadeMeta = const VerificationMeta(
    'modalidade',
  );
  @override
  late final GeneratedColumn<String> modalidade = GeneratedColumn<String>(
    'modalidade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numEquipesMeta = const VerificationMeta(
    'numEquipes',
  );
  @override
  late final GeneratedColumn<int> numEquipes = GeneratedColumn<int>(
    'num_equipes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataInicioMeta = const VerificationMeta(
    'dataInicio',
  );
  @override
  late final GeneratedColumn<DateTime> dataInicio = GeneratedColumn<DateTime>(
    'data_inicio',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _criadoPorMeta = const VerificationMeta(
    'criadoPor',
  );
  @override
  late final GeneratedColumn<int> criadoPor = GeneratedColumn<int>(
    'criado_por',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    modalidade,
    tipo,
    numEquipes,
    dataInicio,
    status,
    criadoPor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campeonatos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Campeonato> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('modalidade')) {
      context.handle(
        _modalidadeMeta,
        modalidade.isAcceptableOrUnknown(data['modalidade']!, _modalidadeMeta),
      );
    } else if (isInserting) {
      context.missing(_modalidadeMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('num_equipes')) {
      context.handle(
        _numEquipesMeta,
        numEquipes.isAcceptableOrUnknown(data['num_equipes']!, _numEquipesMeta),
      );
    } else if (isInserting) {
      context.missing(_numEquipesMeta);
    }
    if (data.containsKey('data_inicio')) {
      context.handle(
        _dataInicioMeta,
        dataInicio.isAcceptableOrUnknown(data['data_inicio']!, _dataInicioMeta),
      );
    } else if (isInserting) {
      context.missing(_dataInicioMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('criado_por')) {
      context.handle(
        _criadoPorMeta,
        criadoPor.isAcceptableOrUnknown(data['criado_por']!, _criadoPorMeta),
      );
    } else if (isInserting) {
      context.missing(_criadoPorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Campeonato map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Campeonato(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      modalidade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modalidade'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      numEquipes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}num_equipes'],
      )!,
      dataInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_inicio'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      criadoPor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}criado_por'],
      )!,
    );
  }

  @override
  $CampeonatosTable createAlias(String alias) {
    return $CampeonatosTable(attachedDatabase, alias);
  }
}

class Campeonato extends DataClass implements Insertable<Campeonato> {
  final int id;
  final String nome;
  final String modalidade;
  final String tipo;
  final int numEquipes;
  final DateTime dataInicio;
  final String status;
  final int criadoPor;
  const Campeonato({
    required this.id,
    required this.nome,
    required this.modalidade,
    required this.tipo,
    required this.numEquipes,
    required this.dataInicio,
    required this.status,
    required this.criadoPor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['modalidade'] = Variable<String>(modalidade);
    map['tipo'] = Variable<String>(tipo);
    map['num_equipes'] = Variable<int>(numEquipes);
    map['data_inicio'] = Variable<DateTime>(dataInicio);
    map['status'] = Variable<String>(status);
    map['criado_por'] = Variable<int>(criadoPor);
    return map;
  }

  CampeonatosCompanion toCompanion(bool nullToAbsent) {
    return CampeonatosCompanion(
      id: Value(id),
      nome: Value(nome),
      modalidade: Value(modalidade),
      tipo: Value(tipo),
      numEquipes: Value(numEquipes),
      dataInicio: Value(dataInicio),
      status: Value(status),
      criadoPor: Value(criadoPor),
    );
  }

  factory Campeonato.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Campeonato(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      modalidade: serializer.fromJson<String>(json['modalidade']),
      tipo: serializer.fromJson<String>(json['tipo']),
      numEquipes: serializer.fromJson<int>(json['numEquipes']),
      dataInicio: serializer.fromJson<DateTime>(json['dataInicio']),
      status: serializer.fromJson<String>(json['status']),
      criadoPor: serializer.fromJson<int>(json['criadoPor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'modalidade': serializer.toJson<String>(modalidade),
      'tipo': serializer.toJson<String>(tipo),
      'numEquipes': serializer.toJson<int>(numEquipes),
      'dataInicio': serializer.toJson<DateTime>(dataInicio),
      'status': serializer.toJson<String>(status),
      'criadoPor': serializer.toJson<int>(criadoPor),
    };
  }

  Campeonato copyWith({
    int? id,
    String? nome,
    String? modalidade,
    String? tipo,
    int? numEquipes,
    DateTime? dataInicio,
    String? status,
    int? criadoPor,
  }) => Campeonato(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    modalidade: modalidade ?? this.modalidade,
    tipo: tipo ?? this.tipo,
    numEquipes: numEquipes ?? this.numEquipes,
    dataInicio: dataInicio ?? this.dataInicio,
    status: status ?? this.status,
    criadoPor: criadoPor ?? this.criadoPor,
  );
  Campeonato copyWithCompanion(CampeonatosCompanion data) {
    return Campeonato(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      modalidade: data.modalidade.present
          ? data.modalidade.value
          : this.modalidade,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      numEquipes: data.numEquipes.present
          ? data.numEquipes.value
          : this.numEquipes,
      dataInicio: data.dataInicio.present
          ? data.dataInicio.value
          : this.dataInicio,
      status: data.status.present ? data.status.value : this.status,
      criadoPor: data.criadoPor.present ? data.criadoPor.value : this.criadoPor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Campeonato(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('modalidade: $modalidade, ')
          ..write('tipo: $tipo, ')
          ..write('numEquipes: $numEquipes, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('status: $status, ')
          ..write('criadoPor: $criadoPor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nome,
    modalidade,
    tipo,
    numEquipes,
    dataInicio,
    status,
    criadoPor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Campeonato &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.modalidade == this.modalidade &&
          other.tipo == this.tipo &&
          other.numEquipes == this.numEquipes &&
          other.dataInicio == this.dataInicio &&
          other.status == this.status &&
          other.criadoPor == this.criadoPor);
}

class CampeonatosCompanion extends UpdateCompanion<Campeonato> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> modalidade;
  final Value<String> tipo;
  final Value<int> numEquipes;
  final Value<DateTime> dataInicio;
  final Value<String> status;
  final Value<int> criadoPor;
  const CampeonatosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.modalidade = const Value.absent(),
    this.tipo = const Value.absent(),
    this.numEquipes = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.status = const Value.absent(),
    this.criadoPor = const Value.absent(),
  });
  CampeonatosCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String modalidade,
    required String tipo,
    required int numEquipes,
    required DateTime dataInicio,
    required String status,
    required int criadoPor,
  }) : nome = Value(nome),
       modalidade = Value(modalidade),
       tipo = Value(tipo),
       numEquipes = Value(numEquipes),
       dataInicio = Value(dataInicio),
       status = Value(status),
       criadoPor = Value(criadoPor);
  static Insertable<Campeonato> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? modalidade,
    Expression<String>? tipo,
    Expression<int>? numEquipes,
    Expression<DateTime>? dataInicio,
    Expression<String>? status,
    Expression<int>? criadoPor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (modalidade != null) 'modalidade': modalidade,
      if (tipo != null) 'tipo': tipo,
      if (numEquipes != null) 'num_equipes': numEquipes,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (status != null) 'status': status,
      if (criadoPor != null) 'criado_por': criadoPor,
    });
  }

  CampeonatosCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? modalidade,
    Value<String>? tipo,
    Value<int>? numEquipes,
    Value<DateTime>? dataInicio,
    Value<String>? status,
    Value<int>? criadoPor,
  }) {
    return CampeonatosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      modalidade: modalidade ?? this.modalidade,
      tipo: tipo ?? this.tipo,
      numEquipes: numEquipes ?? this.numEquipes,
      dataInicio: dataInicio ?? this.dataInicio,
      status: status ?? this.status,
      criadoPor: criadoPor ?? this.criadoPor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (modalidade.present) {
      map['modalidade'] = Variable<String>(modalidade.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (numEquipes.present) {
      map['num_equipes'] = Variable<int>(numEquipes.value);
    }
    if (dataInicio.present) {
      map['data_inicio'] = Variable<DateTime>(dataInicio.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (criadoPor.present) {
      map['criado_por'] = Variable<int>(criadoPor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampeonatosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('modalidade: $modalidade, ')
          ..write('tipo: $tipo, ')
          ..write('numEquipes: $numEquipes, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('status: $status, ')
          ..write('criadoPor: $criadoPor')
          ..write(')'))
        .toString();
  }
}

class $TimesTable extends Times with TableInfo<$TimesTable, Time> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localidadeMeta = const VerificationMeta(
    'localidade',
  );
  @override
  late final GeneratedColumn<String> localidade = GeneratedColumn<String>(
    'localidade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _escudoUrlMeta = const VerificationMeta(
    'escudoUrl',
  );
  @override
  late final GeneratedColumn<String> escudoUrl = GeneratedColumn<String>(
    'escudo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _campeonatoIdMeta = const VerificationMeta(
    'campeonatoId',
  );
  @override
  late final GeneratedColumn<int> campeonatoId = GeneratedColumn<int>(
    'campeonato_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES campeonatos (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    localidade,
    escudoUrl,
    campeonatoId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'times';
  @override
  VerificationContext validateIntegrity(
    Insertable<Time> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('localidade')) {
      context.handle(
        _localidadeMeta,
        localidade.isAcceptableOrUnknown(data['localidade']!, _localidadeMeta),
      );
    } else if (isInserting) {
      context.missing(_localidadeMeta);
    }
    if (data.containsKey('escudo_url')) {
      context.handle(
        _escudoUrlMeta,
        escudoUrl.isAcceptableOrUnknown(data['escudo_url']!, _escudoUrlMeta),
      );
    }
    if (data.containsKey('campeonato_id')) {
      context.handle(
        _campeonatoIdMeta,
        campeonatoId.isAcceptableOrUnknown(
          data['campeonato_id']!,
          _campeonatoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_campeonatoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Time map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Time(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      localidade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}localidade'],
      )!,
      escudoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}escudo_url'],
      ),
      campeonatoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}campeonato_id'],
      )!,
    );
  }

  @override
  $TimesTable createAlias(String alias) {
    return $TimesTable(attachedDatabase, alias);
  }
}

class Time extends DataClass implements Insertable<Time> {
  final int id;
  final String nome;
  final String localidade;
  final String? escudoUrl;
  final int campeonatoId;
  const Time({
    required this.id,
    required this.nome,
    required this.localidade,
    this.escudoUrl,
    required this.campeonatoId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['localidade'] = Variable<String>(localidade);
    if (!nullToAbsent || escudoUrl != null) {
      map['escudo_url'] = Variable<String>(escudoUrl);
    }
    map['campeonato_id'] = Variable<int>(campeonatoId);
    return map;
  }

  TimesCompanion toCompanion(bool nullToAbsent) {
    return TimesCompanion(
      id: Value(id),
      nome: Value(nome),
      localidade: Value(localidade),
      escudoUrl: escudoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(escudoUrl),
      campeonatoId: Value(campeonatoId),
    );
  }

  factory Time.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Time(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      localidade: serializer.fromJson<String>(json['localidade']),
      escudoUrl: serializer.fromJson<String?>(json['escudoUrl']),
      campeonatoId: serializer.fromJson<int>(json['campeonatoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'localidade': serializer.toJson<String>(localidade),
      'escudoUrl': serializer.toJson<String?>(escudoUrl),
      'campeonatoId': serializer.toJson<int>(campeonatoId),
    };
  }

  Time copyWith({
    int? id,
    String? nome,
    String? localidade,
    Value<String?> escudoUrl = const Value.absent(),
    int? campeonatoId,
  }) => Time(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    localidade: localidade ?? this.localidade,
    escudoUrl: escudoUrl.present ? escudoUrl.value : this.escudoUrl,
    campeonatoId: campeonatoId ?? this.campeonatoId,
  );
  Time copyWithCompanion(TimesCompanion data) {
    return Time(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      localidade: data.localidade.present
          ? data.localidade.value
          : this.localidade,
      escudoUrl: data.escudoUrl.present ? data.escudoUrl.value : this.escudoUrl,
      campeonatoId: data.campeonatoId.present
          ? data.campeonatoId.value
          : this.campeonatoId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Time(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('localidade: $localidade, ')
          ..write('escudoUrl: $escudoUrl, ')
          ..write('campeonatoId: $campeonatoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nome, localidade, escudoUrl, campeonatoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Time &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.localidade == this.localidade &&
          other.escudoUrl == this.escudoUrl &&
          other.campeonatoId == this.campeonatoId);
}

class TimesCompanion extends UpdateCompanion<Time> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> localidade;
  final Value<String?> escudoUrl;
  final Value<int> campeonatoId;
  const TimesCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.localidade = const Value.absent(),
    this.escudoUrl = const Value.absent(),
    this.campeonatoId = const Value.absent(),
  });
  TimesCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String localidade,
    this.escudoUrl = const Value.absent(),
    required int campeonatoId,
  }) : nome = Value(nome),
       localidade = Value(localidade),
       campeonatoId = Value(campeonatoId);
  static Insertable<Time> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? localidade,
    Expression<String>? escudoUrl,
    Expression<int>? campeonatoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (localidade != null) 'localidade': localidade,
      if (escudoUrl != null) 'escudo_url': escudoUrl,
      if (campeonatoId != null) 'campeonato_id': campeonatoId,
    });
  }

  TimesCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? localidade,
    Value<String?>? escudoUrl,
    Value<int>? campeonatoId,
  }) {
    return TimesCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      localidade: localidade ?? this.localidade,
      escudoUrl: escudoUrl ?? this.escudoUrl,
      campeonatoId: campeonatoId ?? this.campeonatoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (localidade.present) {
      map['localidade'] = Variable<String>(localidade.value);
    }
    if (escudoUrl.present) {
      map['escudo_url'] = Variable<String>(escudoUrl.value);
    }
    if (campeonatoId.present) {
      map['campeonato_id'] = Variable<int>(campeonatoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimesCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('localidade: $localidade, ')
          ..write('escudoUrl: $escudoUrl, ')
          ..write('campeonatoId: $campeonatoId')
          ..write(')'))
        .toString();
  }
}

class $JogadoresTable extends Jogadores
    with TableInfo<$JogadoresTable, Jogadore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JogadoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<int> numero = GeneratedColumn<int>(
    'numero',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posicaoMeta = const VerificationMeta(
    'posicao',
  );
  @override
  late final GeneratedColumn<String> posicao = GeneratedColumn<String>(
    'posicao',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeIdMeta = const VerificationMeta('timeId');
  @override
  late final GeneratedColumn<int> timeId = GeneratedColumn<int>(
    'time_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES times (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nome, numero, posicao, timeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jogadores';
  @override
  VerificationContext validateIntegrity(
    Insertable<Jogadore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    }
    if (data.containsKey('posicao')) {
      context.handle(
        _posicaoMeta,
        posicao.isAcceptableOrUnknown(data['posicao']!, _posicaoMeta),
      );
    } else if (isInserting) {
      context.missing(_posicaoMeta);
    }
    if (data.containsKey('time_id')) {
      context.handle(
        _timeIdMeta,
        timeId.isAcceptableOrUnknown(data['time_id']!, _timeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_timeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Jogadore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Jogadore(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero'],
      ),
      posicao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}posicao'],
      )!,
      timeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_id'],
      )!,
    );
  }

  @override
  $JogadoresTable createAlias(String alias) {
    return $JogadoresTable(attachedDatabase, alias);
  }
}

class Jogadore extends DataClass implements Insertable<Jogadore> {
  final int id;
  final String nome;
  final int? numero;
  final String posicao;
  final int timeId;
  const Jogadore({
    required this.id,
    required this.nome,
    this.numero,
    required this.posicao,
    required this.timeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || numero != null) {
      map['numero'] = Variable<int>(numero);
    }
    map['posicao'] = Variable<String>(posicao);
    map['time_id'] = Variable<int>(timeId);
    return map;
  }

  JogadoresCompanion toCompanion(bool nullToAbsent) {
    return JogadoresCompanion(
      id: Value(id),
      nome: Value(nome),
      numero: numero == null && nullToAbsent
          ? const Value.absent()
          : Value(numero),
      posicao: Value(posicao),
      timeId: Value(timeId),
    );
  }

  factory Jogadore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Jogadore(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      numero: serializer.fromJson<int?>(json['numero']),
      posicao: serializer.fromJson<String>(json['posicao']),
      timeId: serializer.fromJson<int>(json['timeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'numero': serializer.toJson<int?>(numero),
      'posicao': serializer.toJson<String>(posicao),
      'timeId': serializer.toJson<int>(timeId),
    };
  }

  Jogadore copyWith({
    int? id,
    String? nome,
    Value<int?> numero = const Value.absent(),
    String? posicao,
    int? timeId,
  }) => Jogadore(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    numero: numero.present ? numero.value : this.numero,
    posicao: posicao ?? this.posicao,
    timeId: timeId ?? this.timeId,
  );
  Jogadore copyWithCompanion(JogadoresCompanion data) {
    return Jogadore(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      numero: data.numero.present ? data.numero.value : this.numero,
      posicao: data.posicao.present ? data.posicao.value : this.posicao,
      timeId: data.timeId.present ? data.timeId.value : this.timeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Jogadore(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('numero: $numero, ')
          ..write('posicao: $posicao, ')
          ..write('timeId: $timeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, numero, posicao, timeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Jogadore &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.numero == this.numero &&
          other.posicao == this.posicao &&
          other.timeId == this.timeId);
}

class JogadoresCompanion extends UpdateCompanion<Jogadore> {
  final Value<int> id;
  final Value<String> nome;
  final Value<int?> numero;
  final Value<String> posicao;
  final Value<int> timeId;
  const JogadoresCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.numero = const Value.absent(),
    this.posicao = const Value.absent(),
    this.timeId = const Value.absent(),
  });
  JogadoresCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    this.numero = const Value.absent(),
    required String posicao,
    required int timeId,
  }) : nome = Value(nome),
       posicao = Value(posicao),
       timeId = Value(timeId);
  static Insertable<Jogadore> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<int>? numero,
    Expression<String>? posicao,
    Expression<int>? timeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (numero != null) 'numero': numero,
      if (posicao != null) 'posicao': posicao,
      if (timeId != null) 'time_id': timeId,
    });
  }

  JogadoresCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<int?>? numero,
    Value<String>? posicao,
    Value<int>? timeId,
  }) {
    return JogadoresCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      numero: numero ?? this.numero,
      posicao: posicao ?? this.posicao,
      timeId: timeId ?? this.timeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (numero.present) {
      map['numero'] = Variable<int>(numero.value);
    }
    if (posicao.present) {
      map['posicao'] = Variable<String>(posicao.value);
    }
    if (timeId.present) {
      map['time_id'] = Variable<int>(timeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JogadoresCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('numero: $numero, ')
          ..write('posicao: $posicao, ')
          ..write('timeId: $timeId')
          ..write(')'))
        .toString();
  }
}

class $PartidasTable extends Partidas with TableInfo<$PartidasTable, Partida> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartidasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _campeonatoIdMeta = const VerificationMeta(
    'campeonatoId',
  );
  @override
  late final GeneratedColumn<int> campeonatoId = GeneratedColumn<int>(
    'campeonato_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES campeonatos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _rodadaMeta = const VerificationMeta('rodada');
  @override
  late final GeneratedColumn<int> rodada = GeneratedColumn<int>(
    'rodada',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMandanteIdMeta = const VerificationMeta(
    'timeMandanteId',
  );
  @override
  late final GeneratedColumn<int> timeMandanteId = GeneratedColumn<int>(
    'time_mandante_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES times (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timeVisitanteIdMeta = const VerificationMeta(
    'timeVisitanteId',
  );
  @override
  late final GeneratedColumn<int> timeVisitanteId = GeneratedColumn<int>(
    'time_visitante_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES times (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
    'data',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _horarioMeta = const VerificationMeta(
    'horario',
  );
  @override
  late final GeneratedColumn<String> horario = GeneratedColumn<String>(
    'horario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localMeta = const VerificationMeta('local');
  @override
  late final GeneratedColumn<String> local = GeneratedColumn<String>(
    'local',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    campeonatoId,
    rodada,
    timeMandanteId,
    timeVisitanteId,
    data,
    horario,
    local,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'partidas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Partida> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('campeonato_id')) {
      context.handle(
        _campeonatoIdMeta,
        campeonatoId.isAcceptableOrUnknown(
          data['campeonato_id']!,
          _campeonatoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_campeonatoIdMeta);
    }
    if (data.containsKey('rodada')) {
      context.handle(
        _rodadaMeta,
        rodada.isAcceptableOrUnknown(data['rodada']!, _rodadaMeta),
      );
    } else if (isInserting) {
      context.missing(_rodadaMeta);
    }
    if (data.containsKey('time_mandante_id')) {
      context.handle(
        _timeMandanteIdMeta,
        timeMandanteId.isAcceptableOrUnknown(
          data['time_mandante_id']!,
          _timeMandanteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeMandanteIdMeta);
    }
    if (data.containsKey('time_visitante_id')) {
      context.handle(
        _timeVisitanteIdMeta,
        timeVisitanteId.isAcceptableOrUnknown(
          data['time_visitante_id']!,
          _timeVisitanteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeVisitanteIdMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    }
    if (data.containsKey('horario')) {
      context.handle(
        _horarioMeta,
        horario.isAcceptableOrUnknown(data['horario']!, _horarioMeta),
      );
    }
    if (data.containsKey('local')) {
      context.handle(
        _localMeta,
        local.isAcceptableOrUnknown(data['local']!, _localMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Partida map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Partida(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      campeonatoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}campeonato_id'],
      )!,
      rodada: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rodada'],
      )!,
      timeMandanteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_mandante_id'],
      )!,
      timeVisitanteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_visitante_id'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data'],
      ),
      horario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}horario'],
      ),
      local: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $PartidasTable createAlias(String alias) {
    return $PartidasTable(attachedDatabase, alias);
  }
}

class Partida extends DataClass implements Insertable<Partida> {
  final int id;
  final int campeonatoId;
  final int rodada;
  final int timeMandanteId;
  final int timeVisitanteId;
  final DateTime? data;
  final String? horario;
  final String? local;
  final String status;
  const Partida({
    required this.id,
    required this.campeonatoId,
    required this.rodada,
    required this.timeMandanteId,
    required this.timeVisitanteId,
    this.data,
    this.horario,
    this.local,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['campeonato_id'] = Variable<int>(campeonatoId);
    map['rodada'] = Variable<int>(rodada);
    map['time_mandante_id'] = Variable<int>(timeMandanteId);
    map['time_visitante_id'] = Variable<int>(timeVisitanteId);
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<DateTime>(data);
    }
    if (!nullToAbsent || horario != null) {
      map['horario'] = Variable<String>(horario);
    }
    if (!nullToAbsent || local != null) {
      map['local'] = Variable<String>(local);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  PartidasCompanion toCompanion(bool nullToAbsent) {
    return PartidasCompanion(
      id: Value(id),
      campeonatoId: Value(campeonatoId),
      rodada: Value(rodada),
      timeMandanteId: Value(timeMandanteId),
      timeVisitanteId: Value(timeVisitanteId),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      horario: horario == null && nullToAbsent
          ? const Value.absent()
          : Value(horario),
      local: local == null && nullToAbsent
          ? const Value.absent()
          : Value(local),
      status: Value(status),
    );
  }

  factory Partida.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Partida(
      id: serializer.fromJson<int>(json['id']),
      campeonatoId: serializer.fromJson<int>(json['campeonatoId']),
      rodada: serializer.fromJson<int>(json['rodada']),
      timeMandanteId: serializer.fromJson<int>(json['timeMandanteId']),
      timeVisitanteId: serializer.fromJson<int>(json['timeVisitanteId']),
      data: serializer.fromJson<DateTime?>(json['data']),
      horario: serializer.fromJson<String?>(json['horario']),
      local: serializer.fromJson<String?>(json['local']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'campeonatoId': serializer.toJson<int>(campeonatoId),
      'rodada': serializer.toJson<int>(rodada),
      'timeMandanteId': serializer.toJson<int>(timeMandanteId),
      'timeVisitanteId': serializer.toJson<int>(timeVisitanteId),
      'data': serializer.toJson<DateTime?>(data),
      'horario': serializer.toJson<String?>(horario),
      'local': serializer.toJson<String?>(local),
      'status': serializer.toJson<String>(status),
    };
  }

  Partida copyWith({
    int? id,
    int? campeonatoId,
    int? rodada,
    int? timeMandanteId,
    int? timeVisitanteId,
    Value<DateTime?> data = const Value.absent(),
    Value<String?> horario = const Value.absent(),
    Value<String?> local = const Value.absent(),
    String? status,
  }) => Partida(
    id: id ?? this.id,
    campeonatoId: campeonatoId ?? this.campeonatoId,
    rodada: rodada ?? this.rodada,
    timeMandanteId: timeMandanteId ?? this.timeMandanteId,
    timeVisitanteId: timeVisitanteId ?? this.timeVisitanteId,
    data: data.present ? data.value : this.data,
    horario: horario.present ? horario.value : this.horario,
    local: local.present ? local.value : this.local,
    status: status ?? this.status,
  );
  Partida copyWithCompanion(PartidasCompanion data) {
    return Partida(
      id: data.id.present ? data.id.value : this.id,
      campeonatoId: data.campeonatoId.present
          ? data.campeonatoId.value
          : this.campeonatoId,
      rodada: data.rodada.present ? data.rodada.value : this.rodada,
      timeMandanteId: data.timeMandanteId.present
          ? data.timeMandanteId.value
          : this.timeMandanteId,
      timeVisitanteId: data.timeVisitanteId.present
          ? data.timeVisitanteId.value
          : this.timeVisitanteId,
      data: data.data.present ? data.data.value : this.data,
      horario: data.horario.present ? data.horario.value : this.horario,
      local: data.local.present ? data.local.value : this.local,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Partida(')
          ..write('id: $id, ')
          ..write('campeonatoId: $campeonatoId, ')
          ..write('rodada: $rodada, ')
          ..write('timeMandanteId: $timeMandanteId, ')
          ..write('timeVisitanteId: $timeVisitanteId, ')
          ..write('data: $data, ')
          ..write('horario: $horario, ')
          ..write('local: $local, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    campeonatoId,
    rodada,
    timeMandanteId,
    timeVisitanteId,
    data,
    horario,
    local,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Partida &&
          other.id == this.id &&
          other.campeonatoId == this.campeonatoId &&
          other.rodada == this.rodada &&
          other.timeMandanteId == this.timeMandanteId &&
          other.timeVisitanteId == this.timeVisitanteId &&
          other.data == this.data &&
          other.horario == this.horario &&
          other.local == this.local &&
          other.status == this.status);
}

class PartidasCompanion extends UpdateCompanion<Partida> {
  final Value<int> id;
  final Value<int> campeonatoId;
  final Value<int> rodada;
  final Value<int> timeMandanteId;
  final Value<int> timeVisitanteId;
  final Value<DateTime?> data;
  final Value<String?> horario;
  final Value<String?> local;
  final Value<String> status;
  const PartidasCompanion({
    this.id = const Value.absent(),
    this.campeonatoId = const Value.absent(),
    this.rodada = const Value.absent(),
    this.timeMandanteId = const Value.absent(),
    this.timeVisitanteId = const Value.absent(),
    this.data = const Value.absent(),
    this.horario = const Value.absent(),
    this.local = const Value.absent(),
    this.status = const Value.absent(),
  });
  PartidasCompanion.insert({
    this.id = const Value.absent(),
    required int campeonatoId,
    required int rodada,
    required int timeMandanteId,
    required int timeVisitanteId,
    this.data = const Value.absent(),
    this.horario = const Value.absent(),
    this.local = const Value.absent(),
    required String status,
  }) : campeonatoId = Value(campeonatoId),
       rodada = Value(rodada),
       timeMandanteId = Value(timeMandanteId),
       timeVisitanteId = Value(timeVisitanteId),
       status = Value(status);
  static Insertable<Partida> custom({
    Expression<int>? id,
    Expression<int>? campeonatoId,
    Expression<int>? rodada,
    Expression<int>? timeMandanteId,
    Expression<int>? timeVisitanteId,
    Expression<DateTime>? data,
    Expression<String>? horario,
    Expression<String>? local,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campeonatoId != null) 'campeonato_id': campeonatoId,
      if (rodada != null) 'rodada': rodada,
      if (timeMandanteId != null) 'time_mandante_id': timeMandanteId,
      if (timeVisitanteId != null) 'time_visitante_id': timeVisitanteId,
      if (data != null) 'data': data,
      if (horario != null) 'horario': horario,
      if (local != null) 'local': local,
      if (status != null) 'status': status,
    });
  }

  PartidasCompanion copyWith({
    Value<int>? id,
    Value<int>? campeonatoId,
    Value<int>? rodada,
    Value<int>? timeMandanteId,
    Value<int>? timeVisitanteId,
    Value<DateTime?>? data,
    Value<String?>? horario,
    Value<String?>? local,
    Value<String>? status,
  }) {
    return PartidasCompanion(
      id: id ?? this.id,
      campeonatoId: campeonatoId ?? this.campeonatoId,
      rodada: rodada ?? this.rodada,
      timeMandanteId: timeMandanteId ?? this.timeMandanteId,
      timeVisitanteId: timeVisitanteId ?? this.timeVisitanteId,
      data: data ?? this.data,
      horario: horario ?? this.horario,
      local: local ?? this.local,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (campeonatoId.present) {
      map['campeonato_id'] = Variable<int>(campeonatoId.value);
    }
    if (rodada.present) {
      map['rodada'] = Variable<int>(rodada.value);
    }
    if (timeMandanteId.present) {
      map['time_mandante_id'] = Variable<int>(timeMandanteId.value);
    }
    if (timeVisitanteId.present) {
      map['time_visitante_id'] = Variable<int>(timeVisitanteId.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (horario.present) {
      map['horario'] = Variable<String>(horario.value);
    }
    if (local.present) {
      map['local'] = Variable<String>(local.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartidasCompanion(')
          ..write('id: $id, ')
          ..write('campeonatoId: $campeonatoId, ')
          ..write('rodada: $rodada, ')
          ..write('timeMandanteId: $timeMandanteId, ')
          ..write('timeVisitanteId: $timeVisitanteId, ')
          ..write('data: $data, ')
          ..write('horario: $horario, ')
          ..write('local: $local, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ClassificacoesTable extends Classificacoes
    with TableInfo<$ClassificacoesTable, Classificacoe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassificacoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _campeonatoIdMeta = const VerificationMeta(
    'campeonatoId',
  );
  @override
  late final GeneratedColumn<int> campeonatoId = GeneratedColumn<int>(
    'campeonato_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES campeonatos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timeIdMeta = const VerificationMeta('timeId');
  @override
  late final GeneratedColumn<int> timeId = GeneratedColumn<int>(
    'time_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES times (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pontosMeta = const VerificationMeta('pontos');
  @override
  late final GeneratedColumn<int> pontos = GeneratedColumn<int>(
    'pontos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jogosMeta = const VerificationMeta('jogos');
  @override
  late final GeneratedColumn<int> jogos = GeneratedColumn<int>(
    'jogos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vitoriasMeta = const VerificationMeta(
    'vitorias',
  );
  @override
  late final GeneratedColumn<int> vitorias = GeneratedColumn<int>(
    'vitorias',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _empatesMeta = const VerificationMeta(
    'empates',
  );
  @override
  late final GeneratedColumn<int> empates = GeneratedColumn<int>(
    'empates',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _derrotasMeta = const VerificationMeta(
    'derrotas',
  );
  @override
  late final GeneratedColumn<int> derrotas = GeneratedColumn<int>(
    'derrotas',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _golsProMeta = const VerificationMeta(
    'golsPro',
  );
  @override
  late final GeneratedColumn<int> golsPro = GeneratedColumn<int>(
    'gols_pro',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _golsContraMeta = const VerificationMeta(
    'golsContra',
  );
  @override
  late final GeneratedColumn<int> golsContra = GeneratedColumn<int>(
    'gols_contra',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    campeonatoId,
    timeId,
    pontos,
    jogos,
    vitorias,
    empates,
    derrotas,
    golsPro,
    golsContra,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'classificacoes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Classificacoe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('campeonato_id')) {
      context.handle(
        _campeonatoIdMeta,
        campeonatoId.isAcceptableOrUnknown(
          data['campeonato_id']!,
          _campeonatoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_campeonatoIdMeta);
    }
    if (data.containsKey('time_id')) {
      context.handle(
        _timeIdMeta,
        timeId.isAcceptableOrUnknown(data['time_id']!, _timeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_timeIdMeta);
    }
    if (data.containsKey('pontos')) {
      context.handle(
        _pontosMeta,
        pontos.isAcceptableOrUnknown(data['pontos']!, _pontosMeta),
      );
    } else if (isInserting) {
      context.missing(_pontosMeta);
    }
    if (data.containsKey('jogos')) {
      context.handle(
        _jogosMeta,
        jogos.isAcceptableOrUnknown(data['jogos']!, _jogosMeta),
      );
    } else if (isInserting) {
      context.missing(_jogosMeta);
    }
    if (data.containsKey('vitorias')) {
      context.handle(
        _vitoriasMeta,
        vitorias.isAcceptableOrUnknown(data['vitorias']!, _vitoriasMeta),
      );
    } else if (isInserting) {
      context.missing(_vitoriasMeta);
    }
    if (data.containsKey('empates')) {
      context.handle(
        _empatesMeta,
        empates.isAcceptableOrUnknown(data['empates']!, _empatesMeta),
      );
    } else if (isInserting) {
      context.missing(_empatesMeta);
    }
    if (data.containsKey('derrotas')) {
      context.handle(
        _derrotasMeta,
        derrotas.isAcceptableOrUnknown(data['derrotas']!, _derrotasMeta),
      );
    } else if (isInserting) {
      context.missing(_derrotasMeta);
    }
    if (data.containsKey('gols_pro')) {
      context.handle(
        _golsProMeta,
        golsPro.isAcceptableOrUnknown(data['gols_pro']!, _golsProMeta),
      );
    } else if (isInserting) {
      context.missing(_golsProMeta);
    }
    if (data.containsKey('gols_contra')) {
      context.handle(
        _golsContraMeta,
        golsContra.isAcceptableOrUnknown(data['gols_contra']!, _golsContraMeta),
      );
    } else if (isInserting) {
      context.missing(_golsContraMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Classificacoe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Classificacoe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      campeonatoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}campeonato_id'],
      )!,
      timeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_id'],
      )!,
      pontos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pontos'],
      )!,
      jogos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jogos'],
      )!,
      vitorias: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vitorias'],
      )!,
      empates: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}empates'],
      )!,
      derrotas: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}derrotas'],
      )!,
      golsPro: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gols_pro'],
      )!,
      golsContra: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gols_contra'],
      )!,
    );
  }

  @override
  $ClassificacoesTable createAlias(String alias) {
    return $ClassificacoesTable(attachedDatabase, alias);
  }
}

class Classificacoe extends DataClass implements Insertable<Classificacoe> {
  final int id;
  final int campeonatoId;
  final int timeId;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsPro;
  final int golsContra;
  const Classificacoe({
    required this.id,
    required this.campeonatoId,
    required this.timeId,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsPro,
    required this.golsContra,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['campeonato_id'] = Variable<int>(campeonatoId);
    map['time_id'] = Variable<int>(timeId);
    map['pontos'] = Variable<int>(pontos);
    map['jogos'] = Variable<int>(jogos);
    map['vitorias'] = Variable<int>(vitorias);
    map['empates'] = Variable<int>(empates);
    map['derrotas'] = Variable<int>(derrotas);
    map['gols_pro'] = Variable<int>(golsPro);
    map['gols_contra'] = Variable<int>(golsContra);
    return map;
  }

  ClassificacoesCompanion toCompanion(bool nullToAbsent) {
    return ClassificacoesCompanion(
      id: Value(id),
      campeonatoId: Value(campeonatoId),
      timeId: Value(timeId),
      pontos: Value(pontos),
      jogos: Value(jogos),
      vitorias: Value(vitorias),
      empates: Value(empates),
      derrotas: Value(derrotas),
      golsPro: Value(golsPro),
      golsContra: Value(golsContra),
    );
  }

  factory Classificacoe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Classificacoe(
      id: serializer.fromJson<int>(json['id']),
      campeonatoId: serializer.fromJson<int>(json['campeonatoId']),
      timeId: serializer.fromJson<int>(json['timeId']),
      pontos: serializer.fromJson<int>(json['pontos']),
      jogos: serializer.fromJson<int>(json['jogos']),
      vitorias: serializer.fromJson<int>(json['vitorias']),
      empates: serializer.fromJson<int>(json['empates']),
      derrotas: serializer.fromJson<int>(json['derrotas']),
      golsPro: serializer.fromJson<int>(json['golsPro']),
      golsContra: serializer.fromJson<int>(json['golsContra']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'campeonatoId': serializer.toJson<int>(campeonatoId),
      'timeId': serializer.toJson<int>(timeId),
      'pontos': serializer.toJson<int>(pontos),
      'jogos': serializer.toJson<int>(jogos),
      'vitorias': serializer.toJson<int>(vitorias),
      'empates': serializer.toJson<int>(empates),
      'derrotas': serializer.toJson<int>(derrotas),
      'golsPro': serializer.toJson<int>(golsPro),
      'golsContra': serializer.toJson<int>(golsContra),
    };
  }

  Classificacoe copyWith({
    int? id,
    int? campeonatoId,
    int? timeId,
    int? pontos,
    int? jogos,
    int? vitorias,
    int? empates,
    int? derrotas,
    int? golsPro,
    int? golsContra,
  }) => Classificacoe(
    id: id ?? this.id,
    campeonatoId: campeonatoId ?? this.campeonatoId,
    timeId: timeId ?? this.timeId,
    pontos: pontos ?? this.pontos,
    jogos: jogos ?? this.jogos,
    vitorias: vitorias ?? this.vitorias,
    empates: empates ?? this.empates,
    derrotas: derrotas ?? this.derrotas,
    golsPro: golsPro ?? this.golsPro,
    golsContra: golsContra ?? this.golsContra,
  );
  Classificacoe copyWithCompanion(ClassificacoesCompanion data) {
    return Classificacoe(
      id: data.id.present ? data.id.value : this.id,
      campeonatoId: data.campeonatoId.present
          ? data.campeonatoId.value
          : this.campeonatoId,
      timeId: data.timeId.present ? data.timeId.value : this.timeId,
      pontos: data.pontos.present ? data.pontos.value : this.pontos,
      jogos: data.jogos.present ? data.jogos.value : this.jogos,
      vitorias: data.vitorias.present ? data.vitorias.value : this.vitorias,
      empates: data.empates.present ? data.empates.value : this.empates,
      derrotas: data.derrotas.present ? data.derrotas.value : this.derrotas,
      golsPro: data.golsPro.present ? data.golsPro.value : this.golsPro,
      golsContra: data.golsContra.present
          ? data.golsContra.value
          : this.golsContra,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Classificacoe(')
          ..write('id: $id, ')
          ..write('campeonatoId: $campeonatoId, ')
          ..write('timeId: $timeId, ')
          ..write('pontos: $pontos, ')
          ..write('jogos: $jogos, ')
          ..write('vitorias: $vitorias, ')
          ..write('empates: $empates, ')
          ..write('derrotas: $derrotas, ')
          ..write('golsPro: $golsPro, ')
          ..write('golsContra: $golsContra')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    campeonatoId,
    timeId,
    pontos,
    jogos,
    vitorias,
    empates,
    derrotas,
    golsPro,
    golsContra,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Classificacoe &&
          other.id == this.id &&
          other.campeonatoId == this.campeonatoId &&
          other.timeId == this.timeId &&
          other.pontos == this.pontos &&
          other.jogos == this.jogos &&
          other.vitorias == this.vitorias &&
          other.empates == this.empates &&
          other.derrotas == this.derrotas &&
          other.golsPro == this.golsPro &&
          other.golsContra == this.golsContra);
}

class ClassificacoesCompanion extends UpdateCompanion<Classificacoe> {
  final Value<int> id;
  final Value<int> campeonatoId;
  final Value<int> timeId;
  final Value<int> pontos;
  final Value<int> jogos;
  final Value<int> vitorias;
  final Value<int> empates;
  final Value<int> derrotas;
  final Value<int> golsPro;
  final Value<int> golsContra;
  const ClassificacoesCompanion({
    this.id = const Value.absent(),
    this.campeonatoId = const Value.absent(),
    this.timeId = const Value.absent(),
    this.pontos = const Value.absent(),
    this.jogos = const Value.absent(),
    this.vitorias = const Value.absent(),
    this.empates = const Value.absent(),
    this.derrotas = const Value.absent(),
    this.golsPro = const Value.absent(),
    this.golsContra = const Value.absent(),
  });
  ClassificacoesCompanion.insert({
    this.id = const Value.absent(),
    required int campeonatoId,
    required int timeId,
    required int pontos,
    required int jogos,
    required int vitorias,
    required int empates,
    required int derrotas,
    required int golsPro,
    required int golsContra,
  }) : campeonatoId = Value(campeonatoId),
       timeId = Value(timeId),
       pontos = Value(pontos),
       jogos = Value(jogos),
       vitorias = Value(vitorias),
       empates = Value(empates),
       derrotas = Value(derrotas),
       golsPro = Value(golsPro),
       golsContra = Value(golsContra);
  static Insertable<Classificacoe> custom({
    Expression<int>? id,
    Expression<int>? campeonatoId,
    Expression<int>? timeId,
    Expression<int>? pontos,
    Expression<int>? jogos,
    Expression<int>? vitorias,
    Expression<int>? empates,
    Expression<int>? derrotas,
    Expression<int>? golsPro,
    Expression<int>? golsContra,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campeonatoId != null) 'campeonato_id': campeonatoId,
      if (timeId != null) 'time_id': timeId,
      if (pontos != null) 'pontos': pontos,
      if (jogos != null) 'jogos': jogos,
      if (vitorias != null) 'vitorias': vitorias,
      if (empates != null) 'empates': empates,
      if (derrotas != null) 'derrotas': derrotas,
      if (golsPro != null) 'gols_pro': golsPro,
      if (golsContra != null) 'gols_contra': golsContra,
    });
  }

  ClassificacoesCompanion copyWith({
    Value<int>? id,
    Value<int>? campeonatoId,
    Value<int>? timeId,
    Value<int>? pontos,
    Value<int>? jogos,
    Value<int>? vitorias,
    Value<int>? empates,
    Value<int>? derrotas,
    Value<int>? golsPro,
    Value<int>? golsContra,
  }) {
    return ClassificacoesCompanion(
      id: id ?? this.id,
      campeonatoId: campeonatoId ?? this.campeonatoId,
      timeId: timeId ?? this.timeId,
      pontos: pontos ?? this.pontos,
      jogos: jogos ?? this.jogos,
      vitorias: vitorias ?? this.vitorias,
      empates: empates ?? this.empates,
      derrotas: derrotas ?? this.derrotas,
      golsPro: golsPro ?? this.golsPro,
      golsContra: golsContra ?? this.golsContra,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (campeonatoId.present) {
      map['campeonato_id'] = Variable<int>(campeonatoId.value);
    }
    if (timeId.present) {
      map['time_id'] = Variable<int>(timeId.value);
    }
    if (pontos.present) {
      map['pontos'] = Variable<int>(pontos.value);
    }
    if (jogos.present) {
      map['jogos'] = Variable<int>(jogos.value);
    }
    if (vitorias.present) {
      map['vitorias'] = Variable<int>(vitorias.value);
    }
    if (empates.present) {
      map['empates'] = Variable<int>(empates.value);
    }
    if (derrotas.present) {
      map['derrotas'] = Variable<int>(derrotas.value);
    }
    if (golsPro.present) {
      map['gols_pro'] = Variable<int>(golsPro.value);
    }
    if (golsContra.present) {
      map['gols_contra'] = Variable<int>(golsContra.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassificacoesCompanion(')
          ..write('id: $id, ')
          ..write('campeonatoId: $campeonatoId, ')
          ..write('timeId: $timeId, ')
          ..write('pontos: $pontos, ')
          ..write('jogos: $jogos, ')
          ..write('vitorias: $vitorias, ')
          ..write('empates: $empates, ')
          ..write('derrotas: $derrotas, ')
          ..write('golsPro: $golsPro, ')
          ..write('golsContra: $golsContra')
          ..write(')'))
        .toString();
  }
}

class $EventosPartidasTable extends EventosPartidas
    with TableInfo<$EventosPartidasTable, EventosPartida> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventosPartidasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partidaIdMeta = const VerificationMeta(
    'partidaId',
  );
  @override
  late final GeneratedColumn<int> partidaId = GeneratedColumn<int>(
    'partida_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES partidas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minutoMeta = const VerificationMeta('minuto');
  @override
  late final GeneratedColumn<int> minuto = GeneratedColumn<int>(
    'minuto',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jogadorIdMeta = const VerificationMeta(
    'jogadorId',
  );
  @override
  late final GeneratedColumn<int> jogadorId = GeneratedColumn<int>(
    'jogador_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jogadores (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timeIdMeta = const VerificationMeta('timeId');
  @override
  late final GeneratedColumn<int> timeId = GeneratedColumn<int>(
    'time_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES times (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    partidaId,
    tipo,
    minuto,
    jogadorId,
    timeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'eventos_partidas';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventosPartida> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('partida_id')) {
      context.handle(
        _partidaIdMeta,
        partidaId.isAcceptableOrUnknown(data['partida_id']!, _partidaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partidaIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('minuto')) {
      context.handle(
        _minutoMeta,
        minuto.isAcceptableOrUnknown(data['minuto']!, _minutoMeta),
      );
    }
    if (data.containsKey('jogador_id')) {
      context.handle(
        _jogadorIdMeta,
        jogadorId.isAcceptableOrUnknown(data['jogador_id']!, _jogadorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jogadorIdMeta);
    }
    if (data.containsKey('time_id')) {
      context.handle(
        _timeIdMeta,
        timeId.isAcceptableOrUnknown(data['time_id']!, _timeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_timeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventosPartida map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventosPartida(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      partidaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partida_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      minuto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minuto'],
      ),
      jogadorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jogador_id'],
      )!,
      timeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_id'],
      )!,
    );
  }

  @override
  $EventosPartidasTable createAlias(String alias) {
    return $EventosPartidasTable(attachedDatabase, alias);
  }
}

class EventosPartida extends DataClass implements Insertable<EventosPartida> {
  final int id;
  final int partidaId;
  final String tipo;
  final int? minuto;
  final int jogadorId;
  final int timeId;
  const EventosPartida({
    required this.id,
    required this.partidaId,
    required this.tipo,
    this.minuto,
    required this.jogadorId,
    required this.timeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['partida_id'] = Variable<int>(partidaId);
    map['tipo'] = Variable<String>(tipo);
    if (!nullToAbsent || minuto != null) {
      map['minuto'] = Variable<int>(minuto);
    }
    map['jogador_id'] = Variable<int>(jogadorId);
    map['time_id'] = Variable<int>(timeId);
    return map;
  }

  EventosPartidasCompanion toCompanion(bool nullToAbsent) {
    return EventosPartidasCompanion(
      id: Value(id),
      partidaId: Value(partidaId),
      tipo: Value(tipo),
      minuto: minuto == null && nullToAbsent
          ? const Value.absent()
          : Value(minuto),
      jogadorId: Value(jogadorId),
      timeId: Value(timeId),
    );
  }

  factory EventosPartida.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventosPartida(
      id: serializer.fromJson<int>(json['id']),
      partidaId: serializer.fromJson<int>(json['partidaId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      minuto: serializer.fromJson<int?>(json['minuto']),
      jogadorId: serializer.fromJson<int>(json['jogadorId']),
      timeId: serializer.fromJson<int>(json['timeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'partidaId': serializer.toJson<int>(partidaId),
      'tipo': serializer.toJson<String>(tipo),
      'minuto': serializer.toJson<int?>(minuto),
      'jogadorId': serializer.toJson<int>(jogadorId),
      'timeId': serializer.toJson<int>(timeId),
    };
  }

  EventosPartida copyWith({
    int? id,
    int? partidaId,
    String? tipo,
    Value<int?> minuto = const Value.absent(),
    int? jogadorId,
    int? timeId,
  }) => EventosPartida(
    id: id ?? this.id,
    partidaId: partidaId ?? this.partidaId,
    tipo: tipo ?? this.tipo,
    minuto: minuto.present ? minuto.value : this.minuto,
    jogadorId: jogadorId ?? this.jogadorId,
    timeId: timeId ?? this.timeId,
  );
  EventosPartida copyWithCompanion(EventosPartidasCompanion data) {
    return EventosPartida(
      id: data.id.present ? data.id.value : this.id,
      partidaId: data.partidaId.present ? data.partidaId.value : this.partidaId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      minuto: data.minuto.present ? data.minuto.value : this.minuto,
      jogadorId: data.jogadorId.present ? data.jogadorId.value : this.jogadorId,
      timeId: data.timeId.present ? data.timeId.value : this.timeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventosPartida(')
          ..write('id: $id, ')
          ..write('partidaId: $partidaId, ')
          ..write('tipo: $tipo, ')
          ..write('minuto: $minuto, ')
          ..write('jogadorId: $jogadorId, ')
          ..write('timeId: $timeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, partidaId, tipo, minuto, jogadorId, timeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventosPartida &&
          other.id == this.id &&
          other.partidaId == this.partidaId &&
          other.tipo == this.tipo &&
          other.minuto == this.minuto &&
          other.jogadorId == this.jogadorId &&
          other.timeId == this.timeId);
}

class EventosPartidasCompanion extends UpdateCompanion<EventosPartida> {
  final Value<int> id;
  final Value<int> partidaId;
  final Value<String> tipo;
  final Value<int?> minuto;
  final Value<int> jogadorId;
  final Value<int> timeId;
  const EventosPartidasCompanion({
    this.id = const Value.absent(),
    this.partidaId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.minuto = const Value.absent(),
    this.jogadorId = const Value.absent(),
    this.timeId = const Value.absent(),
  });
  EventosPartidasCompanion.insert({
    this.id = const Value.absent(),
    required int partidaId,
    required String tipo,
    this.minuto = const Value.absent(),
    required int jogadorId,
    required int timeId,
  }) : partidaId = Value(partidaId),
       tipo = Value(tipo),
       jogadorId = Value(jogadorId),
       timeId = Value(timeId);
  static Insertable<EventosPartida> custom({
    Expression<int>? id,
    Expression<int>? partidaId,
    Expression<String>? tipo,
    Expression<int>? minuto,
    Expression<int>? jogadorId,
    Expression<int>? timeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (partidaId != null) 'partida_id': partidaId,
      if (tipo != null) 'tipo': tipo,
      if (minuto != null) 'minuto': minuto,
      if (jogadorId != null) 'jogador_id': jogadorId,
      if (timeId != null) 'time_id': timeId,
    });
  }

  EventosPartidasCompanion copyWith({
    Value<int>? id,
    Value<int>? partidaId,
    Value<String>? tipo,
    Value<int?>? minuto,
    Value<int>? jogadorId,
    Value<int>? timeId,
  }) {
    return EventosPartidasCompanion(
      id: id ?? this.id,
      partidaId: partidaId ?? this.partidaId,
      tipo: tipo ?? this.tipo,
      minuto: minuto ?? this.minuto,
      jogadorId: jogadorId ?? this.jogadorId,
      timeId: timeId ?? this.timeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (partidaId.present) {
      map['partida_id'] = Variable<int>(partidaId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (minuto.present) {
      map['minuto'] = Variable<int>(minuto.value);
    }
    if (jogadorId.present) {
      map['jogador_id'] = Variable<int>(jogadorId.value);
    }
    if (timeId.present) {
      map['time_id'] = Variable<int>(timeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventosPartidasCompanion(')
          ..write('id: $id, ')
          ..write('partidaId: $partidaId, ')
          ..write('tipo: $tipo, ')
          ..write('minuto: $minuto, ')
          ..write('jogadorId: $jogadorId, ')
          ..write('timeId: $timeId')
          ..write(')'))
        .toString();
  }
}

class $ResultadosTable extends Resultados
    with TableInfo<$ResultadosTable, Resultado> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResultadosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partidaIdMeta = const VerificationMeta(
    'partidaId',
  );
  @override
  late final GeneratedColumn<int> partidaId = GeneratedColumn<int>(
    'partida_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES partidas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _golsMandanteMeta = const VerificationMeta(
    'golsMandante',
  );
  @override
  late final GeneratedColumn<int> golsMandante = GeneratedColumn<int>(
    'gols_mandante',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _golsVisitanteMeta = const VerificationMeta(
    'golsVisitante',
  );
  @override
  late final GeneratedColumn<int> golsVisitante = GeneratedColumn<int>(
    'gols_visitante',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registradoPorMeta = const VerificationMeta(
    'registradoPor',
  );
  @override
  late final GeneratedColumn<int> registradoPor = GeneratedColumn<int>(
    'registrado_por',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _registradoEmMeta = const VerificationMeta(
    'registradoEm',
  );
  @override
  late final GeneratedColumn<DateTime> registradoEm = GeneratedColumn<DateTime>(
    'registrado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    partidaId,
    golsMandante,
    golsVisitante,
    registradoPor,
    registradoEm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'resultados';
  @override
  VerificationContext validateIntegrity(
    Insertable<Resultado> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('partida_id')) {
      context.handle(
        _partidaIdMeta,
        partidaId.isAcceptableOrUnknown(data['partida_id']!, _partidaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partidaIdMeta);
    }
    if (data.containsKey('gols_mandante')) {
      context.handle(
        _golsMandanteMeta,
        golsMandante.isAcceptableOrUnknown(
          data['gols_mandante']!,
          _golsMandanteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_golsMandanteMeta);
    }
    if (data.containsKey('gols_visitante')) {
      context.handle(
        _golsVisitanteMeta,
        golsVisitante.isAcceptableOrUnknown(
          data['gols_visitante']!,
          _golsVisitanteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_golsVisitanteMeta);
    }
    if (data.containsKey('registrado_por')) {
      context.handle(
        _registradoPorMeta,
        registradoPor.isAcceptableOrUnknown(
          data['registrado_por']!,
          _registradoPorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registradoPorMeta);
    }
    if (data.containsKey('registrado_em')) {
      context.handle(
        _registradoEmMeta,
        registradoEm.isAcceptableOrUnknown(
          data['registrado_em']!,
          _registradoEmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registradoEmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Resultado map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Resultado(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      partidaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partida_id'],
      )!,
      golsMandante: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gols_mandante'],
      )!,
      golsVisitante: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gols_visitante'],
      )!,
      registradoPor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}registrado_por'],
      )!,
      registradoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registrado_em'],
      )!,
    );
  }

  @override
  $ResultadosTable createAlias(String alias) {
    return $ResultadosTable(attachedDatabase, alias);
  }
}

class Resultado extends DataClass implements Insertable<Resultado> {
  final int id;
  final int partidaId;
  final int golsMandante;
  final int golsVisitante;
  final int registradoPor;
  final DateTime registradoEm;
  const Resultado({
    required this.id,
    required this.partidaId,
    required this.golsMandante,
    required this.golsVisitante,
    required this.registradoPor,
    required this.registradoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['partida_id'] = Variable<int>(partidaId);
    map['gols_mandante'] = Variable<int>(golsMandante);
    map['gols_visitante'] = Variable<int>(golsVisitante);
    map['registrado_por'] = Variable<int>(registradoPor);
    map['registrado_em'] = Variable<DateTime>(registradoEm);
    return map;
  }

  ResultadosCompanion toCompanion(bool nullToAbsent) {
    return ResultadosCompanion(
      id: Value(id),
      partidaId: Value(partidaId),
      golsMandante: Value(golsMandante),
      golsVisitante: Value(golsVisitante),
      registradoPor: Value(registradoPor),
      registradoEm: Value(registradoEm),
    );
  }

  factory Resultado.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Resultado(
      id: serializer.fromJson<int>(json['id']),
      partidaId: serializer.fromJson<int>(json['partidaId']),
      golsMandante: serializer.fromJson<int>(json['golsMandante']),
      golsVisitante: serializer.fromJson<int>(json['golsVisitante']),
      registradoPor: serializer.fromJson<int>(json['registradoPor']),
      registradoEm: serializer.fromJson<DateTime>(json['registradoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'partidaId': serializer.toJson<int>(partidaId),
      'golsMandante': serializer.toJson<int>(golsMandante),
      'golsVisitante': serializer.toJson<int>(golsVisitante),
      'registradoPor': serializer.toJson<int>(registradoPor),
      'registradoEm': serializer.toJson<DateTime>(registradoEm),
    };
  }

  Resultado copyWith({
    int? id,
    int? partidaId,
    int? golsMandante,
    int? golsVisitante,
    int? registradoPor,
    DateTime? registradoEm,
  }) => Resultado(
    id: id ?? this.id,
    partidaId: partidaId ?? this.partidaId,
    golsMandante: golsMandante ?? this.golsMandante,
    golsVisitante: golsVisitante ?? this.golsVisitante,
    registradoPor: registradoPor ?? this.registradoPor,
    registradoEm: registradoEm ?? this.registradoEm,
  );
  Resultado copyWithCompanion(ResultadosCompanion data) {
    return Resultado(
      id: data.id.present ? data.id.value : this.id,
      partidaId: data.partidaId.present ? data.partidaId.value : this.partidaId,
      golsMandante: data.golsMandante.present
          ? data.golsMandante.value
          : this.golsMandante,
      golsVisitante: data.golsVisitante.present
          ? data.golsVisitante.value
          : this.golsVisitante,
      registradoPor: data.registradoPor.present
          ? data.registradoPor.value
          : this.registradoPor,
      registradoEm: data.registradoEm.present
          ? data.registradoEm.value
          : this.registradoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Resultado(')
          ..write('id: $id, ')
          ..write('partidaId: $partidaId, ')
          ..write('golsMandante: $golsMandante, ')
          ..write('golsVisitante: $golsVisitante, ')
          ..write('registradoPor: $registradoPor, ')
          ..write('registradoEm: $registradoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    partidaId,
    golsMandante,
    golsVisitante,
    registradoPor,
    registradoEm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Resultado &&
          other.id == this.id &&
          other.partidaId == this.partidaId &&
          other.golsMandante == this.golsMandante &&
          other.golsVisitante == this.golsVisitante &&
          other.registradoPor == this.registradoPor &&
          other.registradoEm == this.registradoEm);
}

class ResultadosCompanion extends UpdateCompanion<Resultado> {
  final Value<int> id;
  final Value<int> partidaId;
  final Value<int> golsMandante;
  final Value<int> golsVisitante;
  final Value<int> registradoPor;
  final Value<DateTime> registradoEm;
  const ResultadosCompanion({
    this.id = const Value.absent(),
    this.partidaId = const Value.absent(),
    this.golsMandante = const Value.absent(),
    this.golsVisitante = const Value.absent(),
    this.registradoPor = const Value.absent(),
    this.registradoEm = const Value.absent(),
  });
  ResultadosCompanion.insert({
    this.id = const Value.absent(),
    required int partidaId,
    required int golsMandante,
    required int golsVisitante,
    required int registradoPor,
    required DateTime registradoEm,
  }) : partidaId = Value(partidaId),
       golsMandante = Value(golsMandante),
       golsVisitante = Value(golsVisitante),
       registradoPor = Value(registradoPor),
       registradoEm = Value(registradoEm);
  static Insertable<Resultado> custom({
    Expression<int>? id,
    Expression<int>? partidaId,
    Expression<int>? golsMandante,
    Expression<int>? golsVisitante,
    Expression<int>? registradoPor,
    Expression<DateTime>? registradoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (partidaId != null) 'partida_id': partidaId,
      if (golsMandante != null) 'gols_mandante': golsMandante,
      if (golsVisitante != null) 'gols_visitante': golsVisitante,
      if (registradoPor != null) 'registrado_por': registradoPor,
      if (registradoEm != null) 'registrado_em': registradoEm,
    });
  }

  ResultadosCompanion copyWith({
    Value<int>? id,
    Value<int>? partidaId,
    Value<int>? golsMandante,
    Value<int>? golsVisitante,
    Value<int>? registradoPor,
    Value<DateTime>? registradoEm,
  }) {
    return ResultadosCompanion(
      id: id ?? this.id,
      partidaId: partidaId ?? this.partidaId,
      golsMandante: golsMandante ?? this.golsMandante,
      golsVisitante: golsVisitante ?? this.golsVisitante,
      registradoPor: registradoPor ?? this.registradoPor,
      registradoEm: registradoEm ?? this.registradoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (partidaId.present) {
      map['partida_id'] = Variable<int>(partidaId.value);
    }
    if (golsMandante.present) {
      map['gols_mandante'] = Variable<int>(golsMandante.value);
    }
    if (golsVisitante.present) {
      map['gols_visitante'] = Variable<int>(golsVisitante.value);
    }
    if (registradoPor.present) {
      map['registrado_por'] = Variable<int>(registradoPor.value);
    }
    if (registradoEm.present) {
      map['registrado_em'] = Variable<DateTime>(registradoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResultadosCompanion(')
          ..write('id: $id, ')
          ..write('partidaId: $partidaId, ')
          ..write('golsMandante: $golsMandante, ')
          ..write('golsVisitante: $golsVisitante, ')
          ..write('registradoPor: $registradoPor, ')
          ..write('registradoEm: $registradoEm')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $CampeonatosTable campeonatos = $CampeonatosTable(this);
  late final $TimesTable times = $TimesTable(this);
  late final $JogadoresTable jogadores = $JogadoresTable(this);
  late final $PartidasTable partidas = $PartidasTable(this);
  late final $ClassificacoesTable classificacoes = $ClassificacoesTable(this);
  late final $EventosPartidasTable eventosPartidas = $EventosPartidasTable(
    this,
  );
  late final $ResultadosTable resultados = $ResultadosTable(this);
  late final PartidaDao partidaDao = PartidaDao(this as AppDatabase);
  late final CampeonatoDao campeonatoDao = CampeonatoDao(this as AppDatabase);
  late final TimeDao timeDao = TimeDao(this as AppDatabase);
  late final UsuarioDao usuarioDao = UsuarioDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarios,
    campeonatos,
    times,
    jogadores,
    partidas,
    classificacoes,
    eventosPartidas,
    resultados,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'usuarios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('campeonatos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'campeonatos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('times', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'times',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('jogadores', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'campeonatos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('partidas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'times',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('partidas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'times',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('partidas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'campeonatos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('classificacoes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'times',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('classificacoes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'partidas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('eventos_partidas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'jogadores',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('eventos_partidas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'times',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('eventos_partidas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'partidas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('resultados', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'usuarios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('resultados', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      required String nome,
      required String email,
      required String perfil,
      required DateTime criadoEm,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> email,
      Value<String> perfil,
      Value<DateTime> criadoEm,
    });

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CampeonatosTable, List<Campeonato>>
  _campeonatosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.campeonatos,
    aliasName: $_aliasNameGenerator(db.usuarios.id, db.campeonatos.criadoPor),
  );

  $$CampeonatosTableProcessedTableManager get campeonatosRefs {
    final manager = $$CampeonatosTableTableManager(
      $_db,
      $_db.campeonatos,
    ).filter((f) => f.criadoPor.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_campeonatosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ResultadosTable, List<Resultado>>
  _resultadosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.resultados,
    aliasName: $_aliasNameGenerator(
      db.usuarios.id,
      db.resultados.registradoPor,
    ),
  );

  $$ResultadosTableProcessedTableManager get resultadosRefs {
    final manager = $$ResultadosTableTableManager(
      $_db,
      $_db.resultados,
    ).filter((f) => f.registradoPor.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_resultadosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get perfil => $composableBuilder(
    column: $table.perfil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> campeonatosRefs(
    Expression<bool> Function($$CampeonatosTableFilterComposer f) f,
  ) {
    final $$CampeonatosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.criadoPor,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableFilterComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> resultadosRefs(
    Expression<bool> Function($$ResultadosTableFilterComposer f) f,
  ) {
    final $$ResultadosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultados,
      getReferencedColumn: (t) => t.registradoPor,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultadosTableFilterComposer(
            $db: $db,
            $table: $db.resultados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get perfil => $composableBuilder(
    column: $table.perfil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get perfil =>
      $composableBuilder(column: $table.perfil, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  Expression<T> campeonatosRefs<T extends Object>(
    Expression<T> Function($$CampeonatosTableAnnotationComposer a) f,
  ) {
    final $$CampeonatosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.criadoPor,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableAnnotationComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> resultadosRefs<T extends Object>(
    Expression<T> Function($$ResultadosTableAnnotationComposer a) f,
  ) {
    final $$ResultadosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultados,
      getReferencedColumn: (t) => t.registradoPor,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultadosTableAnnotationComposer(
            $db: $db,
            $table: $db.resultados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({bool campeonatosRefs, bool resultadosRefs})
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> perfil = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nome: nome,
                email: email,
                perfil: perfil,
                criadoEm: criadoEm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String email,
                required String perfil,
                required DateTime criadoEm,
              }) => UsuariosCompanion.insert(
                id: id,
                nome: nome,
                email: email,
                perfil: perfil,
                criadoEm: criadoEm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({campeonatosRefs = false, resultadosRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (campeonatosRefs) db.campeonatos,
                    if (resultadosRefs) db.resultados,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (campeonatosRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Campeonato
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._campeonatosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).campeonatosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.criadoPor == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (resultadosRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Resultado
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._resultadosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).resultadosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.registradoPor == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({bool campeonatosRefs, bool resultadosRefs})
    >;
typedef $$CampeonatosTableCreateCompanionBuilder =
    CampeonatosCompanion Function({
      Value<int> id,
      required String nome,
      required String modalidade,
      required String tipo,
      required int numEquipes,
      required DateTime dataInicio,
      required String status,
      required int criadoPor,
    });
typedef $$CampeonatosTableUpdateCompanionBuilder =
    CampeonatosCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> modalidade,
      Value<String> tipo,
      Value<int> numEquipes,
      Value<DateTime> dataInicio,
      Value<String> status,
      Value<int> criadoPor,
    });

final class $$CampeonatosTableReferences
    extends BaseReferences<_$AppDatabase, $CampeonatosTable, Campeonato> {
  $$CampeonatosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _criadoPorTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.campeonatos.criadoPor, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get criadoPor {
    final $_column = $_itemColumn<int>('criado_por')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_criadoPorTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TimesTable, List<Time>> _timesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.times,
    aliasName: $_aliasNameGenerator(db.campeonatos.id, db.times.campeonatoId),
  );

  $$TimesTableProcessedTableManager get timesRefs {
    final manager = $$TimesTableTableManager(
      $_db,
      $_db.times,
    ).filter((f) => f.campeonatoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartidasTable, List<Partida>> _partidasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.partidas,
    aliasName: $_aliasNameGenerator(
      db.campeonatos.id,
      db.partidas.campeonatoId,
    ),
  );

  $$PartidasTableProcessedTableManager get partidasRefs {
    final manager = $$PartidasTableTableManager(
      $_db,
      $_db.partidas,
    ).filter((f) => f.campeonatoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partidasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ClassificacoesTable, List<Classificacoe>>
  _classificacoesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.classificacoes,
    aliasName: $_aliasNameGenerator(
      db.campeonatos.id,
      db.classificacoes.campeonatoId,
    ),
  );

  $$ClassificacoesTableProcessedTableManager get classificacoesRefs {
    final manager = $$ClassificacoesTableTableManager(
      $_db,
      $_db.classificacoes,
    ).filter((f) => f.campeonatoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_classificacoesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CampeonatosTableFilterComposer
    extends Composer<_$AppDatabase, $CampeonatosTable> {
  $$CampeonatosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modalidade => $composableBuilder(
    column: $table.modalidade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numEquipes => $composableBuilder(
    column: $table.numEquipes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataInicio => $composableBuilder(
    column: $table.dataInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get criadoPor {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.criadoPor,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> timesRefs(
    Expression<bool> Function($$TimesTableFilterComposer f) f,
  ) {
    final $$TimesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.campeonatoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableFilterComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> partidasRefs(
    Expression<bool> Function($$PartidasTableFilterComposer f) f,
  ) {
    final $$PartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.campeonatoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableFilterComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> classificacoesRefs(
    Expression<bool> Function($$ClassificacoesTableFilterComposer f) f,
  ) {
    final $$ClassificacoesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classificacoes,
      getReferencedColumn: (t) => t.campeonatoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassificacoesTableFilterComposer(
            $db: $db,
            $table: $db.classificacoes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CampeonatosTableOrderingComposer
    extends Composer<_$AppDatabase, $CampeonatosTable> {
  $$CampeonatosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modalidade => $composableBuilder(
    column: $table.modalidade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numEquipes => $composableBuilder(
    column: $table.numEquipes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataInicio => $composableBuilder(
    column: $table.dataInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get criadoPor {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.criadoPor,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampeonatosTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampeonatosTable> {
  $$CampeonatosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get modalidade => $composableBuilder(
    column: $table.modalidade,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get numEquipes => $composableBuilder(
    column: $table.numEquipes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dataInicio => $composableBuilder(
    column: $table.dataInicio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get criadoPor {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.criadoPor,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> timesRefs<T extends Object>(
    Expression<T> Function($$TimesTableAnnotationComposer a) f,
  ) {
    final $$TimesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.campeonatoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableAnnotationComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> partidasRefs<T extends Object>(
    Expression<T> Function($$PartidasTableAnnotationComposer a) f,
  ) {
    final $$PartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.campeonatoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> classificacoesRefs<T extends Object>(
    Expression<T> Function($$ClassificacoesTableAnnotationComposer a) f,
  ) {
    final $$ClassificacoesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classificacoes,
      getReferencedColumn: (t) => t.campeonatoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassificacoesTableAnnotationComposer(
            $db: $db,
            $table: $db.classificacoes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CampeonatosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampeonatosTable,
          Campeonato,
          $$CampeonatosTableFilterComposer,
          $$CampeonatosTableOrderingComposer,
          $$CampeonatosTableAnnotationComposer,
          $$CampeonatosTableCreateCompanionBuilder,
          $$CampeonatosTableUpdateCompanionBuilder,
          (Campeonato, $$CampeonatosTableReferences),
          Campeonato,
          PrefetchHooks Function({
            bool criadoPor,
            bool timesRefs,
            bool partidasRefs,
            bool classificacoesRefs,
          })
        > {
  $$CampeonatosTableTableManager(_$AppDatabase db, $CampeonatosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampeonatosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CampeonatosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CampeonatosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> modalidade = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> numEquipes = const Value.absent(),
                Value<DateTime> dataInicio = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> criadoPor = const Value.absent(),
              }) => CampeonatosCompanion(
                id: id,
                nome: nome,
                modalidade: modalidade,
                tipo: tipo,
                numEquipes: numEquipes,
                dataInicio: dataInicio,
                status: status,
                criadoPor: criadoPor,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String modalidade,
                required String tipo,
                required int numEquipes,
                required DateTime dataInicio,
                required String status,
                required int criadoPor,
              }) => CampeonatosCompanion.insert(
                id: id,
                nome: nome,
                modalidade: modalidade,
                tipo: tipo,
                numEquipes: numEquipes,
                dataInicio: dataInicio,
                status: status,
                criadoPor: criadoPor,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CampeonatosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                criadoPor = false,
                timesRefs = false,
                partidasRefs = false,
                classificacoesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (timesRefs) db.times,
                    if (partidasRefs) db.partidas,
                    if (classificacoesRefs) db.classificacoes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (criadoPor) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.criadoPor,
                                    referencedTable:
                                        $$CampeonatosTableReferences
                                            ._criadoPorTable(db),
                                    referencedColumn:
                                        $$CampeonatosTableReferences
                                            ._criadoPorTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (timesRefs)
                        await $_getPrefetchedData<
                          Campeonato,
                          $CampeonatosTable,
                          Time
                        >(
                          currentTable: table,
                          referencedTable: $$CampeonatosTableReferences
                              ._timesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CampeonatosTableReferences(
                                db,
                                table,
                                p0,
                              ).timesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.campeonatoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (partidasRefs)
                        await $_getPrefetchedData<
                          Campeonato,
                          $CampeonatosTable,
                          Partida
                        >(
                          currentTable: table,
                          referencedTable: $$CampeonatosTableReferences
                              ._partidasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CampeonatosTableReferences(
                                db,
                                table,
                                p0,
                              ).partidasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.campeonatoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (classificacoesRefs)
                        await $_getPrefetchedData<
                          Campeonato,
                          $CampeonatosTable,
                          Classificacoe
                        >(
                          currentTable: table,
                          referencedTable: $$CampeonatosTableReferences
                              ._classificacoesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CampeonatosTableReferences(
                                db,
                                table,
                                p0,
                              ).classificacoesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.campeonatoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CampeonatosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampeonatosTable,
      Campeonato,
      $$CampeonatosTableFilterComposer,
      $$CampeonatosTableOrderingComposer,
      $$CampeonatosTableAnnotationComposer,
      $$CampeonatosTableCreateCompanionBuilder,
      $$CampeonatosTableUpdateCompanionBuilder,
      (Campeonato, $$CampeonatosTableReferences),
      Campeonato,
      PrefetchHooks Function({
        bool criadoPor,
        bool timesRefs,
        bool partidasRefs,
        bool classificacoesRefs,
      })
    >;
typedef $$TimesTableCreateCompanionBuilder =
    TimesCompanion Function({
      Value<int> id,
      required String nome,
      required String localidade,
      Value<String?> escudoUrl,
      required int campeonatoId,
    });
typedef $$TimesTableUpdateCompanionBuilder =
    TimesCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> localidade,
      Value<String?> escudoUrl,
      Value<int> campeonatoId,
    });

final class $$TimesTableReferences
    extends BaseReferences<_$AppDatabase, $TimesTable, Time> {
  $$TimesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CampeonatosTable _campeonatoIdTable(_$AppDatabase db) =>
      db.campeonatos.createAlias(
        $_aliasNameGenerator(db.times.campeonatoId, db.campeonatos.id),
      );

  $$CampeonatosTableProcessedTableManager get campeonatoId {
    final $_column = $_itemColumn<int>('campeonato_id')!;

    final manager = $$CampeonatosTableTableManager(
      $_db,
      $_db.campeonatos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campeonatoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$JogadoresTable, List<Jogadore>>
  _jogadoresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.jogadores,
    aliasName: $_aliasNameGenerator(db.times.id, db.jogadores.timeId),
  );

  $$JogadoresTableProcessedTableManager get jogadoresRefs {
    final manager = $$JogadoresTableTableManager(
      $_db,
      $_db.jogadores,
    ).filter((f) => f.timeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jogadoresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ClassificacoesTable, List<Classificacoe>>
  _classificacoesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.classificacoes,
    aliasName: $_aliasNameGenerator(db.times.id, db.classificacoes.timeId),
  );

  $$ClassificacoesTableProcessedTableManager get classificacoesRefs {
    final manager = $$ClassificacoesTableTableManager(
      $_db,
      $_db.classificacoes,
    ).filter((f) => f.timeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_classificacoesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventosPartidasTable, List<EventosPartida>>
  _eventosPartidasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventosPartidas,
    aliasName: $_aliasNameGenerator(db.times.id, db.eventosPartidas.timeId),
  );

  $$EventosPartidasTableProcessedTableManager get eventosPartidasRefs {
    final manager = $$EventosPartidasTableTableManager(
      $_db,
      $_db.eventosPartidas,
    ).filter((f) => f.timeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventosPartidasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TimesTableFilterComposer extends Composer<_$AppDatabase, $TimesTable> {
  $$TimesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localidade => $composableBuilder(
    column: $table.localidade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get escudoUrl => $composableBuilder(
    column: $table.escudoUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$CampeonatosTableFilterComposer get campeonatoId {
    final $$CampeonatosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableFilterComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> jogadoresRefs(
    Expression<bool> Function($$JogadoresTableFilterComposer f) f,
  ) {
    final $$JogadoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jogadores,
      getReferencedColumn: (t) => t.timeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JogadoresTableFilterComposer(
            $db: $db,
            $table: $db.jogadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> classificacoesRefs(
    Expression<bool> Function($$ClassificacoesTableFilterComposer f) f,
  ) {
    final $$ClassificacoesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classificacoes,
      getReferencedColumn: (t) => t.timeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassificacoesTableFilterComposer(
            $db: $db,
            $table: $db.classificacoes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventosPartidasRefs(
    Expression<bool> Function($$EventosPartidasTableFilterComposer f) f,
  ) {
    final $$EventosPartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventosPartidas,
      getReferencedColumn: (t) => t.timeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventosPartidasTableFilterComposer(
            $db: $db,
            $table: $db.eventosPartidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TimesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimesTable> {
  $$TimesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localidade => $composableBuilder(
    column: $table.localidade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get escudoUrl => $composableBuilder(
    column: $table.escudoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$CampeonatosTableOrderingComposer get campeonatoId {
    final $$CampeonatosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableOrderingComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimesTable> {
  $$TimesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get localidade => $composableBuilder(
    column: $table.localidade,
    builder: (column) => column,
  );

  GeneratedColumn<String> get escudoUrl =>
      $composableBuilder(column: $table.escudoUrl, builder: (column) => column);

  $$CampeonatosTableAnnotationComposer get campeonatoId {
    final $$CampeonatosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableAnnotationComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> jogadoresRefs<T extends Object>(
    Expression<T> Function($$JogadoresTableAnnotationComposer a) f,
  ) {
    final $$JogadoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jogadores,
      getReferencedColumn: (t) => t.timeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JogadoresTableAnnotationComposer(
            $db: $db,
            $table: $db.jogadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> classificacoesRefs<T extends Object>(
    Expression<T> Function($$ClassificacoesTableAnnotationComposer a) f,
  ) {
    final $$ClassificacoesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classificacoes,
      getReferencedColumn: (t) => t.timeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassificacoesTableAnnotationComposer(
            $db: $db,
            $table: $db.classificacoes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventosPartidasRefs<T extends Object>(
    Expression<T> Function($$EventosPartidasTableAnnotationComposer a) f,
  ) {
    final $$EventosPartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventosPartidas,
      getReferencedColumn: (t) => t.timeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventosPartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.eventosPartidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TimesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimesTable,
          Time,
          $$TimesTableFilterComposer,
          $$TimesTableOrderingComposer,
          $$TimesTableAnnotationComposer,
          $$TimesTableCreateCompanionBuilder,
          $$TimesTableUpdateCompanionBuilder,
          (Time, $$TimesTableReferences),
          Time,
          PrefetchHooks Function({
            bool campeonatoId,
            bool jogadoresRefs,
            bool classificacoesRefs,
            bool eventosPartidasRefs,
          })
        > {
  $$TimesTableTableManager(_$AppDatabase db, $TimesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> localidade = const Value.absent(),
                Value<String?> escudoUrl = const Value.absent(),
                Value<int> campeonatoId = const Value.absent(),
              }) => TimesCompanion(
                id: id,
                nome: nome,
                localidade: localidade,
                escudoUrl: escudoUrl,
                campeonatoId: campeonatoId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String localidade,
                Value<String?> escudoUrl = const Value.absent(),
                required int campeonatoId,
              }) => TimesCompanion.insert(
                id: id,
                nome: nome,
                localidade: localidade,
                escudoUrl: escudoUrl,
                campeonatoId: campeonatoId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TimesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                campeonatoId = false,
                jogadoresRefs = false,
                classificacoesRefs = false,
                eventosPartidasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (jogadoresRefs) db.jogadores,
                    if (classificacoesRefs) db.classificacoes,
                    if (eventosPartidasRefs) db.eventosPartidas,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (campeonatoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.campeonatoId,
                                    referencedTable: $$TimesTableReferences
                                        ._campeonatoIdTable(db),
                                    referencedColumn: $$TimesTableReferences
                                        ._campeonatoIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (jogadoresRefs)
                        await $_getPrefetchedData<Time, $TimesTable, Jogadore>(
                          currentTable: table,
                          referencedTable: $$TimesTableReferences
                              ._jogadoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TimesTableReferences(
                                db,
                                table,
                                p0,
                              ).jogadoresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.timeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (classificacoesRefs)
                        await $_getPrefetchedData<
                          Time,
                          $TimesTable,
                          Classificacoe
                        >(
                          currentTable: table,
                          referencedTable: $$TimesTableReferences
                              ._classificacoesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TimesTableReferences(
                                db,
                                table,
                                p0,
                              ).classificacoesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.timeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventosPartidasRefs)
                        await $_getPrefetchedData<
                          Time,
                          $TimesTable,
                          EventosPartida
                        >(
                          currentTable: table,
                          referencedTable: $$TimesTableReferences
                              ._eventosPartidasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TimesTableReferences(
                                db,
                                table,
                                p0,
                              ).eventosPartidasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.timeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TimesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimesTable,
      Time,
      $$TimesTableFilterComposer,
      $$TimesTableOrderingComposer,
      $$TimesTableAnnotationComposer,
      $$TimesTableCreateCompanionBuilder,
      $$TimesTableUpdateCompanionBuilder,
      (Time, $$TimesTableReferences),
      Time,
      PrefetchHooks Function({
        bool campeonatoId,
        bool jogadoresRefs,
        bool classificacoesRefs,
        bool eventosPartidasRefs,
      })
    >;
typedef $$JogadoresTableCreateCompanionBuilder =
    JogadoresCompanion Function({
      Value<int> id,
      required String nome,
      Value<int?> numero,
      required String posicao,
      required int timeId,
    });
typedef $$JogadoresTableUpdateCompanionBuilder =
    JogadoresCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<int?> numero,
      Value<String> posicao,
      Value<int> timeId,
    });

final class $$JogadoresTableReferences
    extends BaseReferences<_$AppDatabase, $JogadoresTable, Jogadore> {
  $$JogadoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TimesTable _timeIdTable(_$AppDatabase db) => db.times.createAlias(
    $_aliasNameGenerator(db.jogadores.timeId, db.times.id),
  );

  $$TimesTableProcessedTableManager get timeId {
    final $_column = $_itemColumn<int>('time_id')!;

    final manager = $$TimesTableTableManager(
      $_db,
      $_db.times,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventosPartidasTable, List<EventosPartida>>
  _eventosPartidasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventosPartidas,
    aliasName: $_aliasNameGenerator(
      db.jogadores.id,
      db.eventosPartidas.jogadorId,
    ),
  );

  $$EventosPartidasTableProcessedTableManager get eventosPartidasRefs {
    final manager = $$EventosPartidasTableTableManager(
      $_db,
      $_db.eventosPartidas,
    ).filter((f) => f.jogadorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventosPartidasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JogadoresTableFilterComposer
    extends Composer<_$AppDatabase, $JogadoresTable> {
  $$JogadoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posicao => $composableBuilder(
    column: $table.posicao,
    builder: (column) => ColumnFilters(column),
  );

  $$TimesTableFilterComposer get timeId {
    final $$TimesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableFilterComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventosPartidasRefs(
    Expression<bool> Function($$EventosPartidasTableFilterComposer f) f,
  ) {
    final $$EventosPartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventosPartidas,
      getReferencedColumn: (t) => t.jogadorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventosPartidasTableFilterComposer(
            $db: $db,
            $table: $db.eventosPartidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JogadoresTableOrderingComposer
    extends Composer<_$AppDatabase, $JogadoresTable> {
  $$JogadoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posicao => $composableBuilder(
    column: $table.posicao,
    builder: (column) => ColumnOrderings(column),
  );

  $$TimesTableOrderingComposer get timeId {
    final $$TimesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableOrderingComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JogadoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $JogadoresTable> {
  $$JogadoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<int> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get posicao =>
      $composableBuilder(column: $table.posicao, builder: (column) => column);

  $$TimesTableAnnotationComposer get timeId {
    final $$TimesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableAnnotationComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventosPartidasRefs<T extends Object>(
    Expression<T> Function($$EventosPartidasTableAnnotationComposer a) f,
  ) {
    final $$EventosPartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventosPartidas,
      getReferencedColumn: (t) => t.jogadorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventosPartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.eventosPartidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JogadoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JogadoresTable,
          Jogadore,
          $$JogadoresTableFilterComposer,
          $$JogadoresTableOrderingComposer,
          $$JogadoresTableAnnotationComposer,
          $$JogadoresTableCreateCompanionBuilder,
          $$JogadoresTableUpdateCompanionBuilder,
          (Jogadore, $$JogadoresTableReferences),
          Jogadore,
          PrefetchHooks Function({bool timeId, bool eventosPartidasRefs})
        > {
  $$JogadoresTableTableManager(_$AppDatabase db, $JogadoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JogadoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JogadoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JogadoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<int?> numero = const Value.absent(),
                Value<String> posicao = const Value.absent(),
                Value<int> timeId = const Value.absent(),
              }) => JogadoresCompanion(
                id: id,
                nome: nome,
                numero: numero,
                posicao: posicao,
                timeId: timeId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                Value<int?> numero = const Value.absent(),
                required String posicao,
                required int timeId,
              }) => JogadoresCompanion.insert(
                id: id,
                nome: nome,
                numero: numero,
                posicao: posicao,
                timeId: timeId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JogadoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({timeId = false, eventosPartidasRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventosPartidasRefs) db.eventosPartidas,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (timeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.timeId,
                                    referencedTable: $$JogadoresTableReferences
                                        ._timeIdTable(db),
                                    referencedColumn: $$JogadoresTableReferences
                                        ._timeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventosPartidasRefs)
                        await $_getPrefetchedData<
                          Jogadore,
                          $JogadoresTable,
                          EventosPartida
                        >(
                          currentTable: table,
                          referencedTable: $$JogadoresTableReferences
                              ._eventosPartidasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JogadoresTableReferences(
                                db,
                                table,
                                p0,
                              ).eventosPartidasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.jogadorId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JogadoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JogadoresTable,
      Jogadore,
      $$JogadoresTableFilterComposer,
      $$JogadoresTableOrderingComposer,
      $$JogadoresTableAnnotationComposer,
      $$JogadoresTableCreateCompanionBuilder,
      $$JogadoresTableUpdateCompanionBuilder,
      (Jogadore, $$JogadoresTableReferences),
      Jogadore,
      PrefetchHooks Function({bool timeId, bool eventosPartidasRefs})
    >;
typedef $$PartidasTableCreateCompanionBuilder =
    PartidasCompanion Function({
      Value<int> id,
      required int campeonatoId,
      required int rodada,
      required int timeMandanteId,
      required int timeVisitanteId,
      Value<DateTime?> data,
      Value<String?> horario,
      Value<String?> local,
      required String status,
    });
typedef $$PartidasTableUpdateCompanionBuilder =
    PartidasCompanion Function({
      Value<int> id,
      Value<int> campeonatoId,
      Value<int> rodada,
      Value<int> timeMandanteId,
      Value<int> timeVisitanteId,
      Value<DateTime?> data,
      Value<String?> horario,
      Value<String?> local,
      Value<String> status,
    });

final class $$PartidasTableReferences
    extends BaseReferences<_$AppDatabase, $PartidasTable, Partida> {
  $$PartidasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CampeonatosTable _campeonatoIdTable(_$AppDatabase db) =>
      db.campeonatos.createAlias(
        $_aliasNameGenerator(db.partidas.campeonatoId, db.campeonatos.id),
      );

  $$CampeonatosTableProcessedTableManager get campeonatoId {
    final $_column = $_itemColumn<int>('campeonato_id')!;

    final manager = $$CampeonatosTableTableManager(
      $_db,
      $_db.campeonatos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campeonatoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TimesTable _timeMandanteIdTable(_$AppDatabase db) =>
      db.times.createAlias(
        $_aliasNameGenerator(db.partidas.timeMandanteId, db.times.id),
      );

  $$TimesTableProcessedTableManager get timeMandanteId {
    final $_column = $_itemColumn<int>('time_mandante_id')!;

    final manager = $$TimesTableTableManager(
      $_db,
      $_db.times,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeMandanteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TimesTable _timeVisitanteIdTable(_$AppDatabase db) =>
      db.times.createAlias(
        $_aliasNameGenerator(db.partidas.timeVisitanteId, db.times.id),
      );

  $$TimesTableProcessedTableManager get timeVisitanteId {
    final $_column = $_itemColumn<int>('time_visitante_id')!;

    final manager = $$TimesTableTableManager(
      $_db,
      $_db.times,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeVisitanteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventosPartidasTable, List<EventosPartida>>
  _eventosPartidasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventosPartidas,
    aliasName: $_aliasNameGenerator(
      db.partidas.id,
      db.eventosPartidas.partidaId,
    ),
  );

  $$EventosPartidasTableProcessedTableManager get eventosPartidasRefs {
    final manager = $$EventosPartidasTableTableManager(
      $_db,
      $_db.eventosPartidas,
    ).filter((f) => f.partidaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventosPartidasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ResultadosTable, List<Resultado>>
  _resultadosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.resultados,
    aliasName: $_aliasNameGenerator(db.partidas.id, db.resultados.partidaId),
  );

  $$ResultadosTableProcessedTableManager get resultadosRefs {
    final manager = $$ResultadosTableTableManager(
      $_db,
      $_db.resultados,
    ).filter((f) => f.partidaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_resultadosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PartidasTableFilterComposer
    extends Composer<_$AppDatabase, $PartidasTable> {
  $$PartidasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rodada => $composableBuilder(
    column: $table.rodada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get horario => $composableBuilder(
    column: $table.horario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get local => $composableBuilder(
    column: $table.local,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$CampeonatosTableFilterComposer get campeonatoId {
    final $$CampeonatosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableFilterComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableFilterComposer get timeMandanteId {
    final $$TimesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeMandanteId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableFilterComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableFilterComposer get timeVisitanteId {
    final $$TimesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeVisitanteId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableFilterComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventosPartidasRefs(
    Expression<bool> Function($$EventosPartidasTableFilterComposer f) f,
  ) {
    final $$EventosPartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventosPartidas,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventosPartidasTableFilterComposer(
            $db: $db,
            $table: $db.eventosPartidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> resultadosRefs(
    Expression<bool> Function($$ResultadosTableFilterComposer f) f,
  ) {
    final $$ResultadosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultados,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultadosTableFilterComposer(
            $db: $db,
            $table: $db.resultados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartidasTableOrderingComposer
    extends Composer<_$AppDatabase, $PartidasTable> {
  $$PartidasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rodada => $composableBuilder(
    column: $table.rodada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horario => $composableBuilder(
    column: $table.horario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get local => $composableBuilder(
    column: $table.local,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$CampeonatosTableOrderingComposer get campeonatoId {
    final $$CampeonatosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableOrderingComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableOrderingComposer get timeMandanteId {
    final $$TimesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeMandanteId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableOrderingComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableOrderingComposer get timeVisitanteId {
    final $$TimesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeVisitanteId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableOrderingComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartidasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartidasTable> {
  $$PartidasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rodada =>
      $composableBuilder(column: $table.rodada, builder: (column) => column);

  GeneratedColumn<DateTime> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get horario =>
      $composableBuilder(column: $table.horario, builder: (column) => column);

  GeneratedColumn<String> get local =>
      $composableBuilder(column: $table.local, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$CampeonatosTableAnnotationComposer get campeonatoId {
    final $$CampeonatosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableAnnotationComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableAnnotationComposer get timeMandanteId {
    final $$TimesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeMandanteId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableAnnotationComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableAnnotationComposer get timeVisitanteId {
    final $$TimesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeVisitanteId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableAnnotationComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventosPartidasRefs<T extends Object>(
    Expression<T> Function($$EventosPartidasTableAnnotationComposer a) f,
  ) {
    final $$EventosPartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventosPartidas,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventosPartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.eventosPartidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> resultadosRefs<T extends Object>(
    Expression<T> Function($$ResultadosTableAnnotationComposer a) f,
  ) {
    final $$ResultadosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultados,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultadosTableAnnotationComposer(
            $db: $db,
            $table: $db.resultados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartidasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartidasTable,
          Partida,
          $$PartidasTableFilterComposer,
          $$PartidasTableOrderingComposer,
          $$PartidasTableAnnotationComposer,
          $$PartidasTableCreateCompanionBuilder,
          $$PartidasTableUpdateCompanionBuilder,
          (Partida, $$PartidasTableReferences),
          Partida,
          PrefetchHooks Function({
            bool campeonatoId,
            bool timeMandanteId,
            bool timeVisitanteId,
            bool eventosPartidasRefs,
            bool resultadosRefs,
          })
        > {
  $$PartidasTableTableManager(_$AppDatabase db, $PartidasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartidasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartidasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartidasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> campeonatoId = const Value.absent(),
                Value<int> rodada = const Value.absent(),
                Value<int> timeMandanteId = const Value.absent(),
                Value<int> timeVisitanteId = const Value.absent(),
                Value<DateTime?> data = const Value.absent(),
                Value<String?> horario = const Value.absent(),
                Value<String?> local = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => PartidasCompanion(
                id: id,
                campeonatoId: campeonatoId,
                rodada: rodada,
                timeMandanteId: timeMandanteId,
                timeVisitanteId: timeVisitanteId,
                data: data,
                horario: horario,
                local: local,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int campeonatoId,
                required int rodada,
                required int timeMandanteId,
                required int timeVisitanteId,
                Value<DateTime?> data = const Value.absent(),
                Value<String?> horario = const Value.absent(),
                Value<String?> local = const Value.absent(),
                required String status,
              }) => PartidasCompanion.insert(
                id: id,
                campeonatoId: campeonatoId,
                rodada: rodada,
                timeMandanteId: timeMandanteId,
                timeVisitanteId: timeVisitanteId,
                data: data,
                horario: horario,
                local: local,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PartidasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                campeonatoId = false,
                timeMandanteId = false,
                timeVisitanteId = false,
                eventosPartidasRefs = false,
                resultadosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventosPartidasRefs) db.eventosPartidas,
                    if (resultadosRefs) db.resultados,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (campeonatoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.campeonatoId,
                                    referencedTable: $$PartidasTableReferences
                                        ._campeonatoIdTable(db),
                                    referencedColumn: $$PartidasTableReferences
                                        ._campeonatoIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (timeMandanteId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.timeMandanteId,
                                    referencedTable: $$PartidasTableReferences
                                        ._timeMandanteIdTable(db),
                                    referencedColumn: $$PartidasTableReferences
                                        ._timeMandanteIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (timeVisitanteId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.timeVisitanteId,
                                    referencedTable: $$PartidasTableReferences
                                        ._timeVisitanteIdTable(db),
                                    referencedColumn: $$PartidasTableReferences
                                        ._timeVisitanteIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventosPartidasRefs)
                        await $_getPrefetchedData<
                          Partida,
                          $PartidasTable,
                          EventosPartida
                        >(
                          currentTable: table,
                          referencedTable: $$PartidasTableReferences
                              ._eventosPartidasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PartidasTableReferences(
                                db,
                                table,
                                p0,
                              ).eventosPartidasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.partidaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (resultadosRefs)
                        await $_getPrefetchedData<
                          Partida,
                          $PartidasTable,
                          Resultado
                        >(
                          currentTable: table,
                          referencedTable: $$PartidasTableReferences
                              ._resultadosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PartidasTableReferences(
                                db,
                                table,
                                p0,
                              ).resultadosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.partidaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PartidasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartidasTable,
      Partida,
      $$PartidasTableFilterComposer,
      $$PartidasTableOrderingComposer,
      $$PartidasTableAnnotationComposer,
      $$PartidasTableCreateCompanionBuilder,
      $$PartidasTableUpdateCompanionBuilder,
      (Partida, $$PartidasTableReferences),
      Partida,
      PrefetchHooks Function({
        bool campeonatoId,
        bool timeMandanteId,
        bool timeVisitanteId,
        bool eventosPartidasRefs,
        bool resultadosRefs,
      })
    >;
typedef $$ClassificacoesTableCreateCompanionBuilder =
    ClassificacoesCompanion Function({
      Value<int> id,
      required int campeonatoId,
      required int timeId,
      required int pontos,
      required int jogos,
      required int vitorias,
      required int empates,
      required int derrotas,
      required int golsPro,
      required int golsContra,
    });
typedef $$ClassificacoesTableUpdateCompanionBuilder =
    ClassificacoesCompanion Function({
      Value<int> id,
      Value<int> campeonatoId,
      Value<int> timeId,
      Value<int> pontos,
      Value<int> jogos,
      Value<int> vitorias,
      Value<int> empates,
      Value<int> derrotas,
      Value<int> golsPro,
      Value<int> golsContra,
    });

final class $$ClassificacoesTableReferences
    extends BaseReferences<_$AppDatabase, $ClassificacoesTable, Classificacoe> {
  $$ClassificacoesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CampeonatosTable _campeonatoIdTable(_$AppDatabase db) =>
      db.campeonatos.createAlias(
        $_aliasNameGenerator(db.classificacoes.campeonatoId, db.campeonatos.id),
      );

  $$CampeonatosTableProcessedTableManager get campeonatoId {
    final $_column = $_itemColumn<int>('campeonato_id')!;

    final manager = $$CampeonatosTableTableManager(
      $_db,
      $_db.campeonatos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campeonatoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TimesTable _timeIdTable(_$AppDatabase db) => db.times.createAlias(
    $_aliasNameGenerator(db.classificacoes.timeId, db.times.id),
  );

  $$TimesTableProcessedTableManager get timeId {
    final $_column = $_itemColumn<int>('time_id')!;

    final manager = $$TimesTableTableManager(
      $_db,
      $_db.times,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ClassificacoesTableFilterComposer
    extends Composer<_$AppDatabase, $ClassificacoesTable> {
  $$ClassificacoesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pontos => $composableBuilder(
    column: $table.pontos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jogos => $composableBuilder(
    column: $table.jogos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vitorias => $composableBuilder(
    column: $table.vitorias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get empates => $composableBuilder(
    column: $table.empates,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get derrotas => $composableBuilder(
    column: $table.derrotas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get golsPro => $composableBuilder(
    column: $table.golsPro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get golsContra => $composableBuilder(
    column: $table.golsContra,
    builder: (column) => ColumnFilters(column),
  );

  $$CampeonatosTableFilterComposer get campeonatoId {
    final $$CampeonatosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableFilterComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableFilterComposer get timeId {
    final $$TimesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableFilterComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassificacoesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassificacoesTable> {
  $$ClassificacoesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pontos => $composableBuilder(
    column: $table.pontos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jogos => $composableBuilder(
    column: $table.jogos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vitorias => $composableBuilder(
    column: $table.vitorias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get empates => $composableBuilder(
    column: $table.empates,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get derrotas => $composableBuilder(
    column: $table.derrotas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get golsPro => $composableBuilder(
    column: $table.golsPro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get golsContra => $composableBuilder(
    column: $table.golsContra,
    builder: (column) => ColumnOrderings(column),
  );

  $$CampeonatosTableOrderingComposer get campeonatoId {
    final $$CampeonatosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableOrderingComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableOrderingComposer get timeId {
    final $$TimesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableOrderingComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassificacoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassificacoesTable> {
  $$ClassificacoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pontos =>
      $composableBuilder(column: $table.pontos, builder: (column) => column);

  GeneratedColumn<int> get jogos =>
      $composableBuilder(column: $table.jogos, builder: (column) => column);

  GeneratedColumn<int> get vitorias =>
      $composableBuilder(column: $table.vitorias, builder: (column) => column);

  GeneratedColumn<int> get empates =>
      $composableBuilder(column: $table.empates, builder: (column) => column);

  GeneratedColumn<int> get derrotas =>
      $composableBuilder(column: $table.derrotas, builder: (column) => column);

  GeneratedColumn<int> get golsPro =>
      $composableBuilder(column: $table.golsPro, builder: (column) => column);

  GeneratedColumn<int> get golsContra => $composableBuilder(
    column: $table.golsContra,
    builder: (column) => column,
  );

  $$CampeonatosTableAnnotationComposer get campeonatoId {
    final $$CampeonatosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campeonatoId,
      referencedTable: $db.campeonatos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampeonatosTableAnnotationComposer(
            $db: $db,
            $table: $db.campeonatos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableAnnotationComposer get timeId {
    final $$TimesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableAnnotationComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassificacoesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassificacoesTable,
          Classificacoe,
          $$ClassificacoesTableFilterComposer,
          $$ClassificacoesTableOrderingComposer,
          $$ClassificacoesTableAnnotationComposer,
          $$ClassificacoesTableCreateCompanionBuilder,
          $$ClassificacoesTableUpdateCompanionBuilder,
          (Classificacoe, $$ClassificacoesTableReferences),
          Classificacoe,
          PrefetchHooks Function({bool campeonatoId, bool timeId})
        > {
  $$ClassificacoesTableTableManager(
    _$AppDatabase db,
    $ClassificacoesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassificacoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassificacoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassificacoesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> campeonatoId = const Value.absent(),
                Value<int> timeId = const Value.absent(),
                Value<int> pontos = const Value.absent(),
                Value<int> jogos = const Value.absent(),
                Value<int> vitorias = const Value.absent(),
                Value<int> empates = const Value.absent(),
                Value<int> derrotas = const Value.absent(),
                Value<int> golsPro = const Value.absent(),
                Value<int> golsContra = const Value.absent(),
              }) => ClassificacoesCompanion(
                id: id,
                campeonatoId: campeonatoId,
                timeId: timeId,
                pontos: pontos,
                jogos: jogos,
                vitorias: vitorias,
                empates: empates,
                derrotas: derrotas,
                golsPro: golsPro,
                golsContra: golsContra,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int campeonatoId,
                required int timeId,
                required int pontos,
                required int jogos,
                required int vitorias,
                required int empates,
                required int derrotas,
                required int golsPro,
                required int golsContra,
              }) => ClassificacoesCompanion.insert(
                id: id,
                campeonatoId: campeonatoId,
                timeId: timeId,
                pontos: pontos,
                jogos: jogos,
                vitorias: vitorias,
                empates: empates,
                derrotas: derrotas,
                golsPro: golsPro,
                golsContra: golsContra,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClassificacoesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({campeonatoId = false, timeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (campeonatoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.campeonatoId,
                                referencedTable: $$ClassificacoesTableReferences
                                    ._campeonatoIdTable(db),
                                referencedColumn:
                                    $$ClassificacoesTableReferences
                                        ._campeonatoIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (timeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.timeId,
                                referencedTable: $$ClassificacoesTableReferences
                                    ._timeIdTable(db),
                                referencedColumn:
                                    $$ClassificacoesTableReferences
                                        ._timeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ClassificacoesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassificacoesTable,
      Classificacoe,
      $$ClassificacoesTableFilterComposer,
      $$ClassificacoesTableOrderingComposer,
      $$ClassificacoesTableAnnotationComposer,
      $$ClassificacoesTableCreateCompanionBuilder,
      $$ClassificacoesTableUpdateCompanionBuilder,
      (Classificacoe, $$ClassificacoesTableReferences),
      Classificacoe,
      PrefetchHooks Function({bool campeonatoId, bool timeId})
    >;
typedef $$EventosPartidasTableCreateCompanionBuilder =
    EventosPartidasCompanion Function({
      Value<int> id,
      required int partidaId,
      required String tipo,
      Value<int?> minuto,
      required int jogadorId,
      required int timeId,
    });
typedef $$EventosPartidasTableUpdateCompanionBuilder =
    EventosPartidasCompanion Function({
      Value<int> id,
      Value<int> partidaId,
      Value<String> tipo,
      Value<int?> minuto,
      Value<int> jogadorId,
      Value<int> timeId,
    });

final class $$EventosPartidasTableReferences
    extends
        BaseReferences<_$AppDatabase, $EventosPartidasTable, EventosPartida> {
  $$EventosPartidasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PartidasTable _partidaIdTable(_$AppDatabase db) =>
      db.partidas.createAlias(
        $_aliasNameGenerator(db.eventosPartidas.partidaId, db.partidas.id),
      );

  $$PartidasTableProcessedTableManager get partidaId {
    final $_column = $_itemColumn<int>('partida_id')!;

    final manager = $$PartidasTableTableManager(
      $_db,
      $_db.partidas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partidaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $JogadoresTable _jogadorIdTable(_$AppDatabase db) =>
      db.jogadores.createAlias(
        $_aliasNameGenerator(db.eventosPartidas.jogadorId, db.jogadores.id),
      );

  $$JogadoresTableProcessedTableManager get jogadorId {
    final $_column = $_itemColumn<int>('jogador_id')!;

    final manager = $$JogadoresTableTableManager(
      $_db,
      $_db.jogadores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jogadorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TimesTable _timeIdTable(_$AppDatabase db) => db.times.createAlias(
    $_aliasNameGenerator(db.eventosPartidas.timeId, db.times.id),
  );

  $$TimesTableProcessedTableManager get timeId {
    final $_column = $_itemColumn<int>('time_id')!;

    final manager = $$TimesTableTableManager(
      $_db,
      $_db.times,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventosPartidasTableFilterComposer
    extends Composer<_$AppDatabase, $EventosPartidasTable> {
  $$EventosPartidasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minuto => $composableBuilder(
    column: $table.minuto,
    builder: (column) => ColumnFilters(column),
  );

  $$PartidasTableFilterComposer get partidaId {
    final $$PartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableFilterComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JogadoresTableFilterComposer get jogadorId {
    final $$JogadoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jogadorId,
      referencedTable: $db.jogadores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JogadoresTableFilterComposer(
            $db: $db,
            $table: $db.jogadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableFilterComposer get timeId {
    final $$TimesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableFilterComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventosPartidasTableOrderingComposer
    extends Composer<_$AppDatabase, $EventosPartidasTable> {
  $$EventosPartidasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minuto => $composableBuilder(
    column: $table.minuto,
    builder: (column) => ColumnOrderings(column),
  );

  $$PartidasTableOrderingComposer get partidaId {
    final $$PartidasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableOrderingComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JogadoresTableOrderingComposer get jogadorId {
    final $$JogadoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jogadorId,
      referencedTable: $db.jogadores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JogadoresTableOrderingComposer(
            $db: $db,
            $table: $db.jogadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableOrderingComposer get timeId {
    final $$TimesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableOrderingComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventosPartidasTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventosPartidasTable> {
  $$EventosPartidasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get minuto =>
      $composableBuilder(column: $table.minuto, builder: (column) => column);

  $$PartidasTableAnnotationComposer get partidaId {
    final $$PartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JogadoresTableAnnotationComposer get jogadorId {
    final $$JogadoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jogadorId,
      referencedTable: $db.jogadores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JogadoresTableAnnotationComposer(
            $db: $db,
            $table: $db.jogadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimesTableAnnotationComposer get timeId {
    final $$TimesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeId,
      referencedTable: $db.times,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimesTableAnnotationComposer(
            $db: $db,
            $table: $db.times,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventosPartidasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventosPartidasTable,
          EventosPartida,
          $$EventosPartidasTableFilterComposer,
          $$EventosPartidasTableOrderingComposer,
          $$EventosPartidasTableAnnotationComposer,
          $$EventosPartidasTableCreateCompanionBuilder,
          $$EventosPartidasTableUpdateCompanionBuilder,
          (EventosPartida, $$EventosPartidasTableReferences),
          EventosPartida,
          PrefetchHooks Function({bool partidaId, bool jogadorId, bool timeId})
        > {
  $$EventosPartidasTableTableManager(
    _$AppDatabase db,
    $EventosPartidasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventosPartidasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventosPartidasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventosPartidasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> partidaId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int?> minuto = const Value.absent(),
                Value<int> jogadorId = const Value.absent(),
                Value<int> timeId = const Value.absent(),
              }) => EventosPartidasCompanion(
                id: id,
                partidaId: partidaId,
                tipo: tipo,
                minuto: minuto,
                jogadorId: jogadorId,
                timeId: timeId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int partidaId,
                required String tipo,
                Value<int?> minuto = const Value.absent(),
                required int jogadorId,
                required int timeId,
              }) => EventosPartidasCompanion.insert(
                id: id,
                partidaId: partidaId,
                tipo: tipo,
                minuto: minuto,
                jogadorId: jogadorId,
                timeId: timeId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventosPartidasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({partidaId = false, jogadorId = false, timeId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (partidaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.partidaId,
                                    referencedTable:
                                        $$EventosPartidasTableReferences
                                            ._partidaIdTable(db),
                                    referencedColumn:
                                        $$EventosPartidasTableReferences
                                            ._partidaIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (jogadorId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.jogadorId,
                                    referencedTable:
                                        $$EventosPartidasTableReferences
                                            ._jogadorIdTable(db),
                                    referencedColumn:
                                        $$EventosPartidasTableReferences
                                            ._jogadorIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (timeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.timeId,
                                    referencedTable:
                                        $$EventosPartidasTableReferences
                                            ._timeIdTable(db),
                                    referencedColumn:
                                        $$EventosPartidasTableReferences
                                            ._timeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$EventosPartidasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventosPartidasTable,
      EventosPartida,
      $$EventosPartidasTableFilterComposer,
      $$EventosPartidasTableOrderingComposer,
      $$EventosPartidasTableAnnotationComposer,
      $$EventosPartidasTableCreateCompanionBuilder,
      $$EventosPartidasTableUpdateCompanionBuilder,
      (EventosPartida, $$EventosPartidasTableReferences),
      EventosPartida,
      PrefetchHooks Function({bool partidaId, bool jogadorId, bool timeId})
    >;
typedef $$ResultadosTableCreateCompanionBuilder =
    ResultadosCompanion Function({
      Value<int> id,
      required int partidaId,
      required int golsMandante,
      required int golsVisitante,
      required int registradoPor,
      required DateTime registradoEm,
    });
typedef $$ResultadosTableUpdateCompanionBuilder =
    ResultadosCompanion Function({
      Value<int> id,
      Value<int> partidaId,
      Value<int> golsMandante,
      Value<int> golsVisitante,
      Value<int> registradoPor,
      Value<DateTime> registradoEm,
    });

final class $$ResultadosTableReferences
    extends BaseReferences<_$AppDatabase, $ResultadosTable, Resultado> {
  $$ResultadosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartidasTable _partidaIdTable(_$AppDatabase db) =>
      db.partidas.createAlias(
        $_aliasNameGenerator(db.resultados.partidaId, db.partidas.id),
      );

  $$PartidasTableProcessedTableManager get partidaId {
    final $_column = $_itemColumn<int>('partida_id')!;

    final manager = $$PartidasTableTableManager(
      $_db,
      $_db.partidas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partidaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _registradoPorTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.resultados.registradoPor, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get registradoPor {
    final $_column = $_itemColumn<int>('registrado_por')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_registradoPorTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ResultadosTableFilterComposer
    extends Composer<_$AppDatabase, $ResultadosTable> {
  $$ResultadosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get golsMandante => $composableBuilder(
    column: $table.golsMandante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get golsVisitante => $composableBuilder(
    column: $table.golsVisitante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registradoEm => $composableBuilder(
    column: $table.registradoEm,
    builder: (column) => ColumnFilters(column),
  );

  $$PartidasTableFilterComposer get partidaId {
    final $$PartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableFilterComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get registradoPor {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.registradoPor,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultadosTableOrderingComposer
    extends Composer<_$AppDatabase, $ResultadosTable> {
  $$ResultadosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get golsMandante => $composableBuilder(
    column: $table.golsMandante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get golsVisitante => $composableBuilder(
    column: $table.golsVisitante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registradoEm => $composableBuilder(
    column: $table.registradoEm,
    builder: (column) => ColumnOrderings(column),
  );

  $$PartidasTableOrderingComposer get partidaId {
    final $$PartidasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableOrderingComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get registradoPor {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.registradoPor,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultadosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResultadosTable> {
  $$ResultadosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get golsMandante => $composableBuilder(
    column: $table.golsMandante,
    builder: (column) => column,
  );

  GeneratedColumn<int> get golsVisitante => $composableBuilder(
    column: $table.golsVisitante,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get registradoEm => $composableBuilder(
    column: $table.registradoEm,
    builder: (column) => column,
  );

  $$PartidasTableAnnotationComposer get partidaId {
    final $$PartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get registradoPor {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.registradoPor,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultadosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResultadosTable,
          Resultado,
          $$ResultadosTableFilterComposer,
          $$ResultadosTableOrderingComposer,
          $$ResultadosTableAnnotationComposer,
          $$ResultadosTableCreateCompanionBuilder,
          $$ResultadosTableUpdateCompanionBuilder,
          (Resultado, $$ResultadosTableReferences),
          Resultado,
          PrefetchHooks Function({bool partidaId, bool registradoPor})
        > {
  $$ResultadosTableTableManager(_$AppDatabase db, $ResultadosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResultadosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResultadosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResultadosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> partidaId = const Value.absent(),
                Value<int> golsMandante = const Value.absent(),
                Value<int> golsVisitante = const Value.absent(),
                Value<int> registradoPor = const Value.absent(),
                Value<DateTime> registradoEm = const Value.absent(),
              }) => ResultadosCompanion(
                id: id,
                partidaId: partidaId,
                golsMandante: golsMandante,
                golsVisitante: golsVisitante,
                registradoPor: registradoPor,
                registradoEm: registradoEm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int partidaId,
                required int golsMandante,
                required int golsVisitante,
                required int registradoPor,
                required DateTime registradoEm,
              }) => ResultadosCompanion.insert(
                id: id,
                partidaId: partidaId,
                golsMandante: golsMandante,
                golsVisitante: golsVisitante,
                registradoPor: registradoPor,
                registradoEm: registradoEm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ResultadosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({partidaId = false, registradoPor = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (partidaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.partidaId,
                                referencedTable: $$ResultadosTableReferences
                                    ._partidaIdTable(db),
                                referencedColumn: $$ResultadosTableReferences
                                    ._partidaIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (registradoPor) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.registradoPor,
                                referencedTable: $$ResultadosTableReferences
                                    ._registradoPorTable(db),
                                referencedColumn: $$ResultadosTableReferences
                                    ._registradoPorTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ResultadosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResultadosTable,
      Resultado,
      $$ResultadosTableFilterComposer,
      $$ResultadosTableOrderingComposer,
      $$ResultadosTableAnnotationComposer,
      $$ResultadosTableCreateCompanionBuilder,
      $$ResultadosTableUpdateCompanionBuilder,
      (Resultado, $$ResultadosTableReferences),
      Resultado,
      PrefetchHooks Function({bool partidaId, bool registradoPor})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$CampeonatosTableTableManager get campeonatos =>
      $$CampeonatosTableTableManager(_db, _db.campeonatos);
  $$TimesTableTableManager get times =>
      $$TimesTableTableManager(_db, _db.times);
  $$JogadoresTableTableManager get jogadores =>
      $$JogadoresTableTableManager(_db, _db.jogadores);
  $$PartidasTableTableManager get partidas =>
      $$PartidasTableTableManager(_db, _db.partidas);
  $$ClassificacoesTableTableManager get classificacoes =>
      $$ClassificacoesTableTableManager(_db, _db.classificacoes);
  $$EventosPartidasTableTableManager get eventosPartidas =>
      $$EventosPartidasTableTableManager(_db, _db.eventosPartidas);
  $$ResultadosTableTableManager get resultados =>
      $$ResultadosTableTableManager(_db, _db.resultados);
}
