# language: nl

Functionaliteit: als gebruiker van de API wil ik dat zoekresultaten worden gesorteerd op aanduiding (adres)
    zodat ik in een lijst resultaten het gewenste WOZ-object sneller kan vinden
    en bij meerdere pagina's zoekresultaten ik ongeveer kan inschatten of ik het WOZ-object op de pagina kan verwachten.

    - huisnummertoevoeging wordt alphanumeriek gesorteerd ("11"<"2")
    - huisletter en huisnummertoevoeging worden case insensitive gesorteerd ("a"<"B" en "A"<"b")
    - huisnummer wordt numeriek gesorteerd (2<11)


    Achtergrond:
        Gegeven in de LV WOZ zijn de volgende WOZ objecten bekend:
        | identificatie | postcode | huisnummer | huisletter | huisnummertoevoeging | belanghebbende rsin |
        | 000500030827  | 8000GB   | 1          | a          | bis                  | 000000061           |
        | 000500030828  | 7399PP   | 101        | B          | 4                    | 000000061           |
        | 000500030829  | 7399PP   | 101        | B          | 3                    | 000000061           |
        | 000500030830  | 7399PP   | 101        | B          | 31                   | 000000061           |
        | 000500030831  | 7399PP   | 103        | C          | 5                    | 000000061           |
        | 000500030832  | 7399PP   | 101        | E          |                      | 000000061           |
        | 000500030833  | 7399PP   | 103        | A          |                      | 000000061           |
        | 000500030834  | 7399PP   | 101        | B          | a                    | 000000061           |
        | 000500030835  | 7399PP   | 101        | B          | I                    | 000000061           |
        | 000500030836  | 7399PP   | 101        |            |                      | 000000061           |
        | 000500030837  | 7399PP   | 101        | b          | 2                    | 000000061           |
        | 000500030838  | 7399PP   | 22         | E          |                      | 000000061           |
        | 000500030839  | 2496MA   | 204        | d          | 2                    | 000000061           |

    Regel: zoeken sorteert op postcode, huisnummer, huisletter, huisnummertoevoeging
        Als ik een WOZ-object zoek met /wozobjecten?rsin=000000061
        Dan bevat het antwoord de wozObjecten in de volgende voldorde:
        | identificatie | postcode | huisnummer | huisletter | huisnummertoevoeging | belanghebbende rsin | reden                                                |
        | 000500030839  | 2496MA   | 204        | d          | 2                    | 000000061           | laagste postcode                                     |
        | 000500030838  | 7399PP   | 22         | E          |                      | 000000061           | laagste huisnummer bij postcode                      |
        | 000500030836  | 7399PP   | 101        |            |                      | 000000061           | geen huisletter voor wel huisletter                  |
        | 000500030837  | 7399PP   | 101        | b          | 2                    | 000000061           | laagste huisnummertoevoeging bij huisletter "b"=="B" |
        | 000500030829  | 7399PP   | 101        | B          | 3                    | 000000061           |                                                      |
        | 000500030830  | 7399PP   | 101        | B          | 31                   | 000000061           | huisnummertoevoeging "31" komt voor "4"              |
        | 000500030828  | 7399PP   | 101        | B          | 4                    | 000000061           |                                                      |
        | 000500030834  | 7399PP   | 101        | B          | a                    | 000000061           | "a" komt voor "I" ongeacht de casing                 |
        | 000500030835  | 7399PP   | 101        | B          | I                    | 000000061           |                                                      |
        | 000500030832  | 7399PP   | 101        | E          |                      | 000000061           |                                                      |
        | 000500030833  | 7399PP   | 103        | A          |                      | 000000061           | hoger huisnummer                                     |
        | 000500030831  | 7399PP   | 103        | C          | 5                    | 000000061           |                                                      |
        | 000500030827  | 8000GB   | 1          | a          | bis                  | 000000061           | hoogste postcode                                     |