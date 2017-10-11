library(dplyr)
library(tidyr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(googleVis)
library(rsconnect)
library(data.table)
library(stats)
getwd()
InvestmentsFinal = fread('InvestmentsFinal.csv', stringsAsFactors = F)
countrycode = read.csv('countrycodes.csv', stringsAsFactors = FALSE)

countrycode$X = NULL
countrycode$X.1 = NULL
countrycode$X.2 = NULL
InvestmentsFinal = left_join(InvestmentsFinal, countrycode, 'company_country_code')

total_summary = InvestmentsFinal %>% filter(funded_year < 2014) %>% group_by(funded_year) %>% 
  summarise(total = sum(raised_amount_usd, na.rm = TRUE)/1000000) %>% arrange(desc(total))



country_investments = InvestmentsFinal %>% filter(Company_Country != '') %>%
  select(Company_Country, raised_amount_usd) %>%
  group_by(Company_Country) %>% summarise(count = n(), total = sum(raised_amount_usd, na.rm = TRUE)) %>% arrange(desc(count))
State_investments = InvestmentsFinal %>% filter(company_country_code == 'USA', company_state_code != '') %>% select(company_state_code, funded_year, raised_amount_usd) %>% 
  group_by(company_state_code, funded_year) %>% summarise(total = log(sum(raised_amount_usd, na.rm = TRUE))) %>% arrange(desc(total))
State_investments
InvestmentsFinal$FundedQuarter = substr(InvestmentsFinal$funded_quarter,6,7)
BuySide = InvestmentsFinal %>% filter(Acquired == 'Yes') %>% select(investor_name ,company_category_code) %>%
  group_by(investor_name, company_category_code) %>% summarise(count = n()) %>% arrange(desc(count))
InvestmentsFinal %>% filter(funding_round_type == 'angel') %>% select(funded_year, raised_amount_usd) %>% summarise(total = sum(raised_amount_usd))
Acquired_stats = head(InvestmentsFinal %>% filter(Acquired == 'Yes') %>% select(company_category_code, company_name) %>% group_by(company_category_code) %>%
  summarise(count = n_distinct(company_name)) %>% arrange(desc(count)),10)
States_Acquired = InvestmentsFinal %>% filter(company_country_code == 'USA', company_state_code != '') %>% select(company_state_code, Acquired) %>% 
  group_by(company_state_code, Acquired) %>% summarise(count = n()) %>% mutate(total = sum(count)) %>%
  filter(Acquired == 'Yes') %>% mutate(percentage = count/total)
States_Acquired
USA_count = InvestmentsFinal %>% filter(company_country_code == 'USA', company_state_code != '') %>% group_by(company_state_code) %>%
  summarise(count = n(), total = sum(raised_amount_usd, na.rm = TRUE)) %>% arrange(desc(total))
BuySide_Acquired = head(InvestmentsFinal %>% filter(Acquired == 'Yes') %>% select(investor_name, company_name, raised_amount_usd) %>%
                  group_by(investor_name) %>% summarise(count = n_distinct(company_name), total = sum(raised_amount_usd, na.rm = TRUE)) %>%
                    arrange(desc(count)), 10)
Q1_Info = InvestmentsFinal %>% filter(FundedQuarter == 'Q1') %>% select(funded_year, raised_amount_usd) %>% group_by(funded_year) %>%
  summarise(total = sum(raised_amount_usd, na.rm = TRUE))

Q1_14_CAT = head(InvestmentsFinal %>% filter(funded_year == '2014') %>% select(company_category_code, raised_amount_usd) %>% 
  group_by(company_category_code) %>% summarise(count = n(), total = sum(raised_amount_usd, na.rm = TRUE)) %>% 
  arrange(desc(total)),10)

cat_summary = InvestmentsFinal %>% filter(FundedQuarter == 'Q1') %>% 
  select(company_category_code, funded_year) %>% group_by(company_category_code, funded_year) %>% 
  summarise(count = n())

cat_year_breakdown = InvestmentsFinal %>% select(company_category_code, funded_year, raised_amount_usd) %>% group_by(funded_year, company_category_code) %>%
  summarise(total = (sum(raised_amount_usd, na.rm = TRUE))) %>% filter(total > 5000000000, funded_year < 2014)
funding_breakdown = InvestmentsFinal %>% filter(funded_year < 2014, funding_round_type != 'other') %>%
  group_by(funding_round_type, FundedQuarter, funded_year) %>% summarise(count = n()) %>% arrange(FundedQuarter)
unique(InvestmentsFinal$funding_round_type)

post_ipo_cat = head(InvestmentsFinal %>% filter(funding_round_type == 'post-ipo') %>% select(company_category_code, company_name) %>%
                      group_by(company_category_code) %>% summarise(count = n_distinct(company_name)) %>% arrange(desc(count)), 10)



