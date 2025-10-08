# CCVA Misclassification Matrices

This is the inventory of misclassification matrix estimates for verbal autopsy based cause of death analysis using EAVA, InSilicoVA, InterVA algorithms. The estimates are derived using the misclassification matrix modeling framework from [Pramanik et al. (2025)](https://projecteuclid.org/journals/annals-of-applied-statistics/volume-19/issue-2/Modeling-structure-and-country-specific-heterogeneity-in-misclassification-matrices-of/10.1214/24-AOAS2006.short) and paired CHAMPS–VA cause-of-death data from the Child Health and Mortality Prevention Surveillance ([CHAMPS](https://champshealth.org/)) project. CHAMPS and VA causes are interpreted as the true and estimated causes.

See below for a description of the inventory. The .rda file can be downloaded from the [release](https://github.com/sandy-pramanik/CCVA-Misclassification-Matrices/releases/tag/20241004).

## Credit

Sandipan Pramanik, Emily Wilson, Jacob Fiksel, Brian Gilbert, and Abhirup Datta developed this repository.

Maintainer: Sandipan Pramanik ([sandy.pramanik@gmail.com](sandy.pramanik@gmail.com))

Future updates of misclassification estimates will be released here.

## Data Format

A nested list.
  * `age_group`: `"neonate"` for 0-27 days, and `"child"` for 1-59 months
  * `va_algo`: `"eava"`, `"insilicova"`, and `"interva"`
  * `estimate types`:
    * `"postsamples"` contains posterior samples,
    * `"postsumm"` contains posterior summaries,
    * `"postmean"` contains the posterior means, and
    * `"asDirich"` contains Dirichlet approximations for each CHAMPS cause.
  * `country`: `"Bangladesh"`, `"Ethiopia"`, `"Kenya"`, `"Mali"`, `"Mozambique"`, `"Sierra Leone"`, `"South Africa"`, and `"other"`
  * `version`: Date stamp for version control of tracking updates. Only for maintainers.

## Details

  * Posterior sample:
    * `CCVA_missmat[[age_group]][[va_algo]][["postsamples"]][[country]]` contains misclassification matrix samples of the for a desired `age_group`, `va_algo`, and `country`.
    * It is an array arranged as samples `X` CHAMPS broad cause `X` VA broad cause.
    * For example, if analyzing `"neonate"` age group using `"eava"` algorithm in `"Mozambique"`,
      * `CCVA_missmat$neonate$eava$postsamples$Mozambique[,"pneumonia","pneumonia"]` are samples of sensitivity for `"pneumonia"`,
      * `CCVA_missmat$neonate$eava$postsamples$Mozambique[,"pneumonia","ipre"]` are samples of false negative rate for CHAMPS broad cause `"pneumonia"` and VA broad cause `"ipre"`.

  * Posterior summary:
    * `CCVA_missmat[[age_group]][[va_algo]][["postsumm"]][[country]]` contains posterior summaries of misclassification matrix samples for a desired `age_group`, `va_algo`, and `country`.
    * This is the summaries of misclassification matrix samples.It is an array arranged as summaries `X` CHAMPS broad cause `X` VA broad cause.
    * For example, if analyzing `"neonate"` age group using `"eava"` algorithm in `"Mozambique"`,
      * `CCVA_missmat$neonate$eava$postsamples$Mozambique[,"pneumonia","pneumonia"]` are summaries of sensitivity for `"pneumonia"`,
      * `CCVA_missmat$neonate$eava$postsamples$Mozambique[,"pneumonia","ipre"]` are summaries of false negative rate for CHAMPS broad cause `"pneumonia"` and VA broad cause `"ipre"`.

  * Posterior mean:
    * `CCVA_missmat[[age_group]][[va_algo]][["postmean"]][[country]]` contains posterior means
    * This is the average misclassification matrix based on the above samples arranged as CHAMPS broad cause `X` VA broad cause.
    * For example, if analyzing `"neonate"` age group using `"eava"` algorithm in `"Mozambique"`,
      * `CCVA_missmat$neonate$eava$postmean$Mozambique["pneumonia","pneumonia"]` is the average sensitivity for `"pneumonia"`
      * `CCVA_missmat$neonate$eava$postmean$Mozambique["pneumonia","ipre"]` is the average false negative rate for CHAMPS broad cause `"pneumonia"` and VA broad cause `"ipre"`.
        
  * Dirichlet approximation as an approximate informative prior:
    * `CCVA_missmat[[age_group]][[va_algo]][["asDirich"]][[country]]` contains Dirichlet approximations of samples for each CHAMPS cause
    * This is a matrix arranged as CHAMPS broad cause `X` VA broad cause. Each row of `CCVA_missmat[[age_group]][[va_algo]][["asDirich"]][[country]]` acts as an informative Dirichlet prior for the corresponding row of misclassification matrix.
    * For example, if analyzing `"neonate"` age group using `"eava"` algorithm in `"Mozambique"`, Dirichlet distribution with scale parameters `CCVA_missmat$neonate$eava$asDirich$Mozambique["pneumonia",]` best approximates `CCVA_missmat$neonate$eava$postsamples$Mozambique[,"pneumonia",]`), the samples for CHAMPS broad cause "pneumonia".

