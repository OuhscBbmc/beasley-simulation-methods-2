---
title: Graphs of the APA Simulation Chapter
date: "Date: 2022-10-05"
output:
  # radix::radix_article: # radix is a newer alternative that has some advantages over `html_document`.
  html_document:
    keep_md: yes
    toc: 4
    toc_float: true
    number_sections: true
    css: ../common/styles.css         # analysis/common/styles.css
---

This report covers the analyses used in the APA Simulation Chapter the covers Bootstrap and Simulation Methods (William H Beasley, Patrick O'Keefe, & Joseph Rodgers).

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of two directories.-->


<!-- Set the report-wide options, and point to the external code file. -->


<!-- Load 'sourced' R files.  Suppress the output when loading sources. -->


<!-- Load packages, or at least verify they're available on the local machine.  Suppress the output when loading packages. -->


<!-- Load any global functions and variables declared in the R file.  Suppress the output. -->


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. -->


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->


Notes
---------------------------------------------------------------------------


Example 1: Waiting Times Basic 
===========================================================================


```
[1] 23.97086
```

```
[1] 13.55982
```

```
 2.5% 97.5% 
  4.0  58.2 
```

![](figure-png/waiting-times-basic-1.png)<!-- -->

```
[1] 0.033
```

Example 2: Sampling Frames 
===========================================================================

![](figure-png/sampling-frame-1.png)<!-- -->

Example 3: Rejection Sampling
===========================================================================

![](figure-png/rejection-sampling-1.png)<!-- -->

Example 4: Independent Metropolis-Hastings
===========================================================================

![](figure-png/independent-metropolis-hastings-1.png)<!-- -->

Session Information {#session-info}
===========================================================================

For the sake of documentation and reproducibility, the current report was rendered in the following environment.  Click the line below to expand.

<details>
  <summary>Environment <span class="glyphicon glyphicon-plus-sign"></span></summary>

```
- Session info ---------------------------------------------------------------
 setting  value
 version  R version 4.2.1 Patched (2022-07-09 r82577 ucrt)
 os       Windows >= 8 x64 (build 9200)
 system   x86_64, mingw32
 ui       RTerm
 language (EN)
 collate  English_United States.1252
 ctype    English_United States.1252
 tz       America/Chicago
 date     2022-10-05
 pandoc   2.18 @ C:/Program Files/RStudio/bin/quarto/bin/tools/ (via rmarkdown)

- Packages -------------------------------------------------------------------
 package     * version date (UTC) lib source
 assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.2.0)
 bslib         0.4.0   2022-07-16 [1] CRAN (R 4.2.1)
 cachem        1.0.6   2021-08-19 [1] CRAN (R 4.2.0)
 callr         3.7.2   2022-08-22 [1] CRAN (R 4.2.1)
 cli           3.4.1   2022-09-23 [1] CRAN (R 4.2.1)
 crayon        1.5.2   2022-09-29 [1] CRAN (R 4.2.1)
 DBI           1.1.3   2022-06-18 [1] CRAN (R 4.2.0)
 devtools      2.4.4   2022-07-20 [1] CRAN (R 4.2.1)
 digest        0.6.29  2021-12-01 [1] CRAN (R 4.1.2)
 dplyr         1.0.10  2022-09-01 [1] CRAN (R 4.2.1)
 ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.2.1)
 evaluate      0.16    2022-08-09 [1] CRAN (R 4.2.1)
 fansi         1.0.3   2022-03-24 [1] CRAN (R 4.2.1)
 fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.1.0)
 fs            1.5.2   2021-12-08 [1] CRAN (R 4.1.2)
 generics      0.1.3   2022-07-05 [1] CRAN (R 4.2.1)
 glue          1.6.2   2022-02-24 [1] CRAN (R 4.2.1)
 highr         0.9     2021-04-16 [1] CRAN (R 4.2.0)
 htmltools     0.5.3   2022-07-18 [1] CRAN (R 4.2.1)
 htmlwidgets   1.5.4   2021-09-08 [1] CRAN (R 4.2.0)
 httpuv        1.6.6   2022-09-08 [1] CRAN (R 4.2.1)
 import        1.3.0   2022-05-23 [1] CRAN (R 4.2.0)
 jquerylib     0.1.4   2021-04-26 [1] CRAN (R 4.2.0)
 jsonlite      1.8.0   2022-02-22 [1] CRAN (R 4.1.2)
 knitr       * 1.40    2022-08-24 [1] CRAN (R 4.2.1)
 later         1.3.0   2021-08-18 [1] CRAN (R 4.2.0)
 lifecycle     1.0.2   2022-09-09 [1] CRAN (R 4.2.1)
 magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.2.1)
 memoise       2.0.1   2021-11-26 [1] CRAN (R 4.2.0)
 mime          0.12    2021-09-28 [1] CRAN (R 4.2.0)
 miniUI        0.1.1.1 2018-05-18 [1] CRAN (R 4.2.0)
 pillar        1.8.1   2022-08-19 [1] CRAN (R 4.2.1)
 pkgbuild      1.3.1   2021-12-20 [1] CRAN (R 4.2.0)
 pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.2.1)
 pkgload       1.3.0   2022-06-27 [1] CRAN (R 4.2.1)
 prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.2.1)
 processx      3.7.0   2022-07-07 [1] CRAN (R 4.2.1)
 profvis       0.3.7   2020-11-02 [1] CRAN (R 4.2.0)
 promises      1.2.0.1 2021-02-11 [1] CRAN (R 4.2.0)
 ps            1.7.1   2022-06-18 [1] CRAN (R 4.2.0)
 purrr         0.3.4   2020-04-17 [1] CRAN (R 4.2.1)
 R6            2.5.1   2021-08-19 [1] CRAN (R 4.2.1)
 Rcpp          1.0.9   2022-07-08 [1] CRAN (R 4.2.1)
 remotes       2.4.2   2021-11-30 [1] CRAN (R 4.2.0)
 rlang         1.0.6   2022-09-24 [1] CRAN (R 4.2.1)
 rmarkdown     2.16    2022-08-24 [1] CRAN (R 4.2.1)
 rstudioapi    0.14    2022-08-22 [1] CRAN (R 4.2.1)
 sass          0.4.2   2022-07-16 [1] CRAN (R 4.2.1)
 sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.2.0)
 shiny         1.7.2   2022-07-19 [1] CRAN (R 4.2.1)
 stringi       1.7.8   2022-07-11 [1] CRAN (R 4.2.1)
 stringr       1.4.1   2022-08-20 [1] CRAN (R 4.2.1)
 tibble        3.1.8   2022-07-22 [1] CRAN (R 4.2.1)
 tidyselect    1.1.2   2022-02-21 [1] CRAN (R 4.2.1)
 urlchecker    1.0.1   2021-11-30 [1] CRAN (R 4.2.0)
 usethis       2.1.6   2022-05-25 [1] CRAN (R 4.2.0)
 utf8          1.2.2   2021-07-24 [1] CRAN (R 4.2.1)
 vctrs         0.4.1   2022-04-13 [1] CRAN (R 4.2.1)
 xfun          0.33    2022-09-12 [1] CRAN (R 4.2.1)
 xtable        1.8-4   2019-04-21 [1] CRAN (R 4.2.0)
 yaml          2.3.5   2022-02-21 [1] CRAN (R 4.2.1)

 [1] D:/Projects/RLibraries
 [2] C:/Users/Will/AppData/Local/R/win-library/4.2
 [3] C:/Program Files/R/R-4.2.1patched/library

------------------------------------------------------------------------------
```
</details>



Report rendered by Will at 2022-10-05, 09:51 -0500 in 16 seconds.
