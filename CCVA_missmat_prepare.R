

## code to prepare inventory of CCVA misclassification matrix estimates
rm(list = ls())
type = 'single'


# misclassification modeling output path ----
## output from misclassification modeling of CHAMPS data
champs.output.path = "/Users/sandipanpramanik/mystaff/JHU/research/postdoc/VA/comsa calibration/comsa analysis single/code/10-19-24"


# storage ----
CCVA_missmat = list('neonate' = list('eava' = list('postsamples' = NULL, 'postsumm' = NULL, 'postmean' = NULL, 'asDirich' = NULL),
                                    'insilicova' = list('postsamples' = NULL, 'postsumm' = NULL, 'postmean' = NULL, 'asDirich' = NULL),
                                    'interva' = list('postsamples' = NULL, 'postsumm' = NULL, 'postmean' = NULL, 'asDirich' = NULL)),
                   'child' = list('eava' = list('postsamples' = NULL, 'postsumm' = NULL, 'postmean' = NULL, 'asDirich' = NULL),
                                  'insilicova' = list('postsamples' = NULL, 'postsumm' = NULL, 'postmean' = NULL, 'asDirich' = NULL),
                                  'interva' = list('postsamples' = NULL, 'postsumm' = NULL, 'postmean' = NULL, 'asDirich' = NULL)))
for(age_group in c('neonate', 'child')){

  for(va_algo in c('eava', 'insilicova', 'interva')){
    
    # age_group = 'neonate'
    # va_algo = 'eava'
    
    if(va_algo=="eava"){

      mismodel_out = readRDS(file.path(champs.output.path,
                                       paste0(type, '_', age_group, '_', va_algo, '_output'),
                                       'hetmis'))

    }else{

      mismodel_out = readRDS(file.path(champs.output.path,
                                       paste0(type, '_', age_group, '_', va_algo, '_output_eava_removed'),
                                       'hetmis'))

    }
    
    ## posterior samples of misclassification matrix ====
    CCVA_missmat[[age_group]][[va_algo]][["postsamples"]] = mismodel_out$Mmat

    ## posterior summary of misclassification matrix ====
    # "mean", "min", "2.5%" quantile, "25%" quantile, "50%" quantile, "75%" quantile, "97.5%" quantile, "max"
    CCVA_missmat[[age_group]][[va_algo]][["postsumm"]] =
      lapply(1:length(mismodel_out$Mmat),
             FUN = function(k){

               postsumm_k = apply(X = mismodel_out$Mmat[[k]], 2:3,
                                  FUN = function(v){
                                    c(mean(v), min(v), quantile(x = v, probs=c(.025, .25, .5, .75, .975)), max(v))
                                  })
               dimnames(postsumm_k)[[1]] = c("mean", "min", "2.5%", "25%", "50%", "75%", "97.5%", "max")

               postsumm_k

             })
    names(CCVA_missmat[[age_group]][[va_algo]][["postsumm"]]) = names(mismodel_out$Mmat)

    ## separately stored posterior mean ====
    CCVA_missmat[[age_group]][[va_algo]][["postmean"]] = mismodel_out$Mmat.postmean

    ## diriclet approximation of posterior for each age_group, algorithm, country, and CHAMPS cause ====
    CCVA_missmat[[age_group]][[va_algo]][["asDirich"]] = mismodel_out$Mmat.asDirich

    print(paste0(age_group, ', ', va_algo))

  }

}


# adding version for tracking future updates ----
# for maintainer's use only
CCVA_missmat = c(CCVA_missmat, list("version" = "20241004"))


# saving ----
saveRDS(CCVA_missmat, "CCVA_missmat")

