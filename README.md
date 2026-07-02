<div align="center">

# 🔐 cHashes.bat – Coletor de Hashes SHA256 e MD5 em Lote

Script em batch para Windows que percorre pastas e subpastas, calculando hashes SHA256 e MD5 de cada arquivo e gerando um relatório detalhado.

[![➜ ​ ​DOWNLOAD](https://img.shields.io/badge/➜%20DOWNLOAD-gray.svg)](script/cHashes.bat)
[![Versão](https://img.shields.io/badge/versão-1.0-brightgreen)](https://github.com/ravenastar-js/cHashes)
[![Windows](https://img.shields.io/badge/Windows-0078D6?logo=windows&logoColor=white)](https://www.microsoft.com/windows)

</div>

---

## 📜 Sobre

O **cHashes.bat** é uma ferramenta de linha de comando para auditoria e verificação de integridade. Ele gera um relatório com:
- Caminho relativo
- Tamanho (bytes)
- Data de modificação
- Hash SHA256
- Hash MD5

Leve, rápido e sem instalação.

---

## 🚀 Como Usar

1. **Baixe** o script: [cHashes.bat](script/cHashes.bat)
2. **Coloque** na pasta que deseja auditar
3. **Execute** como administrador (recomendado)
4. Escolha `[1] Iniciar coleta` no menu
5. O relatório será salvo na mesma pasta com nome `YYYYMMDDHHMMSS.txt`

---

## 🔍 Comparação de Hashes com Notepad++

Após gerar o relatório, você pode comparar hashes de diferentes arquivos ou versões usando o **Notepad++** com o plugin **Compare**:

1. Baixe e instale o [Notepad++](https://notepad-plus-plus.org/)
2. Instale o plugin **Compare** via `Plugins > Plugins Admin`
3. Abra dois arquivos de relatório ou dois hashes lado a lado
4. Vá em `Plugins > Compare > Compare`
5. As diferenças serão destacadas automaticamente

Isso facilita a verificação de integridade entre versões diferentes de arquivos ou a validação de hashes em auditorias.

---

## 🛠️ Requisitos

- Windows 7, 8, 10, 11 ou Server 2008+
- Nenhuma instalação adicional (usa `certutil` nativo)

---

## ⚖️ Normas

- Boas práticas de hashing (SHA256 e MD5)
- NIST IR 8387 – Investigação digital
- Art. 159, § 4º do CPP – Assistência Técnica em Perícias

---

## 🔐 Sobre a Verifact®

[![Verifact](https://img.shields.io/badge/Verifact®-Registro%20de%20Provas%20Digitais-blue?style=for-the-badge)](https://www.verifact.com.br/)

A **Verifact®** é uma plataforma especializada na coleta e preservação de evidências digitais na internet, oferecendo uma base sólida para apoiar processos judiciais.

### 🎯 Finalidade
- Registrar provas da internet com validade jurídica
- Coletar evidências de WhatsApp, Facebook, Instagram, Twitter, Telegram, YouTube, webmails, blogs e sites
- Alternativa moderna à ata notarial

### 🛡️ Diferenciais
- Aceitação em todas as instâncias do judiciário
- Ambiente antifraude patenteado
- Atestada por órgãos públicos
- Cumpre cadeia de custódia (CPP) e ISO 27037
- Relatórios a partir de R$97, sem assinatura obrigatória

### 🔒 Como preserva a integridade
1. Gera relatório técnico certificado em PDF
2. Utiliza carimbo de tempo ICP-Brasil
3. Registra códigos HASH de todos os arquivos
4. Mantém vídeo da navegação e metadados técnicos

### 📊 Conteúdos que podem ser registrados
- Aplicativos de chat (WhatsApp, Telegram)
- Redes sociais (Facebook, Instagram, TikTok, Twitter)
- E-mails (Outlook, Gmail, Hotmail)
- Vídeos (YouTube, Vimeo)
- Blogs, sites e portais de notícias
- Qualquer conteúdo da internet via browser

---

## 📦 Download

| Arquivo | Versão | Link |
|---------|--------|------|
| `cHashes.bat` | 1.0 | [Baixar](script/cHashes.bat) |

---

## 📞 Suporte

[![Servidor de Suporte](https://img.shields.io/badge/Servidor%20de%20Suporte-Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/FncVNprdgP)

---

## 🌟 Star History

<a href="https://www.star-history.com/#ravenastar-js/cHashes&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/image?repos=ravenastar-js/cHashes&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/image?repos=ravenastar-js/cHashes&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/image?repos=ravenastar-js/cHashes&type=date&legend=top-left" />
 </picture>
</a>
