function Confirm-Success {
    param([string] $step)

    if ($lastExitCode -ne 0) {
        Write-Host
        Write-Host "$step failed with exit code $lastExitCode" -ForegroundColor Red
        Write-Host
        exit $lastExitCode
    }
}

[string] $script = $PSCommandPath.Split([IO.Path]::DirectorySeparatorChar)[-1];

if (Test-Path -Path $script -PathType Leaf) {
    Write-Host
    Write-Host "Scripts need to be run from the project root, i.e. '.\scripts-ps\$script'" -ForegroundColor Yellow
    Write-Host

    exit -1
}

clear
cargo clean
Confirm-Success "clean"

cargo clippy --all-features
Confirm-Success "clippy"

cargo clippy --release --all-features
Confirm-Success "clippy release"

cargo test --all-features -- --nocapture --test-threads=1
Confirm-Success "test"

cargo test --all-features --release -- --nocapture --test-threads=1
Confirm-Success "test release"

cargo doc --release --no-deps --all-features
Confirm-Success "docs"

cargo build --release --all-features
Confirm-Success "build"
