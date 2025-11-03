# GitHub Respository for the Article "Vaccination status in triage decisions: Identifying effects of punishment and in-group biases"

Author: Peer Keßler, M.A.

This repository contains the code and data used for the article "Vaccination status in triage decisions: Identifying effects of punishment and in-group biases". The study investigates how vaccination status influences triage decisions in medical scenarios.

## Abstract

In the context of triage decisions, it has been argued that patients who fulfill the social contract to get vaccinated against a disease should be prioritized over unvaccinated individuals. Empirical evidence on the preferences of the general public are generally in line with punishing unvaccinated patients. However, the results vary depending on the vaccination status of the respondents. This study examines possible mechanisms behind the unequal treatment of vaccinated and unvaccinated patients in triage decisions by drawing from a game theoretical approach and social identity theory. It is argued that accurately identifying the effects of punishment requires controlling for in-group biases. Data from a conjoint experiment with a sample from North America and Europe is utilized. Participants were asked to choose one of two patients to receive a life-saving respiratory ventilator. The patients differed randomly in terms of their vaccination status. The effect of punishment is identified using a difference-in-difference approach. The results indicate that unequal treatment of vaccinated and unvaccinated patients can be attributed to in-group biases for unvaccinated individuals, while vaccinated individuals show evidence for in-group biases as well as punishment effects. The results point towards a differentiated and theory-based interpretation of results on preferences in triage decisions.

## Use of the Repository

The repository includes the folder for the raw (`triage_2023.csv`) and altered data (`df_conj.R`).

The complete analysis including the code for the graphs is provided in the quarto document `analysis.qmd`. `helper_functions.R` contains functions used in the analysis.