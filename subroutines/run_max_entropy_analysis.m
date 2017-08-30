%function [PAB_hb_150_uM_MgCl,fval_hb_150_uM_MgCl,Idelta_hb_150_uM_MgCl,fvec_hb_150_uM_MgCl] = run_max_entropy_analysis(choice,AB, A,B,U, Au, exposures)
%

%%

num = 1;
choice=5;
%%

%load data_2016July22.mat % load compressed data file
%%

% Gold scattering data to create gold-gold basis functions and
% interference pattern substraction. The gold scattering experimental data
% has to originate from the same gold batch as the sample to be analysed
Au = au;

sval=Au(:,1);

Au_offset=max(Au(:,35))/mean(Au(length(Au)-10:end,35)); % Au_offset in case of a high base line
 
load ICF.txt % Load intrinsic correlation function matrix
IqD=IqD_basis_functions(sval,Au(:,35)-max(Au(:,35))/Au_offset); % Create gold-gold basis functions

%% hb_150_uM_MgCl
AB=rh_150_uM_MgCl;
AB(:,34:36) = AB(:,13:15);% Name of the double labelled sample stored in the compressed .mat file
A=jr_150_uM_MgCl; % Name of first single labelled sample stored in the compressed .mat file
B=jh_150_uM_MgCl; % Name of second single labelled sample stored in the compressed .mat file
U=hj_150_uM_MgCl; % Name of funlabelled sample stored in the compressed .mat file

[PAB_hb_150_uM_MgCl,fval_hb_150_uM_MgCl,Idelta_hb_150_uM_MgCl,fvec_hb_150_uM_MgCl]=function_fvec_simple_nonneg_new...
    (choice,AB, A,B,U, Au, IqD,ICF, num);
 

plot(fvec_hb_150_uM_MgCl);
%end