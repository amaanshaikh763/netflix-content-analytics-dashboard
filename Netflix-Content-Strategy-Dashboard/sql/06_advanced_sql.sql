/*
====================================================
Business Question:
Categorize Netflix content by type.
====================================================
*/

SELECT
    title,
    type,
    CASE
        WHEN type = 'Movie' THEN 'Film Content'
        WHEN type = 'TV Show' THEN 'Series Content'
        ELSE 'Other'
    END AS content_category
FROM netflix_titles
LIMIT 20;

-- Output

"QB1: Beyond the Lights"	"TV Show"	"Series Content"
"Cops and Robbers"	"Movie"	"Film Content"
"Song Exploder"	"TV Show"	"Series Content"
"Wonho Chung: Live in New York"	"Movie"	"Film Content"
"Dick Johnson Is Dead"	"Movie"	"Film Content"
"The World's Most Amazing Vacation Rentals"	"TV Show"	"Series Content"
"Selling Sunset"	"TV Show"	"Series Content"
"Gigantosaurus"	"TV Show"	"Series Content"
"You vs. Wild: Out Cold"	"Movie"	"Film Content"
"Single Wives"	"TV Show"	"Series Content"
"Emicida: AmarElo - Live in São Paulo"	"Movie"	"Film Content"
"The Chase"	"TV Show"	"Series Content"
"The Stand-Up"	"Movie"	"Film Content"
"The Beginning of Life 2: Outside"	"Movie"	"Film Content"
"Felix Lobrecht: Hype"	"Movie"	"Film Content"
"MOTHER"	"Movie"	"Film Content"
"Dhanak"	"Movie"	"Film Content"
"Final Account"	"Movie"	"Film Content"
"The Beginning of Life"	"Movie"	"Film Content"
"The Garfield Show"	"TV Show"	"Series Content"

-- Categorize Movies by Duration

SELECT
    title,
    duration,
    CASE
        WHEN type = 'Movie'
         AND CAST(SPLIT_PART(duration,' ',1) AS INTEGER) < 60
            THEN 'Short Movie'

        WHEN type = 'Movie'
         AND CAST(SPLIT_PART(duration,' ',1) AS INTEGER) BETWEEN 60 AND 120
            THEN 'Standard Movie'

        WHEN type = 'Movie'
         AND CAST(SPLIT_PART(duration,' ',1) AS INTEGER) > 120
            THEN 'Long Movie'

        ELSE 'TV Show'
    END AS duration_category
FROM netflix_titles
LIMIT 20;

-- Output

"QB1: Beyond the Lights"	"1 Season"	"TV Show"
"Cops and Robbers"	"8 min"	"Short Movie"
"Song Exploder"	"2 Seasons"	"TV Show"
"Wonho Chung: Live in New York"	"69 min"	"Standard Movie"
"Dick Johnson Is Dead"	"90 min"	"Standard Movie"
"The World's Most Amazing Vacation Rentals"	"2 Seasons"	"TV Show"
"Selling Sunset"	"3 Seasons"	"TV Show"
"Gigantosaurus"	"1 Season"	"TV Show"
"You vs. Wild: Out Cold"	"106 min"	"Standard Movie"
"Single Wives"	"1 Season"	"TV Show"
"Emicida: AmarElo - Live in São Paulo"	"100 min"	"Standard Movie"
"The Chase"	"2 Seasons"	"TV Show"
"The Stand-Up"	"93 min"	"Standard Movie"
"The Beginning of Life 2: Outside"	"92 min"	"Standard Movie"
"Felix Lobrecht: Hype"	"60 min"	"Standard Movie"
"MOTHER"	"127 min"	"Long Movie"
"Dhanak"	"114 min"	"Standard Movie"
"Final Account"	"94 min"	"Standard Movie"
"The Beginning of Life"	"96 min"	"Standard Movie"
"The Garfield Show"	"4 Seasons"	"TV Show"

SELECT
    CASE
        WHEN type = 'Movie'
         AND CAST(SPLIT_PART(duration,' ',1) AS INTEGER) < 60
            THEN 'Short Movie'

        WHEN type = 'Movie'
         AND CAST(SPLIT_PART(duration,' ',1) AS INTEGER) BETWEEN 60 AND 120
            THEN 'Standard Movie'

        WHEN type = 'Movie'
         AND CAST(SPLIT_PART(duration,' ',1) AS INTEGER) > 120
            THEN 'Long Movie'

        ELSE 'TV Show'
    END AS duration_category,

    COUNT(*) AS total_titles

FROM netflix_titles

GROUP BY duration_category

ORDER BY total_titles DESC;

-- Output

/*
====================================================
Business Question:
Create a reusable view containing only movies.
====================================================
*/

CREATE VIEW movie_titles AS

SELECT
    show_id,
    title,
    director,
    country,
    release_year,
    rating,
    duration
FROM netflix_titles

WHERE type='Movie';

-- Now testing the output

SELECT *
FROM movie_titles
LIMIT 20;

-- Output

