

shinyUI(dashboardPage(skin = 'black',
        dashboardHeader(title = "Startup Capital Investments", titleWidth = 300),
        dashboardSidebar(
          sidebarUserPanel('Vineet Luthra',
                           image = 'http://s3.amazonaws.com/garysguide/78e4baf3e87b4934a8b0028fbca0a595original.jpg'),
          sidebarMenu(
            menuItem("Introduction", tabName = 'intro', icon = icon('money')),
            menuItem("Outlook", tabName = 'Outlook', icon = icon('money'),
              menuSubItem("Global", tabName = 'Global', icon = icon('map-o')),
              menuSubItem("Domestic", tabName = 'Domestic', icon = icon('map-o'))),
            menuItem('Industries', tabName = 'industries', icon = icon('money'),
                     menuSubItem("Overview", tabName = 'Overview', icon = icon('bar-chart-o')),
                     menuSubItem("Comparasion", tabName = 'Comparasion', icon = icon('bar-chart-o'))),
            menuItem('Capital Funding', tabName = 'investments', icon = icon('money'),
                     menuSubItem("Quarterly Figures", tabName = 'Quarters', icon = icon('line-chart')),
                     menuSubItem("FundingType", tabName = 'FundingType', icon = icon('line-chart'))),
            menuItem('Summary', tabName = 'summary', icon = icon('money'),
                     menuSubItem('Acquisitions/Post-IPO', tabName = 'acquisitions', icon = icon('pie-chart')),
                     menuSubItem('Future Outlook', tabName = 'future', icon = icon('area-chart')))
          )
        ),
        dashboardBody(
          tabItems(
            tabItem(tabName = 'intro',
                    fluidRow(
                        title = 'Text',
                        plotOutput(outputId = 'fullsum'),
                        h1('Overview', class = 'text-muted'),
                        h4("The Startup scene has seen dramatic change over the last decade. Barriers to entry have become increasingly easier 
                           as small startups have turned into major players in todays global economy.
                            The data collected is from Q1 of 2004  to Q1 of 2014 providing information on companies from around the world along
                           with the amount of money that has been invested for their capital growth. We can use this information to 
                          analyze trends and identify key performers based on volume and total amount invested. 
                          By doing so I hope to provide insight for both the investor and the enteprenuer."),
                        h1('Types of Funding', class = 'text-muted'),
                        h4("Fueling this global change are Angel Investors, Venture Capitalists and many other types of insitutions.
                            Usually angel investments are capital provided at the beginning stages of a company's growth, these are then
                           followed by a rounds of series investments(A,B,C+), and then finally once a company has scaled large enough
                         and has shown potential for high returns, Venture Capital and Private Equity groups will invest with usually very 
                           high levels of capital funding")
                        )),
              tabItem(tabName = 'Global',
                    fluidRow(
                        h1('Global Expansion..', class = 'text-muted'),
                        h4('The below outlines the capital funding landscape around the world. The US has a firm dominace over the
                        rest of the countries interms of volume, but as time goes on we can see investments 
                          start to move towards emerging markets such as South America and Eastern Europe.'),
                        box(
                        sliderInput('Years', 'Years', 2004, 2013,2004, sep = ''))),
                    fluidRow(
                        title = 'Heatmap',
                        htmlOutput('globalgvis'),
                      selectInput(inputId = 'Pages', 'Number of rows:',
                                  choices = c(1:100), selected = 10)),
                      fluidRow(
                      box(
                        tableOutput(outputId = 'global_table'))
                    )
                      ),
            tabItem(tabName = 'Domestic',
                  fluidRow(
                  h1('US Coverage..', class = 'text-muted'),
                  h4('If we focus on the US we see that Silicon Valley coninues to dominate the start up scene. Some of the
                  other top performers include New York, Boston, and Washington DC. But one thing to note, is that the areas to invest is
                  continuing to expand throughout the years which is coorelating to a larger number of investments'),
                  box(
                  title = 'Pick a Year',
                  sliderInput('Years2', 'Years2', 2004, 2013,2004, sep = ''))),
                  fluidRow(
                    title = 'Heatmap',
                    htmlOutput('gvis')
                     ),
              fluidRow(
              selectInput(inputId = 'Pages2', 'Number of rows:',
                          choices = c(1:50), selected = 10),
              box(
              tableOutput(outputId = 'usa_table'))
                  )),
            tabItem(tabName = 'Overview',
                    h1('High Performing Industries', class = 'text-muted'),
                    fluidRow(
                      plotOutput(outputId = 'TopPerYear'),
                      h4('When obvserving specific industries I narrowed down the categories to investments that have surpassed $5 Billion USD
                          per year. In my finding there is no suprise that software has outperformed,
                      many of the other categories. But suprisingly Biotech has been a consistent high performer almost every year.
                      I believe that this is due to the advancements in genetic research and changes in the Healthcare Industry 
                      (ex. ObamaCare).
                      We slowly start to see new industries come in to the market and remain as valuable opportunties to invest. 
                      I think we can expect these trends to continue moving forward')
                    )
            ),
            tabItem(tabName = 'Comparasion',
                h1('Industry Breakdown', class = 'text-muted'),
                      selectInput(inputId = 'Industry', 'Choose an Industry:',
                                  choices = unique(InvestmentsFinal$company_category_code[InvestmentsFinal$company_category_code != 'other']), 
                                  selected = 'software'),
                      selectInput(inputId = 'Industry2', 'Choose an Industry:',
                                  choices = unique(InvestmentsFinal$company_category_code), selected = 'advertising'),
                      plotOutput(outputId = 'Change_Industry'),
                      tableOutput(outputId = 'Industry_Table'),
                      verbatimTextOutput('ftest')
                      ),
            
            tabItem(tabName = 'Quarters',
                    h1('Funding Trends', class = 'text-muted'),
                    fluidRow(
                      plotOutput(outputId = 'Quarterly'),
                      h4('Angel Invesments have consistenly performed well throughout the decade. Other forms 
                          of invesment have been more volatile which could be due to changes in economic conditions.
                        But overall, capital seems to be trending upward with no significant difference within each Quarter of the year')
                    )
            ),
            tabItem(tabName = 'FundingType',
                    h1('Funding Breakdown', class= 'text-muted'),
                    selectInput(inputId = 'fundinground', 'Choose an Investment:',
                                choices = unique(InvestmentsFinal$funding_round_type), selected = 'venture'),
                    plotOutput(outputId = 'Change_Investment'),
                    fluidRow(
                    box(
                    title = 'USA',
                    plotOutput(outputId = 'USA_Distribution')),
                    box(
                    title = 'Global',
                    plotOutput(outputId = 'Global_Distribution'))
            )),
            
            tabItem(tabName = 'acquisitions',
                    h1('Acquisition/Post-IPO Summary', class= 'text-muted'),
                    fluidRow(
                    box(
                    tableOutput(outputId = 'pie_chart')),
                    box(
                      tableOutput(outputId = 'pie_chart2')),
                      tableOutput('pie2_table')
                    )),
            tabItem(tabName = 'future',
                    h1('Future Outlook', class = 'text-muted'),
                    h4('1. Total volume is continuing to trend upward into future years with no sign of slowing down.'),
                    h4('2. US will continue to dominate the industry but emerging markets seem to be on the rise, with potential for big upside.'),
                    h4('3. Technology is still your safe investemnt but keep at eye out for small gains in other industries as they
                       can have a suprise break out.'),
                    fluidRow(
                        plotOutput(outputId = 'Q1Box')
                    ),
                    fluidRow(
                      plotOutput(outputId = 'Cat_summary')
                    ))
            ))
))
