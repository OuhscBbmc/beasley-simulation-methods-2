---
title: Graphs of the APA Simulation Chapter
date: "Date: 2021-01-29"
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


Summary {.tabset .tabset-fade .tabset-pills}
===========================================================================

Notes
---------------------------------------------------------------------------



Example 1: Waiting Times Basic 
===========================================================================


```
[1] 23.34423
```

```
[1] 13.85495
```

```
 2.5% 97.5% 
  4.0  58.2 
```

![](figure-png/waiting-times-basic-1.png)<!-- -->

```
[1] 0.036
```


Example 2: Sampling Frames 
===========================================================================

![](figure-png/sampling-frame-1.png)<!-- -->




Session Information {#session-info}
===========================================================================

For the sake of documentation and reproducibility, the current report was rendered in the following environment.  Click the line below to expand.

<details>
  <summary>Environment <span class="glyphicon glyphicon-plus-sign"></span></summary>

```
- Session info ---------------------------------------------------------------
 setting  value                                      
 version  R version 4.0.3 Patched (2020-11-17 r79439)
 os       Windows >= 8 x64                           
 system   x86_64, mingw32                            
 ui       RTerm                                      
 language (EN)                                       
 collate  English_United States.1252                 
 ctype    English_United States.1252                 
 tz       America/Chicago                            
 date     2021-01-29                                 

- Packages -------------------------------------------------------------------
 package     * version date       lib source        
 assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.0.0)
 boot        * 1.3-25  2020-04-26 [3] CRAN (R 4.0.3)
 bootstrap   * 2019.6  2019-06-17 [1] CRAN (R 4.0.3)
 cachem        1.0.1   2021-01-21 [1] CRAN (R 4.0.3)
 callr         3.5.1   2020-10-13 [1] CRAN (R 4.0.3)
 cli           2.2.0   2020-11-20 [1] CRAN (R 4.0.3)
 crayon        1.3.4   2017-09-16 [1] CRAN (R 4.0.0)
 DBI           1.1.1   2021-01-15 [1] CRAN (R 4.0.3)
 desc          1.2.0   2018-05-01 [1] CRAN (R 4.0.0)
 devtools      2.3.2   2020-09-18 [1] CRAN (R 4.0.2)
 digest        0.6.27  2020-10-24 [1] CRAN (R 4.0.3)
 dplyr         1.0.3   2021-01-15 [1] CRAN (R 4.0.3)
 ellipsis      0.3.1   2020-05-15 [1] CRAN (R 4.0.0)
 evaluate      0.14    2019-05-28 [1] CRAN (R 4.0.0)
 fansi         0.4.2   2021-01-15 [1] CRAN (R 4.0.3)
 fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.0.3)
 fs            1.5.0   2020-07-31 [1] CRAN (R 4.0.2)
 generics      0.1.0   2020-10-31 [1] CRAN (R 4.0.2)
 glue          1.4.2   2020-08-27 [1] CRAN (R 4.0.2)
 htmltools     0.5.1.1 2021-01-22 [1] CRAN (R 4.0.3)
 import        1.2.0   2020-09-24 [1] CRAN (R 4.0.2)
 knitr       * 1.30    2020-09-22 [1] CRAN (R 4.0.2)
 lifecycle     0.2.0   2020-03-06 [1] CRAN (R 4.0.0)
 magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.0.3)
 memoise       2.0.0   2021-01-26 [1] CRAN (R 4.0.3)
 pillar        1.4.7   2020-11-20 [1] CRAN (R 4.0.3)
 pkgbuild      1.2.0   2020-12-15 [1] CRAN (R 4.0.3)
 pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.0.0)
 pkgload       1.1.0   2020-05-29 [1] CRAN (R 4.0.0)
 prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.0.0)
 processx      3.4.5   2020-11-30 [1] CRAN (R 4.0.3)
 ps            1.5.0   2020-12-05 [1] CRAN (R 4.0.3)
 purrr         0.3.4   2020-04-17 [1] CRAN (R 4.0.0)
 R6            2.5.0   2020-10-28 [1] CRAN (R 4.0.2)
 remotes       2.2.0   2020-07-21 [1] CRAN (R 4.0.2)
 rlang         0.4.10  2020-12-30 [1] CRAN (R 4.0.3)
 rmarkdown     2.6     2020-12-14 [1] CRAN (R 4.0.3)
 rprojroot     2.0.2   2020-11-15 [1] CRAN (R 4.0.2)
 sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.0.0)
 stringi       1.5.3   2020-09-09 [1] CRAN (R 4.0.2)
 stringr       1.4.0   2019-02-10 [1] CRAN (R 4.0.0)
 testthat      3.0.1   2020-12-17 [1] CRAN (R 4.0.3)
 tibble        3.0.5   2021-01-15 [1] CRAN (R 4.0.3)
 tidyselect    1.1.0   2020-05-11 [1] CRAN (R 4.0.0)
 usethis       2.0.0   2020-12-10 [1] CRAN (R 4.0.3)
 vctrs         0.3.6   2020-12-17 [1] CRAN (R 4.0.3)
 withr         2.4.1   2021-01-26 [1] CRAN (R 4.0.3)
 xfun          0.20    2021-01-06 [1] CRAN (R 4.0.3)
 yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.0)

[1] D:/Projects/RLibraries
[2] D:/Users/Will/Documents/R/win-library/4.0
[3] C:/Program Files/R/R-4.0.3patched/library
```
</details>



Report rendered by Will at 2021-01-29, 00:36 -0600 in 1 seconds.
