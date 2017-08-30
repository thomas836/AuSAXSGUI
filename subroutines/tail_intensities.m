function [c,STDX]=tail_intensities(sval,IA,IAu,IBuf,cutoff)
%
% Usage: [c,STDX]=tail_intensities(sval,IA,IAu,IBuf,cutoff);

index=find(sval>cutoff);
IA2=IA(index);
IAu2=IAu(index);
IBuf2=IBuf(index);
temp(:,1)=IAu2;
temp(:,2)=IBuf2;

[c,STDX]=lscov(temp,IA2); % Scalling factor to align two traces at high s

end