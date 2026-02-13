# 📸 Instruções para Adicionar as Logos

## Passo a Passo

### 1. Salvar a Logo e-docBR

A primeira imagem anexada é a **logo oficial da e-docBR**. Siga os passos:

1. **Salve a imagem da logo e-docBR como**:
   ```
   /home/itasuporte/edocBR/assets/images/edocbr-logo.png
   ```

2. **Especificações da imagem**:
   - Formato: PNG com transparência (se possível)
   - Dimensões aproximadas: 600-800px de largura
   - Mantém o fundo gradiente azul escuro original

### 2. Salvar a Logo Alfresco (opcional)

A segunda imagem mostra a tela de login do Alfresco com a logo oficial.

1. **Extraia/baixe a logo Alfresco e salve como**:
   ```
   /home/itasuporte/edocBR/assets/images/alfresco-logo.png
   ```

2. **Ou baixe diretamente**:
   ```bash
   cd /home/itasuporte/edocBR/assets/images
   wget https://www.alfresco.com/sites/default/files/alfresco-logo.png
   # ou
   curl -O https://www.alfresco.com/themes/custom/particle/images/alfresco-logo.svg
   ```

### 3. Criar Variações da Logo (opcional mas recomendado)

Para melhor integração, crie estas variações:

#### a) Logo para fundos claros
```bash
# Use um editor de imagens (GIMP, Photoshop, etc)
# Ajuste o fundo e salve como:
/home/itasuporte/edocBR/assets/images/edocbr-logo-light-bg.png
```

#### b) Ícone quadrado (apenas o escudo)
```bash
# Recorte apenas o escudo com documento
# Dimensões: 512x512px
# Salve como:
/home/itasuporte/edocBR/assets/images/edocbr-icon-shield.png
```

#### c) Favicon
```bash
# Redimensione o ícone para 32x32px
# Converta para .ico ou mantenha .png
# Salve como:
/home/itasuporte/edocBR/assets/images/edocbr-favicon.ico
```

### 4. Verificar Estrutura

Após salvar, sua estrutura deve estar assim:

```
edocBR/
├── assets/
│   └── images/
│       ├── README.md                  ✅ (criado)
│       ├── edocbr-logo.png           ⚠️  (você precisa adicionar)
│       ├── edocbr-logo-light-bg.png  📋 (opcional)
│       ├── edocbr-icon-shield.png    📋 (opcional)
│       ├── edocbr-favicon.ico        📋 (opcional)
│       └── alfresco-logo.png         📋 (opcional)
├── docs/
│   ├── index.html                     ✅ (criado)
│   └── brand-guidelines.md           ✅ (criado)
└── README.md                          ✅ (atualizado)
```

---

## 🚀 Comandos Rápidos

### Método 1: Salvar manualmente via interface gráfica

1. Clique com botão direito na imagem anexada
2. "Salvar imagem como..."
3. Navegue até `/home/itasuporte/edocBR/assets/images/`
4. Nome do arquivo: `edocbr-logo.png`
5. Salvar

### Método 2: Via linha de comando (se disponível)

```bash
# Navegue até o diretório
cd /home/itasuporte/edocBR/assets/images/

# Se você tiver o arquivo em Downloads:
cp ~/Downloads/edocbr-logo.png ./edocbr-logo.png

# Ou se tiver URL:
# wget URL_DA_IMAGEM -O edocbr-logo.png
```

### Método 3: Extrair da conversa

Se as imagens estão anexadas nesta conversa:

1. Verifique se há arquivos temporários:
   ```bash
   ls -la /tmp/*edoc* 2>/dev/null
   ls -la /tmp/*logo* 2>/dev/null
   ```

2. Se encontrar, copie:
   ```bash
   cp /tmp/imagem-encontrada.png /home/itasuporte/edocBR/assets/images/edocbr-logo.png
   ```

---

## ✅ Verificação

Após adicionar as imagens, verifique:

```bash
cd /home/itasuporte/edocBR

# Listar imagens
ls -lh assets/images/

# Ver informações da imagem (se tiver ImageMagick)
identify assets/images/edocbr-logo.png

# Ou usando file
file assets/images/edocbr-logo.png
```

Saída esperada:
```
-rw-r--r-- 1 user user 150K Feb 13 10:00 edocbr-logo.png
```

---

## 🔄 Commit das Alterações

Depois de adicionar as imagens:

```bash
cd /home/itasuporte/edocBR

# Adicionar novos arquivos
git add assets/images/
git add docs/index.html
git add docs/brand-guidelines.md
git add README.md

# Verificar status
git status

# Commit
git commit -m "feat: add e-docBR branding and visual identity

- Add official e-docBR logo and assets
- Update README.md with branded header
- Create brand guidelines documentation
- Add branded landing page (index.html)
- Set up assets/images directory structure
- Integrate Alfresco logo for partnership display"

# Push para GitHub
git push origin main
```

---

## 🎨 Testando a Logo no README

Após fazer push, visite:
- https://github.com/e-docBR/gedcmm

A logo deve aparecer no topo do README!

Se não aparecer:
1. Verifique se o caminho está correto: `assets/images/edocbr-logo.png`
2. Confirme que a imagem foi commitada: `git log --stat`
3. Verifique se o arquivo existe no GitHub via browser

---

## 🆘 Troubleshooting

### Problema: "Imagem não aparece no GitHub"

**Solução**:
```bash
# Verificar se foi commitada
git ls-files | grep edocbr-logo

# Se não aparecer, adicione novamente
git add assets/images/edocbr-logo.png
git commit -m "fix: add missing e-docBR logo"
git push origin main
```

### Problema: "Imagem muito grande (>1MB)"

**Solução**: Otimize a imagem
```bash
# Instalar imagemagick (se necessário)
sudo apt-get install imagemagick

# Otimizar
convert edocbr-logo.png -strip -quality 85 -resize 800x edocbr-logo-optimized.png
mv edocbr-logo-optimized.png edocbr-logo.png
```

### Problema: "Não consigo salvar a imagem anexada"

**Solução**: 
1. Tire um screenshot da imagem
2. Salve o screenshot
3. Recorte apenas a logo usando um editor de imagens
4. Salve como PNG no local correto

---

## 📋 Checklist Final

- [ ] Logo e-docBR salva em `assets/images/edocbr-logo.png`
- [ ] Logo Alfresco salva (opcional)
- [ ] README.md mostra a logo corretamente
- [ ] Arquivos commitados no git
- [ ] Push feito para o GitHub
- [ ] Verificado no navegador (github.com)
- [ ] Documentação de branding lida
- [ ] Landing page (index.html) testada localmente

---

## 📞 Precisa de Ajuda?

Se tiver dificuldades para salvar as imagens:

1. Compartilhe as imagens novamente ou forneça URLs
2. Ou informe onde as imagens estão salvas atualmente
3. Posso ajudar com comandos específicos para mover/copiar

---

**Próximo passo**: Assim que salvar `edocbr-logo.png`, execute os comandos de commit acima!
