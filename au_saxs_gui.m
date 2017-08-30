function varargout = au_saxs_gui(varargin)
% AU_SAXS_GUI MATLAB code for au_saxs_gui.fig
%      AU_SAXS_GUI, by itself, creates a new AU_SAXS_GUI or raises the existing
%      singleton*.
%
%      H = AU_SAXS_GUI returns the handle to a new AU_SAXS_GUI or the handle to
%      the existing singleton*.
%
%      AU_SAXS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AU_SAXS_GUI.M with the given input arguments.
%
%      AU_SAXS_GUI('Property','Value',...) creates a new AU_SAXS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before au_saxs_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to au_saxs_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help au_saxs_gui

% Last Modified by GUIDE v2.5 09-Jun-2017 16:05:38


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @au_saxs_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @au_saxs_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before au_saxs_gui is made visible.
function au_saxs_gui_OpeningFcn(hObject, eventdata, handles, varargin)




handles.screensize = get( groot, 'Screensize' );

set(handles.au_saxs_gui, 'position', [handles.screensize])

handles.output = hObject;

handles.number_of_files = 5;
set(handles.edt_number_of_files,'String',num2str(handles.number_of_files));

handles.number_of_exp = 10;
set(handles.edt_number_of_exp,'String',num2str(handles.number_of_exp));


handles.q_min_cut = 35;
handles.q_max_cut = 500;
set(handles.cut_q_min,'String',num2str(handles.q_min_cut)); 
set(handles.cut_q_max,'String',num2str(handles.q_max_cut)); 

handles.au_lb_nr = 1;
handles.a_lb_nr = 2;
handles.b_lb_nr = 3;
handles.double_lb_nr = 4;
handles.un_lb_nr = 5;

set(handles.edt_au_label_pos,'String',num2str(handles.au_lb_nr));
set(handles.edt_a_label_pos,'String',num2str(handles.a_lb_nr)); 
set(handles.edt_b_label_pos,'String',num2str(handles.b_lb_nr)); 
set(handles.edt_double_label_pos,'String',num2str(handles.double_lb_nr)); 
set(handles.edt_unlabel_pos,'String',num2str(handles.un_lb_nr)); 
    

handles.choice_I_d = 5;
set(handles.edt_choice_I_d,'String',num2str(handles.choice_I_d)); 

handles.max_entropy_runs = 10;
set(handles.edt_max_entropy_runs,'String',num2str(handles.max_entropy_runs)); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes au_saxs_gui wait for user response (see UIRESUME)
% uiwait(handles.au_saxs_gui);


% --- Outputs from this function are returned to the command line.
function varargout = au_saxs_gui_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function edt_number_of_files_Callback(hObject, eventdata, handles)

handles.number_of_files = str2double(get(hObject,'String'));
set(hObject,'String',handles.number_of_files);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_number_of_files_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function au_saxs_gui_CreateFcn(hObject, eventdata, handles)



% --- Executes during object deletion, before destroying properties.
function au_saxs_gui_DeleteFcn(hObject, eventdata, handles)



% --- Executes when user attempts to close au_saxs_gui.
function au_saxs_gui_CloseRequestFcn(hObject, eventdata, handles)

handles.path_on_off = get(handles.data_path,'String');


if strcmp(handles.path_on_off, 'Data path') ~= 1 
   %rmpath(handles.data_directory);
end


delete(hObject);


% --- Executes on button press in make_sample_tbl.
function make_sample_tbl_Callback(hObject, eventdata, handles)



tic;
sample_name_tbl_empty = cell(handles.number_of_files,4);
set(handles.sample_name_tbl,'Data', sample_name_tbl_empty);
set(handles.sample_name_tbl,'Visible','on');
set(handles.load_data,'Visible','on');
set(handles.save_saxs_data,'Visible','on');
set(handles.plot_ind_scattering_data,'Visible','on');
set(handles.plot_mean_scattering_data,'Visible','on');
set(handles.text9,'Visible','on');
set(handles.text10,'Visible','on');

