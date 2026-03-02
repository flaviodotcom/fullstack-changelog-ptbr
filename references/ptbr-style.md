# Estilo de Escrita para Changelog (PT-BR)

## Objetivo

Padronizar mensagens de changelog em português, com foco em clareza para quem consome a release.

## Princípios

- Escrever frases curtas.
- Destacar o que mudou e o impacto funcional.
- Evitar detalhes internos de implementação sem valor para release notes.

## Estrutura recomendada por item

`- <Verbo no infinitivo> <mudança principal> [contexto mínimo opcional]`

Exemplos:

- `- Adicionar validação de status para impedir transição inválida de solicitação.`
- `- Corrigir filtro de busca por protocolo no endpoint de atendimento.`
- `- Ajustar paginação da listagem para respeitar ordenação por data de criação.`
- `- Melhorar tratamento de erro de autenticação com retorno 401 padronizado.`
- `- Remover campo obsoleto do payload de resposta de usuário.`

## Verbos preferenciais

- Adicionar
- Corrigir
- Ajustar
- Melhorar
- Remover
- Atualizar
- Padronizar
- Otimizar

## Pontuação

- Encerrar toda nova descrição com ponto final (`.`).
- Mesmo que o histórico antigo tenha variação, padronizar novas entradas com `.`.

## Evitar

- Mensagens genéricas: `melhorias gerais`, `ajustes diversos`.
- Frases longas com múltiplas mudanças não relacionadas.
- Inglês misturado sem necessidade.
- Jargões internos sem contexto para o time de produto/negócio.
