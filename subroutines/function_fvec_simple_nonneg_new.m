function [PAB,fval,Idelta_fvec,fvec]=function_fvec_simple_nonneg_new...
    (choice,AB, A,B,U, Au, IqD,ICF, num, handles)

% n1=1; (orginal scaling)^1;
% n2=1; (nonneg)^1;
% n3=1; Pdelta
% n4: c=f*a...
% n5: c>2*C1...
% SD, sval, buffer will be provided for becky data
% choice_nonneg:  1: regular fminsearch  Y=SD;
%                 2: regular fminsearch  Y=1;
%                 3: nonneg only  Y=SD;
%                 4: nonneg only  Y=1;                

IDX=1:length(Au);

if size(AB,2) >= 6
    
    sval=AB(IDX,1);    
    
    index2=2:3:size(AB,2)-7;
    
     AB_std = zeros(1, length(AB));
     A_std = zeros(1, length(AB));
     B_std = zeros(1, length(AB));
     U_std = zeros(1, length(AB));

    for i=1:length(AB)

        AB_std(i)=std(AB(i,index2))/(10^0.5); % Error estimate double-labelled sample
        A_std(i)=std(A(i,index2))/(10^0.5); % Error estimate single-labelled sample A
        B_std(i)=std(B(i,index2))/(10^0.5); % Error estimate single-labelled sample B
        U_std(i)=std(U(i,index2))/(10^0.5); % Error estimate unlabelled sample

    end
    

    [Idelta_fvec, PAB,fval]=gen_Idelta_nonneg(U(IDX,1), U(IDX,size(AB,2)-1), A(IDX,size(AB,2)-1), ...
        B(IDX,size(AB,2)-1), AB(IDX,size(AB,2)-1),U(IDX,size(AB,2)-4),choice); % Optimizing the interference pattern using option choice
    
    S_std=(AB_std.^2+abs(PAB(2)).*(A_std.^2+B_std.^2)+abs(PAB(1)).*U_std.^2+...
        +abs((PAB(3)).*A(:,size(AB,2)-3)')).^0.5; % Scalled error estimate for the interference pattern


elseif size(AB,2)==6
    
    sval=AB(IDX,1);
    
     AB_std = zeros(1, length(AB));
     A_std = zeros(1, length(AB));
     B_std = zeros(1, length(AB));
     U_std = zeros(1, length(AB));

    
    for i=1:length(AB)
        
        AB_std=std(AB(i,2))/(20^0.5);
        A_std=std(A(i,2))/(20^0.5);
        B_std=std(B(i,2))/(20^0.5);
        U_std=std(U(i,2))/(20^0.5);
        
    end

                     
    [Idelta_fvec, PAB,fval]=gen_Idelta_nonneg(U(IDX,1), U(IDX,2), A(IDX,2), ...
        B(IDX,2), AB(IDX,2),AB(IDX,5),choice);
    
    S_std=(AB_std.^2+abs(PAB(2)).*(A_std.^2+B_std.^2)+abs(PAB(1)).*U_std.^2+...
       +abs((PAB(3)).*A(:,6)')).^0.5;


end


try

    warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    jFrame = get(handle(handles.au_saxs_gui),'JavaFrame');
    jFigPanel = get(jFrame,'FigurePanelContainer');
    jRootPane = jFigPanel.getComponent(0).getRootPane;
    

    statusText = 'Please wait ...';

    jRootPane = jRootPane.getTopLevelAncestor;

    statusbarObj = jRootPane.getStatusBar;

    statusbarObj = com.mathworks.mwswing.MJStatusBar;
    jProgressBar = javax.swing.JProgressBar;
    jProgressBar.setVisible(true);
    statusbarObj.add(jProgressBar,'West');
    jRootPane.setStatusBar(statusbarObj);

    statusbarObj.setText(statusText);
    jRootPane.setStatusBarVisible(1);

    statusbarObj = handle(statusbarObj);
    progressbartype = 2;
    
catch
    
    sb = waitbar(0, 'Please wait!');
    progressbartype = 1;
end


if num>0
        
        
      fvec=zeros(size(IqD, 2),num);
 
        
        
      tic;
      for i=1:num
            

            if(progressbartype == 1)
             waitbar(i/num, sb, sprintf('Processing %d of %d (%.1f%%)...', i, num, i/num*100));       
            
            elseif(progressbartype == 2)
             jProgressBar.setValue(i/num*100);
             jProgressBar.setStringPainted(true);
             jProgressBar.setString(sprintf('%.1f%%', i/num*100))
             statusbarObj.setText(sprintf('Processing %d of %d ...', i, num));
            end
             
             n_delta=max(Idelta_fvec)/10;
             temp_1 = [sval, Idelta_fvec./n_delta, S_std(IDX)'./n_delta, IqD./640000];
             [~,fvec(:,i),~]=jacknife_new(temp_1(:,1), temp_1(:,2), temp_1(:,3), temp_1(:,4:end),ICF);
             
      end
      toc;
        
end

if(progressbartype == 2)
    jRootPane.setStatusBarVisible(0);
elseif(progressbartype == 1)
    close(sb);
end


end