set(handles.plot_mean_buffer,'Visible','on');
set(handles.text16,'Visible','on');
toc;

guidata(handles.au_saxs_gui,handles);

        



% --- Executes when entered data in editable cell(s) in sample_name_tbl.
function sample_name_tbl_CellEditCallback(hObject, eventdata, handles)

  
handles.file_names = get(hObject,'Data');


guidata(handles.au_saxs_gui,handles);


% --- Executes when selected cell(s) is changed in sample_name_tbl.
function sample_name_tbl_CellSelectionCallback(hObject, eventdata, handles)


% --- Executes on button press in load_data.
function load_data_Callback(hObject, eventdata, handles)
    
    cut1 = handles.q_min_cut;
    cut2 = handles.q_max_cut;
    
   
    
    data_load = zeros(handles.number_of_files, 1);

    for iType=1:handles.number_of_files
              
    concentration = str2double(handles.file_names{iType, 3});
    exposures = handles.number_of_exp;
    concentration_error_load = [];
        
         if isempty(handles.file_names{iType, 3})
                       
            concentration_error_load = strcat('Missing concentration at ', num2str(iType), '!');
            errordlg(concentration_error_load);   
            
         end
         
         
         
        % handles.saxs_data{iType}=load_individual_samples(handles.file_names{iType, 1}, handles.file_names{iType, 2}, cut1,cut2,concentration, exposures);

         
        try
            
             
           handles.saxs_data{iType}=load_individual_samples(handles.file_names{iType, 1}, handles.file_names{iType, 2}, cut1,cut2,concentration, handles, exposures);
           
           
           data_load(iType, 1) = 1;

        catch

            file_error_load = strcat('Missing filename at ', num2str(iType), '!');
            errordlg(file_error_load);    
            data_load(iType, 1) = 0;
        end

    end
    
if isempty(find(data_load==0)) && isempty(concentration_error_load)
    msgbox('All data was successfully imported!');
end
    
guidata(handles.au_saxs_gui,handles);



function cut_q_min_Callback(hObject, eventdata, handles)

handles.q_min_cut = str2double(get(hObject,'String'));
set(hObject,'String',handles.q_min_cut);

guidata(handles.au_saxs_gui,handles);



% --- Executes during object creation, after setting all properties.
function cut_q_min_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cut_q_max_Callback(hObject, eventdata, handles)

handles.q_max_cut = str2double(get(hObject,'String'));
set(hObject,'String',handles.q_max_cut);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function cut_q_max_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data_path_Callback(hObject, eventdata, handles)

handles.data_directory = get(hObject,'String');

addpath(handles.data_directory);

set(hObject,'String',handles.data_directory);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function data_path_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function load_data_ButtonDownFcn(hObject, eventdata, handles)




function edt_number_of_exp_Callback(hObject, eventdata, handles)

handles.number_of_exp = get(hObject,'String');
set(hObject,'String',handles.number_of_exp);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_number_of_exp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_number_of_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_saxs_data.
function save_saxs_data_Callback(hObject, eventdata, handles)

    for i=1:handles.number_of_files
        
        savename_scattering_data = strcat(sprintf('%s', handles.file_names{i, 4}), '_scattering_data');
        scattering_data = handles.saxs_data{1, i};
        
        save(savename_scattering_data, 'scattering_data');
        
    end
    
guidata(handles.au_saxs_gui,handles);


% --- Executes on button press in plot_ind_scattering_data.
function plot_ind_scattering_data_Callback(hObject, eventdata, handles)

