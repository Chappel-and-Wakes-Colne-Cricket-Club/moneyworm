library(ggplot2)
update_plots <- function(){
  bar_plot <- ggplot(data=totals[totals$Category == "Bar Sales",], mapping = aes(x = WeekEnd, y = Amount, group=Category, colour = Category)) + geom_line()
  match_plot <- ggplot(data=totals[totals$Category == "Match Fee",], mapping = aes(x = WeekEnd, y = Amount, group=Category, colour = Category)) + geom_line()
  all_plot <- ggplot(data=totals, mapping = aes(x = WeekEnd, y = Amount, group=Category, colour = Category)) + geom_line() + ylim(0,1e3)

  savepath <- Sys.getenv("SAVE_PATH")

  ggsave(paste(savepath, "bar_sales.pdf", sep=""), bar_plot, width = 297, height = 210, units = "mm" )
  ggsave(paste(savepath, "match_fees.pdf", sep=""), match_plot, width = 297, height = 210, units = "mm" )
  ggsave(paste(savepath, "all_zettle.pdf", sep=""), all_plot, width = 297, height = 210, units = "mm" )
}