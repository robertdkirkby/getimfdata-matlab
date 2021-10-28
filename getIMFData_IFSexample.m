%% Get the USD-exchange rate data for all countries (in IMF IFS database) for 1920 to the present.
%
% Code shows how you can automatically get the country list.
% Also shows how you can use the current date as the final date for your requests.
% Loops over the different countries to request the data for each
% All the data is stored in a matrix which is then converted into a table by the final line of code
%
% Note that the data is not available for all countries for all time periods, but this is dealt with 
% automatically and NaN signifies missing data.
%
% Special thanks to Ramiro Kossacoff who let me lightly edit his great code to create this example.

% Use IFS dataset, and get all of the country names
IFSdata = getIMFData('IFS');
CountryName = IFSdata.CountryCodes;
CountryName (237:end,:) = [];
% Set the starting date to Jan-1920 and the end date to the present
StartDate = datetime('January 1, 1920');
EndDate= datetime;
% Create Dates which are all of the months from StartDate to EndDate
NumOfYears = year(datetime) -year(StartDate);
Dates = StartDate + calmonths(0:12*(NumOfYears)+(month(datetime)-1));
DatesNum = datenum(Dates)';
% Now, create matrix in which to store the results
MatDataXR = nan(length(Dates), length(CountryName));
% Loop over the countries
for ii=1:length(CountryName)
    ii
    % Get the USD exchange rate
    aux_r = getIMFData('IFS', 'ENDE_XDC_USD_RATE',CountryName{ii,1},'M', '1920', '2021');
    % Store just the numbers for which we have dates, notice that ii is that the columns of MatDataXR indexes the country
    MatDataXR(ismember(DatesNum,aux_r.Data(:,1),'rows'),ii) = aux_r.Data(:,2);
end
% Convert the result, which is currently a matrix, into a table
tableXR = array2table (MatDataXR, 'VariableNames', CountryName(:,1));

% Let's take a look at the resulting table
tableXR

