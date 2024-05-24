# 点图+颜色映射构成气泡热图

#### 1. 定义因子顺序

- 使用 factor() 函数先定义好各列因子的顺序，防止绘图时按照默认首字母排序排乱了，里面 levels = data$Gene 意思是按原数据顺序排序。

- 因为 y 轴（基因）默认顺序是从下往上，所以按照原数据的顺序我们还需用 rev() 函数倒转一下，才能和 Figure 里顺序一致。

#### 2. 绘图

- geom_point(aes(fill = Avg_Expr, size = Pct_Expr0)) 使得数据映射到点的颜色和大小上
- facet_grid(Trajectory~., scales = "free", space='free', switch = "y") 是将图形按照 Trajectory 变量分组显示。因为每组中基因个数不相同，所以需要设置了 y 轴的刻度和间距，具体：scales="free" 使每个分面的 y 轴刻度根据数据的范围动态调整，而不是按照整个数据集的范围设置。space='free'表示允许每个分面之间的间距可以根据需要自由调整，而不受固定间距的限制。switch="y"表示交换 x 轴和 y 轴的位置，将 y 轴垂直排列在左侧，而不是默认的水平排列在底部。
- scale_size_continuous() 函数用于自定义点的大小范围，breaks = seq(0.2, 1, 0.2) 表示要显示 5 个刻度 (从 0.2 到 1，间隔为 0.2)。range = c(0, 5) 指定点的大小在图表中的实际显示范围。labels 指定每个值对应的标签。
- scale_fill_distiller() 函数用于自定义点的渐变色，palette="Greens" 表示使用绿色系的调色板。direction=1 表示颜色从浅到深进行渐变。
- 对于这种有两个及以上图例的，要修改图例标题，可以在 labs() 函数内和轴标题一起添加。
- ggpubr::rotate_x_text(hjust = 1) 旋转 x 轴的文本， hjust = 1 表示将文本根据 x 轴左对齐，使得文本保持垂直朝下的方向。

#### 

### 最重要的是：

码代码不易，如果你觉得我的教程对你有帮助，请**小红书 - Ttian6688**关注我！！！
