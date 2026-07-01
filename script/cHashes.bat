@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

set "SCRIPTNAME=%~nx0"
set "FOLDER=%~dp0"

:MenuPrincipal
cls
echo ============================================================
echo   🔐 SISTEMA DE COLETA DE HASHES SHA256 E MD5
echo   🔗 https://ravenastar.com/cmd/cHashes.bat
echo ============================================================
echo.
echo   Este sistema irá gerar hashes SHA256 e MD5 de todos os
echo   arquivos da pasta atual e suas subpastas.
echo.
echo   [ 1 ] ▷ Iniciar coleta
echo   [ 2 ] 📖 Guia do script
echo   [ 3 ] ❌ Sair
echo.
echo ============================================================
choice /c 123 /n /m "Opção: "
if errorlevel 3 goto Sair
if errorlevel 2 goto GuiaSistema
if errorlevel 1 goto ColetarTodos
goto MenuPrincipal

:GuiaSistema
cls
echo ============================================================
echo   📖 GUIA DO SCRIPT - Coleta de Hashes SHA256 e MD5
echo   🔗 https://ravenastar.com/cmd/cHashes.bat
echo ============================================================
echo.
echo ═══════════════════════════════════════════════════════════════
echo  🎯 OBJETIVO DO SISTEMA
echo ═══════════════════════════════════════════════════════════════
echo.
echo  Este script foi desenvolvido para coletar e documentar
echo  hashes SHA256 e MD5 de todos os arquivos em uma pasta e suas
echo  subpastas, gerando um relatório detalhado para fins de
echo  auditoria e verificação de integridade.
echo.
echo ═══════════════════════════════════════════════════════════════
echo  ⚖️ NORMAS E REFERÊNCIAS APLICADAS
echo ═══════════════════════════════════════════════════════════════
echo.
echo  📜 Boas práticas de preservação de integridade de arquivos
echo     por meio de hashing SHA-256 e MD5
echo.
echo  📜 NIST IR 8387 - Guia para investigação digital e
echo     preservação de evidências
echo.
echo  📜 Art. 159, § 4º do CPP - Assistência Técnica
echo     em Perícias Digitais
echo.
echo ═══════════════════════════════════════════════════════════════
echo  🔍 COMO FUNCIONA
echo ═══════════════════════════════════════════════════════════════
echo.
echo  [ 1 ] O script percorre recursivamente a pasta atual
echo  [ 2 ] Para cada arquivo encontrado, calcula os hashes SHA256 e MD5
echo  [ 3 ] Gera um relatório com informações detalhadas
echo  [ 4 ] Exclui automaticamente o próprio script e o relatório
echo  [ 5 ] Apresenta estatísticas de processamento
echo.
echo  O relatório gerado contém:
echo  • Cabeçalho com informações do sistema e data/hora
echo  • Normas e referências técnicas aplicadas
echo  • Para cada arquivo processado:
echo    - Caminho relativo do arquivo
echo    - Tamanho em bytes
echo    - Data da última modificação
echo    - Hash SHA256 calculado
echo    - Hash MD5 calculado
echo  • Estatísticas ao final
echo.
echo ═══════════════════════════════════════════════════════════════
echo  🔐 SOBRE A VERIFACT®
echo ═══════════════════════════════════════════════════════════════
echo.
echo  🌐 Site: https://www.verifact.com.br/
echo.
echo  A Verifact® é uma plataforma especializada na coleta e
echo  preservação de evidências digitais na internet, oferecendo
echo  uma base sólida para apoiar processos judiciais.
echo.
echo  🎯 Finalidade:
echo     • Registrar provas da internet com validade jurídica
echo     • Coletar evidências de WhatsApp, Facebook, Instagram,
echo       Twitter, Telegram, YouTube, webmails, blogs e sites
echo     • Alternativa moderna à ata notarial
echo.
echo  🛡️ Diferenciais da Verifact®:
echo     • Aceitação em todas as instâncias do judiciário
echo     • Ambiente antifraude patenteado
echo     • Atestada por órgãos públicos
echo     • Cumpre cadeia de custódia (CPP) e ISO 27037
echo     • Relatórios a partir de R$97, sem assinatura obrigatória
echo.
echo  🔒 Como preserva a integridade:
echo     1. Gera relatório técnico certificado em PDF
echo     2. Utiliza carimbo de tempo ICP-Brasil
echo     3. Registra códigos HASH de todos os arquivos
echo     4. Mantém vídeo da navegação e metadados técnicos
echo.
echo  📊 Conteúdos que podem ser registrados:
echo     • Aplicativos de chat (WhatsApp, Telegram)
echo     • Redes sociais (Facebook, Instagram, TikTok, Twitter)
echo     • E-mails (Outlook, Gmail, Hotmail)
echo     • Vídeos (YouTube, Vimeo)
echo     • Blogs, sites e portais de notícias
echo     • Qualquer conteúdo da internet via browser
echo.
echo ═══════════════════════════════════════════════════════════════
echo  ⚠️ IMPORTANTE
echo ═══════════════════════════════════════════════════════════════
echo.
echo  🚀 O script foi projetado para ser executado em:
echo     • Windows 7, 8, 10, 11
echo     • Windows Server 2008 em diante
echo.
echo  💡 Dicas importantes:
echo     • Execute como administrador para melhor desempenho
echo     • Não mova arquivos durante o processo
echo     • O relatório será salvo na mesma pasta
echo     • Arquivos grandes podem demorar mais tempo
echo.
echo  ❗ Limitações:
echo     • O script não processa arquivos de sistema
echo     • Alguns arquivos podem estar bloqueados
echo     • Pastas vazias não são processadas
echo.
echo  📁 Pasta de execução: %FOLDER%
echo.
echo ═══════════════════════════════════════════════════════════════
echo.
echo  🏠 Pressione ENTER para voltar ao menu principal...
pause >nul
goto MenuPrincipal

