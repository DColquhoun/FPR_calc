library(shiny)


ui <- fluidPage(
  
 # titlePanel (h2("Misinterpretation of P values [1]",  align = #"right")),
 
# Radiobuttns fixed by Brendan Halpin  "You can't use the same name formultiple inputs. That is, the inputs in the different conditionalPanelsneed different names.  
                

#===============================

titlePanel (h4("Calculator for false positive risk (FPR)",  align = "center")),

sidebarLayout(
  
  sidebarPanel(
    radioButtons("calctype", "Choose what to calculate:",selected = "calcprior", choices = c(
"1. calculate prior (for given FPR and P value)" = "calcprior"," 2. calculate P value (for given FPR and prior)" = "calcpval",
"3. calculate FPR (for given P value and prior)" = "calcFPR")),
    
    conditionalPanel(
      condition = "input.calctype == 'calcprior'",
      numericInput("pval1", label = h5("Observed P value"),              value = 0.05, min = 0, max = 1, step=0.01),
      numericInput("FPR1", label = h5("False positive risk"), value = 0.05, min = 0, max = 1, step=0.01)
    ),
    
    conditionalPanel(
      condition = "input.calctype == 'calcpval'",
      numericInput("FPR2", label = h5("False positive risk"),             value = 0.05, min = 0, max = 1, step=0.01),
      numericInput("prior2", label = h5("prior probability of          real effect"), value = 0.5, min = 0, max =         1, step=0.01)
    ),
    
  conditionalPanel(
      condition = "input.calctype == 'calcFPR'",
      numericInput("pval3",label = h5("observed P value"),value = 0.05, min = 0, max = 1, step=0.01),
      numericInput("prior3", label = h5("prior probability of real effect"), value = 0.5, min = 0, max = 1, step=0.01)
    ),

    inputPanel(
      numericInput("nsamp",label = h5("Number in each sample"), step = 1, value = 16, min = 2)
    ),

inputPanel(
  numericInput("effsize",label = h5("Effect size (as multiple of SD)"),step=0.003,min=0.01, value = 1.0)
),
    
    helpText("Please cite this page if you find it useful,          version 1.3 Longstaff,C. and Colquhoun D, https://davidcolquhoun.shinyapps.io/3-calcs-final/ Last accessed", Sys.Date())
  ),
  
  
#==========================
  mainPanel( 
    tabsetPanel(type="tab",
                tabPanel("Calculations", 
                         
                         helpText(h4("Results")),
                         
                         h5(textOutput("text3")), tableOutput("resultsTable")),
                
                
                
                tabPanel("Notes",
                         
helpText(h3("False positive risk calculations")),                
helpText("This web app was written by Colin Longstaff and David Colquhoun with help from Brendan Halpin."), 

helpText(h4("Statistical considerations")),
helpText("The question which we ask in refs[1 -3] is as follows. If you observe a \"significant\" P value after doing a single unbiased experiment, what is the probability that your result is a false positive?."),

helpText("\"False positive risk\" (FPR) is defined here as the probability that a result which is \"significant\" at a specified P value, is a false positive result. It is defined and explained in ref [3] The same thing was called \"false discovery rate\"in refs [1] and[2], and it was called \"false positive rate\" in earlier drafts of ref [3]   The notation in this field is a mess and it's important to check the definitions in each paper"),

helpText("There are two different ways to calculate FPR. These are explained in detail in section 10 of ref [1], and, more carefully, in section 3 of ref [3].  They  can be called the ", tags$em("p-equals"),"method, and the ", tags$em("p-less-than"), "method. The latter definition is used most frequently (eg by Ioannidis and by Wacholder), but the former method is more appropriate for answering our question. All three options give results that are calculated with both methods. The results with the ",tags$em("p-equals"),"method, give higher false positive risk, for any given P value, than the other method, but they are the appropriate way to answer the question."),

helpText(h4("How to run calculations")),

helpText("Click on the calculations tab, and choose which calculation to do by selecting one of the three radio buttons (top left)  The input boxes that are appropriate for the calculation will appear. There are three variables, observed P value, FPR and the prior probability that the null hypothesis is false. The calculator will work out any one of these, given numbers for the other two.  All three calculations require also the number of observations in each sample, The default number is 16 which gives a power of 0.78 for P = 0.05 and the default effect size, one standard deviation -see ref [1] and [3] for more details."  
),

helpText(h4("A real life example")),

helpText("A study of transcranial electromagnetic stimulation, published In ",tags$em("Science")," concluded that it \"improved associative memory performance\", P = 0.043.  If we assume that the experiment had adequate power (the sample size of 8 suggests that might be optimistic)  then, in order to achieve a false positive risk of 5% when we observe P = 0.043, we would have to assume a prior probability of 0.85 that the effect on memory was genuine (found from radio button 1). Most people would think it was less than convincing to present an analysis based on the assumption that you were almost certain (probability 0.85) to be right before you did the experiment.",
tags$br(),
"Another way to express the strength of the evidence provided by P = 0.043 is to note that it makes the existence of a real effect only 3.3 times as likely as the existence of no effect (likelihood ratio).  This would correspond to a minimum false positive risk of 23% if we were willing to assume that non-specific electrical zapping of the brain was as likely as not to improve memory (prior probability of a real effect was 0.5) (found via radio button 3).",
tags$br(),
"The radio button 2 option shows that in the most optimistic case (prior = 0.5), you need to have P = 0.008 to achieve an FPR of 5 percent. [example from ref 3] "  
         
),

helpText(h4("Notes")),

helpText("From ver 1.1 onwards, the effect size (expressed as a multiple of the standard deviation of the observations) can be entered. The same results are found if the power is kept constant. For example effect size = 1 and n = 16 gives power = 0.78. For an effect size of 0.5 SD, n = 61 gives similar power and similar FPR etc.  And for an effect size of 0.2 SD, a power of 0.78 requires n = 375, and again this gives similar FPR etc. See ref [4]. \n 
         So choose n so that the calculated power matches that of your experiment."
),
helpText("From ver 1.3 onwards, the values of power that are printed out are calculated for P = 0.05 and the specified effect size (expressed as a multiple of the standard deviation of the observations).  In earlier versions they were caluclated using the  observed P value)."
),
helpText("There is a popular account of the logic involved in ref [6]. And ref [3] has, on pp 18-19, a response to the recent 72 author paper, Benjamin et al  [7], on related topics"),
helpText(h4("References")),

helpText(
  "1.	Colquhoun D.(2014) An investigation of the false discovery rate and the misinterpretation of p-values. Royal Society Open Science. 1(3):140216. doi: 10.1098/rsos.140216.",
  tags$a(href="http://rsos.royalsocietypublishing.org/content/1/3/140216", "Click for full text"),
 tags$br(),
"2. 	Colquhoun D. False discovery rates: the movie",
tags$a(href="https://www.youtube.com/watch?v=tRZMD1cYX_c", "Click for YouTube"),
tags$br(),
"3. 	Colquhoun D. (2017). The reproducibility of research and misinterpretation of P values.bioRxiv, May 31, 2017, doi: http://dx.doi.org/10.1101/144337",
tags$a(href="http://www.biorxiv.org/content/early/2017/08/07/144337", "Click for full text"),
tags$br(),
"4,   Colquhoun. D, (2015) Response to comment by Loiselle & Ramchandra (2015), Royal Society Open Science: DOI: 10.1098/rsos.150319", tags$a(href="http://rsos.royalsocietypublishing.org/content/2/8/150319", "Click for full text"),
tags$br(),
"6. 	Colquhoun D. (2016). The problem with p-values. Aeon Magazine",
tags$a(href="https://aeon.co/essays/it-s-time-for-science-to-abandon-the-term-statistically-significant", "Click for full text"),
tags$br(),
"7. 	Benjamin, D. et al. (2017)  Redefine Statistical Significance. PsyArXiv Preprints, July 22, 2017.", tags$a(href="https://dx.doi.org/10.17605/OSF.IO/MKY9J", "Click for full text") 


)    # end of helpText references
)    #end of tabpanel
)
  
)   
)
)

