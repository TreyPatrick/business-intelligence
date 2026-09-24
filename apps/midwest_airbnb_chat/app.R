# Midwest Airbnb Explorer
library(shiny)
library(bslib)
library(querychat)

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat(
  con, "listings",
  client             = client,
  tools              = c("filter", "query", "visualize"),
  greeting           = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description   = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

ui = page_sidebar(
  title   = "Midwest Airbnb Explorer",
  theme   = bs_theme(primary   = "#17324D",
                     secondary = "#C98E1B",
                     base_font = font_google("Public Sans")),
  sidebar = qc$sidebar(width = 350),
  card(card_header(textOutput("title")),
       DT::DTOutput("table")),
  accordion(open = "SQL",
            accordion_panel("SQL", verbatimTextOutput("sql")),
            accordion_panel("About",
                            p("Listings come from ",
                              a("Inside Airbnb", href = "https://insideairbnb.com/get-the-data/", target = "_blank",.noWS = "after"),
                              ": Chicago (snapshot 2026-07-20), Columbus (2026-07-23), and the Twin Cities (2026-07-21)."),
                            p("Built by Trey Patrick for ISA 401, Miami University.")))
)

server = function(input, output, session) {
  vals = qc$server()
  output$title = renderText(vals$title() %||% "All listings")
  output$table = DT::renderDT(vals$df(),
                              options = list(pageLength = 10))
  output$sql   = renderText(vals$sql() %||%
                              "SELECT * FROM listings")
}

shinyApp(ui, server)