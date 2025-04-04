function keyStruct=djGetTableKeys(tableName, activeOnly, additionalKeys, returnAsCell, minimal, noNumber)
% djGetUserNames : returns the user names in the datajoint User table

%% default arguments
    if nargin<4
        returnAsCell=0;
    end

    if nargin<3
        additionalKeys=[];
    end

    if nargin<2
        activeOnly=1;
    end

    if nargin<1
        error('must provice a table name');
    end
    
    if nargin<5
        if isempty(additionalKeys)
            minimal=1;
        else
            minimal=0;
        end
    end
    
    if nargin<6
        noNumber=0;
    end
    
    
    
%% make query
    if activeOnly
        queryString=strcat(...
            getenv('use_database'), ...
            '.', ...
            tableName, ...
            '-', ...
            getenv('use_database'), ...
            '.Inactive', ...
            tableName ...
            );
    else
        queryString=strcat(...
            getenv('use_database'), ...
            '.', ...
            tableName...
            );
    end
    
    %   disp(queryString)
    
    query=eval(queryString);
    
%% package
    keyStruct=[];
    if query.count>0
        if isempty(additionalKeys)
            keyStruct=query.fetch;
        else
            keyStruct=query.fetch(additionalKeys);
        end
    end
    
    if returnAsCell
        fNames=fieldnames(keyStruct);
        numChoices=length(keyStruct);
        
        choiceStruct=cell(1, numChoices);
        for counter=1:numChoices
            if noNumber
                ss='';
            else
                ss=[num2str(counter) ': '];
            end
            
            for fCounter=1:length(fNames)
                ff=fNames{fCounter};
                fv=keyStruct(counter).(ff);
                if isnumeric(fv)
                    fv=num2str(fv);
                end
                if minimal
                    ss=[ss fv ' '];
                else
                    ss=[ss ff ' = ' fv ' '];
                end
            end
            choiceStruct{counter}=ss;
        end
        keyStruct=choiceStruct;
    end

