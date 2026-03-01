# Backlog Inicial (Issues)

Baseado no documento de requisitos do projeto **Gestão de Ligas**.

## Convenções
- **Prioridade**: P0 (crítica), P1 (alta), P2 (média)
- **Tipo**: Backend, Mobile, Infra, Qualidade
- **RF/NF**: referência aos requisitos do documento

---

## Epic 1 — Fundação técnica e segurança

### ISSUE-001 — Estruturar repositório e padrão de desenvolvimento
- **Prioridade:** P0
- **Tipo:** Infra
- **Relaciona com:** NF15
- **Descrição:** Definir estrutura inicial dos projetos mobile e backend, padrão de branches, template de PR e convenções de commit.
- **Critérios de aceite:**
  - Repositório possui pastas `mobile/`, `backend/`, `docs/`.
  - Documento de contribuição com fluxo de branch/PR está publicado.
  - Pipeline de CI executa lint e testes básicos em PR.

### ISSUE-002 — Configurar ambiente backend Flask + PostgreSQL + migrações
- **Prioridade:** P0
- **Tipo:** Backend
- **Relaciona com:** NF15
- **Descrição:** Criar aplicação Flask modular, conexão com PostgreSQL e migrações versionadas.
- **Critérios de aceite:**
  - Aplicação sobe localmente com variáveis de ambiente.
  - Migração inicial é executada com sucesso em banco limpo.
  - Health-check `/health` retorna `200`.

### ISSUE-003 — Implementar autenticação (login + recuperação de senha)
- **Prioridade:** P0
- **Tipo:** Backend
- **Relaciona com:** RF01, NF09, NF10
- **Descrição:** Implementar login por e-mail/senha, emissão de JWT e fluxo de recuperação de senha.
- **Critérios de aceite:**
  - Login válido retorna token JWT com expiração configurável.
  - Login inválido retorna erro padronizado.
  - Senhas são armazenadas com `bcrypt`.
  - Endpoint de recuperação de senha gera token temporário e permite redefinição.

### ISSUE-004 — Implementar controle de acesso por perfil (RBAC)
- **Prioridade:** P0
- **Tipo:** Backend
- **Relaciona com:** RF02, NF11
- **Descrição:** Restringir endpoints de escrita para perfil Administrador e manter leitura para Analista.
- **Critérios de aceite:**
  - Requisições sem token retornam `401`.
  - Requisições com perfil sem permissão retornam `403`.
  - Endpoints críticos validam perfil em middleware/decorator.

---

## Epic 2 — Domínio de campeonatos

### ISSUE-005 — Modelar entidades e constraints do domínio
- **Prioridade:** P0
- **Tipo:** Backend
- **Relaciona com:** Seção 5, NF12, NF13
- **Descrição:** Criar tabelas e restrições para `Usuario`, `Campeonato`, `Time`, `Jogador`, `Partida`, `Resultado`, `EventoPartida`, `Classificacao`.
- **Critérios de aceite:**
  - Todas as tabelas do modelo estão criadas com FKs.
  - Campos obrigatórios e unicidade essenciais estão validados.
  - Constraints impedem inconsistências básicas (ex.: resultado duplicado por partida).

### ISSUE-006 — CRUD de campeonatos
- **Prioridade:** P0
- **Tipo:** Backend
- **Relaciona com:** RF03
- **Descrição:** Implementar cadastro, edição, listagem e exclusão de campeonatos.
- **Critérios de aceite:**
  - Administrador cria/edita/exclui campeonato.
  - Analista só consegue listar e visualizar.
  - Validações de campos obrigatórios e tipo de competição aplicadas.

### ISSUE-007 — CRUD de times com vínculo ao campeonato
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** RF05, NF13
- **Descrição:** Implementar operações de times com `nome`, `escudo_url`, `localidade` e vínculo ao campeonato.
- **Critérios de aceite:**
  - Time só é criado vinculado a um campeonato existente.
  - Edição e remoção seguem regras de permissão.
  - Erros de validação retornam mensagem por campo.