"s1485"	"Cops and Robbers"	"Arnon Manor, Timothy Ware-Hill"	"United States"	2020	"PG-13"	"8 min"
"s2015"	"Wonho Chung: Live in New York"	"Shaun Mir"		2014	"TV-14"	"69 min"
"s1"	"Dick Johnson Is Dead"	"Kirsten Johnson"	"United States"	2020	"PG-13"	"90 min"
"s76"	"You vs. Wild: Out Cold"	"Ben Simms"		2021	"TV-G"	"106 min"
"s456"	"Emicida: AmarElo - Live in São Paulo"	"Fred Ouro Preto"		2021	"TV-MA"	"100 min"
"s476"	"The Stand-Up"	"Daniel Růžička"		2019	"TV-MA"	"93 min"
"s1705"	"The Beginning of Life 2: Outside"	"Renata Terra"	"Brazil"	2020	"TV-PG"	"92 min"
"s1743"	"Felix Lobrecht: Hype"	"Jan-Peter Horns"	"Germany"	2020	"TV-MA"	"60 min"
"s1744"	"MOTHER"	"Tatsushi Omori"	"Japan"	2020	"TV-14"	"127 min"
"s117"	"Dhanak"	"Nagesh Kukunoor"	"India"	2015	"TV-PG"	"114 min"
"s118"	"Final Account"	"Luke Holland"	"United Kingdom, United States"	2021	"PG-13"	"94 min"
"s1745"	"The Beginning of Life"	"Estela Renner"		2016	"TV-PG"	"96 min"
"s1872"	"Super Monsters: Dia de los Monsters"		"Canada"	2020	"TV-Y"	"25 min"
"s2058"	"Sky Tour: The Movie"	"Nguyen Thanh Tung"	"Vietnam"	2020	"TV-G"	"93 min"
"s119"	"Gurgaon"	"Shanker Raman"	"India"	2017	"TV-14"	"106 min"
"s120"	"Here and There"	"JP Habac"		2020	"TV-MA"	"99 min"
"s231"	"The River Runner"	"Rush Sturges"		2021	"TV-MA"	"86 min"
"s2248"	"Mama's Boy"	"Amro Salah"	"Egypt"	2018	"TV-14"	"101 min"
"s2249"	"The Claudia Kishi Club"	"Sue Ding"	"United States"	2020	"TV-14"	"17 min"
"s4877"	"Dany Boon: Des Hauts De France"	"Isabelle Nanty"	"France"	2018	"TV-MA"	"113 min"

WITH director_movies AS (

SELECT
    director,
    COUNT(*) AS total_movies

FROM netflix_titles

WHERE type='Movie'
AND director IS NOT NULL

GROUP BY director

)

SELECT *

FROM director_movies

WHERE total_movies > 10

ORDER BY total_movies DESC;

-- Output

"Rajiv Chilaka"	19
"Raúl Campos, Jan Suter"	18
"Suhas Kadav"	16
"Marcus Raboy"	15
"Jay Karas"	14
"Cathy Garcia-Molina"	13
"Youssef Chahine"	12
"Martin Scorsese"	12
"Jay Chapman"	12
"Steven Spielberg"	11

SELECT
    director,
    COUNT(*) AS total_movies,

RANK() OVER(

ORDER BY COUNT(*) DESC

) AS director_rank

FROM netflix_titles

WHERE director IS NOT NULL
AND type='Movie'

GROUP BY director;

-- Output

