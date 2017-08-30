function [PAB, fval, Idelta, fvec, Au_dis] = run_max_entropy_analysis_new(choice,AB, A,B,U, Au,num, exposures, handles)


sval=Au(:,1);

Au_offset=max(Au(:,exposures*3 + 5))/mean(Au(length(Au)-10:end,exposures*3 + 5)); % Au_offset in case of a high base line
 
load ICF.txt % Load intrinsic correlation function matrix
[IqD, Au_dis]=IqD_basis_functions(sval,Au(:,exposures*3 + 5)-max(Au(:,exposures*3 + 5))/Au_offset); % Create gold-gold basis functions


[PAB,fval,Idelta,fvec]=function_fvec_simple_nonneg_new(choice,AB, A,B,U, Au, IqD,ICF, num, handles);
 

end