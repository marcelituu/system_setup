#!/bin/bash

# Directorios
DOTFILES_CONFIG="$HOME/system_setup/.dotfiles/.config"
TARGET_CONFIG="$HOME/.config"

# Verifica que exista el directorio .dotfiles/.config
if [ ! -d "$DOTFILES_CONFIG" ]; then
  echo "El directorio $DOTFILES_CONFIG no existe. Por favor verifica su ubicación."
  exit 1
fi

# Crear el directorio de destino si no existe
mkdir -p "$TARGET_CONFIG"

# Iterar sobre todos los archivos y directorios en .dotfiles/.config
for item in "$DOTFILES_CONFIG"/*; do
  # Obtener el nombre del archivo o directorio
  base_item=$(basename "$item")

  # Ruta de destino para el symlink
  symlink_target="$TARGET_CONFIG/$base_item"

  # Si existe algo en el destino, eliminarlo
  if [ -e "$symlink_target" ] || [ -L "$symlink_target" ]; then
    echo "Eliminando $symlink_target para reemplazarlo con un symlink..."
    rm -rf "$symlink_target"
  fi

  # Crear el symlink directamente al contenido de .dotfiles/.config
  ln -s "$item" "$symlink_target"
  echo "Enlace simbólico creado: $symlink_target -> $item"
done

echo "Todos los enlaces simbólicos se han creado correctamente."