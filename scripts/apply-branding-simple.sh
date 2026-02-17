#!/bin/bash

#############################################################################
# Script Simplificado para Aplicar CSS e-docBR no Alfresco Share
#############################################################################

set -e

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}"
echo "============================================"
echo "  Aplicando CSS e-docBR ao Alfresco Share"
echo "============================================"
echo -e "${NC}"

# Identificar container Share
echo -e "${BLUE}ℹ${NC}  Identificando container Share..."
SHARE_CONTAINER=$(docker ps --filter "name=share" --format "{{.ID}}" | head -n 1)

if [ -z "$SHARE_CONTAINER" ]; then
    echo -e "${RED}✗${NC} Container Share não encontrado!"
    exit 1
fi

echo -e "${GREEN}✓${NC} Container Share: $SHARE_CONTAINER"

# Verificar se logo existe
if [ ! -f "assets/images/edocbr-logo.png" ]; then
    echo -e "${RED}✗${NC} Logo não encontrado em assets/images/edocbr-logo.png"
    exit 1
fi

echo -e "${GREEN}✓${NC} Logo e-docBR encontrado"

# Criar backup
BACKUP_DIR="/tmp/alfresco-backup-$(date +%Y%m%d_%H%M%S)"
echo -e "${BLUE}ℹ${NC}  Criando backup em $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

docker exec $SHARE_CONTAINER bash -c "
    mkdir -p /tmp/backup-share
    [ -d /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts ] && \
        cp -r /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts /tmp/backup-share/ || true
    [ -d /usr/local/tomcat/webapps/share/res ] && \
        cp -r /usr/local/tomcat/webapps/share/res /tmp/backup-share/ || true
" 2>/dev/null || true

echo -e "${GREEN}✓${NC} Backup criado"

# Copiar logo para webapps/share/res/components/images/
echo -e "${BLUE}ℹ${NC}  Copiando logo..."
docker exec $SHARE_CONTAINER mkdir -p /usr/local/tomcat/webapps/share/res/components/images
docker cp assets/images/edocbr-logo.png $SHARE_CONTAINER:/usr/local/tomcat/webapps/share/res/components/images/
echo -e "${GREEN}✓${NC} Logo copiado"

# Copiar CSS para webapps/share/res/css/
echo -e "${BLUE}ℹ${NC}  Copiando CSS..."
docker exec $SHARE_CONTAINER mkdir -p /usr/local/tomcat/webapps/share/res/css
docker cp share/web-extension/site-webscripts/edocbr-branding.css $SHARE_CONTAINER:/usr/local/tomcat/webapps/share/res/css/
echo -e "${GREEN}✓${NC} CSS copiado"

# Copiar webscript extension para injetar CSS
echo -e "${BLUE}ℹ${NC}  Copiando webscript para injetar CSS..."
docker exec $SHARE_CONTAINER mkdir -p /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/components/header
docker cp share/web-extension/site-webscripts/org/alfresco/components/header/share-header.get.head.ftl \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/components/header/
echo -e "${GREEN}✓${NC} Webscript copiado"

# Copiar configuração mínima do Share
echo -e "${BLUE}ℹ${NC}  Copiando configuração Share..."
docker cp share/web-extension/share-config-custom-dev.xml \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml
echo -e "${GREEN}✓${NC} Configuração copiada"

# Limpar cache
echo -e "${BLUE}ℹ${NC}  Limpando cache do Tomcat..."
docker exec $SHARE_CONTAINER rm -rf /usr/local/tomcat/work/* /usr/local/tomcat/temp/* 2>/dev/null || true
echo -e "${GREEN}✓${NC} Cache limpo"

# Reiniciar container
echo -e "${BLUE}ℹ${NC}  Reiniciando container Share..."
docker restart $SHARE_CONTAINER > /dev/null
echo -e "${GREEN}✓${NC} Container reiniciado"

# Aguardar
echo -e "${BLUE}ℹ${NC}  Aguardando Share inicializar (45 segundos)..."
sleep 45

# Verificar se está rodando
if docker ps | grep -q $SHARE_CONTAINER; then
    echo -e "${GREEN}✓${NC} Share está rodando!"
else
    echo -e "${RED}✗${NC} Share não está rodando. Verifique os logs:"
    echo "    docker logs -f $SHARE_CONTAINER"
    exit 1
fi

# Verificar arquivos
echo -e "${BLUE}ℹ${NC}  Verificando arquivos..."
docker exec $SHARE_CONTAINER test -f /usr/local/tomcat/webapps/share/res/css/edocbr-branding.css && \
    echo -e "${GREEN}✓${NC} CSS: OK" || echo -e "${RED}✗${NC} CSS: ERRO"

docker exec $SHARE_CONTAINER test -f /usr/local/tomcat/webapps/share/res/components/images/edocbr-logo.png && \
    echo -e "${GREEN}✓${NC} Logo: OK" || echo -e "${RED}✗${NC} Logo: ERRO"

docker exec $SHARE_CONTAINER test -f /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/components/header/share-header.get.head.ftl && \
    echo -e "${GREEN}✓${NC} Webscript: OK" || echo -e "${RED}✗${NC} Webscript: ERRO"

echo ""
echo -e "${GREEN}"
echo "✓ ✅ Identidade visual aplicada com sucesso!"
echo -e "${NC}"
echo ""
echo "════════════════════════════════════════════════════════════"
echo "  PRÓXIMOS PASSOS:"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "  1. Acesse o Alfresco Share:"
echo "     http://cmmged.e-docbr.cloud/share"
echo ""
echo "  2. Limpe o cache do navegador:"
echo "     • Chrome/Edge: Ctrl + Shift + Delete"
echo "     • Firefox: Ctrl + Shift + Del"
echo "     • Ou use modo anônimo: Ctrl + Shift + N"
echo ""
echo "  3. A interface deve mostrar:"
echo "     • Título: e-docBR GEDCMM"
echo "     • Header azul (#1B4F8C)"
echo "     • Botões vermelhos (#E30613)"
echo "     • Logo e-docBR (se configurado)"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "📋 Backup salvo em: $BACKUP_DIR"
echo "📊 Logs do Share: docker logs -f $SHARE_CONTAINER"
echo ""