for i=1:handles.number_of_files
    
    figure(i)
    scattering_data = handles.saxs_data{1, i};

    for ii=1:handles.number_of_exp
        
        h(ii) = plot(scattering_data(:,1 + 3*(ii-1)),scattering_data(:,2 + 3*(ii-1)), 'LineWidth', 2); hold on;
        
        legend_out{ii} = strcat('Exposure: ', num2str(ii));
        
        
    end
    
    set(gcf, 'position', [handles.screensize(1) handles.screensize(2) handles.screensize(3)/2 handles.screensize(4)]);
    set(gca,'LineWidth', 1,'FontSize', 24, 'FontWeight', 'bold', 'TickLength',[0.02 0.02])
    
    ang = strcat('s (', char(197), '^{-1})');
    xlabel(ang)
    ylabel('Intensity (arb. units)')
    legend(h, legend_out);
    legend('off');
    legend('show');
    
end


guidata(handles.au_saxs_gui,handles);


% --- Executes on button press in plot_mean_scattering_data.
function plot_mean_scattering_data_Callback(hObject, eventdata, handles)
    for i=1:handles.number_of_files
    
    figure(i)
    scattering_data = handles.saxs_data{1, i};
     
    h = plot(scattering_data(:,4 + 3*handles.number_of_files),scattering_data(:,5 + 3*handles.number_of_files), 'LineWidth', 2); hold on;

    set(gcf, 'position', [handles.screensize(1) handles.screensize(2) handles.screensize(3)/2 handles.screensize(4)]);

    set(gca,'LineWidth', 1,'FontSize', 24, 'FontWeight', 'bold', 'TickLength',[0.02 0.02])

    ang = strcat('s (', char(197), '^{-1})');
    xlabel(ang);
    ylabel('Intensity (arb. units)');
    
    legend(h, 'Mean')
    legend('off');
    legend('show');
    
    end
    
    guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function plot_mean_scattering_data_CreateFcn(hObject, eventdata, handles)



% --- Executes on button press in plot_mean_buffer.
function plot_mean_buffer_Callback(hObject, eventdata, handles)

    for i=1:handles.number_of_files
    
    figure
    scattering_data = handles.saxs_data{1, i};
     
    plot(scattering_data(:,1 + 3*handles.number_of_exp),scattering_data(:,2 + 3*handles.number_of_exp), 'LineWidth', 2); hold on;

    set(gca,'LineWidth', 1,'FontSize', 24, 'FontWeight', 'bold', 'TickLength',[0.02 0.02])
    set(gcf, 'position', [handles.screensize(1) handles.screensize(2) handles.screensize(3)/2 handles.screensize(4)]);

    
    ang = strcat('s (', char(197), '^{-1})');
    xlabel(ang);
    ylabel('Intensity (arb. units)');
    
    end
    
    guidata(handles.au_saxs_gui,handles);



function edt_au_label_pos_Callback(hObject, eventdata, handles)

handles.au_lb_nr = str2double(get(hObject,'String'));
set(hObject,'String',handles.au_lb_nr);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_au_label_pos_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_a_label_pos_Callback(hObject, eventdata, handles)

handles.a_lb_nr = str2double(get(hObject,'String'));
set(hObject,'String',handles.a_lb_nr);
guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_a_label_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_a_label_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_b_label_pos_Callback(hObject, eventdata, handles)

handles.b_lb_nr = str2double(get(hObject,'String'));
set(hObject,'String',handles.b_lb_nr);
guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_b_label_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_b_label_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_unlabel_pos_Callback(hObject, eventdata, handles)


handles.un_lb_nr = str2double(get(hObject,'String'));
set(hObject,'String',handles.un_lb_nr);
guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_unlabel_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_unlabel_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_double_label_pos_Callback(hObject, eventdata, handles)

handles.double_lb_nr = str2double(get(hObject,'String'));
set(hObject,'String',handles.double_lb_nr);
guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_double_label_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_double_label_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_max_entropy.
function run_max_entropy_Callback(hObject, eventdata, handles)

choice = handles.choice_I_d;