### ISSUE-008 — CRUD de jogadores por time
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** RF06, NF13
- **Descrição:** Implementar operações de jogadores com `nome`, `posição` e `número` opcional.
- **Critérios de aceite:**
  - Jogador é sempre vinculado a um time válido.
  - Número de camisa é opcional.
  - Operações de escrita restritas a Administrador.

### ISSUE-009 — Cadastro e gestão de partidas
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** RF08
- **Descrição:** Criar e gerenciar partidas com data, horário, local, rodada, times e status.
- **Critérios de aceite:**
  - Partida não permite mesmo time como mandante e visitante.
  - Apenas partidas não finalizadas podem ser editadas/excluídas.
  - Listagem retorna partidas por campeonato e rodada.

### ISSUE-010 — Geração automática de calendário
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** RF07
- **Descrição:** Gerar confrontos para pontos corridos e eliminatória.
- **Critérios de aceite:**
  - Para pontos corridos, não há confronto repetido na mesma rodada.
  - Para eliminatória, chaveamento é válido para número de equipes informado.
  - Calendário é persistido e consultável via API.

---

## Epic 3 — Resultados, classificação e súmula

### ISSUE-011 — Registro de resultado e eventos de partida
- **Prioridade:** P0
- **Tipo:** Backend
- **Relaciona com:** RF04, NF12
- **Descrição:** Permitir registrar placar final e eventos (gol, assistência, cartões).
- **Critérios de aceite:**
  - Resultado só pode ser registrado uma vez por partida.
  - Evento só pode referenciar jogador dos times participantes.
  - Ao finalizar resultado, status da partida muda para `Finalizada`.

### ISSUE-012 — Classificação automática com critérios de desempate
- **Prioridade:** P0
- **Tipo:** Backend
- **Relaciona com:** RF09, NF07
- **Descrição:** Recalcular classificação por pontos, saldo, gols pró e confronto direto.
- **Critérios de aceite:**
  - Classificação é atualizada automaticamente após salvar resultado.
  - Ordem da tabela respeita critérios definidos no requisito.
  - Reprocessamento mantém consistência em cenário de múltiplas partidas.

### ISSUE-013 — Estatísticas por time e jogador
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** RF10
- **Descrição:** Expor estatísticas agregadas para artilharia, assistências, cartões e desempenho dos times.
- **Critérios de aceite:**
  - API retorna estatísticas por campeonato.
  - Valores conferem com eventos e resultados registrados.
  - Endpoint de artilharia ordena por gols (e critério secundário documentado).

### ISSUE-014 — Encerrar campeonato e bloquear novos registros
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** RF14
- **Descrição:** Permitir encerramento formal de campeonato e impedir novos resultados/eventos.
- **Critérios de aceite:**
  - Administrador consegue encerrar campeonato e registrar campeão.
  - Após encerramento, tentativas de registrar resultado/evento retornam erro de negócio.
  - Dados continuam disponíveis para consulta histórica.

### ISSUE-015 — Gerar e consultar súmula eletrônica
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** RF16
- **Descrição:** Consolidar dados da partida finalizada em visão de súmula.
- **Critérios de aceite:**
  - Endpoint retorna data/local/times/placar/eventos/escalações.
  - Súmula é somente leitura para todos os perfis.
  - Partidas sem resultado não exibem súmula final.

---

## Epic 4 — Aplicativo mobile (Flutter)

### ISSUE-016 — Tela de autenticação
- **Prioridade:** P0
- **Tipo:** Mobile
- **Relaciona com:** RF01, NF03
- **Descrição:** Implementar UI de login com validação, feedback de erro e estado de carregamento.
- **Critérios de aceite:**
  - Campos de e-mail/senha com validação.
  - Botão `Entrar` desabilitado durante requisição.
  - Erros aparecem em mensagem padronizada e amigável.

