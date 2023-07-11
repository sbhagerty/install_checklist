library('pins')
library('googlesheets4')


checklist<-read_sheet("1N9m5pG0QCrnX3Th5w9sNd9L2sY_jpq66NOLVI7Pg2V8")
pin_write(board_connect(), checklist, "install_checklist")

