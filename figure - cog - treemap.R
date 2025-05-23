source("./createdb.R")
source("./figure - cog - data.R")

locustag_func_class <- annotated_aff_genes |>
  dplyr::group_by(FUNC_CATEGORY, COG_CATEGORY_DESCRIPTION) |>
  dplyr::tally() |>
  dplyr::filter(!is.na(FUNC_CATEGORY)) |>
  dplyr::mutate(
    FUNC_CATEGORY = dplyr::if_else(is.na(FUNC_CATEGORY), "Not categorized", FUNC_CATEGORY),
    COG_CATEGORY_DESCRIPTION = dplyr::if_else(is.na(COG_CATEGORY_DESCRIPTION), "", COG_CATEGORY_DESCRIPTION),
    FUNC_CATEGORY = stringr::str_to_title(FUNC_CATEGORY),
    COG_CATEGORY_DESCRIPTION = stringr::str_to_sentence(COG_CATEGORY_DESCRIPTION),
    COG_CATEGORY_DESCRIPTION = glue::glue("{COG_CATEGORY_DESCRIPTION} ({n})")
  )


svg(file = "../output/panels/Fig - Treemap.svg",  width = 12, height = 8)
  treemap::treemap(locustag_func_class,
                   index = c("FUNC_CATEGORY", "COG_CATEGORY_DESCRIPTION"),
                   type = "index", title = "", fontsize.labels = c(20, 16),
                   vSize = "n",
                   align.labels = list(
                     c("center", "top"),
                     c("right", "center")
                   ), border.lwds = c(1, 0.5),
                   bg.labels = c("#FFFFFF50"),
                   fontcolor.labels = c("black", "black"), palette = "Pastel2")
dev.off()
