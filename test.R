library(tidyverse)
library(stringr)
library(tidyr)

#test
#データ入力
path <- "./data/2023_06_16.csv"
df <- read.csv(path,fileEncoding = "Shift-jis",colClasses = "character")
df <- distinct(df,品名)

#関数を受け入れる
#カタカナやめる
source("./rscript/function.R")

#加工すべき変数
#「局」があるもの→2828
#「　局　」→131
#「局　」→2284
#「局※ 　」→305
#「局麻　」→24
#「（局）　」→206
#「局麻用」や途中に入っているものもある(対処してはいけない)
# 全てたしても2828にならないため、重複を含んでいる。

#functionの役割→元のベクトルと新しく作ったベクトルを比較
#varには、品名と新品名が入る。

condition <- function(var){
  out <- str_detect(var,"局　") 
  return(out)
}

#| str_detect(df$品名,"局※　") 
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
to_engineer_ok <- df_engineered %>% filter(!condition(新品名))



#加工しないといけないデータ数
to_engineer_num <- df %>% filter(condition(品名)) %>% nrow()

#新品名がcoditionを修正できたデータ数
to_engineer_ok_num <-  to_engineer_ok %>% nrow()

#新品名が再度conditionにひっかかったデータ数
to_engineer_again_num <- to_engineer_again %>% nrow()

#加工すべきものを加工しなかったデータ数(変化なしのもの)
no_change <- sum((to_engineer$品名) %in% (df_engineered$新品名) == TRUE)

#==========================================================================================
#証明したいこと
#加工する前後で変化の種類は4種類ある。
#①加工すべき変数→想定通り加工できた(conditionに引っかからない)
#<証明方法>
#to_engineer_ok_numが全数。

#②加工すべき変数→ⅰ想定通りではない加工(再度conditionに引っかかる)
#<証明方法>
#ⅰ　to_engineer_again_numが0なら良い。
#ⅱ　no_changeが0ならよい。

#③加工すべきではない変数を加工してしまう。（「局麻用」など）
#　または、加工しないといけない変数が加工されていない(conditionの候補の漏れ)
#上記2つは、conditionの網羅性を検証するもの
#証明方法(新たなファイルcodition_checkを作成し、coditionとは異なるロジックで確認)

#④加工すべきではない変数をそのままにする。
#③を満たしていれば④は保証される。


#出力結果を表にまとめる(ここでは、加工すべきと判断した変数のみを評価対象としている)
name <- c("加工しないといけないデータ数",
          "①新品名がcoditionを修正できたデータ数",
          "②新品名が再度conditionに引っかかったデータ数",
          "②加工すべきものを加工しなかったデータ数(変化なしのもの)" )

outcome <- c(to_engineer_num,to_engineer_ok_num,to_engineer_again_num,no_change)
outcome_table <- data.frame(cbind(name,outcome))






#余分なコード======================================================================================================


#③加工前修正不必要→加工後修正必要(0ならおっけー)
mistake_revise_sec <- sum((not_to_engineer$品名) %in% (to_engineer_again$新品名) == TRUE)

