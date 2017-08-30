
function [result]=load_individual_samples(filenamesample, filenamebuffer, cut1,cut2,concentration, handles, exposures)
%
% load_individual_samples(filenamesample, filenamebuffer, cut1,cut2,concentration)
% loads N-by-P data traces for the selected filesample and corresponding buffer.
% Both traces are cut at q_min = cut1 and q_max = cut2 to remove noisy data. 
% Lastly, the data is scalled according to the concentration standard of 50 
% uM for further processing. The input scattering momentum q is transfered
% to s (q/(2*pi)). The input scattering intensity error (standard deviation) is
% tansfered to the variance.
% The function returns the results to the matrix result which has the dimension 
% (q_min:q_max)-by-3xP + 6 where q_min:q_max is the reduced q-range and P the 
% number of exposures, i.e. for 10 exposures with 500 data points in the cut 
% q-range a 500x36 matrix. Columns 1, 4, 7,...3xP-2 are the q-values, 
% columns 2, 5, 8,...,3xP-1 are the scattering intensities and cloumns 3, 6,
% 9,..., 3xP are the scattering intensity errors. The data for the q-range,
% scattering intensity and scattering intensity error are assigned to
% column 3xP+1-3xP+3 and the averaged q-range, scattering intensity and
% intensity errors are stored in column 3xP+4-3xP+6. If the number of
% exposures is greater than 10 the number of exposures has to be given as
% last input for the function.
%
%

switch nargin
    
    case 6
        
        number_of_columns = 36; % the number of columns in the final matrix for exposures <10
        exposures = 0;
        
    case 7
        
        
        number_of_columns = exposures*3 + 6; %the number of columns in the final matrix for exposures >10 
        
end



result=zeros(cut2-cut1+1,number_of_columns);
result_buffer=zeros(cut2-cut1+1,3);
result_tot=zeros(cut2-cut1+1,3);
factor=50/concentration;

if exposures == false
    for i=1:10

        if i<10
            sample_name=[filenamesample,'_0',num2str(i),'.dat'];
            buffer_name=[filenamebuffer,'_0',num2str(i),'.dat'];
        else
            sample_name=[filenamesample,'_',num2str(i),'.dat'];
            buffer_name=[filenamebuffer,'_',num2str(i),'.dat'];
        end

        sample=load(sample_name); % load sample data
        sample=sample(cut1:cut2,:); % cut sample data

        if get(handles.checkbox3,'Value') == true

            sample(:,1)=sample(:,1)./(2*pi); % change from q-range to s-range

        else
            sample(:,1)=sample(:,1);
        end

        Buf=load(buffer_name); % load buffer data
        Buf=Buf(cut1:cut2,:); % cut buffer data

        if get(handles.checkbox3,'Value') == true
            Buf(:,1)=Buf(:,1)./(2*pi); % change from q-range to s-range

        else
            Buf(:,1)=Buf(:,1);

        end

        sample(:,3)=sample(:,3).^2; %change the third column to variance 

        sample(:,2)=sample(:,2)*factor; %account for concentration, normalize to 50 uM
        sample(:,3)=sample(:,3)*factor; %account for concentration, normalize to 50 uM

        result(:,3*i-2:3*i)=sample;
        result_buffer(:,2)=result_buffer(:,2)+Buf(:,2); % sum up buffer intensity
        result_buffer(:,3)=result_buffer(:,3)+Buf(:,3).^2; % sum up buffer intensity error (variance)
        result_tot(:,2)=result_tot(:,2)+sample(:,2); % sum up sample intensity
        result_tot(:,3)=result_tot(:,3)+sample(:,3); % sum up sample intensity error (variance)
    
    end
    
    result_buffer(:,2)=result_buffer(:,2)./10; % average buffer intensity
    result_buffer(:,3)=result_buffer(:,3)./10; % average buffer intensity error (variance)
    result_buffer(:,1)=Buf(:,1);
    result_tot(:,2)=result_tot(:,2)./10; % average sample intensity
    result_tot(:,3)=result_tot(:,3)./10; % average sample intensity error (variance)
    result_tot(:,1)=Buf(:,1);
    result(:,31:33)=result_buffer;
    result(:,34:36)=result_tot;
    
    out_sd = zeros(1, 10);
    
    for i=1:10
        
        out_sd(1, i)=mean(((result(:,2+3*(i-1))-result(:,35))./abs(result(:,36))).^2);
    end
    
    sprintf('The difference between the individual exposures and the average intensity is: %d\n', out_sd)
    % Print the difference between the individual exposures and the average
    % intensity traces to the console to identify possible outlayers

else
    
    for i=1:exposures
        
        if i<10
            
            sample_name=[filenamesample,'_0',num2str(i),'.dat'];
            buffer_name=[filenamebuffer,'_0',num2str(i),'.dat'];
            
        else
            
            sample_name=[filenamesample,'_',num2str(i),'.dat'];
            buffer_name=[filenamebuffer,'_',num2str(i),'.dat'];
            
        end

        try   
            sample=load(sample_name);

        catch

            file_error = strcat('File: ', sample_name, ' not found!');
            str2 = 'Check Path!';
            errordlg({file_error, str2});

        end

        sample=sample(cut1:cut2,:);

        if get(handles.checkbox3,'Value') == true
            sample(:,1)=sample(:,1)./(2*pi);

        else

            sample(:,1)=sample(:,1);
        end

        Buf=load(buffer_name);
        Buf=Buf(cut1:cut2,:);

        if get(handles.checkbox3,'Value') == true
            Buf(:,1)=Buf(:,1)./(2*pi);

        else 

            Buf(:,1)=Buf(:,1);
        end


        sample(:,3)=sample(:,3).^2; 

        sample(:,2)=sample(:,2)*factor; 
        sample(:,3)=sample(:,3)*factor;

        result(:,3*i-2:3*i)=sample;
        result_buffer(:,2)=result_buffer(:,2)+Buf(:,2);
        result_buffer(:,3)=result_buffer(:,3)+Buf(:,3).^2;
        result_tot(:,2)=result_tot(:,2)+sample(:,2);
        result_tot(:,3)=result_tot(:,3)+sample(:,3);
    
    end
    
    result_buffer(:,2)=result_buffer(:,2)./exposures;
    result_buffer(:,3)=result_buffer(:,3)./exposures;
    result_buffer(:,1)=Buf(:,1);
    result_tot(:,2)=result_tot(:,2)./exposures;
    result_tot(:,3)=result_tot(:,3)./exposures;
    result_tot(:,1)=Buf(:,1);
    result(:,3*exposures+1:3*exposures+3)=result_buffer;
    result(:,3*exposures+4:3*exposures+6)=result_tot;
    
    out_sd = zeros(1, exposures);
    
    for i=1:exposures
        
        out_sd(1, i)=mean(((result(:,2+3*(i-1))-result(:,3*exposures+5))./abs(result(:,3*exposures+6))).^2);
        
        
    end
    
    
    
end

savename = strcat(filenamesample, '_std_intensity_traces.dat');
out = fopen(savename, 'w');

fprintf(out, 'The difference between the individual exposures and the average intensity is: \n');

for i=1:exposures

    fprintf(out, '%2.d. exposure: %d \n', i, out_sd(1, i));

end


fclose(out);

    
end
