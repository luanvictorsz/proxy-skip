param(
    [string]$username,
    [string]$password
)

Write-Host "Iniciando atualizacao de tarefas agendadas..."
Write-Host "Usuario: $username"
Write-Host "Senha: $password"
Write-Host "___________________________________________________"

try {
    $tasks = Get-ScheduledTask | Where-Object { $_.Principal.UserId -eq $username }
    
    if (-not $tasks) {
        Write-Host "Nenhuma tarefa encontrada para o usuario $username"
        exit
    }

    foreach ($task in $tasks) {
        $taskName = $task.TaskName
        Write-Host "Atualizando tarefa: $taskName"
        
        $task.Principal.UserId = $username
        $task.Principal.LogonType = "Interactive"
        
        Set-ScheduledTask -InputObject $task -User $username -Password $password -ErrorAction Stop
        Write-Host "Tarefa atualizada com sucesso"
    }

    Write-Host "___________________________________________________"
    Write-Host "TODAS AS TAREFAS FORAM ATUALIZADAS COM SUCESSO!" -ForegroundColor Green
}
catch {
    Write-Host "ERRO: $_" -ForegroundColor Red
    Write-Host "Detalhes: $($_.Exception.Message)" -ForegroundColor Yellow
}

Read-Host "Pressione Enter para sair..."
