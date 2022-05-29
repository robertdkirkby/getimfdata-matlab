% Some codes demonstrating the use of getIMFData.
%
% The codes first show how to download the US current account data from the
% IMF Balance of Payments dataset. 
%
% They then show how to use getIMFData to get the dictionaries and search for the code for a variable.
%
% Lastly they download the US current account and it's components and graph
% them. First a graph using Matlab's plot command. And then a nice plotly
% graph (the plotly graph requires you to install plotly, google it for
% instructions).

%% Download the US current account data from the IMF Balance of Payments dataset.
StartDate_IMF='2000';
EndDate_IMF='2018';
IMFdatabase='BOP';
IMFcountrycode2L='GB';
IMFfrequency='A'; % A is annual, Q is quarterly, M is monthly

IMFdata.CAB_Net = getIMFData(IMFdatabase, 'BCA_BP6_XDC',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF);

% The actual dates and data are kept in:
IMFdata.CAB_Net.Data

% If you look at the 
IMFdata.CAB_Net
% you will see that it is a structure that also contains a bunch of other
% infomration relating to what exactly it is that the data is about.

%% How to use getIMFData to get the dictionaries and search for the code for a variable.
% One way to figure out codes like 'BCA_BP6_XDC' is via the IMF website, 
% http://data.imf.org/

% Alternatively, if you know the database_id, then you can use this as the
% only input to getIMFData() and it will return a dictionary of variable codes 
% and names which can be searched.

% Some database_id include
% IFS: International Fiscal Statistics
% BOP: Balance of Payments

% Can grab the 'dictionary' for a given database by calling getIMFdata with only the database_id as sole input.
BOPdictionary=getIMFData('BOP');

% Can then look for, e.g., the country code for New Zealand
[rowIndex,~]=find(contains(BOPdictionary.CountryCodes,'Zealand'));
BOPdictionary.CountryCodes(rowIndex,:)

% Can then look for, e.g., the series_id for the total net current account, you can find the formal names from the data.imf.org website 
% (the following search gives nine results, and the one we want is the eigth)
[rowIndex,~]=find(contains(BOPdictionary.Variables,'Current Account, Total'));
Results=BOPdictionary.Variables(rowIndex,:)
Results(8,2)

%% Download the US current account and it's components and graph them. 
% First a graph using Matlab's plot command. 
% Then a nice plotly graph (the plotly graph requires you to have plotly installed).

% Codes for IMF Balance of Payments data that I might want to use here are as follows,
%
% BCA_BP6_XDC: Current Account, Total, Net, National Currency
% 
% BXG_BP6_XDC: Current Account, Goods and Services, Goods, Credit, National Currency
% BMG_BP6_XDC: Current Account, Goods and Services, Goods, Debit, National Currency
% BG_BP6_XDC: Current Account, Goods and Services, Goods, Net, National Currency
% BXS_BP6_XDC: Current Account, Goods and Services, Services, Credit, National Currency
% BMS_BP6_XDC: Current Account, Goods and Services, Services, Debit, National Currency
% BS_BP6_XDC: Current Account, Goods and Services, Services, Net, National Currency
% BGS_BP6_XDC: Current Account, Goods and Services, Goods and Services, Net, National Currency
% BXIP_BP6_XDC: Current Account, Primary Income, Credit, National Currency
% BMIP_BP6_XDC: Current Account, Primary Income, Debit, National Currency
% BXIS_BP6_XDC: Current Account, Secondary Income, Credit, National Currency
% BMIS_BP6_XDC: Current Account, Secondary Income, Debit, National Currency
% BXTR_BP6_XDC: Supplementary Items, Total Remittances: Credit, National Currency
% BMTR_BP6_XDC: Supplementary Items, Total Remittances: Debit, National Currency
% BCAXF_BP6_XDC: Balance of Payments, Supplementary Items, Current Account, Net (excluding exceptional financing), National Currency
%
% BISOPTWR_BP6_XDC: Current Account, Secondary Income, Financial Corporations, Nonfinancial Corporations, Households, and NPISHs, Personal Transfers (Current Transfers Between Resident and Nonresident Households), Of which: Workers' Remittances, Net, National Currency
% 
% BK_BP6_XDC: Capital Account, Total, Net, National Currency
% BK_CD_BP6_XDC: Capital Account, Total, Credit, National Currency
% BK_DB_BP6_XDC: Capital Account, Total, Debit, National Currency
% 
% Note: XDC means own currency, can be replaced with EUR or USD

IMFdata.CAB_Net = getIMFData(IMFdatabase, 'BCA_BP6_XDC',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF);

