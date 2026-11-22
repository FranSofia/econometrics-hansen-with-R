# CLAUDE.md

## Proyecto

Apunte personal en formato libro (Quarto) basado en los dos tomos de econometría de Bruce E. Hansen, publicado en GitHub Pages (`https://fransofia.github.io/econometrics-hansen-with-R/`). Repo: `FranSofia/econometrics-hansen-with-R`.

Contenido (~50 capítulos):
- *Probability and Statistics for Economists* (Princeton, 2022): prefacio + 18 capítulos + apéndice A (`chapters/ps-NN-<tema>.qmd`, `appendix/ps-apendice-a-matematicas.qmd`)
- *Econometrics* (Princeton, 2022): 29 capítulos en seis partes + apéndices A y B (`chapters/econ-NN-<tema>.qmd`, `appendix/econ-apendice-*.qmd`)
- Se usan las versiones publicadas (PDF locales en `bibliography/`, que no se sube). Títulos de capítulo: español + original en cursiva, p. ej. «Datos de panel (*Panel Data*)».
- `appendix/referencias.qmd`

Idioma del libro: español (`lang: es`), con ejemplos aplicados en R. Los términos técnicos pueden mantenerse en inglés cuando sea la convención (p. ej. *bootstrap*, *GMM*).

## Estructura

```
_quarto.yml          # configuración y lista de capítulos
index.qmd            # portada
references.bib       # bibliografía (BibTeX)
styles/custom.scss   # estilos HTML (Crimson Pro, Fira Code)
tex/preamble.tex     # estilos PDF (solo render local)
styles/apa.csl       # formato de citas
chapters/            # capítulos
appendix/            # apéndices
.github/workflows/publish.yml   # render + deploy a GitHub Pages
```

## Reglas de trabajo (importantes)

1. **El contenido es mío.** No inventes, completes ni "mejores" el contenido de los capítulos por iniciativa propia. Escribe o edita contenido de capítulos solo cuando te lo pida explícitamente, y en ese caso básate en el texto de Hansen o en el material que yo te entregue.
2. **No inventes fuentes ni resultados.** Toda afirmación técnica, teorema, fórmula o cita debe ser verificable. Si no estás seguro, dilo en vez de rellenar. Si me equivoco en algo, corrígeme y explica en qué.
3. **No hagas cambios grandes sin preguntar.** Antes de reorganizar el repo, renombrar o mover archivos, tocar `_quarto.yml` de forma estructural, o crear/borrar muchos archivos, propón el plan y espera mi confirmación.
4. **Cambios mínimos y localizados.** Prefiero ediciones puntuales antes que reescribir archivos completos. No crees versiones duplicadas de archivos: edita el existente.
5. **No crees archivos extra de documentación o instrucciones** (guías, resúmenes, LEEME) salvo que lo pida. No deben subirse al repo.
6. **Git:** uso GitHub Desktop para commit y push. No los ejecutes tú salvo que lo pida; puedes sugerir un mensaje de commit breve en español. **Nunca** agregues `Co-Authored-By` ni atribución a Claude en commits o PR de este repo.
7. **Respuestas hacia mí:** precisas y sintéticas, sin párrafos largos.

## Estilo de escritura (solo para texto del libro)

Cuando redactes texto que irá en los `.qmd`: prosa ensayística fluida, párrafos narrativos, tono académico sobrio, sin listas con viñetas innecesarias y evitando el estilo típico de texto generado por IA (muletillas, "es importante destacar", enumeraciones mecánicas, cierres tipo resumen). Fórmulas en LaTeX (`$...$`, `$$...$$`), numeradas y referenciadas con crossref de Quarto cuando corresponda (`{#eq-...}`, `@eq-...`).

## Convenciones técnicas

- Todo capítulo es un `.qmd` con YAML mínimo: `title` y `format: html` (el formato real lo define `_quarto.yml`).
- Todo `.qmd` listado en `_quarto.yml` **debe existir**; si no, el workflow de GitHub Actions falla.
- `references.bib` debe mantener sintaxis BibTeX válida: un error ahí rompe el render (`CiteprocParseError`). Valida antes de proponer cambios.
- Crossref en español (Figura, Tabla, Ecuación, Teorema, etc.), ya configurado en `_quarto.yml`.
- Código en R (el repo se llama "with-R"). Mantén `execute: freeze: auto`; `_freeze/` **sí** se sube (así GitHub Actions no re-ejecuta R).
- El PDF (`quarto render --to pdf`) se genera solo en local, porque usa `fonts/` (no se sube). El workflow renderiza solo HTML.
- Antes de dar algo por terminado, verifica que el libro renderiza (`quarto render`, o `quarto preview` para revisión local). Si falla, revisa el log y corrige la causa raíz.

## Código R en los apuntes

El libro es de apuntes y también de práctica en R. Cuando te pida código para un capítulo, sigue en lo posible este orden: (1) implementación "desde cero" que refleje la fórmula de Hansen (p. ej. MCO con álgebra matricial), (2) comparación con funciones o paquetes estándar (`lm`, `fixest`, `sandwich`, etc.), y (3) cuando ayude, una simulación (Monte Carlo) que ilustre el resultado teórico. Código legible, comentado en español, con `set.seed()` en todo lo aleatorio y usando solo paquetes instalados en el workflow (si agregas uno, añádelo a `publish.yml`). Los chunks se muestran (`echo: true`) salvo que diga lo contrario; etiqueta con `#| label:` las figuras y tablas para referenciarlas.

## Rediseño estético

Objetivo: apariencia sobria y académica de libro, distinta a mi sitio de curso (`https://fransofia.github.io/metodos-mgsocio-uah/`).

- Referencia visual: el PDF de mis apuntes de *El capital, tomo II* (títulos en versalitas rojo oscuro, filetes finos).
- Tipografía: **Crimson Pro** para texto (alternativa libre a Minion Pro); **Fira Code** para código; matemáticas con KaTeX en HTML y New Computer Modern Math en PDF. No usar Fira Sans.
- Paleta: sobria (rojos oscuros, grises, azules oscuros).
- Todo el estilo vive en `styles/custom.scss`; evita CSS en línea o estilos dispersos por capítulo.
- Prioriza legibilidad: ancho de línea cómodo, buen espaciado, sidebar limpia, ecuaciones bien dimensionadas y navegación clara entre ~50 capítulos.
- Antes de aplicar cambios visuales grandes, muéstrame la propuesta (qué cambia y por qué). Haz cambios incrementales para poder revertirlos fácilmente.
- Puedes proponer reorganizar el repo si mejora el flujo (p. ej. nombres de capítulos más descriptivos), siguiendo la regla 3.

## Despliegue

- GitHub Pages con fuente "GitHub Actions"; el workflow se dispara en cada push a `main`.
- `.nojekyll` debe permanecer en la raíz.
- `.gitignore` excluye `/_book/`, `/.quarto/`, `*.html`, `*.pdf`, `fonts/`, `bibliography/` y los archivos locales de instrucciones.
- Flujo: editar → `quarto preview` (revisar) → `quarto render --to html` (actualiza `_freeze/`) → commit y push con GitHub Desktop → Actions publica.
