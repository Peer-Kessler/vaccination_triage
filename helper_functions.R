install_and_load <- function(packages) {
  # Überprüfe, welche Pakete noch nicht installiert sind
  new_packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  
  # Installiere fehlende Pakete
  if (length(new_packages) > 0) {
    message("Install packages: ", paste(new_packages, collapse = ", "))
    install.packages(new_packages)
  }
  
  # Lade alle Pakete
  for (pkg in packages) {
    library(pkg, character.only = TRUE)
  }
  
  message("All packages successfully loaded!")
}

conj <- function(data = .) {
  
  cache <- 
    data %>% 
    #eval(parse(text = data)) %>% 
    # pull(IV01_01) %>% 
    transmute(ID = ID,
              conj_var = str_remove_all(IV01_01,
                                        pattern = "\\{|\\}")
    ) %>% 
    # str_remove_all(eval(parse(text = conj_var)), "\\{|\\}") %>% 
    # tibble(my_string = .,
    #        ID = eval(parse(text = ID))) %>%
    separate(data = .,
             col = conj_var, 
             into = paste0("col", 1:240), 
             sep = ",") %>% 
    mutate(across(.cols = contains("col"),
                  .fns = str_remove_all,
                  pattern = "[\\\\\"]"
    )
    ) %>% 
    pivot_longer(cols = contains("col")) 
  
  
  df_conj <- 
    tibble(ID = rep(unique(cache$ID), each = 20),
           vig_set = rep(rep(1:10, rep(2, 10)), times = length(unique(cache$ID))),
           vig_profile = rep(rep(1:2, 10), times = length(unique(cache$ID))),
           Weight = NA,
           Age = NA,
           `Vaccination status` = NA,
           `Volunteer work` = NA, 
           Disability = NA,
           Children = NA,
           `Ventilation status` = NA,
           `Chance of survival with ventilation` = NA
    )
  
  conj_all <- tibble()  
  
  for (i in unique(cache$ID)) {                 # Participant ID
    
    cache_id <- cache %>% filter(ID == i)
    df_conj_id <- df_conj %>% filter(ID == i)
    
    for (j in 1:10) {              # Choice Task
      
      for (k in 1:8) {            # Attributes
        
        assign(x = str_extract(cache_id$value[str_detect(cache_id$value, 
                                                         pattern = paste0("F-", j, "-", k, ":")
        )
        ], 
        "(?<=:)[^:]+"),
        value = c(str_extract(cache_id$value[str_detect(cache_id$value, 
                                                        pattern = paste0("F-", j, "-1-", k,":")
        )
        ], 
        "(?<=:)[^:]+"),
        str_extract(cache_id$value[str_detect(cache_id$value, 
                                              pattern = paste0("F-", j, "-2-", k,":")
        )
        ], "(?<=:)[^:]+")
        )
        )
        
      }
      
      df_conj_id$Weight[(j*2-1):(j*2)] <- Weight
      df_conj_id$Age[(j*2-1):(j*2)] <- Age
      df_conj_id$`Vaccination status`[(j*2-1):(j*2)] <- `Vaccination status`
      df_conj_id$`Volunteer work`[(j*2-1):(j*2)] <- `Volunteer work` 
      df_conj_id$Disability[(j*2-1):(j*2)] <- Disability
      df_conj_id$Children[(j*2-1):(j*2)] <- Children
      df_conj_id$`Ventilation status`[(j*2-1):(j*2)] <- `Ventilation status`
      df_conj_id$`Chance of survival with ventilation`[(j*2-1):(j*2)] <- `Chance of survival with ventilation`
      
    }
    
    conj_all <- bind_rows(conj_all, df_conj_id)
    
  }
  
  conj_all
  
}


marginal_means_all <- function(model) {
  
  results_list <- list()
  
  for (i in all.vars(terms(model)[[3]])) {
    cache <- model %>% 
      ggeffects::predict_response(margin = "marginalmeans",
                                  terms = i
      )
    results_list[[i]] <- cache
    
  }
  
  bind_rows(results_list, .id = "term")
  
}