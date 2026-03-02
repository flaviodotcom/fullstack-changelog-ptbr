param(
    [string]$Path = "",
    [switch]$CheckAllRows
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-ChangelogPath {
    param([string]$InputPath)

    if ($InputPath -and (Test-Path -LiteralPath $InputPath)) {
        return (Resolve-Path -LiteralPath $InputPath).Path
    }

    if (Test-Path -LiteralPath "changelog.md") {
        return (Resolve-Path -LiteralPath "changelog.md").Path
    }

    if (Test-Path -LiteralPath "CHANGELOG.md") {
        return (Resolve-Path -LiteralPath "CHANGELOG.md").Path
    }

    throw "Arquivo changelog.md/CHANGELOG.md nao encontrado."
}

function Count-Matches {
    param(
        [string]$Text,
        [string]$Pattern
    )

    return ([regex]::Matches($Text, $Pattern, "IgnoreCase")).Count
}

$filePath = Resolve-ChangelogPath -InputPath $Path
$raw = Get-Content -LiteralPath $filePath -Raw
$lines = Get-Content -LiteralPath $filePath

$tableRows = @($lines | Where-Object { $_ -match "^\|\s*\d" })
$rowsToCheck = @()
$scope = ""

if ($tableRows.Count -eq 0) {
    throw "Nenhuma linha de versão encontrada na tabela de changelog."
}

if ($CheckAllRows.IsPresent) {
    $rowsToCheck = $tableRows
    $scope = "arquivo inteiro"
}
else {
    $rowsToCheck = @($tableRows[0])
    $scope = "apenas nova linha (mais recente)"
}

$textForSpellingChecks = ($rowsToCheck -join "`n")
$mojibakeCount = Count-Matches -Text $textForSpellingChecks -Pattern "Ã|Â|�"

$wordChecks = @(
    @{ Wrong = "\bnao\b"; Right = "não" },
    @{ Wrong = "\bversao\b"; Right = "versão" },
    @{ Wrong = "\bdescricao\b"; Right = "descrição" },
    @{ Wrong = "\bproducao\b"; Right = "produção" },
    @{ Wrong = "\bhomologacao\b"; Right = "homologação" },
    @{ Wrong = "\bintegracao\b"; Right = "integração" },
    @{ Wrong = "\bcorrecao\b"; Right = "correção" },
    @{ Wrong = "\busuario\b"; Right = "usuário" },
    @{ Wrong = "\bacao\b"; Right = "ação" }
)

$wrongWordTotal = 0
$wrongWordDetails = @()
foreach ($check in $wordChecks) {
    $count = Count-Matches -Text $textForSpellingChecks -Pattern $check.Wrong
    if ($count -gt 0) {
        $wrongWordTotal += $count
        $wrongWordDetails += "$($check.Wrong) -> $($check.Right): $count"
    }
}

$missingDotRows = @()
foreach ($row in $rowsToCheck) {
    $parts = $row -split "\|"
    if ($parts.Count -ge 4) {
        $description = $parts[2].Trim()
        if ($description.Length -gt 0 -and -not $description.EndsWith(".")) {
            $missingDotRows += $row
        }
    }
}

Write-Output "Arquivo: $filePath"
Write-Output "Rows de versao: $($tableRows.Count)"
Write-Output "Escopo de validacao: $scope"
Write-Output "Mojibake detectado: $mojibakeCount"
Write-Output "Palavras sem acento detectadas: $wrongWordTotal"
Write-Output "Descricoes sem ponto final: $($missingDotRows.Count)"

if ($wrongWordDetails.Count -gt 0) {
    Write-Output ""
    Write-Output "Detalhes de palavras sem acento:"
    $wrongWordDetails | ForEach-Object { Write-Output "- $_" }
}

if ($missingDotRows.Count -gt 0) {
    Write-Output ""
    Write-Output "Exemplos de linhas sem ponto final (max 5):"
    $missingDotRows | Select-Object -First 5 | ForEach-Object { Write-Output "- $_" }
}

if ($mojibakeCount -gt 0 -or $wrongWordTotal -gt 0 -or $missingDotRows.Count -gt 0) {
    exit 1
}

Write-Output "Validacao OK."
exit 0
