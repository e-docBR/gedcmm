# 🎨 Guia de Customização da Interface Alfresco com Identidade e-docBR

## 📋 Visão Geral

Este guia explica como aplicar a identidade visual da e-docBR ao Alfresco Share, substituindo a aparência padrão laranja.

---

## 🗂️ Arquivos Criados

### 1. **Theme CSS** (`share/web-extension/site-webscripts/org/alfresco/edocbr-custom-theme.css`)
   - CSS completo para customizar toda a interface
   - Cores da marca e-docBR
   - Responsividade e acessibilidade
   - +500 linhas de customizações

### 2. **Custom Login Page** (`share/web-extension/site-webscripts/org/alfresco/edocbr-login.html`)
   - Página de login branded com logo e-docBR
   - Gradiente azul personalizado
   - Formulário moderno e responsivo
   - Integração com API Alfresco

### 3. **Theme Definition** (`share/web-extension/site-data/themes/edocBR.xml`)
   - Define o tema "edocBR"
   - Tokens de cores customizados
   - Referências aos arquivos CSS

### 4. **Share Config** (`share/web-extension/share-config-custom-dev.xml`)
   - Configuração atualizada
   - Define tema padrão como "edocBR"
   - Configurações de branding

---

## 🚀 Como Aplicar as Customizações

### Opção 1: Via Docker (RECOMENDADO)

#### Passo 1: Copiar Arquivos para os Containers

```bash
cd /home/itasuporte/edocBR

# 1. Identificar os containers
SHARE_CONTAINER=$(docker ps | grep share | awk '{print $1}')
ALFRESCO_CONTAINER=$(docker ps | grep alfresco | awk '{print $1}')

echo "Share Container: $SHARE_CONTAINER"
echo "Alfresco Container: $ALFRESCO_CONTAINER"

# 2. Copiar arquivos para o Share
docker cp share/web-extension/site-webscripts/org/alfresco/edocbr-custom-theme.css \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/

docker cp share/web-extension/site-webscripts/org/alfresco/edocbr-login.html \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/

docker cp share/web-extension/site-data/themes/edocBR.xml \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-data/themes/

docker cp share/web-extension/share-config-custom-dev.xml \
    $SHARE_CONTAINER:/usr/local/tomcat/shared/classes/alfresco/web-extension/

# 3. Copiar logo para o Share
docker cp assets/images/edocbr-logo.png \
    $SHARE_CONTAINER:/usr/local/tomcat/webapps/share/res/components/images/

# 4. Reiniciar o Share
docker restart $SHARE_CONTAINER
```

#### Passo 2: Verificar

```bash
# Aguardar container reiniciar (30-60 segundos)
sleep 45

# Verificar logs
docker logs -f $SHARE_CONTAINER
```

#### Passo 3: Acessar Interface

- Abra: `http://cmmged.e-docbr.cloud/share`
- Login: `admin` / senha configurada
- A interface agora deve ter a identidade e-docBR!

---

### Opção 2: Via AMP (Module)

Se preferir criar um AMP module:

```bash
cd /home/itasuporte/edocBR

# Criar estrutura AMP
mkdir -p share-amp/src/main/amp/config/alfresco/web-extension/site-webscripts/org/alfresco
mkdir -p share-amp/src/main/amp/config/alfresco/web-extension/site-data/themes
mkdir -p share-amp/src/main/amp/web/components/images

# Copiar arquivos
cp share/web-extension/site-webscripts/org/alfresco/* \
   share-amp/src/main/amp/config/alfresco/web-extension/site-webscripts/org/alfresco/

cp share/web-extension/site-data/themes/edocBR.xml \
   share-amp/src/main/amp/config/alfresco/web-extension/site-data/themes/

cp assets/images/edocbr-logo.png \
   share-amp/src/main/amp/web/components/images/

# Build AMP (requer Maven)
cd share-amp
mvn clean package

# Aplicar AMP ao Share
java -jar alfresco-mmt.jar install share-amp-1.0.amp /path/to/share.war -force
```

---

### Opção 3: Via Volume Docker Compose

Atualizar `docker-compose.yml`:

```yaml
services:
  share:
    image: alfresco/alfresco-share:7.2.0
    volumes:
      # Theme CSS
      - ./share/web-extension/site-webscripts/org/alfresco:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco
      
      # Theme definition
      - ./share/web-extension/site-data/themes:/usr/local/tomcat/shared/classes/alfresco/web-extension/site-data/themes
      
      # Logo
      - ./assets/images/edocbr-logo.png:/usr/local/tomcat/webapps/share/res/components/images/edocbr-logo.png
      
      # Config
      - ./share/web-extension/share-config-custom-dev.xml:/usr/local/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml
```

Depois:
```bash
docker-compose down
docker-compose up -d
```

---

## 🎨 Customizações Incluídas

### Login Page
- ✅ Logo e-docBR no topo
- ✅ Gradiente azul personalizado (substitui laranja)
- ✅ Botão vermelho call-to-action
- ✅ Formulário moderno com validação
- ✅ Footer com copyright e-docBR

