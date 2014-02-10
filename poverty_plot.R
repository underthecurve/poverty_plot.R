library(ggplot2)
library(foreign)
library(RColorBrewer)
library(grid)

## World Bank poverty estimates by country ($1.25/day at 2005 PPP) dataset downloaded via http://iresearch.worldbank.org/PovcalNet/index.htm

data <- read.csv("pov_pop.csv")

## The following loops through years, creating a scatterplot whereby countries are plotted according to latitude and longitude and weighted by population in extreme poverty

for (i in 1:length(year)) {
  test<-data[data$Year==year[i], ]
  p <- ggplot(test, aes(Longitude,Latitude,size=Poverty.Pop))
  plot <- p + geom_point(aes(color=Region),alpha=0.5) + scale_size_area(max_size=100,guide=FALSE) +ggtitle(paste("Countries sized by", year[i], "Poverty Headcount"))+scale_color_brewer(palette="Dark2")+geom_text(aes(label=ISO,size=1)) 
  
  ## display.brewer.all() gives all color palettes under RColorBrewer
  
  formatted <- plot + theme(plot.title=element_text(size=30),axis.line=element_blank(),axis.text.x=element_blank(),axis.text.y=element_blank(),axis.ticks=element_blank(),axis.title.x=element_blank(),axis.title.y=element_blank(),legend.position="bottom",legend.text=element_text(size=15),legend.key=element_rect(fill=NA),panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),plot.background=element_blank())+guides(colour=guide_legend(title=NULL,override.aes=list(size=10)))
  
  png(paste(year[i],"_plot",".png", sep= ""),width=1100,height=700, res=NA)
  print(formatted)
  dev.off()
}

