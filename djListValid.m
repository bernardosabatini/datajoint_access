function choiceStruct=djListValid(tableName, activeOnly, additionalKeys, minimal)
    
    numChoices=0;
    choiceStruct=[];
    

    if nargin<3
        additionalKeys=[];
    end
    
    if nargin<4
        if isempty(additionalKeys)
            minimal=1;
        else
            minimal=0;
        end
    end
       
    if nargin<2
        activeOnly=1;
    end
    
    if nargin<1
        error('must provice a table name');
    end
    
    choiceStruct=djGetTableKeys(tableName, activeOnly, additionalKeys);
    
    numChoices=length(choiceStruct);
    if (numChoices==0)
        error(['There are no valid entries to select in table ' tableName])
    end
    
    fNames=fieldnames(choiceStruct);
    
    disp('Valid choices:')
    for counter=1:numChoices
        ss=[num2str(counter) ': '];
        for fCounter=1:length(fNames)
            ff=fNames{fCounter};
            fv=choiceStruct(counter).(ff);
            if isnumeric(fv)
                fv=num2str(fv);
            end
            if minimal
                ss=[ss fv ' '];
            else
                ss=[ss ff ' = ' fv ' '];
            end
        end
        disp(ss)
    end
