%% Get the 'Consumer Price Index, All Data' for the US and UK (in IMF CPI database) for 1990 to the present.
%
% Code shows how you can automatically get the info on the dataset and then
% look through this to find the code for the variable and countries that you want to look at.
% Also shows how you can use the current date as the final date for your requests.
%
% Note that if the data is not available for all countries for all time periods, this will be dealt with 
% automatically and NaN signifies missing data.

% First we need to figure out code for 'Consumer Price Index, All Data' and
% the 2-Digit Country Codes for US and UK. Easiest is just get all the info
% on the dataset using,
CPIdata = getIMFData('CPI');
% 'PCPI_IX' is the code for the Consumper Price Index, All Data'. The
% way I figured this out was to look at CPIdata.Variables which prints the
% list of variables and their names
CPIdata.Variables
% You could also use the IMF database websites to figure out the relevant codes.
% Similarly, you can see all the country codes looking at 
CPIdata.CountryCodes

% Get the CPI data for US exchange rate
CPI_US = getIMFData('CPI', 'PCPI_IX','US','M', '1990', '2021');
% Get the CPI data for UK exchange rate
CPI_UK = getIMFData('CPI', 'PCPI_IX','GB','M', '1990', '2021');
% Note: IMF Country Code for United Kingdom is GB (Great Britain)

% Use matlab to graph both of these, note how it turns the 'matlab datenum
% format' into an x-axis with the date using the datetick command
figure(1)
plot(CPI_US.Data(:,1),CPI_US.Data(:,2),CPI_UK.Data(:,1),CPI_UK.Data(:,2))
datetick('x','yyyy-mm')
legend('USA','United Kingdom')
title('Consumer Price Index, All Data')




