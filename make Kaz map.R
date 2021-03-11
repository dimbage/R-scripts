library(ggplot2)
library(ggspatial)
library(sf)


url = "https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_KAZ_1_sf.rds"
download.file(url, "kaz.sf.rds")
kaz = readRDS("kaz.sf.rds")

cities_points <- cbind(kaz, st_coordinates(st_centroid(kaz$geometry)))
cities_points[["Population"]] = rnorm(nrow(cities_points),mean = 500000, sd = 200000)

library(ggplot2)
library(ggspatial)
ggplot(data = kaz) +
  geom_sf(data = cities_points, aes(fill = Population))+
  scale_fill_viridis_c(option = "plasma", trans = "sqrt")+
  geom_text(data= cities_points,aes(x=X, y=Y, label=NAME_1),
            color = "darkblue", check_overlap = F,size=2)+
  annotation_north_arrow(location = 'bl', which_north = 'true', pad_x = unit(0.2, 'in'), pad_y = unit(0.2, 'in'), style = north_arrow_fancy_orienteering) +
  ggtitle('Map of Kazakhstan (with pop size)') + 
  theme(panel.grid.major = element_line(color = gray(.5), linetype = 'dashed', size = 0.5), panel.background = element_rect(fill = 'aliceblue'))