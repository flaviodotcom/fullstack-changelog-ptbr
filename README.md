# Fullstack Changelog PT-BR

A Claude Code skill that standardizes changelog updates for frontend and backend projects, with focus on PT-BR release notes quality.

## What it does

This skill provides a reliable workflow for updating `changelog.md` / `CHANGELOG.md` when a version bump is ready. It preserves the existing table format and enforces Portuguese text quality (accents, punctuation, and anti-mojibake checks).

### Standards enforced

- **Release Timing**: Updates changelog only after task completion and version bump
- **Table Pattern**: Preserves Markdown table format (`Versão`, `Descrição`, `Data Homologação`, `Data Produção`)
- **Top Insertion**: Adds the newest version row at the top of the table
- **PT-BR Writing**: Keeps descriptions in Portuguese with objective phrasing
- **Final Punctuation**: Enforces final period (`.`) in new descriptions
- **Text Quality**: Validates accents and detects mojibake issues
- **Frontend + Backend**: Applies same workflow to frontend and backend Java/Quarkus projects
- **Validation Script**: Includes `scripts/validate-changelog-ptbr.ps1` for deterministic checks

## Installation

```bash
npx skills add flaviodotcom/fullstack-changelog-ptbr -g -y
```

Or install manually by copying `SKILL.md` to:

```
~/.claude/skills/fullstack-changelog-ptbr/SKILL.md
```

## When it activates

This skill is automatically used when Claude Code detects you are:

- Updating changelog for a release/version bump
- Maintaining changelog in Markdown table format
- Writing release notes in PT-BR
- Validating text quality (accentuation and encoding)

## License

MIT License - see [LICENSE](LICENSE) for details.
