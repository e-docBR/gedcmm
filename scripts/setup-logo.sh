#!/bin/bash

# Script para configurar a logo e-docBR
# Execute após salvar a imagem manualmente

echo "🎨 Configurando logo e-docBR..."

# Diretório de destino
ASSETS_DIR="/home/itasuporte/edocBR/assets/images"
LOGO_FILE="$ASSETS_DIR/edocbr-logo.png"

cd /home/itasuporte/edocBR

# Verificar se a logo existe
if [ -f "$LOGO_FILE" ]; then
    echo "✅ Logo encontrada: $LOGO_FILE"
    
    # Informações do arquivo
    echo ""
    echo "📊 Informações da logo:"
    ls -lh "$LOGO_FILE"
    file "$LOGO_FILE"
    
    # Remover placeholder
    if [ -f "$ASSETS_DIR/edocbr-logo.png.txt" ]; then
        echo ""
        echo "🗑️  Removendo placeholder..."
        git rm "$ASSETS_DIR/edocbr-logo.png.txt"
    fi
    
    # Adicionar logo real
    echo ""
    echo "➕ Adicionando logo ao git..."
    git add "$LOGO_FILE"
    
    # Status
    echo ""
    echo "📋 Status do git:"
    git status --short
    
    # Commit
    echo ""
    echo "💾 Criando commit..."
    git commit -m "feat: add official e-docBR logo image

- Add high-quality PNG logo with gradient background
- Remove placeholder text file
- Logo includes shield, e-doc text and BR branding
- Dimensions: optimized for web display
- Ready for README.md and web application integration"
    
    # Push
    echo ""
    echo "🚀 Fazendo push para GitHub..."
    git push origin main
    
    echo ""
    echo "✅ Logo configurada com sucesso!"
    echo ""
    echo "🌐 Verifique em: https://github.com/e-docBR/gedcmm"
    
else
    echo "❌ Logo não encontrada em: $LOGO_FILE"
    echo ""
    echo "📝 INSTRUÇÕES PARA SALVAR:"
    echo ""
    echo "1. Clique com botão direito na imagem anexada"
    echo "2. Selecione 'Salvar imagem como...'"
    echo "3. Navegue até: $ASSETS_DIR"
    echo "4. Nome do arquivo: edocbr-logo.png"
    echo "5. Salvar"
    echo ""
    echo "Depois execute novamente: ./scripts/setup-logo.sh"
fi
