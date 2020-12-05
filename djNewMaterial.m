function success=djNewMaterial
% djNewUser : enter a user into the database
%           : assumes database is open

    success=0;
    newMaterial=[];
    disp('Who created the material?');
    newMaterial.material_creator=djInputValidChoice('User', 'username');
    if isempty(newMaterial.material_creator) 
        error('Must select a valid user'); 
    end

    disp('For what project is this material?');
    newMaterial.project_id=djInputValidChoice('Project', 'project_id', 1, 'project_name');
    if isempty(newMaterial.project_id) 
        error('Must select a valid project'); 
    end
    
    disp('What is the strain/class of the material?');
    newMaterial.strain=djInputValidChoice('Strain', 'strain');
    if isempty(newMaterial.strain) 
        error('Must select a valid strain'); 
    end
    
    newMaterial.reference=input('Enter an optional user reference number: ', 's');
    newMaterial.dob=input('Enter DOB (YYYY-MM-DD), if appropriate : ', 's');
    newMaterial.sex='';
    while ~any(strcmp(newMaterial.sex, {'M', 'F', 'U'}))
        newMaterial.sex=upper(input('Enter sex of the material (M/F/U): ', 's'));
    end
    newMaterial.culture_date=input('Enter culture date, if appropriate(YYYY-MM-DD): ', 's');
    newMaterial.other_origin_date=input('Enter other date for material, if appropriate (YYYY-MM-DD): ', 's');
    if ~isempty(newMaterial.other_origin_date)
        newMaterial.other_origin_date_description=input('Enter description for this other date : ', 's');
    else
        newMaterial.other_origin_date_description='';
    end
    newMaterial.genotyping_record=input('Enter genotyping record reference number, if appropriate: ', 's');
    
    for counter=1:5
        [newMaterial.(['allele' num2str(counter) '_copy_num']),...
            newMaterial.(['allele' num2str(counter)])]...
            =gAllele(counter);
    end
    
    for counter=1:5
        tg=input(['Enter name of transgene #' num2str(counter) ' : '],'s');
        newMaterial.(['transgene' num2str(counter)])=tg;
        if isempty(tg)
            newMaterial.(['transgene' num2str(counter)])=tg;
        else   
            newMaterial.(['transgene' num2str(counter) '_source'])=input(['Enter source of transgene #' num2str(counter) ' : '],'s');
        end
    end
    disp(newMaterial)

    yn='';
    while ~any(strcmp(yn, {'y', 'n'}))
        yn=input('Is the information correct? Confirm entry to database (y/n): ','s');
        yn=lower(yn);
    end
    if yn(1)=='y'
        insertString=strcat('insert(', ...
            getenv('use_database'), ...
            '.Material, newMaterial)' ...
            );
        disp(insertString)
        eval(insertString);
        success=1;
    end

    if success==0
        disp('Data not entered to database')
    end
end

function [copies, id]=gAllele(numAllele)
    copies=-1;
    id='null';
    
    while isempty(copies) || copies<0 || copies>2
        copies=str2double(input(['Enter the number of copies of allele #' num2str(numAllele) ' (0-2) : '], 's'));
        if isnan(copies)
            copies=0;
        end
    end
    if (copies>0)
        id=djInputValidChoice('Allele', 'allele');
    end
end


function ss=formatFirst(s)
    ss='';
    if ~isempty(s)
        ss=lower(s);
        ss(1)=upper(ss(1));
    end
end