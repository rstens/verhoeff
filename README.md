## Verhoeff Algorithm Implementations

[Wikipedia](https://en.wikipedia.org/wiki/Verhoeff_algorithm) was updated to remove all the implementation links, so for completeness sake they are here now:

* [Detailed description of the Verhoeff algorithm](http://www.cs.utsa.edu/~wagner/laws/verhoeff.html)
* [A description using lookup tables](http://www.augustana.ab.ca/~mohrj/algorithms/checkdigit.html)
* [Verhoeff implementation in Perl](http://search.cpan.org/~jpeterson/Algorithm-Verhoeff-0.3/lib/Algorithm/Verhoeff.pm)
* [Verhoeff implementation in FileMaker Pro](http://www.briandunning.com/cf/616)
* [Verhoeff implementation in MS SQL Server Transact SQL](https://github.com/rstens/verhoeff)
* [Biographical sketch of Jacobus Verhoeff](http://www.ams.org/featurecolumn/archive/verhoeff.html)
* [Verhoeff validation and generation code in C++](http://sites.google.com/site/abapexamples/c/verhoeff-algorithm)
* [Verhoeff validation & generation code in Javascript](http://sites.google.com/site/abapexamples/javascript/verhoeff-algorithm)
* [Algorithm Verhoeff validation & generation code in C#, VB.NET, VBA, Java, Python, D, PHP, ActionScript and Pascal/Delphi](http://en.wikibooks.org/wiki/Algorithm_Implementation/Checksums/Verhoeff)

## Introduction
I have created a SQLServer User-Defined function for checking and creating the Verhoeff check digit.

See [WikiPedia:Verhoeff_algorithm](http://en.wikibooks.org/wiki/Algorithm_Implementation/Checksums/Verhoeff)

The Verhoeff algorithm, a checksum formula for error detection first published in 1969, was developed by Dutch mathematician Jacobus Verhoeff (born 1927). 
Like the more widely known Luhn algorithm, it works with strings of decimal digits of any length. It does a better job than the Luhn algorithm, though, in that it will detect all "transposition" errors (switching of two adjacent digits), as well as catching many other types of errors that pass the Luhn formula undetected.

### Usage

```sql
/* Usage for checking the validity of a number:*/
SELECT dbo.checksumVerhoeff([number TO be checked],0) FROM [your TABLE]


/*Usage for creating a check digit for a number:*/
SELECT dbo.checksumVerhoeff([your number],1) FROM [your TABLE]

```
