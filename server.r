library(shiny)
library(Lahman)
library(xtable)
data(Salaries)
data(Master)
give10<-function(pickyear){
  mydat<-Salaries[Salaries$yearID==pickyear,]
  topten<-mydat[order(mydat$salary, decreasing=T),]
  withnames<-merge(topten, Master, by=c('playerID'))
  withnames$salmil<-paste("$", format(round(withnames$salary/10^6,3), nsmall=3), ' million USD', sep="")
  myout<-withnames[order(withnames$salary, decreasing=T),c('yearID','nameFirst', 'nameLast','teamID', 'salmil')]
  names(myout)<-c('Year','First Name','Last Name', 'Team', 'Salary')
  myout
}

sal.sum<-aggregate(salary~yearID, data=Salaries, max)
sal.sum$salary<-sal.sum$salary/10^6

shinyServer(
  function(input, output) {
    output$plot1<-renderPlot({
      par(mar=c(5,5,2,0))
      plot(salary~yearID, sal.sum, type='l', main='Annual maximum MLB player salary',
           xlab="Year", ylab="Salary (million USD)", lwd=3)})
    output$table1<-renderDataTable({give10(input$pickyear)})
  }
)
