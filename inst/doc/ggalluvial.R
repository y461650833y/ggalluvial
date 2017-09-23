## ----setup, echo=FALSE, message=FALSE, results='hide'--------------------
library(ggalluvial)
knitr::opts_chunk$set(fig.width = 6, fig.height = 4, fig.align = "center")

## ----example alluvial diagram using Titanic dataset, echo=FALSE----------
ggplot(data = to_lodes(as.data.frame(Titanic),
                       key = "Demographic",
                       axes = 1:3),
       aes(x = Demographic, stratum = value, alluvium = id,
           weight = Freq, label = value)) +
  geom_alluvium(aes(fill = Survived)) +
  geom_stratum() + geom_text(stat = "stratum") +
  ggtitle("passengers on the maiden voyage of the Titanic",
          "stratified by demographics and survival")

## ----Berkeley admissions dataset-----------------------------------------
head(as.data.frame(UCBAdmissions), n = 12)
is_alluvial(as.data.frame(UCBAdmissions), logical = FALSE)

## ----alluvial diagram of UC Berkeley admissions dataset------------------
ggplot(as.data.frame(UCBAdmissions),
       aes(weight = Freq, axis1 = Gender, axis2 = Dept)) +
  geom_alluvium(aes(fill = Admit), width = 1/12) +
  geom_stratum(width = 1/12, fill = "black", color = "grey") +
  geom_label(stat = "stratum", label.strata = TRUE) +
  scale_x_continuous(breaks = 1:2, labels = c("Gender", "Dept")) +
  ggtitle("UC Berkeley admissions and rejections, by sex and department")

## ----parallel sets plot of Titanic dataset-------------------------------
ggplot(as.data.frame(Titanic),
       aes(weight = Freq,
           axis1 = Survived, axis2 = Sex, axis3 = Class)) +
  geom_alluvium(aes(fill = Class),
                width = 1/8, knot.pos = 0, reverse = FALSE) +
  guides(fill = FALSE) +
  geom_stratum(width = 1/8, reverse = FALSE) +
  geom_text(stat = "stratum", label.strata = TRUE, reverse = FALSE) +
  scale_x_continuous(breaks = 1:3, labels = c("Survived", "Sex", "Class")) +
  coord_flip() +
  ggtitle("Titanic survival by class and sex")

## ----lode form of Berkeley admissions dataset----------------------------
UCB_lodes <- to_lodes(as.data.frame(UCBAdmissions), axes = 1:3)
head(UCB_lodes, n = 12)
is_alluvial(UCB_lodes, logical = FALSE)

## ----time series alluvia diagram of refugees dataset---------------------
data(Refugees, package = "alluvial")
country_regions <- c(
  Afghanistan = "Middle East",
  Burundi = "Central Africa",
  `Congo DRC` = "Central Africa",
  Iraq = "Middle East",
  Myanmar = "Southeast Asia",
  Palestine = "Middle East",
  Somalia = "Horn of Africa",
  Sudan = "Central Africa",
  Syria = "Middle East",
  Vietnam = "Southeast Asia"
)
Refugees$region <- country_regions[Refugees$country]
ggplot(data = Refugees,
       aes(x = year, weight = refugees, alluvium = country)) +
  geom_alluvium(aes(fill = country, colour = country),
                alpha = .75, decreasing = FALSE) +
  scale_fill_brewer(type = "qual", palette = "Set3") +
  scale_color_brewer(type = "qual", palette = "Set3") +
  facet_wrap(~ region, scales = "fixed") +
  ggtitle("refugee volume by country of origin and geographic region")

## ----alluvial diagram of majors dataset----------------------------------
data(majors)
majors$curriculum <- as.factor(majors$curriculum)
ggplot(majors,
       aes(x = semester, stratum = curriculum, alluvium = student,
           fill = curriculum, label = curriculum)) +
  geom_flow(stat = "alluvium", lode.guidance = "rightleft") +
  geom_stratum() +
  theme(legend.position = "bottom") +
  ggtitle("student curricula across several semesters")

## ----alluvial diagram of vaccinations dataset----------------------------
data(vaccinations)
levels(vaccinations$response) <- rev(levels(vaccinations$response))
ggplot(vaccinations,
       aes(x = survey, stratum = response, alluvium = subject,
           weight = freq,
           fill = response, label = response)) +
  geom_flow() +
  geom_stratum(alpha = .5) +
  geom_text(stat = "stratum", size = 3) +
  theme(legend.position = "none") +
  ggtitle("vaccination survey responses at three points in time")

## ----session info--------------------------------------------------------
sessionInfo()
