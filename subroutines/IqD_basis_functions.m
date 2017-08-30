function [IqD,PAU]=IqD_basis_functions(sval,Au)
%
% Usage: IqD=gen_IqD(sval,Au)
% Decompose the gold autoscattering profile Au into a volume-weighted gold nanocrystal
% radius distribution and creates radius-weighted gold-gold basis functions in the
% distance increment between 1:200 Angstrom and the s-range given as input (sval).
% 
% 
% 


    Rval=1:100; % Size range for Au-nanoparticle radius from 1:100 Angstrom
    IqR=gen_IqR(sval,Rval); % Create basis functions in the distance increment specified
    PAU6=lsqnonneg(IqR,Au); % Transform the gold profile into volumne-weighted weighted distribution
    Rval=Rval';
    PAU=PAU6./(Rval.^6);
    % Transform the gold profile into number-weighted radius distribution
    % (^6 since data is in intensity)
    
    figure
    plot(Rval,PAU, 'LineWidth',2); % Plot number-weighted gold nanocrystal radius distribution
    
    title('Au Nanoparticle Size Distribution');
    set(gca,'LineWidth', 1,'FontSize', 24, 'FontWeight', 'bold', 'TickLength',[0.02 0.02])
    ang = strcat('Au radius (', char(197), ')');
    xlabel(ang);
    ylabel('P(d) (arb. units)');


    ID0=gen_Ic2c0(PAU6, Rval, sval); % Create radius-weighted gold autoscattering intensity 
    Dval=1:200; % Gold-gold basis function distance increment from 1:200 Angstrom
    IqD=gen_IqD(ID0, sval, Dval); % Create gold-gold basis functions in the distance increment specified
    
end