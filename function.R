#正しい品名を得る
#df_engineredがその比較表
#function 
engineer <- function(var){
  df_enginered <- mutate(df,
                         new_stuff = str_replace(var,"局",""))
}
