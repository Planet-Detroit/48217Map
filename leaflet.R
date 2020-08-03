library(tidyverse)
library(leaflet)
library(htmltools)

m <- leaflet() %>%
  setView(lng = -83.148, lat = 42.2827, zoom = 13) %>%
  addTiles()

#add 48217 to the leaflet
# created geojson with https://mapshaper.org/

bondries <- readLines("Data/Detroit_Zip_Codes_filtered.json") %>% paste(collapse = "\n")
m <- m %>% addGeoJSON(bondries)

bondries_2 <- readLines("Data/Detroit_Zip_Codes_48209.json") %>% paste(collapse = "\n")
m <- m %>% addGeoJSON(bondries_2, color = 'yellow')


#set icons
#tri_icon = makeIcon("img/warning.png", "img/warning2x.png", 18, 18)

monitoring_icon_2 = makeIcon("img/monitoring.png", "monitoring2x.png", 18, 18)

tri_icon = awesomeIcons(icon = 'industry',
                        iconColor = 'black',
                        library = 	'fa' ,
                        markerColor = 'red')

monitoring_icon = awesomeIcons(icon = 'eye',
                               iconColor = 'black',
                               library = 'fa',
                               markerColor = 'green')

#monitoring_icon  = awesomeIcons(icon = 'fa-search',
#                             iconColor = 'black',
#                             library = 	'fa' ,
#                             markerColor = 'red')

#add TRI points to leaflet

html_leg <- " <p style='color:black; font-weight: bold;'>Marathon Monitoring Locations</p>
              <p style='color:green; font-weight: bold;'>EGLE Monitoring Sites Discueesed</p>
              <p style='color:red; font-weight:bold;'>Industry Sites Discueesed</p> "

m <- m %>% addAwesomeMarkers(data = TRI_2018_MI_filtered, icon = tri_icon, label = ~htmlEscape(NAME) )

#add Montoring points to leaflet

m <- m %>% addAwesomeMarkers(data = aqs_sites_filtered, icon = monitoring_icon, label = ~htmlEscape(clean_name), labelOptions = labelOptions(noHide = T, direction = "bottom"))


m <- m %>% addMarkers(data = aqs_sites_marathon, icon = monitoring_icon_2, popup = ~htmlEscape(`Owning Agency`))
#add tooltip

m <- m %>% addControl(html = html_leg, position = "bottomright")

m <- m %>% addPopups(-83.097113, 42.2876, "<b>Gordie Howe International Bridge</b>",
               options = popupOptions(closeButton = FALSE))

m#mas if time permits

# <p style='color:blue; font-weight: bold;'>48217</p>
# <p style='color:dark-yellow ; font-weight: bold;'>48209</p>
#<img src='img/warning2x.png' size=100%> Marathon Monotoring locatons<br/>