#=========================================
server <-  function(input, output){
  
  
  output$resultsTable<-renderTable({
    
    if (input$calctype == "calcprior") {
      pval = input$pval1
      FPR = input$FPR1
      prior = NaN
    }
    if (input$calctype == "calcpval") {
      pval = NaN
      FPR = input$FPR2
      prior = input$prior2
    }
    if (input$calctype == "calcFPR") {
      pval = input$pval3
      FPR = NaN
      prior = input$prior3
    }
    #
    nsamp=input$nsamp   
    #    
    mymu1=0
    mymu2=input$effsize
    mysd1=1
    mysd2=1
    sigma=1
    delta1=mymu2-mymu1
    sdiff=sqrt(sigma^2/nsamp + sigma^2/nsamp)
    #    sdiff=sqrt(input$sigma^2/input$nsamp + sigma^2/input$nsamp)
    df=2*(nsamp-1)
    # Note FPR doesn't need calculation of power for p-equals case  
    #
      if (input$calctype == "calcprior") {
      #under H0, use central t distribution
      tcrit=qt((1-pval/2),df,ncp=0)
      x0=tcrit
      y0=dt(x0,df,0)
      #
      # under H1 use non-central t distribution
      ncp1=delta1/sdiff     #non-centrality paramater
      x1=x0  #tcrit
      y1=dt(x1,df,ncp=ncp1)
      # check solution
      #  pcheck=pt(y1,df,ncp=ncp1)
      #  pcheck
      
      p0=2*y0
      p1=y1
      #Rearrange result for FPR to calculate prior for given pval
      prior=(p0*(1-FPR))/(p1*FPR + (p0*(1-FPR)))
      
      myp=power.t.test(n=nsamp,sd=sigma,delta=delta1,sig.level=pval,type="two.sample",alternative="two.sided",power=NULL)
      power = myp$power
      prior0=pval*(1-FPR)/(pval*(1-FPR) + power*FPR)
      prior1=round(prior,4)    #rounded to 4 sig figs
      prior10=round(prior0,4)
      power1=round(power,4)
# For print, calculate power for p=0.05 and specified eff size 
      myp2=power.t.test(n=nsamp,sd=sigma,delta=delta1,sig.level=0.05,type="two.sample",alternative="two.sided",power=NULL)
      power2 = myp2$power
      power21=round(power2,4)
#      
      ResMat<-matrix(c("INPUT", "", "",
                       "FPR", FPR, "",
                       "Observed P value", pval, "",
                       "Observations per sample", nsamp, "",
                       "Sample1 mean,  sd", mymu1, mysd1,
                       "Sample2 mean,  sd", mymu2, mysd2,
                       " Effect size (mult of SD)",input$effsize,"",
                        "","","",
                       "OUTPUT", "p-equals case", 
                         "P-less-than case",
                       "prior prob of H1", prior1,prior10,
                       "power (for p=0.05, and effect size)", power21, power21),
                        byrow=TRUE, nrow = 11)
      
      
    }    #end of if (input$calctype == "calcprior")
    #
    #===================================
    if (input$calctype == "calcpval") {
      pguess=c(10^-8, 0.99999999)   # pval must be between 0 and 1.
      #Define function to calculate FPR 
      calc.FPR =  function(pval,nsamp,prior,sigma,delta1)
      {
        sdiff=sqrt(sigma^2/nsamp + sigma^2/nsamp)
        df=2*(nsamp-1)
        # Note FPR doesn't need calculation of power for p-equals case  #  
        #under H0, use central t distribution
        tcrit=qt((1-pval/2),df,ncp=0)
        x0=tcrit
        y0=dt(x0,df,0)
        #
        # under H1 use non-central t distribution
        ncp1=delta1/sdiff     #non-centrality paramater
        x1=x0  #tcrit
        y1=dt(x1,df,ncp=ncp1)
        #
        # Calc false positive rate
        p0=2*y0
        p1=y1
        LRH1=p1/p0
        FPR=((1-prior)*p0)/(((1-prior)*p0) + prior*p1)
        FPR
        output=c(FPR,LRH1)
        return(output)
      }
      # end of function calc.FPR
      #===============================
      # Now calc.FPRO, for the p-less-than case
      calc.FPR0 =  function(pval,nsamp,prior,sigma,delta1){
        myp=power.t.test(n=nsamp,sd=sigma,delta=delta1,sig.level=pval,type="two.sample",alternative="two.sided",power=NULL)
        power = myp$power
        PH1=prior
        PH0=1-PH1
        FPR0=(pval*PH0/(pval*PH0 + PH1*power))
        LR0=power/pval
        output=c(FPR0,LR0,power)
        return(output)
      }
      # end of function calc.FPR0  
      #========================================
      
      
      #
      # Define functiob, f.root, of pval for given FPR, prior etc. Solve for FPR = FPR1 using uniroot()
      #   calc.FPR =  function(pval,nsamp,prior,sigma,delta1)
      f.root = function(pval,nsamp,prior,sigma,delta1)
      {
        FPRcalc=calc.FPR(pval,nsamp,prior,sigma,delta1)
        x= FPRcalc[1]-FPR   #=0 when FPRcalc = FPR!
        return (x)
      }
      
      plow=f.root(pguess[1],nsamp,prior,sigma,delta1)
      phi=f.root(pguess[2],nsamp,prior,sigma,delta1)
      
      if(plow*phi>0) {
        pval1=NaN
        LR1=NaN
      } else { 
        out1=uniroot(f = f.root,nsamp=nsamp,prior=prior,sigma=sigma,delta1=delta1,interval=pguess, tol=10^-10, maxiter=10000, check.conv=TRUE)
        pval1=out1$root   #pval that gives FPR= FPR
        # calc.FPR =  function(pval,nsamp,prior,sigma,delta1)
        out11=calc.FPR(pval1,nsamp,prior,sigma,delta1)
        LR1=out11[2]
      }
#====================
# repeat above for p-less-than case     
      
      f.root0 = function(pval,nsamp,prior,sigma,delta1)
      {
        FPRcalc0=calc.FPR0(pval,nsamp,prior,sigma,delta1)
        x= FPRcalc0[1]-FPR   #=0 when FPRcalc0 = FPR!
        return (x)
      }
      
      plow=f.root0(pguess[1],nsamp,prior,sigma,delta1)
      phi=f.root0(pguess[2],nsamp,prior,sigma,delta1)
      
      if(plow*phi>0) {
        pval10=NaN
        LR10=NaN
      } else { 
        out10=uniroot(f = f.root0,nsamp=nsamp,prior=prior,sigma=sigma,delta1=delta1,interval=pguess, tol=10^-10, maxiter=10000, check.conv=TRUE)
        pval10=out10$root   #pval that gives FPR= FPR
        # calc.FPR =  function(pval,nsamp,prior,sigma,delta1)
        out110=calc.FPR0(pval10,nsamp,prior,sigma,delta1)
        LR10=out110[2]
      }
 #
#      
#==========================      
      pval2=round(pval1,6)    # 6 sig figs
      LR2=round(LR1,4)        # 4 sig figs
      pval20=round(pval10,6)    # 6 sig figs
      LR20=round(LR10,4)  
      
      ResMat<-matrix(c("INPUT", "", "",
                       "FPR", FPR, "",
                       "Prior prob of H1=", prior, "",
                       "observations per sample", nsamp, "",
                       "Sample1 mean,  sd", mymu1, mysd1,
                       "Sample2 mean,  sd", mymu2, mysd2,
                       "","","",            
                       "OUTPUT", "p-equals case",
                       "p-less-than case",
                       "p value", pval2, pval20,
                       "Lik, ratio, L(H1)/L(H0)", LR2,LR20),
                     byrow=TRUE, nrow = 10)
      
    }    #end of if (input$calctype == "calcpval")
    
    #=================================
    if (input$calctype == "calcFPR") {
      #under H0, use central t distribution
      tcrit=qt((1-pval/2),df,ncp=0)
      x0=tcrit
      y0=dt(x0,df,0)
      #
      # under H1 use non-central t distribution
      ncp1=delta1/sdiff     #non-centrality paramater
      x1=x0  #tcrit
      y1=dt(x1,df,ncp=ncp1)
      
      #   Calc false positive risk
      p0=2*y0
      p1=y1
      FPR=((1-prior)*p0)/(((1-prior)*p0) + prior*p1)
      #FPR
      LR1=p1/p0
      
      myp4=power.t.test(n=nsamp,sd=sigma,delta=delta1,sig.level=pval,type="two.sample",alternative="two.sided",power=NULL)
      power = myp4$power
      PH1=prior
      PH0=1-PH1
      FPR0=(pval*PH0/(pval*PH0 + PH1*power))
      LR10=power/pval
      #
      power1 = round(power,4)
      LR2=round(LR1,4)
      LR20=round(LR10,4)
      FPR1=round(FPR,4)
      FPR10 = round(FPR0,4)
      # Print power for p = 0.05 and specified effect size
      mypp=power.t.test(n=nsamp,sd=sigma,delta=delta1,sig.level=0.05,type="two.sample",alternative="two.sided",power=NULL)
      powerp = mypp$power
      powerp1 = round(powerp,4)
      #
      
      ResMat<-matrix(c("INPUT", "", "",
                       "Observed p value", pval, "",
                       "prior prob of H1", prior, "",
                       "observations per sample", nsamp, "",
                       "Sample1 mean, sd", mymu1, mysd1,
                       "Sample2 mean, sd", mymu2, mysd2,
                       " Effect size (mult of SD)",input$effsize,"",
                       " "," "," ",
                       "OUTPUT", "p-equals case",
                       "p-less-than case",
                       "FPR", FPR1, FPR10,
                       "Likelihood ratio", LR2, LR20,
                     "power (for p = 0.05 and effect size)", powerp1, powerp1),
                     byrow=TRUE, nrow = 12)
      
      
    }    # end of  if (input$calctype == "calcFPR")
    #
    
#   write.table(ResMat, "clipboard", sep="\t", col.names=T,row.names=F)  #"clipboard works locally only
    
    colnames(ResMat) = c(" ", " "," ")
    write.table(ResMat, sep="\t", col.names=T,row.names=F)#
#   as.matrix(ResMat)    
    ResMat

  }
  )
}

#======================================================

shinyApp(ui = ui, server = server)
