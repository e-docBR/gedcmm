#!/bin/bash

#############################################################################
# Script de Setup - Alfresco GED Integration (GEDCMM)
# 
# Este script configura o ambiente de desenvolvimento para o projeto GEDCMM
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
                                            
  Alfresco GED Integration - Setup Script
EOF
echo -e "${NC}"

# Verificar sistema operacional
log_info "Detectando sistema operacional..."
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    log_success "Linux detectado"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    log_success "macOS detectado"
else
    log_warning "Sistema operacional não reconhecido: $OSTYPE"
fi

# Verificar dependências
log_info "Verificando dependências..."

# Python
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    log_success "Python $PYTHON_VERSION instalado"
else
    log_error "Python 3 não encontrado. Por favor, instale Python 3.8 ou superior."
    exit 1
fi

# pip
if command -v pip3 &> /dev/null; then
    log_success "pip instalado"
else
    log_error "pip não encontrado. Instalando..."
    python3 -m ensurepip --upgrade
fi

# Docker
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version | cut -d' ' -f3 | tr -d ',')
    log_success "Docker $DOCKER_VERSION instalado"
else
    log_warning "Docker não encontrado. Docker é recomendado para executar o Alfresco."
fi

# Docker Compose
if command -v docker-compose &> /dev/null; then
    COMPOSE_VERSION=$(docker-compose --version | cut -d' ' -f4 | tr -d ',')
    log_success "Docker Compose $COMPOSE_VERSION instalado"
elif command -v docker &> /dev/null && docker compose version &> /dev/null; then
    log_success "Docker Compose (plugin) instalado"
else
    log_warning "Docker Compose não encontrado."
fi

# Git
if command -v git &> /dev/null; then
    log_success "Git instalado"
else
    log_error "Git não encontrado. Por favor, instale Git."
    exit 1
fi

# Node.js (opcional, para frontend)
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    log_success "Node.js $NODE_VERSION instalado"
else
    log_warning "Node.js não encontrado. Necessário para desenvolvimento frontend."
fi

# Criar diretórios necessários
log_info "Criando estrutura de diretórios..."
mkdir -p logs
mkdir -p backup
mkdir -p data
mkdir -p scripts
log_success "Diretórios criados"

# Criar ambiente virtual Python
log_info "Configurando ambiente virtual Python..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    log_success "Ambiente virtual criado"
else
    log_warning "Ambiente virtual já existe"
fi

# Ativar ambiente virtual
log_info "Ativando ambiente virtual..."
source venv/bin/activate
log_success "Ambiente virtual ativado"

# Atualizar pip
log_info "Atualizando pip..."
pip install --upgrade pip > /dev/null 2>&1
log_success "pip atualizado"

# Instalar dependências Python
log_info "Instalando dependências Python..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt > /dev/null 2>&1
    log_success "Dependências Python instaladas"
else
    log_warning "requirements.txt não encontrado"
fi

# Criar arquivo .env se não existir
log_info "Configurando variáveis de ambiente..."
if [ ! -f ".env" ]; then
    cat > .env << 'EOL'
# Alfresco Configuration
ALFRESCO_URL=http://localhost:80/alfresco
ALFRESCO_USER=admin
ALFRESCO_PASSWORD=admin

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=alfresco
DB_USER=alfresco
DB_PASSWORD=alfresco

# Application Configuration
APP_ENV=development
APP_DEBUG=True
APP_PORT=5000

# Logging
LOG_LEVEL=INFO
LOG_FILE=logs/app.log

# Email Configuration (for notifications)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
SMTP_FROM=noreply@edocbr.com.br

# Backup Configuration
BACKUP_DIR=backup
BACKUP_RETENTION_DAYS=30

# Monitoring Configuration
METRICS_ENABLED=True
METRICS_INTERVAL=60

# Security
SECRET_KEY=change-this-to-a-random-secret-key
JWT_SECRET_KEY=change-this-to-another-random-key

# Frontend Configuration
REACT_APP_API_URL=http://localhost:5000
REACT_APP_WS_URL=http://localhost:5000
EOL
    log_success "Arquivo .env criado (por favor, configure suas credenciais)"
else
    log_warning "Arquivo .env já existe"
fi

# Verificar conectividade com Alfresco (se estiver rodando)
log_info "Verificando conectividade com Alfresco..."
if curl -s -f -o /dev/null "http://localhost:80/alfresco/api/discovery"; then
    log_success "Alfresco está acessível"
else
    log_warning "Alfresco não está acessível. Certifique-se de que o Alfresco está rodando."
    log_info "Para iniciar o Alfresco: docker-compose up -d"
fi

# Verificar estrutura do projeto
log_info "Verificando estrutura do projeto..."
REQUIRED_DIRS=(
    "alfresco-ged-integration/docs"
    "alfresco-ged-integration/scripts"
    "alfresco-ged-integration/templates"
    "alfresco-ged-integration/examples"
    "alfresco-ged-integration/tests"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        log_success "$dir ✓"
    else
        log_warning "$dir não encontrado"
    fi
done

# Criar alias úteis
log_info "Configurando aliases..."
cat >> venv/bin/activate << 'EOL'

# GEDCMM Aliases
alias gedcmm-test='pytest alfresco-ged-integration/tests/'
alias gedcmm-lint='flake8 alfresco-ged-integration/scripts/'
alias gedcmm-format='black alfresco-ged-integration/scripts/'
alias gedcmm-up='docker-compose up -d'
alias gedcmm-down='docker-compose down'
alias gedcmm-logs='docker-compose logs -f'
alias gedcmm-api='python scripts/web/alfresco_dashboard_app.py'
EOL
log_success "Aliases configurados (reative o ambiente virtual para usar)"

# Resumo
echo ""
log_success "Setup completo!"
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Próximos passos:${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "  1. Ative o ambiente virtual:"
echo -e "     ${YELLOW}source venv/bin/activate${NC}"
echo ""
echo "  2. Configure o arquivo .env com suas credenciais:"
echo -e "     ${YELLOW}nano .env${NC}"
echo ""
echo "  3. Inicie o Alfresco (se necessário):"
echo -e "     ${YELLOW}docker-compose up -d${NC}"
echo ""
echo "  4. Execute os testes:"
echo -e "     ${YELLOW}pytest alfresco-ged-integration/tests/${NC}"
echo ""
echo "  5. Inicie a aplicação web:"
echo -e "     ${YELLOW}python scripts/web/alfresco_dashboard_app.py${NC}"
echo ""
echo "  6. Acesse a documentação:"
echo -e "     ${YELLOW}http://localhost:5000/docs${NC}"
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
log_info "Para mais informações, consulte: alfresco-ged-integration/docs/getting-started.md"
echo ""
