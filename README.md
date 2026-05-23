# Rhythm Game 🎧⚡

¿Tienes el ritmo en las venas o vas a perder el combo en la primera nota? Prepárate para **Rhythm Game**, un juego de ritmo frenético de 6 carriles donde tus reflejos y tu oído musical son tu única salvación. ¡Siente la música, domina los carriles y demuestra quién es el rey de la pista!

## 🔥 CARACTERÍSTICAS PRINCIPALES

* 🎹 **Acción a 6 Carriles:** Un desafío clásico de ritmo. Las notas caen a toda velocidad y tu misión es clavarlas en el momento exacto. ¡Consigue Perfects y mantén tu combo al máximo!
* ⚔️ **Multijugador Local (1v1):** ¿Crees que eres el mejor? Reta a un amigo en la misma pantalla. Dos jugadores, una canción, y solo un ganador. ¡Que gane el que tenga los dedos más rápidos!
* 🧠 **Beatmaps Dinámicos (Magia Pura):** ¡El juego crea los niveles por ti! Gracias a un analizador interno, el juego procesa las canciones y genera el mapa de notas automáticamente.
* 🌍 **Bilingüe (English / Español):** Cambia el idioma de toda la interfaz al instante con un solo clic.
* 👁️ **Accesibilidad ante todo:** Incluye un Modo Daltonismo integrado con shaders personalizados para que los colores de las notas se adapten y todos puedan disfrutar del juego sin problemas visuales.
* 🌃 **Estética Cyberpunk Neón:** Uso intensivo de efectos de *Glow* HDR, shaders de distorsión y paletas de colores vibrantes.
* 🎬 **Fondos Dinámicos:** El servidor descarga clips de video de las canciones seleccionadas, extrae frames en la nube y los envía al cliente como un slideshow animado.

## 🎮 CÓMO JUGAR

¡Es súper sencillo de entender, pero difícil de dominar!
* **Controles:** Teclas `S`, `D`, `F`, `H`, `J`, `K` (o la configuración que prefieras en tu teclado).
* Espera a que las notas de colores caigan por la pantalla.
* Presiona la tecla correspondiente justo cuando la nota pase por la línea de golpe (*Hit Line*) en la parte inferior.
* Tu precisión define tu puntuación: **PERFECT**, **GOOD** o **BAD**. ¡Si dejas pasar la nota, será un **MISS** y perderás tu combo!

## 🛠️ DETALLES TÉCNICOS

Desarrollado con muchísimo cariño (y mucho café) utilizando **Godot Engine 4**. Jugable directamente desde tu navegador de internet, ¡sin descargar nada!

### Cliente
* **Modo de Renderizado:** *Compatibility* (optimizadísimo para HTML5 y WebAssembly usando SharedArrayBuffer).
* **Shaders Procedurales (Fragment Shaders):** El apartado visual destaca por el uso intensivo de matemáticas puras en la GPU. El fondo caleidoscópico utiliza coordenadas polares, funciones trigonométricas (`sin`, `cos`) y la variable de tiempo (`TIME`) para crear anillos geométricos con distorsiones orgánicas ("efecto espagueti/bajo el agua"), reemplazando costosos sistemas de partículas por código altamente optimizado.
* **Game Feel & Animaciones Rítmicas:** Uso avanzado de Tweens combinados con la detección de BPM para animar a los enemigos y la UI. El juego responde a los impactos superando el umbral HDR (`>1.0`) para activar efectos de Glow/Bloom en tiempo real, latidos de pantalla ("Screen Pump") al acertar y temblores erráticos de cámara ("Shake") al fallar.
* **UI Dinámica:** Uso de `PanelContainer` con `StyleBoxFlat` para generar interfaces asimétricas con bordes neón y esquinas cortadas sin usar texturas externas.
* **Game Feel & Animaciones:** Sistema de *Tweens* para feedback visual (escalado de notas al golpearlas, vibración de la cámara, pulsos de energía en botones) y Shaders nativos (efecto Glitch y RGB split al fallar notas).
* **Gestión de Audio:** Implementación de buses de audio para aplicar efectos dinámicos en tiempo real (como LowPass filters) y sincronización precisa con los beatmaps.

### Backend (Python + FastAPI)
* **Despliegue:** Alojado en **Railway** con volúmenes persistentes (`/app/data`) para almacenamiento de caché de descargas.
* **Generación Cuantizada de Beatmaps:** Algoritmo en Python impulsado por `librosa` que analiza el audio descargado. Aplica "Snap to grid" para asegurar que las notas caigan en tiempos musicales perfectos (semicorcheas) y segmenta la energía acústica (Low, Mid, High) para mapear inteligentemente los instrumentos a carriles específicos.
* **Base de Datos:** SQLite para la persistencia de metadatos, gestión de canciones cacheadas y tablas de puntuación.

---

## 🎓 Datos Escolares

**PROYECTO FINAL HECHO PARA LA MATERIA DE:** **PROGRAMACIÓN 3D - CUCEI 2026** **Con el Profesor:** JOSE LUIS DAVID BONILLA CARRANZA  

### 👥 Integrantes del Equipo
* **Sánchez Naranjo José Alejandro** - 219881881
* **Almaraz Correa Diego Damián** - 222967185
* **Zamora Delgadillo Miguel Angel** - 219630986
