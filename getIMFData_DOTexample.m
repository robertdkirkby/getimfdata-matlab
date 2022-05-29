% Some codes demonstrating the use of getIMFData for DOT (Direction of Trade) database.
%
% The codes first show how to download the data for US, the "Goods, Value of Trade Balance, US Dollars" in 2000 to 2017 with China.
% In DOT the "series_id" for "Goods, Value of Trade Balance, US Dollars" is TBG_USD
%
% The codes then show how to use getIMFData to get the dictionaries and search for the code for a variable.

%% Download the  data from the IMF Coordinated Portfolio Investment Survey dataset.
StartDate_IMF='2000';
EndDate_IMF='2017';
IMFdatabase='DOT';
IMFcountrycode2L='US';
IMFcounterpartycountrycode2L='CN'; % 'World' is an option, 'W00'.
IMFfrequency='A'; % A is annual, Q is quarterly, M is monthly

IMFdata.GoodsTradeBalance = getIMFData(IMFdatabase, 'TBG_USD',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF,[],IMFcounterpartycountrycode2L);

% The actual dates and data are kept in:
IMFdata.GoodsTradeBalance.Data

% If you look at the 
IMFdata.GoodsTradeBalance
% you will see that it is a structure that also contains a bunch of other
% information relating to what exactly it is that the data is about.

% If you forget the codes you used to request this specific piece of data,
% you can always find them listed in 
IMFdata.GoodsTradeBalance.IMFcodes
% Note that what I call country, they call area.

%% How to use getIMFData to get the dictionaries and search for the code for a variable.
% One way to figure out codes like 'TBG_USD' is via the IMF website, 
% http://data.imf.org/

% Alternatively, if you know the database_id, then you can use this as the
% only input to getIMFData() and it will return a dictionary of variable codes 
% and names which can be searched.

% We are here looking specifically at the database_id
% DOT: Direction of Trade

% Can grab the 'dictionary' for a given database by calling getIMFdata with only the database_id as sole input.
DOTdictionary=getIMFData('DOT');

% Can then look for, e.g., the country code for New Zealand
[rowIndex,~]=find(contains(DOTdictionary.CountryCodes,'Zealand'));
DOTdictionary.CountryCodes(rowIndex,:)

% Can then look for, e.g., the series_id for the total net current account, you can find the formal names from the data.imf.org website 
% (the following search gives nine results, and the one we want is the eigth)
[rowIndex,~]=find(contains(DOTdictionary.Variables,'Value of Trade Balance'));
Results=DOTdictionary.Variables(rowIndex,:)

% Or just leaf through DOTdictionary and see what you find :)
DOTdictionary


