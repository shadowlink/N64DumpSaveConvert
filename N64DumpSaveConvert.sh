#!/bin/bash

INPUT="$1"
TYPE="$2"
OUTPUT="${INPUT%.*}.srm"

# 1. Crear el contenedor vacío de RetroArch (296,960 bytes exactos)
dd if=/dev/zero of="$OUTPUT" bs=1 count=296960 2>/dev/null

# 2. Invertir bytes de 4 en 4 (32-bit swap)
objcopy -I binary -O binary --reverse-bytes=4 "$INPUT" temp_swapped.bin

# 3. Inyectar en el offset exacto según el tipo
if [ "$TYPE" == "sram" ]; then
    # Ocarina of Time (SRAM) - Inyectamos solo 32KB (32768 bytes)
    dd if=temp_swapped.bin of="$OUTPUT" bs=1 count=32768 seek=133120 conv=notrunc 2>/dev/null
    echo "-> Inyectados 32KB como SRAM en byte 133120"
elif [ "$TYPE" == "flash" ]; then
    # Majora's Mask (FlashRAM) - Inyectamos los 128KB enteros
    dd if=temp_swapped.bin of="$OUTPUT" bs=1 seek=165888 conv=notrunc 2>/dev/null
    echo "-> Inyectados 128KB como FlashRAM en byte 165888"
else
    echo "Error: Especifique 'sram' o 'flash'."
    rm temp_swapped.bin
    exit 1
fi

rm temp_swapped.bin
echo "------------------------------------------------"
echo "¡ÉXITO! Archivo listo: $OUTPUT"
echo "------------------------------------------------"