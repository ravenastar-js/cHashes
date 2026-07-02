#!/usr/bin/env bash
# ============================================================
#   🔐 SCRIPT DE COLETA DE HASHES SHA256 E MD5 (Linux)
#   🔗 https://ravenastar.com/cmd/cHashes
# ============================================================

set -u

SCRIPTNAME="$(basename "$0")"
FOLDER="$(cd "$(dirname "$0")" && pwd)/"

pause() {
    read -r -p "🏠 Pressione ENTER para continuar..." dummy
}

menu_principal() {
    while true; do
        clear
        echo "============================================================"
        echo "  🔐 SCRIPT DE COLETA DE HASHES SHA256 E MD5"
        echo "  🔗 https://ravenastar.com/cmd/cHashes"
        echo "============================================================"
        echo
        echo "  Este script irá gerar hashes SHA256 e MD5 de todos os"
        echo "  arquivos da pasta atual e suas subpastas."
        echo
        echo "  [ 1 ] ▷ Iniciar coleta"
        echo "  [ 2 ] 📖 Guia do script"
        echo "  [ 3 ] ❌ Sair"
        echo
        echo "============================================================"
        read -r -p "Opção: " opcao
        case "$opcao" in
            1) coletar_todos ;;
            2) guia_script ;;
            3) sair ;;
            *) ;;
        esac
    done
}

guia_script() {
    clear
    cat <<EOF
============================================================
  📖 GUIA DO SCRIPT - Coleta de Hashes SHA256 e MD5
  🔗 https://ravenastar.com/cmd/cHashes
============================================================

═══════════════════════════════════════════════════════════════
 🎯 OBJETIVO DO SCRIPT
═══════════════════════════════════════════════════════════════

 Este script foi desenvolvido para coletar e documentar
 hashes SHA256 e MD5 de todos os arquivos em uma pasta e suas
 subpastas, gerando um relatório detalhado para fins de
 auditoria e verificação de integridade.

═══════════════════════════════════════════════════════════════
 ⚖️ NORMAS E REFERÊNCIAS APLICADAS
═══════════════════════════════════════════════════════════════

 📜 Boas práticas de preservação de integridade de arquivos
    por meio de hashing SHA-256 e MD5

 📜 NIST IR 8387 - Guia para investigação digital e
    preservação de evidências

 📜 Art. 159, § 4º do CPP - Assistência Técnica
    em Perícias Digitais

═══════════════════════════════════════════════════════════════
 🔍 COMO FUNCIONA
═══════════════════════════════════════════════════════════════

 [ 1 ] O script percorre recursivamente a pasta atual
 [ 2 ] Para cada arquivo encontrado, calcula os hashes SHA256 e MD5
 [ 3 ] Gera um relatório com informações detalhadas
 [ 4 ] Exclui automaticamente o próprio script e o relatório
       da listagem processada
 [ 5 ] Apresenta estatísticas de processamento

 O relatório gerado contém:
 • Cabeçalho com informações do sistema e data/hora
 • Normas e referências técnicas aplicadas
 • Para cada arquivo processado:
   - Caminho relativo do arquivo
   - Tamanho em bytes
   - Data da última modificação
   - Hash SHA256 calculado
   - Hash MD5 calculado
 • Estatísticas ao final

═══════════════════════════════════════════════════════════════
 🔐 SOBRE A VERIFACT®
═══════════════════════════════════════════════════════════════

 🌐 Site: https://www.verifact.com.br/

 A Verifact® é uma plataforma especializada na coleta e
 preservação de evidências digitais na internet, oferecendo
 uma base sólida para apoiar processos judiciais.

 🎯 Finalidade:
    • Registrar provas da internet com validade jurídica
    • Coletar evidências de WhatsApp, Facebook, Instagram,
      Twitter, Telegram, YouTube, webmails, blogs e sites
    • Alternativa moderna à ata notarial

 🛡️ Diferenciais da Verifact®:
    • Aceitação em todas as instâncias do judiciário
    • Ambiente antifraude patenteado
    • Atestada por órgãos públicos
    • Cumpre cadeia de custódia (CPP) e ISO 27037
    • Relatórios a partir de R\$97, sem assinatura obrigatória

 🔒 Como preserva a integridade:
    1. Gera relatório técnico certificado em PDF
    2. Utiliza carimbo de tempo ICP-Brasil
    3. Registra códigos HASH de todos os arquivos
    4. Mantém vídeo da navegação e metadados técnicos

 📊 Conteúdos que podem ser registrados:
    • Aplicativos de chat (WhatsApp, Telegram)
    • Redes sociais (Facebook, Instagram, TikTok, Twitter)
    • E-mails (Outlook, Gmail, Hotmail)
    • Vídeos (YouTube, Vimeo)
    • Blogs, sites e portais de notícias
    • Qualquer conteúdo da internet via browser

═══════════════════════════════════════════════════════════════
 ⚠️ IMPORTANTE
═══════════════════════════════════════════════════════════════

 🚀 O script foi projetado para ser executado em:
    • Distribuições Linux com bash, coreutils (sha256sum/md5sum)
    • Ambientes com permissão de leitura na pasta analisada

 💡 Dicas importantes:
    • Execute com permissões adequadas (sudo se necessário)
    • Não mova arquivos durante o processo
    • O relatório será salvo na mesma pasta
    • Arquivos grandes podem demorar mais tempo

 ❗ Limitações:
    • Links simbólicos quebrados são ignorados
    • Alguns arquivos podem estar bloqueados por permissão
    • Pastas vazias não são processadas

 📁 Pasta de execução: $FOLDER

═══════════════════════════════════════════════════════════════

EOF
    pause
}

