# 🗂️ Alfresco GED Integration (GEDCMM)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue.svg)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![CI/CD](https://github.com/e-docBR/gedcmm/workflows/CI/badge.svg)](https://github.com/e-docBR/gedcmm/actions)

> Sistema completo de integração e automação para Alfresco GED (Gestão Eletrônica de Documentos)

## 📋 Visão Geral

O **GEDCMM** é uma plataforma abrangente para integração, automação e gerenciamento de sistemas Alfresco GED. Oferece scripts Python poderosos, APIs REST, interface web moderna e ferramentas de automação para processos empresariais.

### 🎯 Principais Recursos

- **🔌 Cliente Python REST API** - Cliente completo para todas operações Alfresco
- **⚡ Operações em Lote** - Upload/atualização de milhares de documentos com paralelização
- **🔄 Automação de Workflows** - Aprovações automáticas, escalações e notificações
- **📦 Migração de Dados** - Ferramentas para migrar de sistemas legados (filesystem, CSV, JSON)
- **💾 Backup & Restore** - Backups completos e incrementais com verificação de integridade
- **📊 Monitoramento** - Dashboard de métricas, health checks e alertas
- **🌐 Interface Web** - Dashboard React moderno com atualizações em tempo real
- **🚀 Ready for Production** - Docker, CI/CD, testes automatizados

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────┐
│                    Interface Web (React)                 │
│  Dashboard │ Documentos │ Workflows │ Backups │ Monitor │
└───────────────────────┬─────────────────────────────────┘
                        │ REST API + WebSocket
┌───────────────────────▼─────────────────────────────────┐
│              Backend Flask Application                   │
│  Routes │ Controllers │ Services │ WebSocket Handlers   │
└───────────────────────┬─────────────────────────────────┘
                        │ Python SDK
┌───────────────────────▼─────────────────────────────────┐
│             Alfresco REST API Client                     │
│  Authentication │ CRUD │ Search │ Permissions │ Workflow│
└───────────────────────┬─────────────────────────────────┘
                        │ HTTP/REST
┌───────────────────────▼─────────────────────────────────┐
│                  Alfresco Content Services               │
│  Repository │ Search │ Workflows │ Transformations      │
└─────────────────────────────────────────────────────────┘
```

## 🚀 Início Rápido

### Pré-requisitos

- Python 3.8+
- Docker & Docker Compose
- Node.js 16+ (para desenvolvimento frontend)
- Git

### Instalação

```bash
# Clone o repositório
git clone https://github.com/e-docBR/gedcmm.git
cd gedcmm

# Execute o script de setup
chmod +x scripts/setup.sh
./scripts/setup.sh

# Configure as variáveis de ambiente
cp .env.example .env
nano .env  # Edite com suas credenciais

# Instale as dependências Python
pip install -r requirements.txt

# Inicie os serviços Alfresco (opcional - se não tiver ambiente)
docker-compose up -d
```

### Uso Básico

#### 1. Cliente API Python

```python
from scripts.alfresco_api_client import AlfrescoAPIClient

# Conectar ao Alfresco
client = AlfrescoAPIClient('http://localhost:80/alfresco', 'admin', 'admin')

# Upload de documento
node = client.upload_file(
    '/path/to/document.pdf',
    parent_id='-my-',
    properties={'cm:title': 'Documento Importante'}
)

# Busca de documentos
results = client.search("TYPE:'cm:content' AND cm:title:'*Contrato*'")

# Gerenciar permissões
client.set_permissions(node['entry']['id'], 'user123', ['Consumer', 'Editor'])
```

#### 2. Operações em Lote

```python
from scripts.bulk_operations import BulkOperations

bulk = BulkOperations('http://localhost:80/alfresco', 'admin', 'admin')

# Upload de diretório inteiro (paralelo)
results = bulk.bulk_upload('/data/documents', '-my-', max_workers=10)
print(f"Uploaded {results['successful']} files in {results['duration']}s")

# Atualização em massa de metadados
updates = {
    'node-id-1': {'cm:description': 'Atualizado'},
    'node-id-2': {'cm:description': 'Revisado'}
}
bulk.bulk_update_metadata(updates)
```

#### 3. Automação de Workflows

```python
from scripts.workflow_automation import WorkflowAutomation

