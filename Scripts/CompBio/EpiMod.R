######################################################################################################
# using EpiModel basics
# P. Alexander Burnham
# 21, March 2017
######################################################################################################

# source EpiModel package
library(EpiModel)


############################################################################################
## Example 2: Two-group SIR model with vital dynamics (deterministic compartmental models DCM)
param <- param.dcm(inf.prob = 0.2, inf.prob.g2 = 0.5,
                   act.rate = 3, balance = "g1",
                   rec.rate = 1/50, rec.rate.g2 = 1/50,
                   b.rate = 1/100, b.rate.g2 = NA,
                   ds.rate = 1/100, ds.rate.g2 = 1/100,
                   di.rate = 1/90, di.rate.g2 = 1/90,
                   dr.rate = 1/100, dr.rate.g2 = 1/100)

init <- init.dcm(s.num = 500, i.num = 1, r.num = 0,
                 s.num.g2 = 500, i.num.g2 = 1, r.num.g2 = 0)

control <- control.dcm(type = "SIR", nsteps = 500)

mod2 <- dcm(param, init, control)

plot(mod2)

############################################################################################
# 1 sim
## Stochastic ICM SIS model with 1 simulations (individual contact model)
param <- param.icm(inf.prob = 0.8, act.rate = 2, rec.rate = 0.1)
init <- init.icm(s.num = 500, i.num = 1)
control <- control.icm(type = "SIS", nsteps = 25,
                       nsims = 1, verbose = FALSE)
mod <- icm(param, init, control)
# Default output is mean across simulations
as.data.frame(mod)

plot(mod)

############################################################################################
## Stochastic ICM SIS model with 5 simulations
param <- param.icm(inf.prob = 0.8, act.rate = 2, rec.rate = 0.1)
init <- init.icm(s.num = 500, i.num = 1)
control <- control.icm(type = "SIS", nsteps = 25,
                       nsims = 5, verbose = FALSE)
mod <- icm(param, init, control)
# Default output is mean across simulations
as.data.frame(mod)

plot(mod)

############################################################################################
## Stochastic ICM SIS model with 10 simulations
param <- param.icm(inf.prob = 0.8, act.rate = 2, rec.rate = 0.1)
init <- init.icm(s.num = 500, i.num = 1)
control <- control.icm(type = "SIS", nsteps = 25,
                       nsims = 10, verbose = FALSE)
mod <- icm(param, init, control)
# Default output is mean across simulations
as.data.frame(mod)

plot(mod)
#############################################################################################

param <- param.dcm(inf.prob = 0.2, 
                   act.rate = 1,
                   rec.rate = 1/20,
                   b.rate = 1/95,
                   ds.rate = 1/100, 
                   di.rate = 1/80, 
                   dr.rate = 1/100)

init <- init.dcm(s.num = 1000,
                 i.num = 1,
                 r.num = 0)

control <- control.dcm(type = "SIR", nsteps = 500, dt = 0.5)

mod <- dcm(param, init, control)

plot(mod, popfrac = FALSE, alpha = 0.5,
     lwd = 4, main = "Compartment Sizes")





