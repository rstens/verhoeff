/* I have created a SQLServer User-Defined function for checking and creating the Verhoeff check digit.

See WikiPedia:Verhoeff_algorithm
The Verhoeff algorithm, a checksum formula for error detection first published in 1969, was developed by Dutch mathematician Jacobus Verhoeff (born 1927). 
Like the more widely known Luhn algorithm, it works with strings of decimal digits of any length. It does a better job than the Luhn algorithm, though, in that it will detect 
all "transposition" errors (switching of two adjacent digits), as well as catching many other types of errors that pass the Luhn formula undetected.
*/

/****** Object:  UserDefinedFunction [dbo].[checksumVerhoeff]    Script Date: 02/08/2008 15:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[checksumVerhoeff] (@NUMBER bigint, @ACTION tinyint) 
/* @NUMBER is the number to check or to create a checkdigit for. */
/* @ACTION: 0 = Check on validity (0 return is valid, anything else is not), 1=Create checknum */

RETURNS tinyint
WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE @c tinyint
	DECLARE @len int
	DECLARE @m tinyint
	DECLARE @n varchar(255)
	DECLARE @i smallint
	
	/* Declare the Arrays */
	DECLARE @d char(100)
	DECLARE @p char(80)
	DECLARE @inv char(10)
	SET @d='0123456789123406789523401789563401289567401239567859876043216598710432765982104387659321049876543210'
	SET @p='01234567891576283094580379614289160435279453126870428657390127938064157046913258'
	SET @inv='0432156789'	

	/* Start Processing */
	SET @c = 0
	SET @n = Reverse(@NUMBER)
	SET @len = Len(@n)

	SET @i=0
	WHILE @i < @len
	BEGIN
		IF @ACTION = 1
			BEGIN
				/* Do the CalcChecksum */
				SET @m = CAST(substring(@p,(((@i+1)%8)*10)+ CAST(substring(@n,@i+1,1) as tinyint)+1,1) as tinyint);
			END
		ELSE
			BEGIN
				/* Do the Checksum */
				SET @m = CAST(substring(@p,((@i%8)*10)+ CAST(substring(@n,@i+1,1) as tinyint)+1,1) as tinyint);
			END

		SET @c = CAST(substring(@d,(@c*10+@m+1),1) as tinyint);
		SET @i=@i+1
	END

	IF @ACTION = 1
			BEGIN
				/* Do the CalcChecksum */
				SET @c = CAST(substring(@inv,@c+1,1) as tinyint)
			END

	RETURN(@c)
END;

/* Usage for checking the validity of a number:*/
SELECT dbo.checksumVerhoeff([number TO be checked],0) FROM [your TABLE]


/*Usage for creating a check digit for a number:*/
SELECT dbo.checksumVerhoeff([your number],1) FROM [your TABLE]