wf = WorkflowAutomation('http://localhost:80/alfresco', 'admin', 'admin')

# Iniciar workflow de aprovação
workflow_id = wf.start_approval_workflow(
    document_id='node-id',
    approvers=['manager@company.com', 'director@company.com']
)

# Auto-aprovar baseado em regras
wf.auto_approve_workflows({
    'amount': lambda value: value < 1000,
    'department': lambda dept: dept == 'TI'
})
```

#### 4. Interface Web

```bash
# Backend
cd scripts/web
python alfresco_dashboard_app.py

# Frontend (em outro terminal)
cd scripts/web/frontend
npm install
npm start

# Acesse: http://localhost:3000
```

## 📚 Documentação

### Documentação Completa

- **[Getting Started](alfresco-ged-integration/docs/getting-started.md)** - Guia inicial completo
- **[API Reference](alfresco-ged-integration/references/api_reference.md)** - Referência completa da API REST
- **[Arquitetura](alfresco-ged-integration/docs/architecture-overview.md)** - Visão geral da arquitetura
- **[Deployment](alfresco-ged-integration/docs/deployment-guide.md)** - Guia de implantação
- **[Content Modeling](alfresco-ged-integration/docs/content-modeling.md)** - Modelos de conteúdo
- **[Workflows](alfresco-ged-integration/docs/workflow-configuration.md)** - Configuração de workflows
- **[WebScripts](alfresco-ged-integration/docs/webscript-development.md)** - Desenvolvimento de webscripts
- **[Troubleshooting](alfresco-ged-integration/docs/troubleshooting.md)** - Solução de problemas

### Scripts Python

| Script | Descrição | Documentação |
|--------|-----------|--------------|
| `alfresco_api_client.py` | Cliente REST API completo | [Ver código](scripts/alfresco_api_client.py) |
| `bulk_operations.py` | Operações em lote paralelas | [Ver código](scripts/bulk_operations.py) |
| `workflow_automation.py` | Automação de workflows | [Ver código](scripts/workflow_automation.py) |
| `data_migration.py` | Migração de dados | [Ver código](scripts/data_migration.py) |
| `backup_restore.py` | Backup e restore | [Ver código](scripts/backup_restore.py) |
| `monitoring.py` | Monitoramento e alertas | [Ver código](scripts/monitoring.py) |

### Exemplos

Explore exemplos práticos no diretório [`alfresco-ged-integration/examples/`](alfresco-ged-integration/examples/):

- **Advanced Search** - Busca avançada com filtros customizados
- **Bulk Operations** - Import/export em massa
- **Custom Document Types** - Tipos de documento personalizados
- **Custom Workflows** - Workflows BPMN customizados

## 🛠️ Stack Tecnológico

### Backend
- **Python 3.8+** - Linguagem principal
- **Flask 2.3+** - Framework web
- **Requests** - Cliente HTTP
- **Flask-SocketIO** - WebSocket para real-time
- **psutil** - Monitoramento de sistema

### Frontend
- **React 18** - Framework UI
- **TypeScript** - Type safety
- **Material-UI v5** - Componentes UI
- **Axios** - Cliente HTTP
- **Socket.IO Client** - WebSocket client
- **Chart.js** - Visualizações

### DevOps
- **Docker** - Containerização
- **Docker Compose** - Orquestração
- **GitHub Actions** - CI/CD
- **pytest** - Testes Python
- **Jest** - Testes JavaScript

### Alfresco
- **Alfresco Content Services 7.x** - Repositório de conteúdo
- **Alfresco Share** - Interface web
- **Solr 6** - Motor de busca
- **Activiti** - Motor de workflows BPMN

## 🤝 Contribuindo

Contribuições são bem-vindas! Veja nosso [Guia de Contribuição](CONTRIBUTING.md) para detalhes.

### Passos Rápidos

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Agradecimentos

- Comunidade Alfresco
- Contribuidores open-source
- Equipe e-docBR

## 📧 Suporte

- **Issues**: [GitHub Issues](https://github.com/e-docBR/gedcmm/issues)
- **Email**: suporte@edocbr.com.br
- **Documentação**: [Wiki do Projeto](https://github.com/e-docBR/gedcmm/wiki)

---

<p align="center">Desenvolvido com ❤️ pela equipe <a href="https://github.com/e-docBR">e-docBR</a></p>
