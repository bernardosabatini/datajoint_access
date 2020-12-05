%{ 
codeRunner.m
Author MM893
6/24/2020 HMS RC

Description:
    codeRunner is designed as an example program to showcase script features, and processes.
        
    This document will take in one pre-defined file, construct tables, and
    insert them into a database.

        ** It is important to note, this document will only supply
        one-to-one relationships (i.e. a new session table for each
        operation). 

This document uses omitted variables that coencide with newest data format.

%}

datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss'); % Crucial to using time, date not explicitly set on import parameters.
% Will complain about ambiguity, however will still follow stated format.
% connection to server should already exist.  Use djConnectServer if not
% djConnectServer(); % connect to server...

% =====================
% Configuration, mainly used for Session table.
% Can be bound to an input, or cli

setenv('useDatabase','sabatini_prod');
setenv('experimentID','0001');
setenv('experimentPurpose','prod');

setenv('user','Example');   % User availible in headerString, however in example 'runnerLoop.m' one session is used for multiple acquisitions. [ID: 2]
setenv('timeversion','1');  % timeversion availible in headerString, however in example 'runnerLoop.m' one session is used for multiple acquisitions.[ID: 8]

setenv('date','now');% Get current time; included for backlogging ability.
setenv('mouseID','1');
setenv('mouseDescriptor','ExampleMouse');

% =====================
% Load and process data

loadedData=load('AD0_3.mat'); %Main Variable, can be set to output of loop
objectName=fieldnames(loadedData); %get object name (eg 'AD0_1')


omittedItems=[2,8];% Items in userData that should not be used %%userData, softwareTimeversion
areNumbers=[4,8,14,28,30,32,34,36,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,113,114,118,122];% Items in userData that should not be a string
areTime=[10,12,116,120];% Items in userData that should be cast as time




% =====================
% Create and insert session
insertSession=buildSession();
disp("session Data Created, Inserting...");
%eval(insertSession);



% =====================
% Create and insert acquisition
workingStr=reFormatHeaderString(get(objectName{1}, 'UserData').headerString);
userData = regexp(splitlines(workingStr),'=','split','once');
%workingStr = usrFile.(locator).UserData.headerString;
%userData=getUser(loadedData,[objectName{:}])';%returns a  list of user data/variables (transposed)

insertAcquisition=buildAcquisition(userData,objectName,omittedItems,areNumbers,areTime,getenv('experimentID'));

userData=[userData{:}]; %Expand/Transpose Data


disp("Inserting Acquisition...");
eval(strcat("insert(",(getenv('useDatabase')),".Acquisition,eval(insertAcquisition))"));%perform acquisition insert


% =====================
% Create and insert Data
insertData=buildData(objectName);
disp("Inserting Data...");
eval(insertData);

% =====================
% That's all folks.
disp("done.");