IMFdata.CAB_GoodsNet = getIMFData(IMFdatabase, 'BG_BP6_XDC',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF);
IMFdata.CAB_ServicesNet = getIMFData(IMFdatabase, 'BS_BP6_XDC',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF);
IMFdata.CAB_PrimaryIncomeNet = getIMFData(IMFdatabase, 'BIP_BP6_XDC',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF);
IMFdata.CAB_SecondaryIncomeNet = getIMFData(IMFdatabase, 'BIS_BP6_XDC',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF);

% Will also need the following from IFS (International Financial Statistics)
% NGDP_XDC: Gross Domestic Product, Nominal, Domestic Currency (National Accounts, Current Prices, Not Seasonally Adjusted; IFS)
IMFdata.NGDP = getIMFData('IFS', 'NGDP_XDC',IMFcountrycode2L,IMFfrequency,StartDate_IMF,EndDate_IMF);

% Graph using plot
figure(1)
plot(IMFdata.CAB_Net.Data(:,1),100*IMFdata.CAB_Net.Data(:,2)./IMFdata.NGDP.Data(:,2))
hold on
plot(IMFdata.CAB_ServicesNet.Data(:,1),100*IMFdata.CAB_ServicesNet.Data(:,2)./IMFdata.NGDP.Data(:,2))
plot(IMFdata.CAB_GoodsNet.Data(:,1),100*IMFdata.CAB_GoodsNet.Data(:,2)./IMFdata.NGDP.Data(:,2))
plot(IMFdata.CAB_PrimaryIncomeNet.Data(:,1),100*IMFdata.CAB_PrimaryIncomeNet.Data(:,2)./IMFdata.NGDP.Data(:,2))
plot(IMFdata.CAB_SecondaryIncomeNet.Data(:,1),100*IMFdata.CAB_SecondaryIncomeNet.Data(:,2)./IMFdata.NGDP.Data(:,2))
hold off
datetick('x','dd/mmm/yy') % make x-axis display datenum as dd/mmm/yy
title('UK Current Account Balance')
ylabel('Percent of GDP')


%% Alternative version of graph using plotly (you must install plotly, it is not default part of Matlab)
% trace_CAB= struct('x', {cellstr(num2str(IMFdata.CAB_Net.Data(:,1)))},'y',100*IMFdata.CAB_Net.Data(:,2)./IMFdata.NGDP.Data(:,2),'name', 'Current Account Balance (Total)','type', 'scatter','marker',struct('size',1),'line',struct('dash','dash'));
% trace1= struct('x', {cellstr(num2str(IMFdata.CAB_ServicesNet.Data(:,1)))},'y',100*IMFdata.CAB_ServicesNet.Data(:,2)./IMFdata.NGDP.Data(:,2),'name', 'Services','type', 'scatter','marker',struct('size',1));
% trace2= struct('x', {cellstr(num2str(IMFdata.CAB_GoodsNet.Data(:,1)))},'y',100*IMFdata.CAB_GoodsNet.Data(:,2)./IMFdata.NGDP.Data(:,2),'name', 'Goods','type', 'scatter','marker',struct('size',1));
% trace3= struct('x', {cellstr(num2str(IMFdata.CAB_PrimaryIncomeNet.Data(:,1)))},'y',100*IMFdata.CAB_PrimaryIncomeNet.Data(:,2)./IMFdata.NGDP.Data(:,2),'name', 'Income','type', 'scatter','marker',struct('size',1));
% trace4= struct('x', {cellstr(num2str(IMFdata.CAB_SecondaryIncomeNet.Data(:,1)))},'y',100*IMFdata.CAB_SecondaryIncomeNet.Data(:,2)./IMFdata.NGDP.Data(:,2),'name', 'Transfers','type', 'scatter','marker',struct('size',1));
% data = {trace_CAB, trace1,trace2,trace3,trace4};
% layout = struct('title', 'USA Current Account Balance','showlegend', true,'width', 800,...
%     'xaxis', struct('domain', [0, 0.9],'title','Year'), ...
%     'yaxis', struct('title', 'Percent of GDP','titlefont', struct('color', 'black'),'tickfont', struct('color', 'black'),'anchor', 'free','side', 'left','position',0),...
%     'legend',struct('x',0.9,'y',0.95));
% response = plotly(data, struct('layout', layout, 'filename', 'USA_CurrentAccountBalance_Components', 'fileopt', 'overwrite'));
% response.data=data; response.layout=layout;
% saveplotlyfig(response, './Graphs/USA_CurrentAccountBalance_Components.pdf')





