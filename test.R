#test
path <- "C:\\Users\\sokur\\OneDrive\\デスクトップ\\2023_06_16.csv"
df <- read_csv(path, locale = locale(encoding = "shift-jis"))


#加工すべき変数と加工
condition <- (
  str_detect()|
    str_ditect()
)
to_engineer <- df %>% filter(conditon)
not_to_engineer <- df %>% filter(!conditon)

num_before_row(to_engineer)


num_whole <- df %>% filter(新品名!=品名) %>% NROW