coletar_todos() {
    clear
    echo "============================================================"
    echo "  🔐 COLETANDO HASHES DE TODOS OS ARQUIVOS"
    echo "  🔗 https://ravenastar.com/cmd/cHashes"
    echo "============================================================"
    echo
    echo "📂 Pasta analisada: $FOLDER"
    echo
    echo "⚠️ Isso pode levar alguns minutos..."
    echo
    read -r -p "💡 Pressione ENTER para iniciar ou CTRL+C para cancelar." dummy

    iniciar_coleta

    echo
    echo "============================================================"
    echo "  ✅ COLETA FINALIZADA COM SUCESSO!"
    echo "============================================================"
    echo
    echo "📊 Estatísticas:"
    echo "   • Total de arquivos processados: $COUNT"
    echo "   • Hashes SHA256 gerados com sucesso: $SUCCESS_COUNT_SHA"
    echo "   • Hashes MD5 gerados com sucesso: $SUCCESS_COUNT_MD5"
    echo "   • Erros: $ERROR_COUNT"
    echo
    echo "📂 Relatório gerado: $OUTFILE"
    echo
    pause
}

iniciar_coleta() {
    # Timestamp apenas com números (formato YYYYMMDDHHMMSS) - NOVO A CADA EXECUÇÃO
    TIMESTAMP="$(date +%Y%m%d%H%M%S)"

    OUTFILE="${FOLDER}${TIMESTAMP}.txt"
    OUTNAME="${TIMESTAMP}.txt"

    COUNT=0
    ERROR_COUNT=0
    SUCCESS_COUNT_SHA=0
    SUCCESS_COUNT_MD5=0

    [ -f "$OUTFILE" ] && rm -f "$OUTFILE"

    {
        echo "============================================================"
        echo "  📋 COLETA DE HASHES - SHA256 E MD5"
        echo "============================================================"
        echo
        echo "🔗 Ferramenta utilizada: ravenastar.com/cmd/cHashes"
        echo
        echo "⏱️ Data/Hora da execução : $(date)"
        echo
        echo "⚖️ Normas e referências aplicadas:"
        echo "  • Boas práticas de preservação de integridade de arquivos"
        echo "    por meio de hashing SHA-256 e MD5"
        echo "  • NIST IR 8387 - Guia para investigação digital e"
        echo "    preservação de evidências"
        echo "  • Art. 159, § 4º do CPP - Assistência Técnica em Perícias"
        echo "    Digitais"
        echo
        echo "💡 Verifact®: https://www.verifact.com.br/"
        echo "  Plataforma para registro de provas digitais com validade jurídica."
        echo
        echo "----------------------------------------------------------"
    } > "$OUTFILE"

    echo
    echo "🔄 Processando arquivos..."
    echo
    echo "📄 Arquivo de saída: $OUTNAME"
    echo

    # Percorre recursivamente, ignorando o próprio script e o relatório
    while IFS= read -r -d '' filepath; do
        filename="$(basename "$filepath")"

        [ "$filename" = "$SCRIPTNAME" ] && continue
        [ "$filename" = "$OUTNAME" ] && continue

        COUNT=$((COUNT+1))

        fsize=$(stat -c%s "$filepath" 2>/dev/null)
        fdate=$(stat -c '%y' "$filepath" 2>/dev/null)
        relativepath="${filepath#"$FOLDER"}"

        hash_sha=$(sha256sum "$filepath" 2>/dev/null | awk '{print $1}')
        hash_md5=$(md5sum "$filepath" 2>/dev/null | awk '{print $1}')

        if [ -z "$hash_sha" ]; then
            hash_sha="ERRO - Hash SHA256 não gerado"
            ERROR_COUNT=$((ERROR_COUNT+1))
        else
            SUCCESS_COUNT_SHA=$((SUCCESS_COUNT_SHA+1))
        fi

        if [ -z "$hash_md5" ]; then
            hash_md5="ERRO - Hash MD5 não gerado"
            ERROR_COUNT=$((ERROR_COUNT+1))
        else
            SUCCESS_COUNT_MD5=$((SUCCESS_COUNT_MD5+1))
        fi

        {
            echo "📂 Arquivo             : $relativepath"
            echo "📏 Tamanho             : ${fsize:-0} bytes"
            echo "⏱️ Última modificação  : $fdate"
            echo "🔐 SHA256              : $hash_sha"
            echo "🔑 MD5                 : $hash_md5"
            echo "----------------------------------------------------------"
        } >> "$OUTFILE"

        echo "[$COUNT] ✅ Processado: $relativepath"
    done < <(find "$FOLDER" -type f -print0)
}

sair() {
    clear
    echo "============================================================"
    echo "  👋 SCRIPT ENCERRADO"
    echo "============================================================"
    echo
    pause
    exit 0
}

# ------------------------------------------------------------
# Verificação de dependências
# ------------------------------------------------------------
for cmd in sha256sum md5sum stat find; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Erro: o comando '$cmd' não foi encontrado. Instale o pacote coreutils/findutils."
        exit 1
    fi
done

menu_principal
