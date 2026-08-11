Business Question #1

-- Is Netflix primarily a Movie platform or a TV Show platform?

-- Result:

-- Type	Titles
-- Movie	6131
-- TV Show	2676

-- Business Insight

-- Netflix's catalog is heavily weighted toward movies (around 70%), suggesting a strategy focused on offering a broad movie library while maintaining a smaller TV show catalog.

-- Dashboard Visualization: Donut Chart

Business Question #2
Which countries contribute the most content?

SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Output

"United States"	2818
"India"	972
"United Kingdom"	419
"Japan"	245
"South Korea"	199
"Canada"	181
"Spain"	145
"France"	124
"Mexico"	110
"Egypt"	106

Business Question #3
Which ratings dominate Netflix?

SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;

-- Output

"TV-MA"	3207
"TV-14"	2160
"TV-PG"	863
"R"	799
"PG-13"	490
"TV-Y7"	334
"TV-Y"	307
"PG"	287
"TV-G"	220
"NR"	80
"G"	41
"TV-Y7-FV"	6
"UR"	3
"NC-17"	3
"66 min"	1
"84 min"	1
"74 min"	1

Business Question #4
Which directors have produced the most Netflix titles?

SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- Output

"Rajiv Chilaka"	19
"Raúl Campos, Jan Suter"	18
"Suhas Kadav"	16
"Marcus Raboy"	16
"Jay Karas"	14
"Cathy Garcia-Molina"	13
"Youssef Chahine"	12
"Martin Scorsese"	12
"Jay Chapman"	12
"Steven Spielberg"	11

Business Question #5
Which genres dominate Netflix?

SELECT
    listed_in,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;

-- Output

"Dramas, International Movies"	362
"Documentaries"	359
"Stand-Up Comedy"	334
"Comedies, Dramas, International Movies"	274
"Dramas, Independent Movies, International Movies"	252
"Kids' TV"	220
"Children & Family Movies"	215
"Children & Family Movies, Comedies"	201
"Documentaries, International Movies"	186
"Dramas, International Movies, Romantic Movies"	180

Business Question #6
How has Netflix's content library changed over time?

SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

-- Output

1925	1
1942	2
1943	3
1944	3
1945	4
1946	2
1947	1
1954	2
1955	3
1956	2
1958	3
1959	1
1960	4
1961	1
1962	3
1963	2
1964	2
1965	2
1966	1
1967	5
1968	3
1969	2
1970	2
1971	5
1972	5
1973	10
1974	7
1975	7
1976	9
1977	7
1978	7
1979	11
1980	11
1981	13
1982	17
1983	11
1984	12
1985	10
1986	13
1987	8
1988	18
1989	16
1990	22
1991	17
1992	23
1993	28
1994	22
1995	25
1996	24
1997	38
1998	36
1999	39
2000	37
2001	45
2002	51
2003	61
2004	64
2005	80
2006	96
2007	88
2008	136
2009	152
2010	194
2011	185
2012	237
2013	288
2014	352
2015	560
2016	902
2017	1032
2018	1147
2019	1030
2020	953
2021	592