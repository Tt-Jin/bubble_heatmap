library(tidyverse)

#读入数据
data  = readxl::read_xlsx("data.xlsx")

#先定义好各列因子的顺序，防止绘图时按照默认首字母排序排乱了
data$Gene <- factor(data$Gene, levels = data$Gene %>% unique() %>% rev())
data$CellType <- factor(data$CellType, levels = data$CellType %>% unique())
data$Trajectory <- factor(data$Trajectory, levels = data$Trajectory %>% unique())

# 绘图
ggplot(data, aes(CellType, Gene)) + 
  geom_point(aes(fill = Avg_Expr, size = Pct_Expr0),
             shape = 21, color = "black") + 
  facet_grid(Trajectory~., scales = "free", space='free', switch = "y") +
  scale_size_continuous(breaks = seq(0.2, 1, 0.2), limits = c(0, 1),
                        range = c(0, 5),
                        labels = c("20%", "40%", "60%", "80%", "100%")) + 
  scale_fill_distiller(palette = "Greens", direction = 1) +
  #scale_fill_gradient(low = 'white', high = 'red') +
  theme_bw() +
  theme(panel.grid = element_blank(),
        panel.border = element_rect(color = "black", linewidth = 1),
        strip.background.y = element_rect(color="white"),
        strip.placement = "outside",
        strip.text.y = element_text(size = 13, color = "black", face = "bold"),
        axis.text.x = element_text(angle = 90, color = "black", size = 13, hjust = 1), 
        axis.text.y = element_text(color = "black", size = 13, vjust = 0.5),
        axis.ticks = element_blank(),
        legend.title = element_text(size = 13),
        legend.text=element_text(size=13)) + 
  guides(fill = guide_colorbar(ticks = FALSE, 
                               barheight = 8, 
                               frame.colour = "black")) + 
  labs(x = "", y = "", 
       fill = "Avg\nexpr", 
       size = "Pct nuclei\nexpr > 0") +
  ggpubr::rotate_x_text(hjust = 1)

ggsave("bubble-heatmap.png", width = 6, height = 9, dpi = 600)
ggsave("bubble-heatmap.pdf", width = 6, height = 9)