:ColetarTodos
cls
echo ============================================================
echo   🔐 COLETANDO HASHES DE TODOS OS ARQUIVOS
echo   🔗 https://ravenastar.com/cmd/cHashes.bat
echo ============================================================
echo.
echo 📂 Pasta analisada: %FOLDER%
echo.
echo ⚠️ Isso pode levar alguns minutos...
echo.
echo  💡 Pressione ENTER para iniciar ou CTRL+C para cancelar.
set /p dummy=

call :IniciarColeta

echo.
echo ============================================================
echo   ✅ COLETA FINALIZADA COM SUCESSO!
echo ============================================================
echo.
echo 📊 Estatísticas:
echo    • Total de arquivos processados: !COUNT!
echo    • Hashes SHA256 gerados com sucesso: !SUCCESS_COUNT_SHA!
echo    • Hashes MD5 gerados com sucesso: !SUCCESS_COUNT_MD5!
echo    • Erros: !ERROR_COUNT!
echo.
echo 📂 Relatório gerado: %OUTFILE%
echo.
echo 🏠 Pressione ENTER para voltar ao menu principal...
pause >nul
goto MenuPrincipal

:IniciarColeta
:: Gerar timestamp apenas com números (formato YYYYMMDDHHMMSS) - NOVO A CADA EXECUÇÃO
for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set "DATETIME=%%a"
set "TIMESTAMP=%DATETIME:~0,4%%DATETIME:~4,2%%DATETIME:~6,2%%DATETIME:~8,2%%DATETIME:~10,2%%DATETIME:~12,2%"

set "OUTFILE=%FOLDER%%TIMESTAMP%.txt"
set "OUTNAME=%TIMESTAMP%.txt"

set "COUNT=0"
set "ERROR_COUNT=0"
set "SUCCESS_COUNT_SHA=0"
set "SUCCESS_COUNT_MD5=0"

if exist "%OUTFILE%" del "%OUTFILE%" 2>nul

(
echo ============================================================
echo   📋 COLETA DE HASHES - SHA256 E MD5
echo ============================================================
echo.
echo 🔗 Ferramenta utilizada: ravenastar.com/cmd/cHashes.bat
echo.
echo ⏱️ Data/Hora da execução : %date% %time%
echo.
echo ⚖️ Normas e referências aplicadas:
echo   • Boas práticas de preservação de integridade de arquivos
echo     por meio de hashing SHA-256 e MD5
echo   • NIST IR 8387 - Guia para investigação digital e
echo     preservação de evidências
echo   • Art. 159, § 4º do CPP - Assistência Técnica em Perícias
echo     Digitais
echo.
echo 💡 Verifact®: https://www.verifact.com.br/
echo   Plataforma para registro de provas digitais com validade jurídica.
echo.
echo ----------------------------------------------------------
) > "%OUTFILE%"

echo.
echo 🔄 Processando arquivos...
echo.
echo 📄 Arquivo de saída: %OUTNAME%
echo.

for /r "%FOLDER%" %%F in (*) do (
    set "FILENAME=%%~nxF"
    set "FILEPATH=%%F"
    set "SKIP=0"

    if /i "!FILENAME!"=="%SCRIPTNAME%" set "SKIP=1"
    if /i "!FILENAME!"=="%OUTNAME%" set "SKIP=1"

    if "!SKIP!"=="0" (
        set /a COUNT+=1
        set "FSIZE=%%~zF"
        set "FDATE=%%~tF"

        set "RELATIVEPATH=!FILEPATH:%FOLDER%=!"

        set "HASH_SHA="
        for /f "skip=1 delims=" %%H in ('certutil -hashfile "%%F" SHA256 2^>nul') do (
            if "!HASH_SHA!"=="" set "HASH_SHA=%%H"
        )
        set "HASH_SHA=!HASH_SHA: =!"

        set "HASH_MD5="
        for /f "skip=1 delims=" %%H in ('certutil -hashfile "%%F" MD5 2^>nul') do (
            if "!HASH_MD5!"=="" set "HASH_MD5=%%H"
        )
        set "HASH_MD5=!HASH_MD5: =!"

        if "!FSIZE!"=="0" (
            set "HASH_SHA=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
            set "HASH_MD5=d41d8cd98f00b204e9800998ecf8427e"
        )

        if "!HASH_SHA!"=="" (
            set "HASH_SHA=ERRO - Hash SHA256 não gerado"
            set /a ERROR_COUNT+=1
        ) else (
            set /a SUCCESS_COUNT_SHA+=1
        )

        if "!HASH_MD5!"=="" (
            set "HASH_MD5=ERRO - Hash MD5 não gerado"
            set /a ERROR_COUNT+=1
        ) else (
            set /a SUCCESS_COUNT_MD5+=1
        )

        (
        echo 📂 Arquivo             : !RELATIVEPATH!
        echo 📏 Tamanho             : !FSIZE! bytes
        echo ⏱️ Última modificação  : !FDATE!
        echo 🔐 SHA256              : !HASH_SHA!
        echo 🔑 MD5                 : !HASH_MD5!
        echo ----------------------------------------------------------
        ) >> "%OUTFILE%"

        echo [!COUNT!] ✅ Processado: !RELATIVEPATH!
    )
)

goto :eof

:Sair
cls
echo ============================================================
echo   👋 SISTEMA ENCERRADO
echo ============================================================
echo.
pause >nul
exit /b
