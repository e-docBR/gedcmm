# 🤝 Guia de Contribuição - GEDCMM

Obrigado por considerar contribuir para o projeto GEDCMM! Este documento fornece diretrizes para contribuir com o projeto.

## 📋 Índice

- [Código de Conduta](#código-de-conduta)
- [Como Contribuir](#como-contribuir)
- [Padrões de Código](#padrões-de-código)
- [Processo de Pull Request](#processo-de-pull-request)
- [Reportando Bugs](#reportando-bugs)
- [Sugerindo Melhorias](#sugerindo-melhorias)

## 📜 Código de Conduta

Este projeto adere a um código de conduta. Ao participar, você deve manter um comportamento respeitoso e profissional.

### Nossas Expectativas

- Seja respeitoso e inclusivo
- Use linguagem acolhedora e profissional
- Aceite críticas construtivas
- Foque no que é melhor para a comunidade
- Mostre empatia com outros membros

## 🚀 Como Contribuir

### 1. Fork e Clone

```bash
# Fork o repositório no GitHub
# Clone seu fork
git clone https://github.com/SEU-USUARIO/gedcmm.git
cd gedcmm

# Adicione o repositório upstream
git remote add upstream https://github.com/e-docBR/gedcmm.git
```

### 2. Crie uma Branch

```bash
# Atualize sua branch main
git checkout main
git pull upstream main

# Crie uma branch para sua feature/fix
git checkout -b feature/nome-da-feature
# ou
git checkout -b fix/nome-do-bug
```

### 3. Faça suas Mudanças

- Escreva código limpo e bem documentado
- Siga os padrões de código do projeto
- Adicione testes quando aplicável
- Atualize a documentação conforme necessário

### 4. Commit

```bash
# Adicione seus arquivos
git add .

# Commit com mensagem descritiva
git commit -m "feat: adiciona nova funcionalidade X"
```

### 5. Push e Pull Request

```bash
# Push para seu fork
git push origin feature/nome-da-feature

# Abra um Pull Request no GitHub
```

## 📝 Padrões de Código

### Python

Seguimos o [PEP 8](https://pep8.org/) com algumas adaptações:

#### Formatação

```python
# Use 4 espaços para indentação
def exemplo_funcao(param1: str, param2: int) -> dict:
    """
    Docstring descrevendo a função.
    
    Args:
        param1: Descrição do parâmetro 1
        param2: Descrição do parâmetro 2
        
    Returns:
        Descrição do retorno
    """
    resultado = {
        'chave1': param1,
        'chave2': param2
    }
    return resultado
```

#### Type Hints

```python
from typing import List, Dict, Optional, Union

def processar_dados(
    dados: List[Dict[str, str]], 
    filtro: Optional[str] = None
) -> Union[List[Dict], None]:
    """Sempre use type hints para parâmetros e retornos."""
    pass
```

#### Naming Conventions

```python
# Classes: PascalCase
class AlfrescoClient:
    pass

# Funções e variáveis: snake_case
def processar_documento(node_id: str) -> dict:
    nome_arquivo = "documento.pdf"
    return {}

# Constantes: UPPER_SNAKE_CASE
MAX_RETRIES = 3
DEFAULT_TIMEOUT = 30
```

#### Imports

```python
# Imports padrão
import os
import sys
from typing import List, Dict

# Imports de terceiros
import requests
from flask import Flask, request

# Imports locais
from scripts.alfresco_api_client import AlfrescoAPIClient
from scripts.utils import validate_node_id
```

### JavaScript/TypeScript

Seguimos o [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript):

```typescript
// Use interfaces para tipos complexos
interface Document {
  id: string;
  name: string;
  createdAt: Date;
}

// Use arrow functions
const processDocuments = (docs: Document[]): Document[] => {
  return docs.filter(doc => doc.name.includes('.pdf'));
};

// Use async/await
const fetchDocument = async (id: string): Promise<Document> => {
  const response = await api.get(`/nodes/${id}`);
  return response.data;
};
```

### Java (Alfresco Extensions)

```java
// Naming: PascalCase para classes, camelCase para métodos
public class CustomActionExecuter extends ActionExecuterAbstractBase {
    
    // Constantes em UPPER_SNAKE_CASE
    private static final String PARAM_NODE_REF = "nodeRef";
    
    @Override
    protected void executeImpl(Action action, NodeRef actionedUponNodeRef) {
        // Implementação
    }
}
```

### XML (Configurações Alfresco)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
           http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
    
    <!-- Use comentários descritivos -->
    <bean id="custom.action" 
          class="com.edocbr.alfresco.CustomActionExecuter"
          parent="action-executer">
        <property name="publicAction">
            <value>true</value>
        </property>
    </bean>
</beans>
```

## 🔄 Processo de Pull Request

### Checklist antes do PR

- [ ] Código segue os padrões do projeto
- [ ] Testes adicionados/atualizados
- [ ] Documentação atualizada
- [ ] Commits seguem o padrão de mensagens
- [ ] Branch está atualizada com main
- [ ] CI/CD passa sem erros

### Template de Pull Request

```markdown
## Descrição
Breve descrição das mudanças realizadas.

## Tipo de Mudança
- [ ] Bug fix (mudança que corrige um problema)
- [ ] Nova feature (mudança que adiciona funcionalidade)
- [ ] Breaking change (mudança que quebra compatibilidade)
- [ ] Documentação

## Como Testar
1. Passo 1
2. Passo 2
3. Resultado esperado

## Screenshots (se aplicável)
Cole screenshots aqui

## Checklist
- [ ] Meu código segue os padrões do projeto
- [ ] Revisei meu próprio código
- [ ] Comentei código complexo
- [ ] Atualizei a documentação
- [ ] Minhas mudanças não geram warnings
- [ ] Adicionei testes
- [ ] Testes novos e existentes passam localmente
```

### Revisão de Código

Os PRs serão revisados considerando:

1. **Qualidade do Código**
   - Legibilidade e clareza
   - Manutenibilidade
   - Performance
   - Segurança

2. **Testes**
   - Cobertura adequada
   - Casos de teste relevantes
   - Testes passando

3. **Documentação**
   - Código documentado
   - README atualizado
   - Exemplos fornecidos quando necessário

4. **Impacto**
   - Não quebra funcionalidades existentes
   - Melhora a experiência do usuário
   - Alinhado com objetivos do projeto

## 🐛 Reportando Bugs

### Antes de Reportar

1. Verifique se já não existe uma issue aberta
2. Teste na versão mais recente
3. Colete informações sobre o ambiente

### Template de Bug Report

```markdown
**Descrição do Bug**
Descrição clara e concisa do bug.

**Como Reproduzir**
1. Vá para '...'
2. Clique em '...'
3. Role até '...'
4. Veja o erro

**Comportamento Esperado**
O que deveria acontecer.

**Screenshots**
Se aplicável, adicione screenshots.

**Ambiente:**
 - OS: [e.g. Ubuntu 22.04]
 - Python: [e.g. 3.9.7]
 - Alfresco: [e.g. 7.2]
 - Versão do Projeto: [e.g. 1.0.0]

**Contexto Adicional**
Outras informações relevantes.
```

## 💡 Sugerindo Melhorias

### Template de Feature Request

```markdown
**A melhoria resolve um problema? Descreva.**
Descrição clara do problema.

**Descreva a solução desejada**
O que você gostaria que acontecesse.

**Descreva alternativas consideradas**
Outras soluções que você considerou.

**Contexto Adicional**
Screenshots, mockups, exemplos, etc.
```

## 🏷️ Convenções de Commit

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

```
<tipo>[escopo opcional]: <descrição>

[corpo opcional]

[rodapé(s) opcional(is)]
```

### Tipos

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Mudanças na documentação
- `style`: Formatação, ponto e vírgula, etc
- `refactor`: Refatoração de código
- `test`: Adição ou correção de testes
- `chore`: Manutenção, dependências, etc
- `perf`: Melhoria de performance
- `ci`: Mudanças em CI/CD

### Exemplos

```bash
# Feature simples
git commit -m "feat: adiciona busca por texto completo"

# Bug fix com escopo
git commit -m "fix(api): corrige timeout em uploads grandes"

# Com corpo e breaking change
git commit -m "feat!: redesenha API de autenticação

BREAKING CHANGE: o método authenticate() agora retorna Promise
em vez de callback. Veja docs/migration.md para detalhes."
```

## 🧪 Testes

### Python

```bash
# Execute todos os testes
pytest

# Com cobertura
pytest --cov=scripts --cov-report=html

# Teste específico
pytest tests/unit/test_alfresco_client.py
```

### JavaScript

```bash
# Execute testes
npm test

# Com cobertura
npm run test:coverage

# Watch mode
npm run test:watch
```

### Escrevendo Testes

```python
# tests/unit/test_exemplo.py
import pytest
from scripts.alfresco_api_client import AlfrescoAPIClient

class TestAlfrescoClient:
    @pytest.fixture
    def client(self):
        return AlfrescoAPIClient('http://localhost', 'user', 'pass')
    
    def test_upload_file_success(self, client, tmp_path):
        """Testa upload bem-sucedido de arquivo."""
        # Arrange
        test_file = tmp_path / "test.txt"
        test_file.write_text("conteúdo de teste")
        
        # Act
        result = client.upload_file(str(test_file), '-my-')
        
        # Assert
        assert result['entry']['name'] == 'test.txt'
```

## 📚 Documentação

### Documentando Código Python

```python
def funcao_exemplo(param1: str, param2: int = 10) -> dict:
    """
    Breve descrição de uma linha.
    
    Descrição mais detalhada se necessário, explicando o propósito,
    comportamento e casos especiais da função.
    
    Args:
        param1: Descrição do primeiro parâmetro
        param2: Descrição do segundo parâmetro (opcional, default: 10)
        
    Returns:
        Dicionário contendo:
        - 'key1': Descrição do valor
        - 'key2': Descrição do valor
        
    Raises:
        ValueError: Quando param1 está vazio
        ConnectionError: Quando não consegue conectar ao servidor
        
    Example:
        >>> resultado = funcao_exemplo("teste", 20)
        >>> print(resultado['key1'])
        'teste'
    """
    pass
```

### Atualizando Documentação

- README.md para mudanças gerais
- docs/ para documentação detalhada
- Comentários inline para código complexo
- Docstrings para todas as funções públicas

## 🎯 Áreas para Contribuir

### Backend
- Novos endpoints na API REST
- Melhorias de performance
- Tratamento de erros
- Testes unitários e de integração

### Frontend
- Novos componentes React
- Melhorias de UX/UI
- Responsividade mobile
- Acessibilidade

### DevOps
- Otimizações Docker
- Scripts de deployment
- Monitoramento e logging
- Documentação de infraestrutura

### Documentação
- Guias tutoriais
- Exemplos práticos
- Tradução para outros idiomas
- Diagramas e visualizações

## ❓ Perguntas

Se tiver dúvidas sobre como contribuir:

1. Verifique a [documentação](alfresco-ged-integration/docs/)
2. Procure em [issues existentes](https://github.com/e-docBR/gedcmm/issues)
3. Abra uma nova issue com a tag `question`
4. Entre em contato: suporte@edocbr.com.br

---

**Obrigado por contribuir! 🙏**

Sua contribuição ajuda a tornar o GEDCMM melhor para todos.
