#　conditionの網羅性の検証

# とりあえず「局」が含まれている
condition_all <- function(var){
  out <- str_detect(var,"局") 
  return(out)
}

#「局」がとりあえず含まれている(2828)
to_engineer_all <- df %>% filter(condition_all(品名)) 

#the_differnceが、2828から「局麻用」などを除いた数になればよいのではないかと考えた。
the_differnce <- sum((to_engineer_all$品名) %in% (df_engineered$品名) == TRUE)