"Rajiv Chilaka"	19	1
"Raúl Campos, Jan Suter"	18	2
"Suhas Kadav"	16	3
"Marcus Raboy"	15	4
"Jay Karas"	14	5
"Cathy Garcia-Molina"	13	6
"Youssef Chahine"	12	7
"Martin Scorsese"	12	7
"Jay Chapman"	12	7
"Steven Spielberg"	11	10
"Don Michael Paul"	10	11
"David Dhawan"	9	12
"Hakan Algül"	8	13
"Kunle Afolayan"	8	13
"Johnnie To"	8	13
"Fernando Ayllón"	8	13
"Yılmaz Erdoğan"	8	13
"Troy Miller"	8	13
"Shannon Hartman"	8	13
"Robert Rodriguez"	8	13
"Lance Bangs"	8	13
"Mae Czarina Cruz"	7	22
"Prakash Satam"	7	22
"Ryan Polito"	7	22
"Hidenori Inoue"	7	22
"Toshiya Shinohara"	7	22
"Ozan Açıktan"	7	22
"McG"	7	22
"Clint Eastwood"	7	22
"S.S. Rajamouli"	7	22
"Ron Howard"	7	22
"Quentin Tarantino"	7	22
"Justin G. Dyck"	7	22
"Omoni Oboli"	7	22
"Ram Gopal Varma"	7	22
"Robert Vince"	6	36
"Sameh Abdulaziz"	6	36
"David Fincher"	6	36
"Noah Baumbach"	6	36
"Imtiaz Ali"	6	36
"Milan Luthria"	6	36
"Joey So"	6	36
"Lasse Hallström"	6	36
"Rajkumar Santoshi"	6	36
"Robert Luketic"	6	36
"Sooraj R. Barjatya"	6	36
"Wenn V. Deramas"	6	36
"Hanung Bramantyo"	6	36
"Matt Askem"	6	36
"Steven Soderbergh"	6	36
"Ashutosh Gowariker"	6	36
"Vlad Yudin"	6	36
"Anees Bazmee"	6	36
"Thierry Donard"	5	54
"John G. Avildsen"	5	54
"Mike Clattenburg"	5	54
"Khaled Marei"	5	54
"Mahesh Manjrekar"	5	54
"Wilson Yip"	5	54
"Prakash Jha"	5	54
"Paul Thomas Anderson"	5	54
"David Batty"	5	54
"Detlev Buck"	5	54
"Manny Rodriguez"	5	54
"Martin Campbell"	5	54
"Priyadarshan"	5	54
"Umesh Mehra"	5	54
"Nagesh Kukunoor"	5	54
"Antoinette Jadaone"	5	54
"Rohit Shetty"	5	54
"Leslie Small"	5	54
"Kevin Smith"	5	54
"Andy Tennant"	5	54
"Rajiv Mehra"	5	54
"Niyi Akinmolayan"	5	54
"Spike Lee"	5	54
"Mani Ratnam"	5	54
"Angga Dwimas Sasongko"	5	54
"Kıvanç Baruönü"	5	54
"Madhur Bhandarkar"	5	54
"Riri Riza"	5	54
"Vishal Bhardwaj"	5	54
"Steve Brill"	5	54
"Anurag Kashyap"	5	54
"Ava DuVernay"	5	54
"Vince Marcello"	5	54
"Lynn Shelton"	5	54
"Indra Kumar"	5	54
"Jay Roach"	5	54
"Rocky Soraya"	5	54
"Ernie Barbarash"	4	91
"Farah Khan"	4	91
"Masahiko Murata"	4	91
"Rathindran R Prasad"	4	91
"Lee Tamahori"	4	91
"Dan Villegas"	4	91
"Dibakar Banerjee"	4	91
"Wael Ihsan"	4	91
"Chris Stokes"	4	91
"David Zucker"	4	91
"Ahmad El-Badri"	4	91
"Anurag Basu"	4	91
"Sudhir Mishra"	4	91
"Michael Tiddes"	4	91
"Jun Lana"	4	91
"Jeremy Saulnier"	4	91
"Abbas Alibhai Burmawalla, Mastan Alibhai Burmawalla"	4	91
"Mike Gunther"	4	91
"Fernando González Molina"	4	91
"Michael Simon"	4	91
"Gregory Hoblit"	4	91
"Maroun Baghdadi"	4	91
"Shyam Benegal"	4	91
"Nishikant Kamat"	4	91
"Wong Jing"	4	91
"Subhash Ghai"	4	91
"Roger Kumble"	4	91
"Moses Inwang"	4	91
"Sean McNamara"	4	91
"Chia-Liang Liu"	4	91
"Brian Levant"	4	91
"Rakeysh Omprakash Mehra"	4	91
"Rohit Jugraj"	4	91
"Ahmed Nader Galal"	4	91
"Michael McKay"	4	91
"Farhan Akhtar"	4	91
"Savage Steve Holland"	4	91
"Cristina Jacob"	4	91
"Steve Ball"	4	91
"Paul Dugdale"	4	91
"Clay Glen"	4	91
"Oliver Stone"	4	91
"William Lau"	4	91
"Rob Reiner"	4	91
"Bruno Garotti"	4	91
"Raja Gosnell"	4	91
"Peter Segal"	4	91
"Hrishikesh Mukherjee"	4	91
"Poj Arnon"	4	91
"Philippe Aractingi"	4	91
"Jesse V. Johnson"	4	91
"Rob Minkoff"	4	91
"Kundan Shah"	4	91
"Antonio Campos"	4	91
"Werner Herzog"	4	91
"Edward Cotterill"	4	91
"Lucas Margutti"	4	91
"Wael Ehsan"	4	91
"Shaun Paul Piccinino"	4	91
"Hernán Zin"	4	91
"Mike Newell"	4	91
"Antoine Fuqua"	4	91
"Kayode Kasum"	4	91
"Barry Avrich"	4	91
"Dennis Dugan"	4	91
"Sam Liu"	3	156
"Tim Burton"	3	156
"Munjal Shroff, Tilak Shetty"	3	156
"Ron Oliver"	3	156
"Greg MacGillivray"	3	156
"Gilles Paquet-Brenner"	3	156
"Steve Carr"	3	156
"Rako Prijanto"	3	156
"John Asher"	3	156
"Ahmed Al-Badry"	3	156
"Blair Simmons"	3	156
"David R. Ellis"	3	156
"Barry Levinson"	3	156
"Amr Arafa"	3	156
"Wolfgang Petersen"	3	156
"Atom Egoyan"	3	156
"Orlando von Einsiedel"	3	156
"Robert Zemeckis"	3	156
"Bobcat Goldthwait"	3	156
"Ric Roman Waugh"	3	156
"Toshiyuki Kubooka"	3	156
"Reginald Hudlin"	3	156
"Hasan Karacadağ"	3	156
"Linda Mendoza"	3	156
"Sachin Yardi"	3	156
"Paul W.S. Anderson"	3	156
"Jonathan Demme"	3	156
"Adam Shankman"	3	156
"Gonzalo López-Gallego"	3	156
"Latif Faiziyev, Umesh Mehra"	3	156
"Walter Hill"	3	156
"Tom Hooper"	3	156
"Les Mayfield"	3	156
"Olivia M. Lamasan"	3	156
"Shawn Levy"	3	156
"Peter Spirer"	3	156
"David Ayer"	3	156
"Mohamed Samy"	3	156
"Rajiv Menon"	3	156
"Chris Howe"	3	156
"Christopher Nolen"	3	156
"Gabriele Muccino"	3	156
"Abhishek Sharma"	3	156
"Ketan Mehta"	3	156
"Mohamed Hamdy"	3	156
"Barak Goodman"	3	156
"Ribhu Dasgupta"	3	156
"Nate Adams, Adam Carolla"	3	156
"Peyton Reed"	3	156
"Rajkumar Hirani"	3	156
"Raj Kapoor"	3	156
"Kim Nguyen"	3	156
"Ken Ghosh"	3	156
"Prakash Mehra"	3	156
"Abhishek Kapoor"	3	156
"Fajar Bustomi, Pidi Baiq"	3	156
"Sebastián Schindel"	3	156
"Shigeaki Kubo"	3	156
"Onir"	3	156
"Remo D'Souza"	3	156
"Luis Ara"	3	156
"Roland Emmerich"	3	156
"Simon Wincer"	3	156
"Sujoy Ghosh"	3	156
"Sermiyan Midyat"	3	156
"Michèle Ohayon"	3	156
"Terry Gilliam"	3	156
"John Fortenberry"	3	156
"Hardik Mehta"	3	156
"Mark Waters"	3	156
"Barry Sonnenfeld"	3	156
"Sumitra Bhave, Sunil Sukthankar"	3	156
"Matías Gueilburt"	3	156
"Chris Smith"	3	156
"Mark Raso"	3	156
"Ishaya Bako"	3	156
"John Huston"	3	156
"Soudade Kaadan"	3	156
"Burak Aksak"	3	156
"Mahesh Bhatt"	3	156
"Phillip Noyce"	3	156
"David Michôd"	3	156
"Sofia Coppola"	3	156
"B. V. Nandini Reddy"	3	156
"Peter Jackson"	3	156
"Diego Pignataro"	3	156
"Pankaj Batra"	3	156
"Drake Doremus"	3	156
"Tilak Shetty"	3	156
"David Mackenzie"	3	156
"Brett Haley"	3	156
"Todd Phillips"	3	156
"Sylvester Stallone"	3	156
"Jeff Nichols"	3	156
"Nila Madhab Panda"	3	156
"Marc Forster"	3	156
"Maria Ripoll"	3	156
"Craig Brewer"	3	156
"Zoya Akhtar"	3	156
"Louis C.K."	3	156
"Noriyuki Abe"	3	156
"Adriano Rudiman"	3	156
"Alfonso Cuarón"	3	156
"Note Chern-Yim"	3	156
"Bedran Güzel"	3	156
"James Wan"	3	156
"Abhinay Deo"	3	156
"Karan Johar"	3	156
"Alex Woo, Stanley Moore"	3	156
"Lekh Tandon"	3	156
"Rob Cohen"	3	156
"Andibachtiar Yusuf"	3	156
"Dante Lam"	3	156
"Charles Stone III"	3	156
"John Lee Hancock"	3	156
"Theodore Boborol"	3	156
"Chandrakant Kulkarni"	3	156
"Aziz Mirza"	3	156
"Jane Campion"	3	156
"Raj Kumar Gupta"	3	156
"Joe Berlinger"	3	156
"Amitoj Mann"	3	156
"Leigh Janiak"	3	156
"Mike Smith, John Paul Tremblay, Robb Wells"	3	156
"Kenneth Gyang"	3	156
"Pablo Larraín"	3	156
"Adze Ugah"	3	156
"Robert O. Peters"	3	156
"Jon Rosenbaum"	3	156
"Momoko Kamiya"	3	156
"Guillermo del Toro"	3	156
"John Schultz"	3	156
"Olivier Assayas"	3	156
"Roger Donaldson"	3	156
"Leena Yadav"	3	156
"Mikhail Red"	3	156
"Steven C. Miller"	3	156
"Tate Taylor"	3	156
"Chapman Way, Maclain Way"	3	156
"Jeff Baena"	3	156
"Vikramaditya Motwane"	3	156
"Andrzej Bartkowiak"	3	156
"Neeraj Pandey"	3	156
"Jon M. Chu"	3	156
"Adrian Teh"	3	156
"Yoshiyuki Tomino, Yoshikazu Yasuhiko"	3	156
"Vivieno Caldinelli"	3	156
"Ron Myrick"	3	156
"Karthik Subbaraj"	3	156
"Rano Karno"	3	156
"Richard Weston"	3	156
"Walter C. Miller"	3	156
"Conrad Helten"	3	156
"Abhishek Chaubey"	3	156
"Cheh Chang"	3	156
"Morgan Neville"	3	156
"Tope Oshin"	3	156
"Qaushiq Mukherjee"	3	156
"Scott Zabielski"	3	156
"Seyi Babatope"	3	156
"Neal Brennan"	3	156
"Frank Coraci"	3	156
"Alex Lehmann"	3	156
"Joe Camp"	3	156
"Brad Anderson"	3	156
"Mike Flanagan"	3	156
"Ashwin Saravanan"	3	156
"Shirish Kunder"	3	156
"Mahmoud Karim"	3	156
"Satish Rajwade"	3	156
"Ishi Rudell"	3	156
"Paul Greengrass"	3	156
"Renny Harlin"	3	156
"Ivan Reitman"	3	156
"Adam McKay"	3	156
"Yasmin Ahmad"	3	156
"Lilly Wachowski, Lana Wachowski"	3	156
"G.J. Echternkamp"	3	156
"Pang Ho-cheung"	3	156
"Garry Marshall"	3	156
"Michael Dowse"	3	156
"Michael Bay"	3	156
"Damien O’Connor"	2	338
"Gore Verbinski"	2	338
"Shakun Batra"	2	338
"Wayne Blair"	2	338
"Ruel S. Bayani"	2	338
"Zoe Berriatúa"	2	338
"Rodrigo Van Der Put"	2	338
"Jeff Wadlow"	2	338
"Nicholas Kharkongor"	2	338
"Michael D. Black"	2	338
"Erik Canuel"	2	338
"Shivam Nair"	2	338
"Scott Moran"	2	338
"Vicky Matthews"	2	338
"Luis Valdez"	2	338
"Naoko Yamada"	2	338
"Mitch Schauer"	2	338
"Shakti Samanta"	2	338
"Mohit Suri"	2	338
"Amy Poehler"	2	338
"Baran bo Odar"	2	338
"David Dobkin"	2	338
"Stephen Frears"	2	338
"Ruben Fleischer"	2	338
"David Gordon Green"	2	338
"Aditya Kripalani"	2	338
"Shalini Kantayya"	2	338
"Tyler Spindel"	2	338
"James Ponsoldt"	2	338
"Alexandre Avancini"	2	338
"J.C. Chandor"	2	338
"Seth Barrish"	2	338
"Sangeeth Sivan"	2	338
"Eduardo Chauvet"	2	338
"Javier Ruiz Caldera"	2	338
"Nikhil Advani"	2	338
"Anirban Majumder"	2	338
"Brian Klein"	2	338
"Kagiso Lediga"	2	338
"Sze Yu Lau"	2	338
"Gareth Evans"	2	338
"Justin Kelly"	2	338
"Chris Robinson"	2	338
"Frank Oz"	2	338
"Errol Morris"	2	338
"Brian Volk-Weiss"	2	338
"Rizal Mantovani"	2	338
"Sherif Arafa"	2	338
"Lucky Kuswandi"	2	338
"Malcolm D. Lee"	2	338
"Dan Gilroy"	2	338
"Neill Blomkamp"	2	338
"Park Hoon-jung"	2	338
"Vikas Bahl"	2	338
"Peter Orton"	2	338
"Lars von Trier"	2	338
"Jose Manuel Colón"	2	338
"Karen J. Lloyd"	2	338
"Martin Gorst"	2	338
"Cem Yılmaz"	2	338
"J.D. Dillard"	2	338
"Tarun Mansukhani"	2	338
"Ben Wallis"	2	338
"Peter Chelsom"	2	338
"Cristi Puiu"	2	338
"Alex Zamm"	2	338
"Jonathan Mostow"	2	338
"Smeep Kang"	2	338
"Ksshitij Chaudhary"	2	338
"Nia Dinata"	2	338
"Tim Johnson"	2	338
"Alejandro Montiel"	2	338
"Asif Kapadia"	2	338
"Ulises Valencia"	2	338
"Isaac Ezban"	2	338
"Janusz Majewski"	2	338
"Liam Lynch"	2	338
"Haifaa Al-Mansour"	2	338
"Liam O'Donnell"	2	338
"Edwin"	2	338
"Davis Guggenheim"	2	338
"Leslie Small, Tim Story"	2	338
"Richard LaGravenese"	2	338
"Joram Lürsen"	2	338
"Vinil Mathew"	2	338
"Ekene Som Mekwunye"	2	338
"Walter Taylaur"	2	338
"Rob Marshall"	2	338
"Johannes Roberts"	2	338
"Alexis Morante"	2	338
"Simon Wells"	2	338
"Neil Jordan"	2	338
"Elaine McMillion Sheldon"	2	338
"Ömer Faruk Sorak"	2	338
"A. L. Vijay"	2	338
"Michael J. Bassett"	2	338
"Florent Bodin"	2	338
"Girish Malik"	2	338
"Laura Brownson"	2	338
"Peter Lepeniotis"	2	338
"Kenny Young"	2	338
"Ali F. Mostafa"	2	338
"Marcelo Galvão"	2	338
"Anurag Kashyap, Dibakar Banerjee, Karan Johar, Zoya Akhtar"	2	338
"Philipp Stölzl"	2	338
"Tanuja Chandra"	2	338
"Laxman Utekar"	2	338
"Dee Rees"	2	338
"Alex Merkin"	2	338
"Matthew Vaughn"	2	338
"Darren Lynn Bousman"	2	338
"Kip Andersen, Keegan Kuhn"	2	338
"Luis Estrada"	2	338
"Nelson McCormick"	2	338
"Daniel Benmayor"	2	338
"Sriram Raghavan"	2	338
"Karyn Kusama"	2	338
"David M. Rosenthal"	2	338
"Sylvie Verheyde"	2	338
"Sara Colangelo"	2	338
"Brad Bird"	2	338
"Mana Yasuda"	2	338
"Jonathan Levine"	2	338
"Sanjay Jadhav"	2	338
"Olivier Marchal"	2	338
"Parambrata Chatterjee"	2	338
"Nadia Hallgren"	2	338
"Abba T. Makama"	2	338
"Peter Sullivan"	2	338
"Wes Craven"	2	338
"Ramsey Nouah"	2	338
"Brian Oakes"	2	338
"Matt Kugelman"	2	338
"Stephen Herek"	2	338
"John Duigan"	2	338
"Jon Lucas, Scott Moore"	2	338
"Stan Lathan"	2	338
"Luv Ranjan"	2	338
"Mohamed Diab"	2	338
"Navaniat Singh"	2	338
"Hussein Kamal"	2	338
"Michael Damian"	2	338
"Avadhoot Gupte"	2	338
"George Clooney"	2	338
"Gary Fleder"	2	338
"Keishi Otomo"	2	338
"Eduardo Roy Jr."	2	338
"Mark Steven Johnson"	2	338
"Brad Peyton"	2	338
"Danny Boyle"	2	338
"Greg Rankin, TJ Sullivan"	2	338
"Antonio Serrano"	2	338
"Bobby Farrelly, Peter Farrelly"	2	338
"Banjong Pisanthanakun"	2	338
"Susannah Ward"	2	338
"Tom Shadyac"	2	338
"Ted Demme"	2	338
"Oluseyi Asurf"	2	338
"Najwa Najjar"	2	338
"Kazuchika Kise"	2	338
"Trivikram Srinivas"	2	338
"Ahmed Zain"	2	338
"JP Habac"	2	338
"Mark Palansky"	2	338
"Yorgos Lanthimos"	2	338
"Stanley Kubrick"	2	338
"John Wells"	2	338
"Kabir Sadanand"	2	338
"Daniel Oriahi"	2	338
"Nicolas Pesce"	2	338
"Ian Edelman"	2	338
"Daniel Gray Longino"	2	338
"Obi Emelonye"	2	338
"Trey Edward Shults"	2	338
"Gary Ross"	2	338
"Angelina Jolie"	2	338
"Peter Berg"	2	338
"Reema Kagti"	2	338
"N. Linguswamy"	2	338
"Paco Plaza"	2	338
"Damián Romay"	2	338
"Paul Soriano"	2	338
"James Wong"	2	338
"David O. Russell"	2	338
"Renzil D'Silva"	2	338
"Kyle Newacheck"	2	338
"Marcos Bucay"	2	338
"Mike Binder"	2	338
"Robert Altman"	2	338
"Christopher Guest"	2	338
"M. Night Shyamalan"	2	338
"Israel Adrián Caetano"	2	338
"Will Yapp"	2	338
"Jeethu Joseph"	2	338
"Swapnaneel Jayakar"	2	338
"Federico Lemos"	2	338
"Satish Kaushik"	2	338
"Brian De Palma"	2	338
"Charlie Lightening"	2	338
"Paul Verhoeven"	2	338
"Toa Fraser"	2	338
"Hadi El Bagoury"	2	338
"Bryan Bertino"	2	338
"Ashok Nanda"	2	338
"John Hillcoat"	2	338
"Anthony Minghella"	2	338
"Jota Linares"	2	338
"Frank Rajah Arase"	2	338
"Abhijit Panse"	2	338
"Hani Hamdi"	2	338
"Upi Avianto"	2	338
"Andy Fickman"	2	338
"Alejandro Doria"	2	338
"Jared Hess"	2	338
"Sang-ho Yeon"	2	338
"Mez Tharatorn"	2	338
"David Paul Meyer"	2	338
"Mysskin"	2	338
"Alex Proyas"	2	338
"Alejandro Agresti"	2	338
"Delhiprasad Deenadayalan"	2	338
"Jalil Lespert"	2	338
"Bille Woodruff"	2	338
"Esteban Vidal"	2	338
"Scott L. Montoya"	2	338
"Jonathan Hensleigh"	2	338
"Jayan Moodley"	2	338
"Bo Burnham, Christopher Storer"	2	338
"Satyajit Bhatkal"	2	338
"Shigeaki Kubo, Tsuyoshi Nakakuki"	2	338
"Kemi Adetiba"	2	338
"Alexandre Aja"	2	338
"Gus Van Sant"	2	338
"Vipul Amrutlal Shah"	2	338
"Mikhil Musale"	2	338
"Harvey Lowry"	2	338
"Susan Johnson"	2	338
"Ismail Farouk"	2	338
"Pratim D. Gupta"	2	338
"Gillian Robespierre"	2	338
"Ivan Ayr"	2	338
"Sameer Vidwans"	2	338
"Mahsun Kırmızıgül"	2	338
"Makarand Mane"	2	338
"Sachin"	2	338
"Pete Travis"	2	338
"George Ford"	2	338
"J.A. Bayona"	2	338
"Halitha Shameem"	2	338
"Manolo Caro"	2	338
"Bonni Cohen, Jon Shenk"	2	338
"Joe Roth"	2	338
"Julián Hernández"	2	338
"Paul Haggis"	2	338
"Taika Waititi"	2	338
"Bill Condon"	2	338
"Sekhar Kammula"	2	338
"Oliver Twinch"	2	338
"Dallas Jackson"	2	338
"Jacob Kornbluth"	2	338
"Zack Snyder"	2	338
"Oz Rodriguez"	2	338
"Joyce Bernal"	2	338
"Bernie Denk"	2	338
"Kedar Shinde"	2	338
"Sam Hobkinson"	2	338
"Thomas Sieben"	2	338
"Shirley Frimpong-Manso"	2	338
"Brian Robbins"	2	338
"Nick Castle"	2	338
"Keoni Waxman"	2	338
"R. Ellis Frazier"	2	338
"Daniel Calparsoro"	2	338
"Daniel Stamm"	2	338
"Christopher Smith"	2	338
"Timothy Woodward Jr."	2	338
"Cosima Spender"	2	338
"Tom Donahue"	2	338
"Dimitri Logothetis"	2	338
"James Toback"	2	338
"James Mangold"	2	338
"Chanda Bell"	2	338
"Scott Hicks"	2	338
"Stanley Nelson"	2	338
"Tom Ford"	2	338
"Ron Davis"	2	338
"Sergio Leone"	2	338
"Courtney Hunt"	2	338
"Toka McBaror"	2	338
"James McTeigue"	2	338
"Mary Harron"	2	338
"Andrew Niccol"	2	338
"Sean Penn"	2	338
"Kasia Uscinska"	2	338
"Patryk Vega"	2	338
"Tarsem Singh"	2	338
"Mar Targarona"	2	338
"Jeremy Kenyon Lockyer Corbell"	2	338
"Hannah Fidell"	2	338
"Tony Scott"	2	338
"Shlok Sharma"	2	338
"Leslie Iwerks"	2	338
"Sarah Gavron"	2	338
"Gregory Caruso"	2	338
"James Bobin"	2	338
"Basu Chatterjee"	2	338
"Petra Costa"	2	338
"Herman Yau"	2	338
"Kim Joo-hyung"	2	338
"Rajat Kapoor"	2	338
"Timo Tjahjanto"	2	338
"Spike Jonze"	2	338
"Raditya Dika"	2	338
"Jon Favreau"	2	338
"Rebecca Zlotowski"	2	338
"Bruce Beresford"	2	338
"Stacie Passon"	2	338
"Nick Broomfield"	2	338
"Ben Simms"	2	338
"Jeff Orlowski"	2	338
"Robin Swicord"	2	338
"Sam Mendes"	2	338
"Phil Weinstein"	2	338
"George C. Wolfe"	2	338
"Àlex Pastor, David Pastor"	2	338
"Sam Raimi"	2	338
"Chris Bould"	2	338
"RZA"	2	338
"Álex de la Iglesia"	2	338
"Howard Zieff"	2	338
"Aditya Sarpotdar"	2	338
"Ridley Scott"	2	338
"Will Gluck"	2	338
"James Yukich"	2	338
"Punit Malhotra"	2	338
"Dennie Gordon"	2	338
"Claire Scanlon"	2	338
"Salvador Calvo"	2	338
"Eli Roth"	2	338
"Daniel Alfredson"	2	338
"Maryo J. De los Reyes"	2	338
"Paul Andrew Williams"	2	338
"Jack C. Newell"	2	338
"Julien Leclercq"	2	338
"Bong Joon Ho"	2	338
"Heidi Ewing, Rachel Grady"	2	338
"Gerardo Olivares"	2	338
"Kobun Shizuno, Hiroyuki Seshita"	2	338
"Ali Ragab"	2	338
"Hajime Kamegaki"	2	338
"Michael Cuesta"	2	338
"Bradley Parker"	2	338
"Ahishor Solomon"	2	338
"Esteban Crespo"	2	338
"Kingsley Ogoro"	2	338
"Ted Emery"	2	338
"Asghar Farhadi"	2	338
"Duncan Jones"	2	338
"Bill D'Elia"	2	338
"Charles Uwagbai"	2	338
"Patricia Rozema"	2	338
"Alex Díaz"	2	338
"Santosh Sivan"	2	338
"Steven Brill"	2	338
"A.R. Murugadoss"	2	338
"Stanisław Różewicz"	2	338
"Anthony D'Souza"	2	338
"Michael Winterbottom"	2	338
"V Vignarajan"	2	338
"Alison Klayman"	2	338
"BB Sasore"	2	338
"Christopher Storer"	2	338
"Lee Hirsch"	2	338
"Nagraj Manjule"	2	338
"Sean Cisterna"	2	338
"Joe DeMaio"	2	338
"Alejandro Fernández Almendras"	2	338
"John Dahl"	2	338
"Steve Paley"	2	338
"Florian Henckel von Donnersmarck"	2	338
"Joe Dante"	2	338
"Husam El-Gohari"	2	338
"Apoorva Lakhia"	2	338
"Justin Benson, Aaron Moorhead"	2	338
"Jeff Tremaine"	2	338
"Peter Hutchings"	2	338
"Baljit Singh Deo"	2	338
"Jerrold Tarog"	2	338
"John Stockwell"	2	338
"Tigmanshu Dhulia"	2	338
"Erwin van den Eshof"	2	338
"Şenol Sönmez"	2	338
"Dharmesh Darshan"	2	338
"Patrick Brice"	2	338
"Ryan Murphy"	2	338
"Nawapol Thamrongrattanarit"	2	338
"John Ford"	2	338
"Kevin MacDonald"	2	338
"Tyler Perry"	2	338
"Dominic Sena"	2	338
"Jason Reitman"	2	338
"Ezekiel Norton"	2	338
"Stanley Moore, Alex Woo"	2	338
"Cal Seville"	2	338
"Pierre Morel"	2	338
"Osgood Perkins"	2	338
"Ben Wheatley"	2	338
"Vikram Bhatt"	2	338
"Stephen Daldry"	2	338
"Tiller Russell"	2	338
"Dino Risi"	2	338
"Michael Fimognari"	2	338
"Scott Stewart"	2	338
"Jason Paul Laxamana"	2	338
"Tony Giglio"	2	338
"Bejoy Nambiar"	2	338
"Michael Drumm"	2	338
"Luc Vinciguerra"	2	338
"Meltem Bozoflu"	2	338
"Randal Kleiser"	2	338
"Ethan Coen, Joel Coen"	2	338
"Harold Cronk"	2	338
"Ciarán Foy"	2	338
"Ari Sandel"	2	338
"Colin Trevorrow"	2	338
"Larry Latham"	2	338
"Mukul Anand"	2	338
"Khaled El Halafawy"	2	338
"Stanley Tong"	2	338
"Ryan Coogler"	2	338
"Richard Rich"	2	338
"Michael Patrick King"	2	338
"Kim A. Snyder"	2	338
"Everardo González"	2	338
"Dave Higby"	2	338
"Sam Taplin"	2	338
"Federico Veiroj"	2	338
"Chris Weitz"	2	338
"Pascal Amanfo"	2	338
"Andrew Lau Wai-Keung"	2	338
"Francesco Imperato"	2	338
"Alistair Legrand"	2	338
"Daniel Lindsay, T.J. Martin"	2	338
"Paul Weitz"	2	338
"Norman Jewison"	2	338
"Jerry Rothwell"	2	338
"David E. Talbert"	2	338
"Chito S. Roño"	2	338
"Bo Burnham"	2	338
"Miguel Arteta"	2	338
"Steve Gukas"	2	338
"Stephen Chow"	2	338
"John Erick Dowdle"	2	338
"Warren P. Sonoda"	2	338
"Umesh Shukla"	2	338
"S.S. Wilson"	2	338
"Atanu Ghosh"	2	338
"Aaron Sorkin"	2	338
"Zak Hilditch"	2	338
"Simon Stone"	2	338
"Amy Schumer"	2	338
"Morgan Spurlock"	2	338
"Ricky Gervais"	2	338
"Anthony Giordano"	2	338
"Eli Craig"	2	338
"William Brent Bell"	2	338
"Ifa Isfansyah"	2	338
"Nicolás López"	2	338
"Ahmed Zein"	2	338
"Chad Van De Keere"	2	338
"Stephen Chiodo"	2	338
"Clark Johnson"	2	338
"Thiru"	2	338
"Ringo Lam"	2	338
"David Pablos"	2	338
"Chris Sivertson"	2	338
"Tosin Igho"	2	338
"Floyd Russ"	2	338
"Ross Boyask"	2	338
"Sridhar Rangayan"	2	338
"Michael Showalter"	2	338
"Saratswadee Wongsomphet"	2	338
"Gajendra Ahire"	2	338
"Manish Jha"	2	338
"Kevin Layne"	2	338
"Måns Mårlind, Björn Stein"	2	338
"Derek Cianfrance"	2	338
"Rian Johnson"	2	338
"Liz Garbus"	2	338
"Kristian Mercado"	2	338
"Jeffrey Walker"	2	338
"Rhys Thomas"	2	338
"Gianfranco Rosi"	2	338
"Charlie McDowell"	2	338
"Sundar C."	2	338
"Guy Ritchie"	2	338
"George Stevens"	1	834
"Shanawaz Nellikunnil"	1	834
"Phyllida Lloyd"	1	834
"Richard Greenberg"	1	834
"Benjamin Arfmann"	1	834
"Pulkit"	1	834
"Aleksey German"	1	834
"Brian Skiba"	1	834
"Ian Cheney, Sharon Shattuck"	1	834
"V. Scott Balcerek"	1	834
"Borja Cobeaga"	1	834
"Jee-woon Kim"	1	834
"Matt Wechsler"	1	834
"Einar Gabbassov"	1	834
"Joe Swanberg"	1	834
"Nitesh Tiwari"	1	834
"Gervasio Iglesias, Alexis Morante"	1	834
"Louis Leterrier"	1	834
"Mitch Gould"	1	834
"Renato De Maria"	1	834
"Eshom Nelms, Ian Nelms"	1	834
"Geetu Mohandas"	1	834
"Mark McQueen"	1	834
"Adam Salky"	1	834
"Alessandra de Rossi"	1	834
"Will Canon"	1	834
"Terry Jones"	1	834
"Olivier Megaton"	1	834
"Ben Patterson"	1	834
"Alejandro De Grazia, Juan Stadler"	1	834
"Colin Strause, Greg Strause"	1	834
"Nicholas Hytner"	1	834
"Paula Apsell, Kirk Wolfinger"	1	834
"Giancarlo Esposito"	1	834
"Mark Craig"	1	834
"Abhishek Varman"	1	834
"Jaume Collet-Serra"	1	834
"Remi Weekes"	1	834
"Eric Idle, Aubrey Powell"	1	834
"Álvaro Longoria, Gerardo Olivares"	1	834
"Christian Zübert"	1	834
"David Guy Levy"	1	834
"Henrik Ruben Genz"	1	834
"Joel Hopkins"	1	834
"Norberto López Amado"	1	834
"Rodrigo Triana"	1	834
"Kiki Goshay, Jacqueline Monetta"	1	834
"Haissam Hussain"	1	834
"Puneet Sira"	1	834
"So Yong Kim"	1	834
"Tony Kaye"	1	834
"Hanno Olderdissen"	1	834
"Matheus Souza"	1	834
"Alan Yang"	1	834
"Armando Iannucci"	1	834
"Manjari Makijany"	1	834
"Kyle Rideout"	1	834
"Arjun Gourisaria, Moinak Biswas"	1	834
"Brit McAdams"	1	834
"Lucien Bourjeily"	1	834
"William Wyler, John Sturges"	1	834
"Amy Rice"	1	834
"Tiffanie Hsu"	1	834
"Joe Nussbaum"	1	834
"Ziad Doueiri"	1	834
"Jamie M. Dagg"	1	834
"Sam de Jong"	1	834
"Daniel Lee"	1	834
"Eric D. Cabello Díaz"	1	834
"Marla M. Ancheta"	1	834
"Dianne Dreyer"	1	834
"Arthur Allan Seidelman"	1	834
"Can Ulkay"	1	834
"Mark Lo"	1	834
"Sarjun"	1	834
"Raja Menon"	1	834
"Robi Michael"	1	834
"Lorena Munoz"	1	834
"Edward Drake"	1	834
"Shamyl Othman"	1	834
"Joe Penna"	1	834
"Derek Yee"	1	834
"Mike Fleiss"	1	834
"Sung Do-jun"	1	834
"Terry Loane"	1	834
"Leticia Jorge Romero"	1	834
"Rohan Sippy"	1	834
"Julia von Heinz"	1	834
"Dejan Zečević"	1	834
"Gauravv K Chawla"	1	834
"Camille Shooshani"	1	834
"Juraj Šajmovič"	1	834
"Anurin Nwunembom"	1	834
"Dallas Jenkins"	1	834
"Jose Gomez"	1	834
"Kristin Hanggi"	1	834
"Rajesh Touchriver"	1	834
"Ayaan Mukherji"	1	834
"Shivendra Singh Dungarpur"	1	834
"Franziska Meyer Price"	1	834
"Yuki Tanada"	1	834
"Sarik Andreasyan"	1	834
"Khalid Mohamed"	1	834
"Huang Hsin-Yao"	1	834
"Naya Anindita"	1	834
"Moataz El Tony"	1	834
"Leandro Mark, Nicolás Silbert"	1	834
"Adam Nimoy"	1	834
"Karan Malhotra"	1	834
"Adam Sjöberg"	1	834
"Jesús Magaña Vázquez"	1	834
"Monique Gardenberg"	1	834
"Inas El-Degheidy"	1	834
"Matt Palmer"	1	834
"Chris Perkel"	1	834
"Eric Summer, Éric Warin"	1	834
"Tolga Karaçelik"	1	834
"Clay Kaytis"	1	834
"Keenen Ivory Wayans"	1	834
"Binu Ulahhannan"	1	834
"Carey McKenzie"	1	834
"Rana Eid"	1	834
"Akhil Paul, Anas Khan"	1	834
"Sonia Lowman"	1	834
"Tomer Eshed"	1	834
"Shawn Crahan"	1	834
"Nguyen Thanh Tung"	1	834
"Mateo Gil"	1	834
"Pascal Atuma"	1	834
"Jonathan Lynn"	1	834
"Richard van't Riet"	1	834
"David Blair"	1	834
"Christian Charles"	1	834
"Jijo Pancode"	1	834
"Hemant Gaba, Pratim D. Gupta, Sudhish Kamath, Nalan Kumarasamy, Anu Menon, Sandeep Mohan, Qaushiq Mukherjee, Rajshree Ojha, Raja Sen, Abhinav Shiv Tiwari, Suparn Verma"	1	834
"Tejas Prabha Vijay Deoskar"	1	834
"Aytaç Ağırlar"	1	834
"Ross Kauffman"	1	834
"Hang-Jun Jang"	1	834
"Luis Mandoki"	1	834
"Naoto Amazutsumi"	1	834
"Hèctor Hernández Vicens"	1	834
"Beth Sleven, Allan Jacobsen, Kevin Wotton"	1	834
"Yeung Yat-Tak"	1	834
"Shawn Arranha"	1	834
"Matias Mariani"	1	834
"Michael Del Monte"	1	834
"Nimród Antal"	1	834
"Emmett Malloy"	1	834
"Chris Kelly"	1	834
"Mohammed Alhmly"	1	834
"Aditya Vikram Sengupta"	1	834
"Geoffrey Orthwein, Andrew Sullivan"	1	834
"Bob Nelson"	1	834
"Rod Cabatana Marmol"	1	834
"Halder Gomes"	1	834
"Wash Westmoreland"	1	834
"Matt D'Elia"	1	834
"Manish Tiwary"	1	834
"Michael Winnick"	1	834
"Andrew Slater"	1	834
"Roberto Santucci"	1	834
"Lee Chang-dong"	1	834
"Ding-Lin Wang"	1	834
"Daniele Thompson"	1	834
"Mark Rosman"	1	834
"Marek Losey"	1	834