AB = handles.saxs_data{1, handles.double_lb_nr};
A = handles.saxs_data{1, handles.a_lb_nr};
B = handles.saxs_data{1, handles.b_lb_nr};
Au = handles.saxs_data{1, handles.au_lb_nr};
U = handles.saxs_data{1, handles.un_lb_nr};

num = handles.max_entropy_runs;
exposures = handles.number_of_exp;


[handles.PAB,handles.fval,handles.Idelta_fvec,handles.fvec, handles.Au_dis]=run_max_entropy_analysis_new(choice,AB, A,B,U, Au, num, exposures, handles);

figure
plot(handles.fvec, 'LineWidth', 2);
set(gca,'LineWidth', 1,'FontSize', 24, 'FontWeight', 'bold', 'TickLength',[0.02 0.02])
ang = strcat('Distance (', char(197), ')');
xlabel(ang);
ylabel('P(d) (arb. units)');
legend('show');
title('Au-Au Distance Distribution');


figure
plot(Au(:,1), handles.Idelta_fvec, 'LineWidth', 2);
set(gca,'LineWidth', 1,'FontSize', 24, 'FontWeight', 'bold', 'TickLength',[0.02 0.02])
set(gcf, 'position', [handles.screensize(1) handles.screensize(2) handles.screensize(3)/2 handles.screensize(4)]);

ang = strcat('s (', char(197), '^{-1})');
xlabel(ang);
ylabel('Intensity (arb. units)');
title('Interference Pattern I(d)');


guidata(handles.au_saxs_gui,handles);



function edt_choice_I_d_Callback(hObject, eventdata, handles) 

handles.choice_I_d = str2double(get(hObject,'String'));
set(hObject,'String',handles.choice_I_d);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_choice_I_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_choice_I_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_max_entropy_runs_Callback(hObject, eventdata, handles)

handles.max_entropy_runs = str2double(get(hObject,'String'));
set(hObject,'String',handles.max_entropy_runs);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function edt_max_entropy_runs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_max_entropy_runs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_max_entropy_data.
function save_max_entropy_data_Callback(hObject, eventdata, handles)


savename_scattering_data = strcat(sprintf('%s', handles.max_entropy_name), '_Distance_Distribution');
distance_dis = handles.fvec;

save(savename_scattering_data, 'distance_dis');


if get(handles.chek_I_d,'Value')==get(handles.chek_I_d,'Max')
    savename_scattering_data = strcat(sprintf('%s', handles.max_entropy_name), '_Interference_Pattern');
    I_delta = handles.Idelta_fvec;

    save(savename_scattering_data, 'I_delta');    
end

if get(handles.check_au_distr,'Value')==get(handles.check_au_distr,'Max')
    savename_scattering_data = strcat(sprintf('%s', handles.max_entropy_name), '_Au_Radius_Distribution');
    r_au = handles.Au_dis;

    save(savename_scattering_data, 'r_au');  
end


guidata(handles.au_saxs_gui,handles);

% --- Executes on button press in check_au_distr.
function check_au_distr_Callback(hObject, eventdata, handles)

guidata(handles.au_saxs_gui,handles);


% --- Executes on button press in chek_I_d.
function chek_I_d_Callback(hObject, eventdata, handles)


guidata(handles.au_saxs_gui,handles);


function max_entropy_save_name_Callback(hObject, eventdata, handles)

handles.max_entropy_name = get(hObject,'String');
set(hObject,'String',handles.max_entropy_name);

guidata(handles.au_saxs_gui,handles);


% --- Executes during object creation, after setting all properties.
function max_entropy_save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_entropy_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function close_fiugres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to close_fiugres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in close_figures.
function close_figures_Callback(hObject, eventdata, handles)

set(handles.au_saxs_gui, 'HandleVisibility', 'off');
close all;
set(handles.au_saxs_gui, 'HandleVisibility', 'on');
guidata(handles.au_saxs_gui,handles);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes during object creation, after setting all properties.
function checkbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
