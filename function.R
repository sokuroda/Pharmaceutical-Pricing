#新品名と品名の比較表の作成
#df_engineredがその比較表
#function 
engineer <- function(df){
  df_enginered <-
    mutate(df,
           新品名=品名)
replace(df_enginered)
}
