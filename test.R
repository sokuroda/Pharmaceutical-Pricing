library(tidyverse)
library(stringr)

#test
#データ入力
path <- file.choose()
df <- read.csv(path,fileEncoding = "Shift-jis",colClasses = "character")

#関数の受け入れ
#path_function <- file.choose()
#source(path_function)

#加工すべき変数(「区分中で、"局"があれば無くす」をとりあえず行う)
condition <- (
  str_detect(df$品名,"局"))

#加工を加えるべきもの(to_engineer)と加えなくてよいもの(not_to_enginner)
to_engineer <- df %>% filter(condition) %>% nrow()
not_to_engineer <- df %>% filter(!condition) %>% nrow()

#「加工すべき変数」に引っかかったものを関数により処理する
engineer(to_engineer)

#
num_whole <- df_enginered %>% filter(new_stuff!=品名) %>% nrow()
