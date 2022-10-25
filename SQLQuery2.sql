
--Data Cleaning  for Well Notice Planning  dataset which  has more than 14,000 records

SELECT * FROM wellnotice;


--Standard Date Format

SELECT  NoticeDated,NoticeDateDetermination  FROM wellnotice;


SELECT NoticeDated, PARSE(NoticeDated as Date) NewNoticeDated ,PARSE(NoticeDateDetermination as Date) NewNoticeDateDetermination FROM wellnotice;


ALTER TABLE wellnotice
ADD NewNoticeDated  date,
 NewNoticeDateDetermination date;

 UPDATE wellnotice
 SET NewNoticeDated = PARSE(NoticeDated as Date),
 NewNoticeDateDetermination = PARSE(NoticeDateDetermination as Date);


 -- To find any missing data

 SELECT *
 FROM wellnotice
WHERE NoticePermitNumber IS NULL;

 --To find any duplicate Records

WITH rowcte as( 
 SELECT *,
 ROW_NUMBER()  OVER (
 PARTITION BY OBJECTID, NoticePermitNumber,API,OperatorCode,API,OperatorCode 
 ORDER BY  OBJECTID) row_num
 FROM wellnotice 
 )

 SELECT * FROM rowcte where row_num > 1;

 --Change WellNumber if  it is NULL

 SELECT * 
 FROM wellnotice
 WHERE WellNumber IS NULL;

 UPDATE wellnotice
 SET WellNumber = 0
 WHERE WellNumber IS NULL;


 --Change WellType  with Proper Labels

 SELECT DISTINCT
 WellType,WellTypeLabel FROM wellnotice

 SELECT *,
 CASE WHEN WellType = 'OG' THEN  'OIL & GAS' 
	WHEN WellType = 'SC' THEN  'Cyclic Steam' 
	WHEN WellType = 'SF' THEN  'Steamflood'
    WHEN WellType = 'WF' THEN  'Waterflood'
    WHEN WellType = 'WD' THEN  'Water Disposal' 
    WHEN WellType = 'INJ' THEN  'Injection' 
    WHEN WellType = 'DH' THEN  'Dry Hole' 
    WHEN WellType = 'OB' THEN  'Observation'
    WHEN WellType = 'UNK' THEN  'Unknown' 
    WHEN WellType = 'GS' THEN  'Gas Storage' 
    WHEN WellType = 'Multi' THEN  'Multi-Purpose' 
    WHEN WellType = 'DG' THEN  'Dry Gas' 
    WHEN WellType = 'CH' THEN  'Core Hole' 
    WHEN WellType = 'WS' THEN  'Water Source'
    WHEN WellType = 'LG' THEN  'Liquefied Gas' 
    WHEN WellType = 'GD' THEN  'Gas Disposal' 
    WHEN WellType = 'PM' THEN  'Pressure Maintenance'
 ELSE WellType
 END
 FROM wellnotice


 UPDATE wellnotice
 SET WellType =
  CASE WHEN WellType = 'OG' THEN  'OIL & GAS' 
	WHEN WellType = 'SC' THEN  'Cyclic Steam' 
	WHEN WellType = 'SF' THEN  'Steamflood'
    WHEN WellType = 'WF' THEN  'Waterflood'
    WHEN WellType = 'WD' THEN  'Water Disposal' 
    WHEN WellType = 'INJ' THEN  'Injection' 
    WHEN WellType = 'DH' THEN  'Dry Hole' 
    WHEN WellType = 'OB' THEN  'Observation'
    WHEN WellType = 'UNK' THEN  'Unknown' 
    WHEN WellType = 'GS' THEN  'Gas Storage' 
    WHEN WellType = 'Multi' THEN  'Multi-Purpose' 
    WHEN WellType = 'DG' THEN  'Dry Gas' 
    WHEN WellType = 'CH' THEN  'Core Hole' 
    WHEN WellType = 'WS' THEN  'Water Source'
    WHEN WellType = 'LG' THEN  'Liquefied Gas' 
    WHEN WellType = 'GD' THEN  'Gas Disposal' 
    WHEN WellType = 'PM' THEN  'Pressure Maintenance'
 ELSE WellType
 END


 --Delete unwanted Columns

ALTER TABLE wellnotice
DROP COLUMN WellTypeLabel

ALTER TABLE wellnotice
DROP COLUMN NoticeDated, NoticeDateDetermination


--Change Column Names
ALTER TABLE wellnotice
CHANGE  COLUMN NewNoticeDated TO NoticeDated DATE
              
