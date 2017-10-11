
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  Total_Invest_Cat = reactive({InvestmentsFinal %>% 
      filter(company_category_code == input$Industry | company_category_code == input$Industry2, funded_year < 2014) %>% 
      group_by(company_category_code, funded_year) %>%
      summarise(total = sum(raised_amount_usd, na.rm = TRUE))
  })

  
  test = InvestmentsFinal %>% select(company_category_code, raised_amount_usd) %>% group_by(company_category_code) %>%
    mutate(ind = row_number()) %>% spread(key = company_category_code, value = raised_amount_usd) %>% select(-ind)

  output$fullsum = renderPlot({
    ggplot(total_summary, aes(x = funded_year, y = total)) + geom_histogram(stat= 'identity', aes(fill = total)) + geom_smooth(se = FALSE) + xlab('Years') + ylab('Total Invested')
    
  })
  
  GlobalOptions = reactive({
    list(
      pageSize=input$Pages,
      width=550
    )
  })
  
  USOptions = reactive({
    list(
      pageSize=input$Pages2,
      width=550
    )
  })
  
  Country_map = reactive({
    InvestmentsFinal %>% filter(Company_Country != '', funded_year <= input$Years) %>% 
      group_by(Company_Country, funded_year) %>% summarise(total = log(sum(raised_amount_usd, na.rm = TRUE)+1))
  })
  
  output$globalgvis = renderGvis({
    gvisGeoChart(Country_map(),
                 locationvar="Company_Country", colorvar="total",
                 options = list(width = 750, height = 600)
                 )   
  })
  
  StatesYear = reactive({
    InvestmentsFinal %>% filter(company_country_code == 'USA', funded_year <= input$Years2) %>% 
      group_by(company_state_code) %>% summarise(total = log(sum(raised_amount_usd, na.rm = TRUE)+1))
  })
  output$gvis = renderGvis({
    gvisGeoChart(StatesYear(),
                 locationvar="company_state_code", colorvar="total",
                 options=list(region="US", displayMode="regions", 
                              resolution="provinces",
                              width=750, height=600,
                              colorAxis="{colors:['pink', 'red']}"
                 ))   
  })
  
  output$usa_table = renderGvis({
    gvisTable(USA_count, options = USOptions())
  })
  
  output$global_table = renderGvis({
    gvisTable(country_investments, options = GlobalOptions())
  })
  
  output$Change_Industry = renderPlot({
    ggplot(Total_Invest_Cat(), 
           aes(x = funded_year,
               y = total)) + geom_density(stat = 'identity', aes(fill= company_category_code, alpha = .1)) + xlab('Years') + 
                ylab('Total Invested') + title('Change Per Industry')
  })
  
  output$Industry_Table = renderGvis({
    gvisTable(spread(Total_Invest_Cat(), key = funded_year, value = total))
  })
  
  FundingRoundChart = reactive({
    InvestmentsFinal %>% filter(funding_round_type == input$fundinground, funded_year < 2014) %>%
      group_by(input$fundinground, funded_year, FundedQuarter) %>%
      summarise(count = n())
  })
  
  USA = reactive({
    InvestmentsFinal %>% filter(company_country_code == 'USA', funding_round_type == input$fundinground, funded_year < 2014) %>%
      group_by(funding_round_type, funded_year) %>%
      summarise(total = sum(raised_amount_usd, na.rm = TRUE))
  })
  
  
  GLOBAL = reactive({
    InvestmentsFinal %>%
      filter(company_country_code != 'USA', funding_round_type == input$fundinground, funded_year < 2014) %>%
      group_by(funding_round_type, funded_year) %>%
      summarise(total = sum(raised_amount_usd, na.rm = TRUE))
  })
  
  output$Quarterly = renderPlot({
    ggplot(funding_breakdown, aes(x = FundedQuarter, y = count)) + 
      geom_bar(stat = 'identity', aes(fill = funding_round_type)) + 
      facet_wrap(~funded_year) + ylab('count') + title('Change in Funding')
  })
  
  output$Change_Investment = renderPlot({
    ggplot(FundingRoundChart(), 
           aes(x = funded_year,
               y = count)) + geom_bar(stat = 'identity', aes(fill = FundedQuarter)) + xlab('Years') + ylab('Count')
  })
 
  output$USA_Distribution = renderPlot({
    ggplot(USA(), 
           aes(x = funded_year,
               y = total)) + geom_smooth() + xlab('Years') + ylab('Total Invested')
  }) 
  
  output$Global_Distribution = renderPlot({
    ggplot(GLOBAL(), 
           aes(x = funded_year,
               y = total)) + geom_smooth() + xlab('Years') + ylab('Total Invested')
  }) 
  
  output$pie_chart = renderGvis({
    gvisPieChart(Acquired_stats, labelvar = 'company_category_code', numvar = 'count',
                 options = list(width = 500, height = 500, is3D = TRUE))
  })
  
  output$pie_chart2 = renderGvis({
    gvisPieChart(post_ipo_cat, labelvar = "company_category_code", numvar = 'count', 
                  options = list(width = 500, height = 500, is3D = TRUE))
  })
  
  output$pie2_table = renderGvis({
    gvisTable(BuySide_Acquired, options = list(width = 800, height = 400))
  })
  
  output$Q1Box = renderPlot({
    ggplot(Q1_Info, aes(x = funded_year, y = total)) + geom_smooth() + xlab('Years') + ylab('Total Invested')
  })
  
  output$Cat_summary = renderPlot({
    ggplot(cat_summary) + geom_area(aes(x = funded_year, y = count, fill = company_category_code))
  })
  
  output$TopPerYear = renderPlot({
    ggplot(cat_year_breakdown, aes(x = company_category_code, y = total)) + geom_bar(stat = 'identity', aes(fill = company_category_code)) +
      facet_wrap(~funded_year) + xlab('Industry') + ylab('Total Invesment') + theme(axis.text.x=element_blank(),
                                                                                    axis.ticks.x=element_blank())
})
  
  output$ftest = renderPrint(
    paste('The p value is: ', var.test(test[[input$Industry]], test[[input$Industry2]])[3])
  )
  
})


