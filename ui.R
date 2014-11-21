shinyUI(pageWithSidebar(
  headerPanel("Hello Baseball Fans!"),
  sidebarPanel(
    h3('Select a year to see the top paid players for a particular year:'),
    numericInput('pickyear', 'Pick a year between 1985-2013', 2013, min=1985, max=2013, step=1),
    submitButton('Get Annual Salaries!'),
    p("The data will be presented in an interactive table that you can sort and filter."),
    h3(''),
    h3(''),
    p("Baseball salary data available from:
       Michael Friendly (2014). Lahman: Sean Lahman's Baseball Database.
       R package version 3.0-1."),
    p ("http://CRAN.R-project.org/package=Lahman")
  ),
  mainPanel(
    plotOutput('plot1', height=200),
    dataTableOutput('table1')
  )
))
