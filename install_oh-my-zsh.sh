#!/bin/bash

# Verificar si se está ejecutando como usuario normal
echo "Iniciando script para instalar Oh My Zsh y copiar el tema steeef."

# Comprobar si Zsh está instalado
if ! command -v zsh &> /dev/null; then
    echo "Zsh no está instalado. Por favor, instálalo antes de ejecutar este script."
    exit 1
fi

# Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh ya está instalado."
fi

# Verificar si el archivo de tema existe en .dotfiles
theme_source=".dotfiles/steeef.zsh-theme"
theme_destination="$HOME/.oh-my-zsh/themes/"

if [ ! -f "$theme_source" ]; then
    echo "No se encontró el archivo $theme_source. Por favor, verifica que exista en .dotfiles."
    exit 1
fi

# Copiar el archivo de tema al directorio de temas de Oh My Zsh
echo "Copiando el archivo de tema steeef.zsh-theme a $theme_destination"
cp "$theme_source" "$theme_destination"

if [ $? -eq 0 ]; then
    echo "Tema copiado exitosamente."
else
    echo "Hubo un error al copiar el tema."
    exit 1
fi

# Verificar si el archivo .zshrc existe en .dotfiles
zshrc_source=".dotfiles/.zshrc"
zshrc_destination="$HOME/.zshrc"

if [ ! -f "$zshrc_source" ]; then
    echo "No se encontró el archivo $zshrc_source. Por favor, verifica que exista en .dotfiles."
    exit 1
fi

# Copiar el archivo .zshrc al directorio home
echo "Copiando el archivo .zshrc a $HOME"
cp "$zshrc_source" "$zshrc_destination"

if [ $? -eq 0 ]; then
    echo "Archivo .zshrc copiado exitosamente."
else
    echo "Hubo un error al copiar el archivo .zshrc."
    exit 1
fi

# Mensaje final
echo "Instalación completa. Asegúrate de que el tema 'steeef' esté configurado en tu archivo ~/.zshrc."
