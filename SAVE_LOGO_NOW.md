# 📸 COMO SALVAR A LOGO E-DOCBR

## ⚡ Método Rápido (3 passos)

### Passo 1: Salvar a Imagem
1. **Clique com botão direito** na imagem da logo anexada acima
2. Selecione **"Salvar imagem como..."** (ou "Save image as...")
3. No diálogo de salvar:
   - **Navegue até**: `/home/itasuporte/edocBR/assets/images/`
   - **Nome do arquivo**: `edocbr-logo.png`
   - **Clique em**: Salvar

### Passo 2: Executar o Script
```bash
cd /home/itasuporte/edocBR
./scripts/setup-logo.sh
```

### Passo 3: Pronto! ✅
O script irá automaticamente:
- ✅ Verificar a logo
- ✅ Remover o placeholder
- ✅ Adicionar ao git
- ✅ Fazer commit
- ✅ Fazer push para GitHub

---

## 📂 Caminho Completo

```
/home/itasuporte/edocBR/assets/images/edocbr-logo.png
```

---

## 🖱️ Alternativa: Arrastar e Soltar

Se seu editor/navegador suporta:
1. **Arraste** a imagem da logo anexada
2. **Solte** na pasta: `/home/itasuporte/edocBR/assets/images/`
3. **Renomeie** para: `edocbr-logo.png`
4. Execute: `./scripts/setup-logo.sh`

---

## 🔍 Verificação Manual

Depois de salvar, verifique:

```bash
cd /home/itasuporte/edocBR/assets/images

# Verificar se existe
ls -lh edocbr-logo.png

# Ver tipo do arquivo
file edocbr-logo.png

# Deveria mostrar algo como:
# edocbr-logo.png: PNG image data, 616 x 216, 8-bit/color RGBA
```

---

## 🚀 Executar Manualmente (se preferir)

Se não quiser usar o script:

```bash
cd /home/itasuporte/edocBR

# Remover placeholder
git rm assets/images/edocbr-logo.png.txt

# Adicionar logo real
git add assets/images/edocbr-logo.png

# Commit
git commit -m "feat: add official e-docBR logo image"

# Push
git push origin main
```

---

## ✅ Checklist

- [ ] Imagem salva em `assets/images/edocbr-logo.png`
- [ ] Script executado: `./scripts/setup-logo.sh`
- [ ] Commit criado pelo script
- [ ] Push feito para GitHub
- [ ] Logo visível em https://github.com/e-docBR/gedcmm

---

## 🆘 Problemas?

### "Não consigo salvar no local correto"
```bash
# Salve onde conseguir (ex: Downloads) e depois mova:
mv ~/Downloads/edocbr-logo.png /home/itasuporte/edocBR/assets/images/
```

### "Não tenho permissão"
```bash
# Ajustar permissões do diretório:
sudo chown -R $USER:$USER /home/itasuporte/edocBR/assets/
chmod -R 755 /home/itasuporte/edocBR/assets/
```

### "O script não funciona"
Execute os comandos manualmente (veja seção "Executar Manualmente" acima)

---

## 📞 Pronto para Continuar?

Após salvar a logo, me avise:
- ✅ "Logo salva" - e eu ajudo com o próximo passo
- ❓ "Tive problema X" - e eu ajudo a resolver

---

**Esperando você salvar a imagem...** ⏳
