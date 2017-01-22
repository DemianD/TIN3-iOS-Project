# TIN3-iOS-Project
> Dit project is gemaakt voor het examen van Native apps II: mobile apps voor IOS aan de HoGent

## Project Manager

Als student werk ik aan enkele projecten waarbij ik eenvoudig mijn werktijden wil bijhouden. Het probleem is dat ik deze nooit correct bijhoud.
Hiervoor heb ik een simpele iOS app gemaakt waarbij je projecten kan toevoegen, en daarna via een timer je werktijden kan laten opmeten.
Wanneer je de timer start wordt door middel van `CoreLocation` ook je huidige locatie opgeslagen. Als je dan naar de details van een werkuur kijkt, kan je zien waar je precies was.
Daarnaast zijn er ook notificaties. Nadat de timer gestart is krijg je elk halfuur een notificatie met “De timer is nog aan het lopen”. Hierbij zit er ook een actieknop waardoor je de timer onmiddellijk kan stoppen zonder de app te openen.

## Install

1. git clone git@github.com:DemianD/TIN3-iOS-Project.git ProjectDemianDekoninck
2. cd ProjectDemianDekoninck
3. pod update
4. pod install 
5. open TIN3-iOS-Project.xcworkspace
6. Run the 'TIN3-iOS-Project'
