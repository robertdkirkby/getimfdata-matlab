% Some codes demonstrating the use of getIMFData for GFS (Government Finance Statistics) databases.
% There are seven GFS databases:
% GFSMAB: Main Aggregates and Balances
% GFSE: Expense
% GFSR Revenue
% GFSCOFOG: Classification of the Functions of Government
% GFSSSUC: Statement of Sources and Uses of Cash
% GFSFALCS: Financial Assets and Liabilities by Counterpart Sector
% GFSIBS: Integrated Balance Sheet
%
% Using any of GFSMAB,GFSE,GFSR,GFSCOFOG,GFSSSUC is essentially the same,
% just that the variable names differ. So we will just see one example.
%
% Using GFSFALCS requires more inputs, we will see an example.
% Using GFSIBS requires more inputs, we will see an example.
%
% The codes then show how to use getIMFData to get the dictionaries and search for the code for a variable.


%% Special thanks to Mikhail Nicolaev for implementing the GFS databases in getIMFData!


%% For all the data, let's use the same time period, frequency, and country
StartDate_IMF='2010';
EndDate_IMF='2017';
IMFfrequency='A'; % A is annual, Q is quarterly, M is monthly
IMFcountrycode2L='US';

%% Download some data from the GFSE dataset.
IMFdatabase='GFSE';
IMFseries_id='W0_S1_G21'; % W0_S1_G21 is 'Compensation of employees'
IMFsector='S13'; % S13 is 'General Government'
IMFunit='XDC_R_B1GQ'; % XDC_R_B1GQ is 'Percent of GDP'

IMFdata.US_GenGov_CompEmp = getIMFData(IMFdatabase, IMFseries_id,IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF,[],IMFsector,IMFunit);

% The actual dates and data are kept in:
IMFdata.US_GenGov_CompEmp

% If you look at the 
IMFdata.US_GenGov_CompEmp
% you will see that it is a structure that also contains a bunch of other
% information relating to what exactly it is that the data is about.

%% Download some data from the GFSFALCS dataset.
IMFdatabase='GFSFALCS';
IMFseries_id='G62'; % G62 is 'Net financial worth'
IMFsector='S13'; % S13 is 'General Government'
IMFunit='XDC_R_B1GQ'; % XDC_R_B1GQ is 'Percent of GDP'
IMFcounterpart='W2_S121'; % W2_S121 is 'Central bank'

IMFdata.US_GenGov_NetWorth = getIMFData(IMFdatabase, IMFseries_id,IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF,[],IMFsector,IMFunit,IMFcounterpart);

% The actual dates and data are kept in:
IMFdata.US_GenGov_NetWorth.Data

% If you look at the 
IMFdata.US_GenGov_NetWorth
% you will see that it is a structure that also contains a bunch of other
% information relating to what exactly it is that the data is about.

%% Download some data from the GFSIBS dataset.
IMFdatabase='GFSIBS';
IMFseries_id='G42'; % G42 is 'Holding gains and losses in financial assets''
IMFsector='S13'; % S13 is 'General Government'
IMFunit='XDC_R_B1GQ'; % XDC_R_B1GQ is 'Percent of GDP'
IMFinstrument='F'; % F is 'Total financial assets/liabilities'
IMFcounterpart='W1_S1'; % W1_S1 is 'External'

IMFdata.US_GenGov_Holding = getIMFData(IMFdatabase,IMFseries_id,IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF,[],IMFsector,IMFunit,IMFinstrument,IMFcounterpart);

% The actual dates and data are kept in:
IMFdata.US_GenGov_Holding.Data

% If you look at the 
IMFdata.US_GenGov_Holding
% you will see that it is a structure that also contains a bunch of other
% information relating to what exactly it is that the data is about.

%% How to use getIMFData to get the dictionaries and search for the code for a variable.
% One way to figure out codes like 'S13' is via the IMF website, 
% http://data.imf.org/

% Alternatively, if you know the database_id, then you can use this as the
% only input to getIMFData() and it will return a dictionary of variable codes 
% and names which can be searched.

% We are here looking specifically at the database_id
% GFSE: Coordinated Portfolio Investment Survey
% But it could be any database_id

% Can grab the 'dictionary' for a given database by calling getIMFdata with only the database_id as sole input.
GFSEdictionary=getIMFData('GFSIBS');

% Can then look for, e.g., the country code for New Zealand
[rowIndex,~]=find(contains(GFSEdictionary.CountryCodes,'Zealand'));
GFSEdictionary.CountryCodes(rowIndex,:)

% Can then look for, e.g., the series_id for the total net current account, you can find the formal names from the data.imf.org website 
% (the following search gives nine results, and the one we want is the eigth)
[rowIndex,~]=find(contains(GFSEdictionary.Variables,'General government'));
Results=GFSEdictionary.Variables(rowIndex,:)

% Or just leaf through CPISdictionary and see what you find :)
GFSEdictionary
% Hmm, lets see what Sector is about
GFSEdictionary.Sector
% What about unit?
GFSEdictionary.Unit



