# verkeersongelukken-twitter
script(s) voor analyse verkeersongelukken zoals gemeld op Twitter. Aanleiding onderzoek De Correspondent https://decorrespondent.nl/9077/help-je-mee-berichten-over-verkeersongelukken-te-verzamelen/175599321348-54bda7f7

Eerste versie van een script gemaakt in R die zoveel mogelijk de verkeersongelukken waar op Twitter over gesproken wordt verzamelt, en die een link naar een online bron hebben. Het script levert een lijst met alle tweets, screenname, tijdstip van plaatsing en een externe URL's. Het is nog ruw, maar het werkt. Wie met R uit de voeten kan kan eenvoudig zelf de lijst genereren. De tweets zelf online zetten mag volgens mij vanuit de gebruiksvoorwaarden van Twitter niet, maar als je een lijst aangeleverd wilt, kan dat via mail of op een andere manier. Wie meer wil weten, of aanpassingen weet: welkom!

Overigens is dit na een eenmansbrainstorm mijn zoekopdracht. Ook als je geen code kunt lezen zie je vast wat het idee is. 
Ik zie vast benamingen over het hoofd. Laat het weten, dan pas ik de code er op aan.

(fietser OR wandelaar OR voetganger OR automobilist OR bromfietser) 
AND 
(aanrijding OR botsing OR ongeluk OR ongeval OR letsel OR gewond OR overleden)
