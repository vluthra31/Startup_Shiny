library(dplyr)
library(ggplot2)
library(stats)
library(tidyr)
unique(InvestmentsFinal$funding_round_type)

FRC = InvestmentsFinal %>% filter(funding_round_type == 'venture') %>%
  group_by(funding_round_type, funded_year) %>%
  summarise(count = n())
ggplot(FRC, aes(x = funded_year, y = count)) + geom_bar(stat = 'identity')
FRC
InvestmentsFinal %>% filter(Acquired == 'Yes') %>% 
  group_by(company_category_code) %>% summarise(count = n()) %>% 
  arrange(desc(count))
unique(InvestmentsFinal$company_country_code)
state.name
unique(InvestmentsFinal$company_state_code)
state.x77
country_investments = InvestmentsFinal %>% filter(company_country_code != '') %>%
  group_by(company_country_code) %>% summarise(count = n())
country_investments
state.x77
InvestmentsFinal %>% filter(company_country_code != 'USA', company_country_code != '') %>% group_by(company_country_code) %>% summarise(count = n()) %>% arrange(desc(count))
Countries = unique(InvestmentsFinal$company_country_code)
Countries
State_investments = InvestmentsFinal %>% filter(company_country_code == 'USA', company_state_code != '') %>% select(company_state_code, raised_amount_usd) %>% group_by(company_state_code) %>%
  summarise(total = sum(raised_amount_usd, na.rm = TRUE)) %>% arrange(desc(total))
str(unique(country_investments$company_country_code))
unique(InvestmentsFinal$investor_name)
InvestmentsFinal %>% filter(company_country_code == 'USA', company_state_code != '') %>% select(company_state_code, Acquired) %>% 
  group_by(company_state_code, Acquired) %>% summarise(count = n()) %>% mutate(total = sum(count)) %>%
  filter(Acquired == 'Yes') %>% mutate(percentage = count/total) %>% arrange(desc(percetage))

'january' < 'march'
InvestmentsFinal %>% filter(funded_year == 2013) %>% group_by(company_category_code) %>% summarise(count = n()) %>% arrange(desc(count))
InvestmentsFinal %>% filter(company_category_code == 'healthcare') %>% group_by(funded_year) %>% summarise(count = n()) %>% 
  arrange(desc(count))

unique(InvestmentsFinal$company_category_code)
companies = InvestmentsFinal %>% select(company_name, company_category_code) %>% group_by(company_name)
companies %>% group_by(company_category_code) %>% summarise(count = n()) %>% arrange(desc(count))
unique(InvestmentsFinal$funding_round_type)
InvestmentsFinal %>% filter(funding_round_type == 'post-ipo') %>% group_by(company_category_code) %>% 
  summarise(count = n()) %>% arrange(desc(count))
InvestmentsFinal %>% filter(company_country_code == 'USA') %>% group_by(company_country_code, funded_year) %>%
  summarise(total = sum(raised_amount_usd, na.rm = TRUE)) %>% arrange(desc(total))
InvestmentsFinal %>% filter(company_country_code != 'USA', company_country_code != '') %>% group_by(funded_year) %>% 
  summarise(total = sum(raised_amount_usd, na.rm = TRUE)) %>% arrange(desc(total))
InvestmentsFinal %>% filter(investor_country_code != '') %>% group_by(investor_country_code) %>% summarise(count = n()) %>%
  arrange(desc(count))

InvestmentsFinal %>% filter(company_country_code == 'USA', company_state_code != '') %>% group_by(company_state_code) %>%
  summarise(count = n(), total = sum(raised_amount_usd, na.rm = TRUE)) %>% arrange(desc(total))
InvestmentsFinal %>% group_by(US = (company_country_code== 'USA)'), Global = (company_country_code != 'USA')) %>% 
  summarize(count = n())
InvestmentsFinal %>% filter(FundedQuarter == 'Q1') %>% select(funded_year, raised_amount_usd) %>% 
  group_by(funded_year)

InvestmentsFinal %>% filter(company_country_code != '') %>% 
  group_by(company_country_code) %>% summarise(total = log(sum(raised_amount_usd, na.rm = TRUE)+1))



unique(InvestmentsFinal$company_category_code)
t.test(test$design, test$music, alternative = 'two.sided')[[3]]
var.test()

head(InvestmentsFinal %>% filter(Acquired == 'Yes') %>% select(company_name, company_category_code, company_country_code) %>%
  group_by(company_country_code) %>% summarise(count = n_distinct(company_name)) %>% arrange(desc(count)), 10)
unique(InvestmentsFinal$company_category_code[InvestmentsFinal$company_category_code != 'other'])

 