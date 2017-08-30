function load_au_saxs_data()
% load_au-saxs_data() calls function
% load_individual_samples(filenamesample, filenamebuffer, cut1,cut2,concentration)
% for every given sample and returns formated matrices with cut q-range to remove
% noisy data and averaged buffer/sample intensities and averaged scattering
% intensity variances. The submitted data has to fulfil following
% requirements: 1st column scattering momentum in q
%               2nd column scattering intensity
%               3rd column scattering intensity error as standard deviation
%
% The load_individual_samples function will loop over the given input name
% for sample and buffer with serially numbered name.
%
% Example:
% sample_01, sample_02, sample_03,....
% 
% If more than 10 exposures were recorded the number of exposures has to be given as
% additional input (load_individual_samples(filenamesample, filenamebuffer, cut1,cut2,concentration, exposures).
% All data traces are cut at q_min = cut1 and q_max = cut2 and scalled to the
% concentration standard of 50 uM thus a rough estimation of the concentration has to be
% given as input. To concatenate multiple samples simply add another line calling
% the load_individual_samples function.
% 
% Example:
%   sample_1 = load_individual_samples(filenamesample1, filenamebuffer1,cut1,cut2,concentration1);
%   sample_2 = load_individual_samples(filenamesample2, filenamebuffer2,cut1,cut2,concentration2);
%   .
%   .
%   .
%   sample_N = load_individual_samples(filenamesample_N, filenamebuffer_N,cut1,cut2,concentration_N);
%
% The function returns the results to the matrix and saves
% all given data including averaged buffer/sample intensities and averaged scattering
% intensity variances to a file with the chosen savename.
% 
%

data_path = '/Users/thomaszettl/Desktop/holliday junction/thomas/analysis/test_folder'; %path of the data directory
savename = 'data_2016June2.mat'; % set savename of the data


addpath(data_path)

%% All data 
cut1=15; % cut data trace at q_min = cut1 to remove noise caused around the beam stop
cut2=500; % cut data trace at q_max = cut2 to remove noise in the high q range
%%  Au 

[au]=load_data_nov2011('sample5_01B_S108', 'sample5_01A_B107', cut1,cut2,50);
[au2]=load_data_nov2011('sample5_01C_S109', 'sample5_01A_B107', cut1,cut2,50);
[au3]=load_data_nov2011('sample5_01D_S110', 'sample5_01A_B107', cut1,cut2,50);
[Au_Ym3]=load_data_nov2011('Au_01C_S038', 'Au_01A_B037', cut1,cut2,152.9);
%% rna1 (70 mM tris pH 7.4, 10mM Na-ascorbate, 150 mM NaCl, 10 mM Mg)
[rna1_1_1c]=load_data_nov2011('rna1_01B_S002', 'rna1_01A_B001', cut1,cut2,29.9); % 
[rna1_1]=load_data_nov2011('rna1_01C_S004', 'rna1_01A_B003', cut1,cut2, 24.4); % 
[rna1_1c]=load_data_nov2011('rna1_01D_S006', 'rna1_01A_B005', cut1,cut2,30); % 

%% rna2 (70 mM tris pH 7.4, 10mM Na-ascorbate, 150 mM NaCl, 10 mM Mg)
[rna2_2_2c]=load_data_nov2011('rna2_01B_S008', 'rna2_01A_B007', cut1,cut2,30); % 
[rna2_2]=load_data_nov2011('rna2_01C_S010', 'rna2_01A_B009', cut1,cut2, 28.5); % 
[rna2_2c]=load_data_nov2011('rna2_01D_S012', 'rna2_01A_B011', cut1,cut2,24.7); % 

%% rna3 (70 mM tris pH 7.4, 10mM Na-ascorbate, 150 mM NaCl, 10 mM Mg)
[rna3_3_3c]=load_data_nov2011('rna3_01B_S014', 'rna3_01A_B013', cut1,cut2,30); % 
[rna3_3]=load_data_nov2011('rna3_01C_S016', 'rna3_01A_B015', cut1,cut2, 22.5); % 
[rna3_3c]=load_data_nov2011('rna3_01D_S018', 'rna3_01A_B017', cut1,cut2,9.25); % 


%% rna4 (70 mM tris pH 7.4, 10mM Na-ascorbate, 150 mM NaCl, 10 mM Mg)
[rna4_4_4c]=load_data_nov2011('rna4_01B_S020', 'rna4_01A_B019', cut1,cut2,30); % 
[rna4_4]=load_data_nov2011('rna4_01C_S022', 'rna4_01A_B021', cut1,cut2, 30.2); % 

%% steve TL (70 mM tris pH 7.4, 10mM Na-ascorbate, 150 mM NaCl, 10 mM Mg)
[TL_c7_S0L3]=load_data_nov2011('TLc7_01B_S028', 'TLc7_01A_B027', cut1,cut2,50); % 
[TL_c7_S3L0]=load_data_nov2011('TLc7_01C_S030', 'TLc7_01A_B029', cut1,cut2,50); % 
[TL_c7_S3L3_peak2]=load_data_nov2011('TLc7_01D_S032', 'TLc7_01A_B031', cut1,cut2,50); % 
[TL_c7_S0L0]=load_data_nov2011('TLc7_01E_S034', 'TLc7_01A_B033', cut1,cut2,50); % 

[TL_uucg_S0L3]=load_data_nov2011('TLuucg_01B_S040', 'TLuucg_01A_B039', cut1,cut2,50); % 
[TL_uucg_S3L0]=load_data_nov2011('TLuucg_01C_S042', 'TLuucg_01A_B041', cut1,cut2,50); % 
[TL_uucg_S3L3_peak2]=load_data_nov2011('TLuucg_01D_S044', 'TLuucg_01A_B043', cut1,cut2,50); % 
[TL_uucg_S0L0]=load_data_nov2011('TLuucg_01E_S046', 'TLuucg_01A_B045', cut1,cut2,50); % 

[TL_wt_1]=load_data_nov2011('TLwt_01B_S048', 'TLwt_01A_B047', cut1,cut2,50*30/35); % 
[TL_wt_2]=load_data_nov2011('TLwt_01C_S050', 'TLwt_01A_B049', cut1,cut2,50*30/40); % 
[TL_wt_3]=load_data_nov2011('TLwt_01D_S052', 'TLwt_01A_B051', cut1,cut2,50*30/40); % 
[TL_wt_4]=load_data_nov2011('TLwt_01E_S054', 'TLwt_01A_B053', cut1,cut2,50*30/40); % 
[TL_wt_5]=load_data_nov2011('TLwt_01F_S056', 'TLwt_01A_B055', cut1,cut2,50*30/38); % 
[TL_wt_S0L0]=load_data_nov2011('TLwt_01G_S058', 'TLwt_01A_B057', cut1,cut2,50); % 

[TL_wt_S3L0]=load_data_nov2011('TLwt_01B_S048', 'TLwt_01A_B047', cut1,cut2,50*30/35); % 
[TL_wt_S2L0]=load_data_nov2011('TLwt_01C_S050', 'TLwt_01A_B049', cut1,cut2,50*30/40); % 
[TL_wt_S3L3_peak2]=load_data_nov2011('TLwt_01D_S052', 'TLwt_01A_B051', cut1,cut2,50*30/40); % 
[TL_wt_S3L3]=load_data_nov2011('TLwt_01E_S054', 'TLwt_01A_B053', cut1,cut2,50*30/40); % 
[TL_wt_S0L3]=load_data_nov2011('TLwt_01F_S056', 'TLwt_01A_B055', cut1,cut2,50*30/38); % 

save(savename);
rmpath(data_path);
end





