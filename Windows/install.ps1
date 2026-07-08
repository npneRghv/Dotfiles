<#
.SYNOPSIS
    Symlinks the Windows dotfiles from this repo into their live locations.

.DESCRIPTION
    Single source of truth = this repo. Each live path becomes a symbolic link
    pointing back here, so editing either path edits the same file and `git`
    tracks changes directly (no copy step).

    Creating symlinks on Windows is privileged: run this from an **elevated**
    PowerShell (Run as Administrator) OR enable Developer Mode
    (Settings > Privacy & security > For developers > Developer Mode).

.PARAMETER DryRun
    Show what would happen without changing anything.

.PARAMETER Copy
    Copy files instead of symlinking. Use if you can't elevate / enable
    Developer Mode, or on machines where git didn't preserve symlinks.

.EXAMPLE
    ./install.ps1 -DryRun      # preview
    ./install.ps1              # symlink into place
    ./install.ps1 -Copy        # copy instead of link
#>
[CmdletBinding()]
param(
    [switch]$DryRun,
    [switch]$Copy
)

$ErrorActionPreference = 'Stop'

$WinDir   = $PSScriptRoot                       # ...\Dotfiles\Windows
$RepoRoot = Split-Path -Parent $WinDir          # ...\Dotfiles

# ---------------------------------------------------------------------------
# Link table:  <live path that gets created>  =  <real file/dir in this repo>
# Comment out any line you don't want managed on a given machine.
# ---------------------------------------------------------------------------
$Links = [ordered]@{
    # Neovim / Neovide (whole folder, so future lua/ files come along too)
    "$env:LOCALAPPDATA\nvim"                   = "$WinDir\nvim"

    # VsVim (Visual Studio vim emulation) reads ~\_vsvimrc
    "$env:USERPROFILE\_vsvimrc"                = "$WinDir\_vsvimrc"

    # VS Code shares ONE config with the Linux folder (used on Windows too).
    # Remove these two lines if you keep VS Code settings separate on Windows.
    "$env:APPDATA\Code\User\settings.json"     = "$RepoRoot\Linux\.config\Code\User\settings.json"
    "$env:APPDATA\Code\User\keybindings.json"  = "$RepoRoot\Linux\.config\Code\User\keybindings.json"
}

$stamp   = Get-Date -Format 'yyyyMMdd-HHmmss'
$made = 0; $skipped = 0; $backed = 0

function Test-IsLinkTo($path, $target) {
    $item = Get-Item -LiteralPath $path -Force -ErrorAction SilentlyContinue
    if (-not $item) { return $false }
    if (-not $item.LinkType) { return $false }
    # Normalize both sides for comparison
    return ($item.Target | ForEach-Object { $_.TrimEnd('\') }) -contains $target.TrimEnd('\')
}

foreach ($entry in $Links.GetEnumerator()) {
    $link   = $entry.Key
    $source = $entry.Value

    if (-not (Test-Path -LiteralPath $source)) {
        Write-Warning "source missing, skipping: $source"
        continue
    }

    if (Test-IsLinkTo $link $source) {
        Write-Host "[ ok ] already linked: $link" -ForegroundColor DarkGray
        $skipped++
        continue
    }

    $parent = Split-Path -Parent $link
    if (-not (Test-Path -LiteralPath $parent)) {
        Write-Host "[ mkdir ] $parent" -ForegroundColor Cyan
        if (-not $DryRun) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    }

    # Back up anything real that's already sitting at the live path
    if (Test-Path -LiteralPath $link) {
        $backup = "$link.bak-$stamp"
        Write-Host "[ backup ] $link -> $backup" -ForegroundColor Yellow
        if (-not $DryRun) { Move-Item -LiteralPath $link -Destination $backup -Force }
        $backed++
    }

    if ($Copy) {
        Write-Host "[ copy ] $link  <=  $source" -ForegroundColor Green
        if (-not $DryRun) { Copy-Item -LiteralPath $source -Destination $link -Recurse -Force }
    }
    else {
        Write-Host "[ link ] $link  ->  $source" -ForegroundColor Green
        if (-not $DryRun) {
            try {
                New-Item -ItemType SymbolicLink -Path $link -Target $source -Force | Out-Null
            }
            catch {
                Write-Error @"
Failed to create symlink (need Administrator or Developer Mode).
  $link -> $source
Re-run in an elevated PowerShell, enable Developer Mode, or use:  ./install.ps1 -Copy
Original error: $($_.Exception.Message)
"@
                exit 1
            }
        }
    }
    $made++
}

Write-Host ""
Write-Host ("Done. {0} created, {1} already ok, {2} backed up.{3}" -f `
    $made, $skipped, $backed, ($(if ($DryRun) { '  (dry run — nothing changed)' } else { '' }))) `
    -ForegroundColor Magenta
