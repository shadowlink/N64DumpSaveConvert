# N64 Dump Save Converter (Cartridge Dumper a RetroArch)

Un script ligero en Bash para convertir volcados de partidas (Saves) originales de cartuchos de Nintendo 64 extraídos con dumpers físicos (como Sanni CartReader) a formato `.srm`, estructurado específicamente para el núcleo **Mupen64Plus-Next** de **RetroArch / EmuDeck**.

## 📌 El Problema que Resuelve

Los emuladores modernos basados en Libretro (RetroArch) no leen los volcados de memoria crudos de la consola por dos motivos:
1. **Endianness:** La N64 guarda los datos en *Big Endian*, pero el PC/Emulador espera *Little Endian*. Requiere una inversión de bytes de 32 bits (Byte Swap).
2. **Estructura del Contenedor:** RetroArch usa un contenedor `.srm` gigante de 290 KB (296.960 bytes) que simula toda la memoria de la consola (EEPROM + Controller Paks + SRAM + FlashRAM). Si le das el archivo suelto, lo ignora y lo sobreescribe.

Este script realiza la inversión matemática correcta e **inyecta** tu partida en el byte exacto que espera el emulador sin corromper el resto del contenedor.

## 🚀 Características

* **Soporte FlashRAM (128KB):** Para juegos como *The Legend of Zelda: Majora's Mask* o *Paper Mario*.
* **Soporte SRAM (32KB):** Para juegos como *The Legend of Zelda: Ocarina of Time* o *Super Smash Bros*.
* **Precisión:** Utiliza `objcopy` para un *32-bit swap* perfecto, respetando la cabecera original del juego.
* **Nativo de Linux:** Ideal para sistemas como CachyOS, SteamOS (Steam Deck) o cualquier distribución GNU/Linux.

## 🛠️ Requisitos

Asegúrate de tener instaladas las utilidades binarias estándar de Linux (`binutils` y `coreutils`). Vienen por defecto en casi todas las distribuciones.
* `dd`
* `objcopy` (parte del paquete `binutils`)

## 📥 Instalación

Crea el archivo del script y dale permisos de ejecución:

```bash
touch n64_srm_maker.sh
chmod +x n64_srm_maker.sh