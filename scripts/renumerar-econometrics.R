# ============================================================
#  Post-render (solo HTML): reinicia en 1 la numeración de los
#  capítulos de *Econometrics*. Quarto numera los capítulos de un
#  libro de corrido, así que econ-01 sale como 19. Este script
#  resta ese desfase en títulos, secciones, sidebar y crossrefs.
#  (En el PDF lo resuelve tex/preamble.tex.)
# ============================================================

out <- "_book"
if (!dir.exists(out) || !file.exists(file.path(out, "chapters", "econ-01-introduccion.html"))) quit(save = "no")

leer <- function(f) paste(readLines(f, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
escribir <- function(x, f) writeLines(enc2utf8(x), f, useBytes = TRUE)

# Desfase = número que Quarto asignó a econ-01 menos 1
html1 <- leer(file.path(out, "chapters", "econ-01-introduccion.html"))
n1 <- as.integer(sub('.*?<span class="chapter-number">([0-9]+)</span>.*', "\\1", html1))
desfase <- n1 - 1L
if (is.na(desfase) || desfase <= 0) quit(save = "no")
rango <- n1:(n1 + 28L)

# Reemplaza números de capítulo K (en rango) por K - desfase dentro de un patrón
renumerar <- function(x, patron) {
  m <- gregexpr(patron, x, perl = TRUE)
  regmatches(x, m) <- lapply(regmatches(x, m), function(v) {
    vapply(v, function(s) {
      k <- as.integer(sub(patron, "\\2", s, perl = TRUE))
      if (k %in% rango) sub(patron, paste0("\\1", k - desfase, "\\3"), s, perl = TRUE) else s
    }, character(1), USE.NAMES = FALSE)
  })
  x
}

# Patrones globales (sidebar y navegación aparecen en todas las páginas)
globales <- c(
  '(<span class="chapter-number">)([0-9]+)(</span>)',
  '(<span class="header-section-number">)([0-9]+)([.<])',
  '(<title>)([0-9]+)(\\s|&nbsp;)'
)
# Patrones solo en páginas de Econometrics (crossrefs, ecuaciones, TOC)
locales <- c(
  '((?:Figura|Tabla|Ecuación|Sección|Capítulo|Teorema|Lema|Definición|Proposición|Corolario|Ejemplo|Ejercicio)(?:&nbsp;|\\s))([0-9]+)(\\.[0-9])',
  '(\\\\qquad\\()([0-9]+)(\\.[0-9]+\\))',
  '(data-number=")([0-9]+)([".])'
)

htmls <- list.files(out, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
for (f in htmls) {
  x <- leer(f); x0 <- x
  for (p in globales) x <- renumerar(x, p)
  if (grepl("econ-[0-9]{2}-", basename(f))) for (p in locales) x <- renumerar(x, p)
  if (!identical(x, x0)) escribir(x, f)
}

# Resultados de búsqueda
sj <- file.path(out, "search.json")
if (file.exists(sj)) {
  x <- leer(sj); x0 <- x
  x <- renumerar(x, '(\\"(?:title|section)\\":\\s*\\"(?:\\\\n)?)([0-9]+)([^0-9])')
  x <- renumerar(x, "(<span class='chapter-number'>)([0-9]+)(<)")
  if (!identical(x, x0)) escribir(x, sj)
}
