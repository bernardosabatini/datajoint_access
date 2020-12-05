function choice=djInputValidChoice(tableName, returnField, activeOnly, additionalKeys)
    
    choice='';
    if nargin<4
        additionalKeys=[];
    end
    
    if nargin<3
        activeOnly=1;
    end
    
    if nargin<2
        error('must select field to return');
    end
    
    if nargin<1
        error('must provice a table name');
    end
    
    choiceStruct=djListValid(tableName, activeOnly, additionalKeys);
    
    if ~isempty(choiceStruct)
        numChoices=length(choiceStruct);
        numSelected=str2double(input(['Enter choice from 1-' num2str(numChoices) ': '], 's'));
        if isempty(numSelected) || isnan(numSelected) || ~isnumeric(numSelected) || (numSelected<1) || (numSelected>numChoices) 
            error('Invalid selection'); 
        else
           choice=choiceStruct(numSelected).(returnField); 
        end
   end
    
