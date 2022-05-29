% Some codes demonstrating the use of getIMFData for CPIS (Coordinated Portfolio Investment Survey) database.
%
% The codes first show how to download the data for Argentina, the "Assets,
% Total Investment, BPM6, US Dollars" in 2015 to 2017 held by Spain.
% In CPIS the "series_id" for "Assets, Total Investment, BPM6, US Dollars" is I_A_T_T_T_BP6_USD
%
% The codes then show how to use getIMFData to get the dictionaries and search for the code for a variable.

%% Download the  data from the IMF Coordinated Portfolio Investment Survey dataset.
StartDate_IMF='2015';
EndDate_IMF='2017';
IMFdatabase='CPIS';
IMFcountrycode2L='AR';
IMFcounterpartycountrycode2L='ES'; % 'World' is an option, 'W00'.
IMFfrequency='A'; % A is annual, Q is quarterly, M is monthly
IMFsector='T'; % Total holdings
IMFcounterpartysector='T'; % Total holdings

IMFdata.AssetsTotal = getIMFData(IMFdatabase, 'I_A_T_T_T_BP6_USD',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF,[],IMFcounterpartycountrycode2L,IMFsector,IMFcounterpartysector);

% The actual dates and data are kept in:
IMFdata.AssetsTotal.Data

% If you look at the 
IMFdata.AssetsTotal
% you will see that it is a structure that also contains a bunch of other
% information relating to what exactly it is that the data is about.

% If you forget the codes you used to request this specific piece of data,
% you can always find them listed in 
IMFdata.AssetsTotal.IMFcodes
% Note that what I call country, they call area.

%% How to use getIMFData to get the dictionaries and search for the code for a variable.
% One way to figure out codes like 'I_A_T_T_T_BP6_USD' is via the IMF website, 
% http://data.imf.org/

% Alternatively, if you know the database_id, then you can use this as the
% only input to getIMFData() and it will return a dictionary of variable codes 
% and names which can be searched.

% We are here looking specifically at the database_id
% CPIS: Coordinated Portfolio Investment Survey

% Can grab the 'dictionary' for a given database by calling getIMFdata with only the database_id as sole input.
CPISdictionary=getIMFData('CPIS');

% Can then look for, e.g., the country code for New Zealand
[rowIndex,~]=find(contains(CPISdictionary.CountryCodes,'Zealand'));
CPISdictionary.CountryCodes(rowIndex,:)

% Can then look for, e.g., the series_id for the total net current account, you can find the formal names from the data.imf.org website 
% (the following search gives nine results, and the one we want is the eigth)
[rowIndex,~]=find(contains(CPISdictionary.Variables,'Assets, Total Investment'));
Results=CPISdictionary.Variables(rowIndex,:)
Results(8,2)

% Or just leaf through CPISdictionary and see what you find :)
CPISdictionary
% Hmm, lets see what Sector is about
CPISdictionary.Sector
% This 'GG', General Government sounds like the sector I am interested in:
CPISdictionary.Sector(13,:)
% (Note: 'GG' is the sector_id)


