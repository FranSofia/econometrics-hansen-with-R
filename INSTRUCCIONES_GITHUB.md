# Guía de Configuración para GitHub Pages

## Paso 1: Crear el repositorio en GitHub

1. Ve a [GitHub](https://github.com) e inicia sesión
2. Haz clic en el botón verde "New" (o "Nuevo") para crear un repositorio
3. Nombra tu repositorio (por ejemplo: `econometrics-hansen`)
4. Selecciona "Public" (público)
5. **NO** marques "Add a README file" ni "Add .gitignore" (ya los tienes)
6. Haz clic en "Create repository"

## Paso 2: Subir tu proyecto a GitHub

Abre la terminal en la carpeta de tu proyecto y ejecuta:

```bash
# Inicializar git
git init

# Agregar todos los archivos
git add .

# Hacer el primer commit
git commit -m "Initial commit: estructura del libro"

# Conectar con tu repositorio de GitHub (reemplaza USUARIO y REPO)
git remote add origin https://github.com/USUARIO/REPO.git

# Cambiar a la rama main (si estás en master)
git branch -M main

# Subir a GitHub
git push -u origin main
```

**IMPORTANTE:** Reemplaza `USUARIO` con tu usuario de GitHub y `REPO` con el nombre de tu repositorio.

## Paso 3: Configurar GitHub Pages

1. En tu repositorio de GitHub, ve a **Settings** (Configuración)
2. En el menú lateral izquierdo, busca **Pages** (en la sección "Code and automation")
3. En "Build and deployment":
   - **Source**: Selecciona "GitHub Actions"
   
4. ¡Listo! El workflow ya está configurado en `.github/workflows/publish.yml`

## Paso 4: Verificar la publicación

1. Ve a la pestaña **Actions** en tu repositorio
2. Deberías ver un workflow ejecutándose llamado "Render and Deploy"
3. Espera a que termine (aparecerá un ✓ verde)
4. Tu libro estará disponible en: `https://USUARIO.github.io/REPO/`

## Actualizaciones futuras

Cada vez que hagas cambios y los subas a GitHub:

```bash
git add .
git commit -m "Descripción de los cambios"
git push
```

El sitio se actualizará automáticamente en unos minutos.

## Solución de problemas

### El workflow falla
- Verifica que todos los archivos .qmd que referenciaste en `_quarto.yml` existan
- Revisa los logs en la pestaña Actions para ver el error específico

### El sitio no se ve bien
- Asegúrate de que el archivo `.nojekyll` existe en la raíz del proyecto
- Verifica que los archivos CSS estén en la carpeta `styles/`

### No aparece mi sitio
- Espera unos 5-10 minutos después del deploy
- Verifica en Settings > Pages que la URL esté activa
- Asegúrate de que el repositorio sea público

## Estructura final del proyecto

```
econometrics-hansen/
├── .github/
│   └── workflows/
│       └── publish.yml       # GitHub Actions
├── .gitignore               # Archivos a ignorar
├── .nojekyll               # Para GitHub Pages
├── _quarto.yml             # Configuración principal
├── index.qmd               # Portada
├── README.md               # Descripción del repo
├── references.bib          # Bibliografía
├── styles/
│   ├── custom.scss         # Estilos personalizados
│   └── apa.csl            # Formato de citas
├── chapters/               # Aquí van tus capítulos
│   ├── intro-01.qmd
│   ├── intro-02.qmd
│   └── ...
└── appendix/              # Apéndices
    ├── intro-appendix.qmd
    ├── econ-appendix-a.qmd
    ├── econ-appendix-b.qmd
    └── referencias.qmd
```

## Consejos adicionales

1. **Crear capítulos**: Crea los archivos .qmd en la carpeta `chapters/` a medida que los necesites
2. **Actualizar _quarto.yml**: Si cambias nombres de archivos, actualiza `_quarto.yml`
3. **Preview local**: Ejecuta `quarto preview` en tu terminal para ver cambios localmente
4. **Commits frecuentes**: Haz commits pequeños y descriptivos regularmente