### Header/Navigation
- ✅ Header com gradiente azul e-docBR
- ✅ Borda vermelha inferior
- ✅ Menu items em branco
- ✅ Hover effects customizados

### Document Library
- ✅ Cards com bordas arredondadas
- ✅ Hover effects azul claro
- ✅ Selected items com borda vermelha
- ✅ Botões primários azuis, CTAs vermelhos

### Dashboard
- ✅ Dashlets com título azul
- ✅ Cards modernos e limpos
- ✅ Status indicators coloridos
- ✅ Footer azul escuro com branding

### Geral
- ✅ Paleta completa e-docBR
- ✅ Tipografia profissional
- ✅ Responsividade mobile
- ✅ Acessibilidade (WCAG 2.1)
- ✅ Print styles customizados

---

## 🔧 Troubleshooting

### Problema: "Tema não aplicado após reiniciar"

**Solução 1**: Limpar cache do Share
```bash
SHARE_CONTAINER=$(docker ps | grep share | awk '{print $1}')
docker exec $SHARE_CONTAINER rm -rf /usr/local/tomcat/temp/*
docker exec $SHARE_CONTAINER rm -rf /usr/local/tomcat/work/*
docker restart $SHARE_CONTAINER
```

**Solução 2**: Forçar rebuild do cache do navegador
- Abra o DevTools (F12)
- Clique com botão direito no refresh
- Selecione "Empty Cache and Hard Reload"

### Problema: "Logo não aparece"

**Verificar se foi copiada**:
```bash
SHARE_CONTAINER=$(docker ps | grep share | awk '{print $1}')
docker exec $SHARE_CONTAINER ls -la /usr/local/tomcat/webapps/share/res/components/images/ | grep edocbr
```

**Se não existir, copiar novamente**:
```bash
docker cp assets/images/edocbr-logo.png \
    $SHARE_CONTAINER:/usr/local/tomcat/webapps/share/res/components/images/
docker restart $SHARE_CONTAINER
```

### Problema: "CSS não está sendo aplicado"

**Verificar permissões**:
```bash
docker exec $SHARE_CONTAINER ls -la /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/
```

**Verificar conteúdo**:
```bash
docker exec $SHARE_CONTAINER cat /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/edocbr-custom-theme.css | head -n 20
```

### Problema: "Alfresco não inicia após mudanças"

**Ver logs**:
```bash
docker logs -f $(docker ps | grep share | awk '{print $1}')
```

**Reverter mudanças**:
```bash
# Remover customizações e reiniciar clean
docker exec $SHARE_CONTAINER rm -f /usr/local/tomcat/shared/classes/alfresco/web-extension/site-webscripts/org/alfresco/edocbr-*
docker restart $(docker ps | grep share | awk '{print $1}')
```

---

## 📱 Testando a Interface

### Checklist

- [ ] Login page mostra logo e-docBR
- [ ] Login page tem fundo azul gradiente (não laranja)
- [ ] Botão "Entrar" é vermelho
- [ ] Após login, header é azul
- [ ] Document library usa cores e-docBR
- [ ] Dashlets tem título azul
- [ ] Footer mostra copyright e-docBR
- [ ] Responsivo em mobile
- [ ] Logo aparece no topo do Share

### Teste de Cores

Página de login:
- Fundo: Gradiente azul (#1B4F8C → #0A2647) ✅
- Botão: Vermelho (#E30613) ✅
- Logo: e-docBR visível ✅

Dentro do Share:
- Header: Azul (#1B4F8C) ✅
- Botões primários: Azul ✅
- Botões call-to-action: Vermelho ✅
- Links: Azul e-docBR ✅

---

## 🎯 Próximos Passos

Após aplicar o tema básico, você pode:

1. **Customizar Welcome Dashboard**
   - Adicionar widgets personalizados
   - Métricas e KPIs da empresa

2. **Criar Custom Actions**
   - Ações específicas para documentos
   - Workflows customizados

3. **Desenvolver WebScripts**
   - APIs customizadas
   - Integrações específicas

4. **Mobile App**
   - App nativo com marca e-docBR
   - Push notifications

---

## 📞 Suporte

Se tiver problemas aplicando as customizações:

1. Verifique os logs do Share: `docker logs -f <share-container>`
2. Verifique se os arquivos foram copiados corretamente
3. Confirme que o container foi reiniciado
4. Teste em modo incógnito (sem cache)

---

## 📚 Referências

- [Alfresco Share Customization Guide](https://docs.alfresco.com/content-services/latest/develop/share-ext-points/)
- [Alfresco Theming](https://docs.alfresco.com/content-services/latest/develop/share-ext-points/share-themes/)
- [WebScripts Development](https://docs.alfresco.com/content-services/latest/develop/repo-ext-points/web-scripts/)

---

**Status**: ✅ Arquivos criados | 🔄 Aguardando aplicação ao Alfresco
