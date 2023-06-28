library(tidyverse)
library(stringr)
library(tidyr)

#test
#データ入力
path <- ".\\data\\2023_06_16.csv"
df <- read.csv(path,fileEncoding = "Shift-jis",colClasses = "character")
df <- distinct(df,品名)


#関数の受け入れ
#path_function <- file.choose()
#カタカナやめる
source(".\\rscript\\function.R")

#加工すべき変数
#「局」があるもの→3155
#「　局」→131
#「局　」→2600
#「局※ 　」→307
#「局麻　」→27
#「（局）」→206
#「局麻用」や途中に入っているものもある
#functionにする意味→元のベクトルと新しく作ったベクトルを比較するため
#varには、品名と新品名が入る。
#今回は、"局　"のみを対象とする

condition <- function(var){
  out <- str_detect(var,"局　") 
  return(out)
}
#|
#str_detect(df$品名,"局※　") |   
#str_detect(df$品名,"局麻　") |
#str_detect(df$品名,"（局）")

#品名のうち加工を加えるべきもののベクトル(前修正必要)
to_engineer <- df %>% filter(condition(品名)) 
not_to_engineer <- df %>% filter(!condition(品名))

#「加工すべき変数」に引っかかったものを関数により加工する
df_engineered <- engineer(to_engineer)

#新品名のうち加工を加えるべきもののベクトル(後修正必要)
to_engineer_again <- df_engineered %>% filter(condition(新品名)) 
to_engineer_anymore <- df_engineered %>% filter(!condition(新品名))


#==========================================================================================
#証明したいこと

#加工しないといけないデータ数
to_engineer_num <- df %>% filter(condition(品名)) %>% nrow()

#新品名がcoditionを修正できたデータ数
to_engineer_anymore_num <- df_engineered %>% filter(!condition(新品名)) %>% nrow()

#新品名が再度conditionにひっかかったデータ数
to_engineer_again_num <- df_engineered %>% filter(condition(新品名)) %>% nrow()

#加工すべきものを加工しなかったデータ数(変化なしのもの)
mistake_revise <- sum((to_engineer$品名) %in% (to_engineer_again$新品名) == TRUE)


#出力結果を表にまとめる
name <- c("加工しないといけないデータ数",
          "新品名がcoditionを修正できたデータ数",
          "新品名が再度conditionに引っかかったデータ数",
          "加工すべきものを加工しなかったデータ数(変化なしのもの)" )

outcome <- c(to_engineer_num,to_engineer_anymore_num,to_engineer_again_num,mistake_revise)
outcome_table <- data.frame(cbind(name,outcome))


#余分なコード======================================================================================================


#③加工前修正不必要→加工後修正必要(0ならおっけー)
mistake_revise_sec <- sum((not_to_engineer$品名) %in% (to_engineer_again$新品名) == TRUE)