### ISSUE-017 — Tela principal de campeonatos
- **Prioridade:** P0
- **Tipo:** Mobile
- **Relaciona com:** RF03, RF11, RF15
- **Descrição:** Exibir lista de campeonatos com status, busca por nome e logout.
- **Critérios de aceite:**
  - Listagem carrega e atualiza via API.
  - Busca filtra resultados conforme digitação.
  - Botão de criação visível apenas para Administrador.

### ISSUE-018 — Painel do campeonato com abas principais
- **Prioridade:** P1
- **Tipo:** Mobile
- **Relaciona com:** RF08, RF09, RF10, RF05
- **Descrição:** Implementar abas de classificação, partidas, artilharia e times.
- **Critérios de aceite:**
  - Abas carregam dados corretos por campeonato.
  - Partidas finalizadas exibem placar, pendentes exibem `x`.
  - Navegação entre abas mantém estado básico.

### ISSUE-019 — Tela de registro de resultado (Administrador)
- **Prioridade:** P1
- **Tipo:** Mobile
- **Relaciona com:** RF04, NF04
- **Descrição:** Tela para informar placar, adicionar/remover eventos e finalizar partida com confirmação.
- **Critérios de aceite:**
  - Somente Administrador acessa a tela.
  - Confirmação explícita antes de finalizar.
  - Após sucesso, classificação é atualizada na UI.

### ISSUE-020 — Ficha do time, histórico e súmula
- **Prioridade:** P2
- **Tipo:** Mobile
- **Relaciona com:** RF13, RF16
- **Descrição:** Exibir detalhes do time, histórico de partidas e tela de súmula de partida finalizada.
- **Critérios de aceite:**
  - Ficha mostra estatísticas e elenco.
  - Histórico lista partidas com data/adversário/placar.
  - Súmula abre em modo somente leitura.

---

## Epic 5 — Qualidade, desempenho e operação

### ISSUE-021 — Testes automatizados de regras críticas
- **Prioridade:** P0
- **Tipo:** Qualidade
- **Relaciona com:** NF12, NF13
- **Descrição:** Criar testes unitários/integrados para autenticação, permissão, resultado e classificação.
- **Critérios de aceite:**
  - Cobertura mínima de 70% no backend.
  - Casos críticos de negócio cobertos com testes de regressão.
  - CI bloqueia merge em caso de falha de teste.

### ISSUE-022 — Observabilidade e tratamento de erros
- **Prioridade:** P1
- **Tipo:** Backend
- **Relaciona com:** NF03, NF14
- **Descrição:** Padronizar respostas de erro, logs estruturados e rastreio de falhas de integração.
- **Critérios de aceite:**
  - Erros retornam payload padronizado (`code`, `message`, `details`).
  - Logs incluem correlação por `request_id`.
  - Falhas de conexão no app apresentam mensagem amigável e preservam formulário.

### ISSUE-023 — Metas de desempenho e teste de carga
- **Prioridade:** P1
- **Tipo:** Qualidade
- **Relaciona com:** NF06, NF07, NF08
- **Descrição:** Validar SLA de resposta e atualização da classificação com teste de carga controlado.
- **Critérios de aceite:**
  - Listagens principais respondem em < 2s no cenário definido.
  - Recalcular classificação ocorre em até 1s após resultado.
  - Backend suporta 50 requisições simultâneas sem degradação > 30%.

---

## Sugestão de priorização por sprint

### Sprint 1 (fundação + segurança)
`ISSUE-001` a `ISSUE-006` + `ISSUE-016` + `ISSUE-021`

### Sprint 2 (fluxo fim a fim)
`ISSUE-007` a `ISSUE-013` + `ISSUE-017` a `ISSUE-019`

### Sprint 3 (fechamento MVP + robustez)
`ISSUE-014`, `ISSUE-015`, `ISSUE-020`, `ISSUE-022`, `ISSUE-023`

---

## Definição de pronto (DoD)
- Código revisado em PR.
- Testes passando na CI.
- Documentação da API atualizada quando houver alteração de contrato.
- Validação de permissão e tratamento de erro aplicados nos endpoints novos.
