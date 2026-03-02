# Validação de Qualidade de Texto (PT-BR)

Aplicar esta validação em toda nova linha de changelog antes de salvar.

## 1) Encoding

- Salvar arquivo em UTF-8.
- Evitar conversões de encoding que gerem caracteres inválidos.

## 2) Anti-mojibake

Rejeitar texto que contenha padrões comuns de mojibake:

- `Ã`
- `Â`
- `�`

Se algum padrão aparecer, corrigir o texto antes de concluir.

## 3) Acentuação obrigatória

Conferir e corrigir palavras frequentes:

- não
- versão
- descrição
- produção
- homologação
- integração
- validação
- correção
- usuário
- ação

Exemplos de correção:

- `nao` -> `não`
- `versao` -> `versão`
- `descricao` -> `descrição`
- `producao` -> `produção`

## 4) Pontuação final

- Toda nova descrição deve terminar com ponto final (`.`).

