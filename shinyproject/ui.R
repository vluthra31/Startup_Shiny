

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
                        h4('The Startup scene has seen dramatic change over the last decade. Barriers to entry have become increasingly easier', 
                           'as small startups have turned into major players in todays global economy/n',
                           'The data collected is from Q1 of 2004 to Q1 of 2014 showing companies from the world and 
                           how much money has been invested for their capital growth. We can use this information to 
                          analyze trends over time and identify key performers based on volume and total amount invested. 
                          By doing so I hope to provide insight for both the investor and enteprenuer'),
                        h1('Types of Funding'),
                        h4('Fueling this change are Angel investors, venture capitalists and other types of financial insitutions.',
                            'In our breakdown we will be focusing on Angel Investments which are beginning level investments 
                           for a company, followed by a few rounds of series investments, and finally Venture Capital or Private
                          Equity are the highest levels of capital funding')
                        )),
              tabItem(tabName = 'Global',
                    fluidRow(
                        h1('Global Expansion..', class = 'text-muted'),
                        h4('The below outlines the capital funding landscape around the world. The US has a firm dominace over the
                        rest of the countries interms of volume and in the .'),
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
                  other top performers include New York, Boston, Washington DC. But one thing to note is that the areas to invest is
                  continuing to expand throughout the years which is coorelating to larger number of investments'),
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
                    fluidRow(
                      plotOutput(outputId = 'TopPerYear'),
                      h4('When obvserving into specific industries there is no suprise that software has outperformed,
                      many of the other categories. But suprsisingly Biotech has been a consistent high peroformer almost every year.
                      I believe that this has to do with advancements in genetics and changes in Healthcare. In 2013 we saw the 
                      implementation of Obamacare which caused a increased amount Healthcare startups emerge.
                      As each year goes by new industries appear and take a large portion of
                      the capital, but then die out after 2 or 3 years. I think we can expect these trends to continue moving forward')
                    )
            ),
            tabItem(tabName = 'Comparasion',
                h2('INDUSTRY INFORMATION'),
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
                    fluidRow(
                      plotOutput(outputId = 'Quarterly'),
                      h4('Key Takeaways: Angel Invesments have consistenly performed well throughout the decade. Other forms 
                          of invesment have been more volatile which could be due to changes in economic conditions.
                        But overall, capital seems to be trending upward with no significant change within each Quarter of the year')
                    )
            ),
            tabItem(tabName = 'FundingType',
                    h2('Change in Investments'),
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
            tabItem(tabName = 'global',
                    h2('Global Outlook')),
            
            tabItem(tabName = 'acquisitions',
                    h1('Acquisition/Post-IPO Summary', class= 'text-muted'),
                    h4('As expected we have seen Acquisitions and IPOs from the major industries in the market.'),
                    fluidRow(
                    box(
                    tableOutput(outputId = 'pie_chart')),
                    box(
                      tableOutput(outputId = 'pie_chart2')),
                      tableOutput('pie2_table')
                    )),
            tabItem(tabName = 'future',
                    fluidRow(
                      box(
                        title = 'Text',
                        helpText('Conclusion, expectation for future.')
                        )),
                    fluidRow(
                        plotOutput(outputId = 'Q1Box')
                    ),
                    fluidRow(
                      plotOutput(outputId = 'Cat_summary')
                    ))
            ))
))
