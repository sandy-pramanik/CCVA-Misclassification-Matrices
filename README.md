# Misclassification Estimates Based on CHAMPS Data

Estimates of misclassification matrices using the modeling framework from [Pramanik et al. (2025)](https://projecteuclid.org/journals/annals-of-applied-statistics/volume-19/issue-2/Modeling-structure-and-country-specific-heterogeneity-in-misclassification-matrices-of/10.1214/24-AOAS2006.full) and the limited paired MITS-VA data from the Child Health and Mortality Prevention Surveillance ([CHAMPS](https://champshealth.org/)) project.

## Credit

Sandipan Pramanik and Abhirup Datta developed this repository and uploaded the estimates included here.

## Data Format

A list.
  * `age_group`: `"neonate"` for 0-27 days, and `"child"` for 1-59 months
  * `algo`: `"eava"`, `"insilicova"`, and `"interva"`
  * `estimate types`:
    * `"postsamples"` contains posterior samples,
    * `"postmean"` contains the posterior means, and
    * `"asDirich"` contains Dirichlet approximations for each CHAMPS cause and country.
  * `country`: `"Bangladesh"`, `"Ethiopia"`, `"Kenya"`, `"Mali"`, `"Mozambique"`, `"Sierra Leone"`, `"South Africa"`, `"other"`
  * `version`: Date stamp for version control of tracking updates. Only for maintainers.

## Details

  * Posterior sample:
    * `Mmat_champs[[age_group]][[algo]][["postsamples"]][[country]]` contains posterior samples of the misclassification matrix for a desired `age_group`, `algo`, and `country.
    * It is an array of dimension posterior sample `X` CHAMPS broad cause `X` VA broad cause.
    * For example, if analyzing `"neonate"` age group using `"eava"` algorithm in `"Mozambique"`,
      * `Mmat_champs$neonate$eava$postsamples$Mozambique[1,"pneumonia","pneumonia"]` is the first posterior sample of sensitivity for `"pneumonia"`,
      * `Mmat_champs$neonate$eava$postsamples$Mozambique[1,"pneumonia","ipre"]` is the first posterior sample of false negative rate for CHAMPS broad cause `"pneumonia"` and VA broad cause `"ipre"`.
        
  * Posterior mean:
    * `Mmat_champs[[age_group]][[algo]][["postmean"]][[country]]` contains posterior means
    * This is a matrix of dimension CHAMPS broad cause `X` VA broad cause
    * For example, if analyzing `"neonate"` age group using `"eava"` algorithm in `"Mozambique"`,
      * `Mmat_champs$neonate$eava$postmean$Mozambique["pneumonia","pneumonia"]` is the posterior mean of sensitivity for `"pneumonia"`
      * `Mmat_champs$neonate$eava$postmean$Mozambique["pneumonia","ipre"]` is the posterior mean of false negative rate for CHAMPS broad cause `"pneumonia"` and VA broad cause `"ipre"`.
        
  * Dirichlet approximation to use an approximate informative prior:
    * `Mmat_champs[[age_group]][[algo]][["asDirich"]][[country]]` contains posterior Dirichlet approximations of posterior distributions `Mmat_champs[[age_group]][[algo]][["postsamples"]][[country]]`
    * This is a matrix of dimension CHAMPS broad cause `X` VA broad cause
    * For example, if analyzing `"neonate"` age group using `"eava"` algorithm in `"Mozambique"`,
    * `Mmat_champs$neonate$eava$asDirich$Mozambique["pneumonia",]` are parameters of the Dirichlet distribution approximating the posterior of classification rates of different broad causes for the CHAMPS broad cause "pneumonia" (that is, `Mmat_champs[["neonate"]][["eava"]][["postsamples"]][["Mozambique"]][,"pneumonia",]`).

