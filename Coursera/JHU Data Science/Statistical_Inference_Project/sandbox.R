set.seed(8310) # For reproducibilty
lambda <- 0.2
number.of.simulations <- 1000
n <- 40  # distribution of 40 exponentials will be investigated.

simulation <- matrix(rexp(number.of.simulations * n, rate=lambda), number.of.simulations, n)
simulation.mean <- rowMeans(simulation)

theoretical.mean <- 1/lambda
theoretical.mean
simulated.mean <- mean(simulation.mean)
simulated.mean



library(ggplot2)
simulation.mean.df <- data.frame(simulation.mean)  # convert to dataframe for plotting
plot <- ggplot(simulation.mean.df, aes(x = simulation.mean)) + geom_histogram(color="black", fill = "steelblue", binwidth = 0.1, alpha = 0.2)
plot <- plot + ggtitle("Figure 1: Distribution of Simulation Means")
plot <- plot + ylab("Count") + xlab("Simulation Means")
# Put mean values in the dataframe for plotting as veritical lines
means.df <- data.frame(xintercept = c(theoretical.mean, simulated.mean), Means = factor(c("Theoretical", "Simulated")))
plot <- plot + geom_vline(aes(xintercept = xintercept, linetype = Means), data = means.df, color = c("firebrick", "forestgreen"), show_guide = T)
plot


theoretical.variance <- (1/lambda)^2/n
theoretical.variance
sample.variance <- round(var(simulation.mean), 3)
sample.variance


simulation.mean.df <- data.frame(simulation.mean)  # convert to dataframe for plotting
plot <- ggplot(simulation.mean.df, aes(x = simulation.mean)) 
plot <- plot + geom_histogram(aes(y=..density..), color="black", fill = "steelblue", binwidth = 0.1, alpha = 0.2)
plot <- plot + geom_density()
plot <- plot + stat_function(fun = dnorm, colour = "red", args = list(mean = 5, sd = sqrt(0.625)))
plot





#####################
set.seed(1234)
dat <- data.frame(cond = factor(rep(c("A","B"), each=200)), rating = c(rnorm(200),rnorm(200, mean=.8)))
plot <- ggplot(dat, aes(x = rating))
plot <- plot + geom_histogram(aes(y=..density..), color="black", fill = "steelblue", binwidth = 0.5, alpha = 0.2)
plot <- plot + geom_density(show_guide=TRUE)
plot <- plot + stat_function(aes(color = "Normal"), fun = dnorm, colour = "red", args = list(mean = 0.3, sd = 1))
plot


ggsave(filename = "plot.png", dpi = 96)

set.seed(1234)
dat <- data.frame(cond = factor(rep(c("A","B"), each=200)), rating = c(rnorm(200),rnorm(200, mean=.8)))
plot <- ggplot(dat, aes(x = rating))
plot <- plot + geom_histogram(aes(y = ..density..), color = "black", fill = "steelblue", binwidth = 0.5, alpha = 0.2)
plot <- plot + geom_density(aes(color = "Simulated"))
plot <- plot + stat_function(aes(colour = "Normal"), fun = dnorm, args = list(mean = 0.3, sd = 1)) 
plot <- plot + scale_colour_manual("Density", values = c("red", "black"))
plot

ggsave(filename = "normalplot.png", dpi = 96)

