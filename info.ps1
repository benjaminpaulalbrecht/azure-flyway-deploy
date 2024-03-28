# Info.ps1
param (

    [string]$License,
    [string]$Config,
    [string]$MigrationFolder,
    [string]$RootPath,
    [string]$Stage
);

# versioning this to 5.1 as it contains workflows{} 
set-version -version 5.1

# Runbook: info 
Workflow Info {

    param (
        [string]$Command
        [string]$License,
        [string]$Config,
        [string]$MigrationFolder,
        [string]$RootPath,
        [string]$Stage
    )
    sequence
    { 

        InlineScript
        {
            
            [System.Environment]::SetEnvironmentVariable("FLYWAY_LICENSE_KEY", $using:License)
            # since this is a PoC, feel free to use something else here to invoke flyway 
            & "C:\Program Files\Flyway\flyway-10.8.1\flyway.cmd" -configFiles='"'$($using:Config)'"' $($Command) -location='"'filesystem:$($using:MigrationFolder)'"' -environment $Stage
        }
    } 
}

$Command = "info"
Info -License $License -Config $Config -MigrationFolder $MigrationFolder -RootPath $RootPath -Stage $Stage -Command $Command;

