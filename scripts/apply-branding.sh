#!/bin/bash

#############################################################################
# Script para Aplicar Identidade Visual e-docBR no Alfresco Share
# 
# Este script automatiza a aplicação do tema customizado no container Share
#############################################################################

set -e  # Exit on error

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funções de log
log_info() {
    echo -e "${BLUE}ℹ ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Banner
echo -e "${BLUE}"
cat << "EOF"
   ____  ______ ____   _____ __  __ __  __ 
  / __ \|  ____|  _ \ / ____|  \/  |  \/  |
 | |  | | |__  | | | | |    | \  / | \  / |
 | |  | |  __| | | | | |    | |\/| | |\/| |
 | |__| | |____| |_| | |____| |  | | |  | |
  \____/|______|____/ \_____|_|  |_|_|  |_|
                                            
  Aplicar Identidade Visual e-docBR
EOF
echo -e "${NC}"

# Verificar se está no diretório correto
if [ ! -d "share/web-extension" ]; then
    log_error "Execute este script da raiz do projeto: /home/itasuporte/edocBR"
    exit 1
fi

cd /home/itasuporte/edocBR

# Identificar containers
log_info "Identificando containers Docker..."
SHARE_CONTAINER=$(docker ps | grep share | awk '{print $1}')

if [ -z "$SHARE_CONTAINER" ]; then
    log_error "Container Share não encontrado. Certifique-se que o Alfresco está rodando."
    log_info "Inicie com: docker-compose up -d"
    exit 1
fi

log_success "Container Share identificado: $SHARE_CONTAINER"

# Verificar se logo existe
if [ ! -f "assets/images/edocbr-logo.png" ]; then
    log_error "Logo e-docBR não encontrada em assets/images/edocbr-logo.png"
    exit 1
fi

log_success "Logo e-docBR encontrada"

# Criar backup da configuração original
log_info "Fazendo backup das configurações originais..."
docker exec $SHARE_CONTAINER bash -c "
    mkdir -p /tmp/alfresco-backup
    [ -f /usr/local/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml ] && \
    cp /usr/local/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml \
       /tmp/alfresco-backup/share-config-custom.xml.bak 2>/dev/null || true
" 2>/dev/null

log_success "Backup criado em /tmp/alfresco-backup/"

# Criar diretórios necessários no container
log_info "Criando estrutura de diretórios no container..."
docker exec $SHARE_CONTAINER bash -c "
    mkdir -p /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco && \
    mkdir -p /usr/local/tomcat/shared/classes/alfresco/web-extension/site-data/themes && \
    mkdir -p /usr/local/tomcat/webapps/share/res/components/images
"

log_success "Diretórios criados"

# 1. Copiar CSS customizado
log_info "Copiando CSS customizado..."
docker cp share/web-extension/site-webscripts/org/alfresco/edocbr-custom-theme.css \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/

log_success "CSS copiado"

# 2. Copiar página de login customizada
log_info "Copiando página de login..."
docker cp share/web-extension/site-webscripts/org/alfresco/edocbr-login.html \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/

log_success "Login page copiada"

# 3. Copiar definição do tema
log_info "Copiando definição do tema..."
docker cp share/web-extension/site-data/themes/edocBR.xml \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-data/themes/

log_success "Tema copiado"

# 4. Copiar configuração do Share
log_info "Copiando configuração do Share..."
docker cp share/web-extension/share-config-custom-dev.xml \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml

log_success "Configuração copiada"

# 5. Copiar logo e-docBR
log_info "Copiando logo e-docBR..."
docker cp assets/images/edocbr-logo.png \
    $SHARE_CONTAINER:/usr/local/tomcat/webapps/share/res/components/images/

log_success "Logo copiada"

# 6. Limpar cache
log_info "Limpando cache do Tomcat..."
docker exec $SHARE_CONTAINER bash -c "
    rm -rf /usr/local/tomcat/temp/*
    rm -rf /usr/local/tomcat/work/*
" 2>/dev/null

log_success "Cache limpo"

# 7. Reiniciar container
log_info "Reiniciando container Share..."
docker restart $SHARE_CONTAINER

log_success "Container reiniciado"

# Aguardar container ficar pronto
log_info "Aguardando Share inicializar (45 segundos)..."
sleep 45

# Verificar se está rodando
if docker ps | grep -q $SHARE_CONTAINER; then
    log_success "Share está rodando!"
else
    log_error "Share não iniciou corretamente. Verificar logs:"
    docker logs --tail 50 $SHARE_CONTAINER
    exit 1
fi

# Verificar se arquivos foram copiados
log_info "Verificando arquivos copiados..."

VERIFICATION_OK=true

# Verificar CSS
if docker exec $SHARE_CONTAINER test -f /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/edocbr-custom-theme.css; then
    log_success "CSS customizado: OK"
else
    log_error "CSS customizado: NÃO ENCONTRADO"
    VERIFICATION_OK=false
fi

# Verificar tema
if docker exec $SHARE_CONTAINER test -f /usr/local/tomcat/shared/classes/alfresco/web-extension/site-data/themes/edocBR.xml; then
    log_success "Tema edocBR: OK"
else
    log_error "Tema edocBR: NÃO ENCONTRADO"
    VERIFICATION_OK=false
fi

# Verificar logo
if docker exec $SHARE_CONTAINER test -f /usr/local/tomcat/webapps/share/res/components/images/edocbr-logo.png; then
    log_success "Logo e-docBR: OK"
else
    log_error "Logo e-docBR: NÃO ENCONTRADA"
    VERIFICATION_OK=false
fi

echo ""
if [ "$VERIFICATION_OK" = true ]; then
    log_success "✅ Identidade visual aplicada com sucesso!"
    echo ""
    echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  PRÓXIMOS PASSOS:${NC}"
    echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "  1. Acesse o Alfresco Share:"
    echo -e "     ${YELLOW}http://cmmged.e-docbr.cloud/share${NC}"
    echo ""
    echo "  2. Faça login com suas credenciais"
    echo ""
    echo "  3. A interface deve estar com:"
    echo "     • Logo e-docBR no topo"
    echo "     • Header azul (não laranja)"
    echo "     • Botões com cores e-docBR"
    echo ""
    echo "  4. Se não ver as mudanças:"
    echo "     • Abra em modo anônimo/privado"
    echo "     • Ou limpe o cache (Ctrl+F5)"
    echo ""
    echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "📋 Para reverter as mudanças:"
    echo "   ./scripts/revert-branding.sh"
    echo ""
    echo "📊 Para ver os logs do Share:"
    echo "   docker logs -f $SHARE_CONTAINER"
    echo ""
else
    log_error "❌ Alguns arquivos não foram copiados corretamente"
    echo ""
    echo "Verifique os logs:"
    echo "  docker logs --tail 100 $SHARE_CONTAINER"
    echo ""
    echo "Para mais ajuda, consulte:"
    echo "  docs/alfresco-branding-guide.md"
    exit 1
fi
