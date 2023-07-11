
get_checklist <- function(){
  pin_read(board_rsconnect(),"shannon/install_checklist") |> 
    mutate(Info =case_when(is.na(Description)&is.na(Resources) ~ paste(""),
                           is.na(Resources) ~ paste(Description),
                           is.na(Description) ~ paste("<b>Resources: </b>",Resources),
                           TRUE ~ paste(Description,"<b>Resources: </b>",Resources))) 
}

list_conditions <- function(wb_servers, connect_servers, pm_servers, os, auth){
  cust_conditions <- c("all", os, auth)
  cust_conditions <- if(wb_servers >0){append(cust_conditions, 'workbench')} else(cust_conditions)
  cust_conditions <- if(wb_servers >1){append(cust_conditions, 'workbench_ha')} else(cust_conditions)
  cust_conditions <- if(connect_servers >0){append(cust_conditions, 'connect')} else(cust_conditions)
  cust_conditions <- if(connect_servers >1){append(cust_conditions, 'connect_ha')} else(cust_conditions)
  cust_conditions <- if(pm_servers >0){append(cust_conditions, 'packagemanager')} else(cust_conditions)
  cust_conditions <- if(pm_servers >1){append(cust_conditions, 'pm_ha')} else(cust_conditions)
  cust_conditions
}



build_checklist <- function(data,cust_conditions) {
  filter(data, Conditions %in% cust_conditions)
  
}


format_table <- function(wb_servers, connect_servers, pm_servers, os, auth){
  data <- get_checklist()
  cust_conditions <- list_conditions(wb_servers, connect_servers, pm_servers, os, auth)
  checklist <- build_checklist(data,cust_conditions) 
  checklist %>%
  select(Category, Step, Info) %>%
  group_by(Category)  %>%
  gt() %>%
  fmt_markdown(columns=Info) %>% 
  cols_width(Step ~ "100pt",
           Info ~ "400pt") %>% 
  tab_options(column_labels.hidden = TRUE)} 
