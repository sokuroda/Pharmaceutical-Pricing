#正しい品名を得る
#df_engineredがその比較表
#function 
#「　局」→131
#「局　」→2600
#「局※ 　」→307
#「局麻　」→27
#「（局）」→206

#to_engineeredに対して、加工し新品名を作成する関数
engineer <- function(df){
  df_engineered <- mutate(df,新品名=str_replace(品名,"局　",""))
    return(df_engineered)
}
    #mutate(df,
                          #new_stuff = str_replace(var,"　局","")|
                          #  str_replace(var,"局　","")|
                           # str_replace(var,"局※　","")|
                            #str_replace(var,"局麻　","")|
                            #str_replace(var,"（局）",""))
#}


