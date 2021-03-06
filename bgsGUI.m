function varargout = bgsGUI(varargin)
% BGSGUI MATLAB code for bgsGUI.fig
%      BGSGUI, by itself, creates a new BGSGUI or raises the existing
%      singleton*.
%
%      H = BGSGUI returns the handle to a new BGSGUI or the handle to
%      the existing singleton*.
%
%      BGSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BGSGUI.M with the given input arguments.
%
%      BGSGUI('Property','Value',...) creates a new BGSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bgsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bgsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bgsGUI

% Last Modified by GUIDE v2.5 18-Oct-2016 14:54:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bgsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @bgsGUI_OutputFcn, ...
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


% --- Executes just before bgsGUI is made visible.
function bgsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bgsGUI (see VARARGIN)

% Choose default command line output for bgsGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bgsGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bgsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

% Rozmiar uk�adu r�wna�
N = str2double(get(handles.nEdit, 'String'));
% Elementy z ukladu (odpowiednio R - czesc rzeczywista, I - czesc zespolona)
% Przedzial na elementy pod i nad diagonala
przedzialR = [str2double(get(handles.outsideDiagRealFrom, 'String')) str2double(get(handles.outsideDiagRealTo, 'String'))];
przedzialI = [str2double(get(handles.outsideDiagImagFrom', 'String')) str2double(get(handles.outsideDiagRealTo, 'String'))];
% Przedzial na elementy na diagonali
przedzialDiagR = [str2double(get(handles.diagRealFrom, 'String')) str2double(get(handles.diagRealTo, 'String'))];
przedzialDiagI = [str2double(get(handles.diagImagFrom, 'String')) str2double(get(handles.diagImagTo, 'String'))];
% Przedzial na wektor b
przedzialBR = [str2double(get(handles.bRealFrom, 'String')) str2double(get(handles.bRealTo, 'String'))];
przedzialBI = [str2double(get(handles.bImagFrom, 'String')) str2double(get(handles.bImagTo, 'String'))];
% Przedzial na wektor x0
przedzialX0R = [str2double(get(handles.x0RealFrom, 'String')) str2double(get(handles.x0RealTo, 'String'))];
przedzialX0I = [str2double(get(handles.x0ImagFrom, 'String')) str2double(get(handles.x0ImagTo, 'String'))];

% Parametry stopu
epsilon = str2double(get(handles.epsilonEdit, 'String'));
delta = str2double(get(handles.deltaEdit, 'String'));
maxIteracji = str2double(get(handles.maxIterEdit, 'String'));

% Generowanie wektorow
% Wszystkie powinny byc tej samej dlugosci (N), stad dodajemy odpowiednio
% zera
upp = [randComplex(przedzialR, przedzialI, 1, N-1) 0];
dia = randComplex(przedzialDiagR, przedzialDiagI, 1, N);
low = [0 randComplex(przedzialR, przedzialI, 1, N-1)];
% Zrekonstruowanie macierzy A
A = diag(dia) + diag(upp(1:end-1), 1) + diag(low(2:end), -1);

% Generowanie wektora b
b = randComplex(przedzialBR, przedzialBI, 1, N);
% Generowanie przyblizenia poczatkowego x0
x0 = randComplex(przedzialX0R, przedzialX0I, 1, N);

% Rozwiazywanie ukladu za pomoca BGS
tic;
[xBGS, liczbaIteracji] = bgs(low, dia, upp, b, x0, epsilon, delta, maxIteracji);
czasBGS = toc;

set(handles.iterationCount, 'String', liczbaIteracji);
set(handles.timeElapsedBGS, 'String', sprintf('%.2fms', czasBGS*1000));

if all(isnan(xBGS))
    set(handles.errorMagnitudeBGS, 'String', 'blad');
else
    % Obliczenie bledow
    bladBGS = norm(A*reshape(xBGS, N, 1) - reshape(b, N, 1));
    rzadBleduBGS = round(log10(bladBGS));
    set(handles.errorMagnitudeBGS, 'String', rzadBleduBGS);
end


% Obliczenie rozwiazania niezalezna metoda linsolve
tic
xLinsolve = linsolve(A, reshape(b, N, 1));
czasLinsolve = toc;

set(handles.timeElapsedLinsolve, 'String', sprintf('%.2fms', czasLinsolve*1000));

if all(isnan(xLinsolve))
    set(handles.errorMagnitudeLinsolve, 'String', 'blad');
else
    % Obliczenie bledow
    bladLinsolve = norm(A*xLinsolve - b);
    rzadBleduLinsolve = round(log10(bladLinsolve));
    set(handles.errorMagnitudeLinsolve, 'String', rzadBleduLinsolve);
end




function bImagTo_Callback(hObject, eventdata, handles)
% hObject    handle to bImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bImagTo as text
%        str2double(get(hObject,'String')) returns contents of bImagTo as a double


% --- Executes during object creation, after setting all properties.
function bImagTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bImagFrom_Callback(hObject, eventdata, handles)
% hObject    handle to bImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bImagFrom as text
%        str2double(get(hObject,'String')) returns contents of bImagFrom as a double


% --- Executes during object creation, after setting all properties.
function bImagFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bRealTo_Callback(hObject, eventdata, handles)
% hObject    handle to bRealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bRealTo as text
%        str2double(get(hObject,'String')) returns contents of bRealTo as a double


% --- Executes during object creation, after setting all properties.
function bRealTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bRealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bRealFrom_Callback(hObject, eventdata, handles)
% hObject    handle to bRealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bRealFrom as text
%        str2double(get(hObject,'String')) returns contents of bRealFrom as a double


% --- Executes during object creation, after setting all properties.
function bRealFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bRealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0ImagTo_Callback(hObject, eventdata, handles)
% hObject    handle to x0ImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0ImagTo as text
%        str2double(get(hObject,'String')) returns contents of x0ImagTo as a double


% --- Executes during object creation, after setting all properties.
function x0ImagTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0ImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0ImagFrom_Callback(hObject, eventdata, handles)
% hObject    handle to x0ImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0ImagFrom as text
%        str2double(get(hObject,'String')) returns contents of x0ImagFrom as a double


% --- Executes during object creation, after setting all properties.
function x0ImagFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0ImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0RealTo_Callback(hObject, eventdata, handles)
% hObject    handle to x0RealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0RealTo as text
%        str2double(get(hObject,'String')) returns contents of x0RealTo as a double


% --- Executes during object creation, after setting all properties.
function x0RealTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0RealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0RealFrom_Callback(hObject, eventdata, handles)
% hObject    handle to x0RealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0RealFrom as text
%        str2double(get(hObject,'String')) returns contents of x0RealFrom as a double


% --- Executes during object creation, after setting all properties.
function x0RealFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0RealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outsideDiagImagTo_Callback(hObject, eventdata, handles)
% hObject    handle to outsideDiagImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outsideDiagImagTo as text
%        str2double(get(hObject,'String')) returns contents of outsideDiagImagTo as a double


% --- Executes during object creation, after setting all properties.
function outsideDiagImagTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outsideDiagImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outsideDiagImagFrom_Callback(hObject, eventdata, handles)
% hObject    handle to outsideDiagImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outsideDiagImagFrom as text
%        str2double(get(hObject,'String')) returns contents of outsideDiagImagFrom as a double


% --- Executes during object creation, after setting all properties.
function outsideDiagImagFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outsideDiagImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outsideDiagRealTo_Callback(hObject, eventdata, handles)
% hObject    handle to outsideDiagRealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outsideDiagRealTo as text
%        str2double(get(hObject,'String')) returns contents of outsideDiagRealTo as a double


% --- Executes during object creation, after setting all properties.
function outsideDiagRealTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outsideDiagRealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outsideDiagRealFrom_Callback(hObject, eventdata, handles)
% hObject    handle to outsideDiagRealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outsideDiagRealFrom as text
%        str2double(get(hObject,'String')) returns contents of outsideDiagRealFrom as a double


% --- Executes during object creation, after setting all properties.
function outsideDiagRealFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outsideDiagRealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diagRealFrom_Callback(hObject, eventdata, handles)
% hObject    handle to diagRealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diagRealFrom as text
%        str2double(get(hObject,'String')) returns contents of diagRealFrom as a double


% --- Executes during object creation, after setting all properties.
function diagRealFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diagRealFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diagRealTo_Callback(hObject, eventdata, handles)
% hObject    handle to diagRealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diagRealTo as text
%        str2double(get(hObject,'String')) returns contents of diagRealTo as a double


% --- Executes during object creation, after setting all properties.
function diagRealTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diagRealTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diagImagFrom_Callback(hObject, eventdata, handles)
% hObject    handle to diagImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diagImagFrom as text
%        str2double(get(hObject,'String')) returns contents of diagImagFrom as a double


% --- Executes during object creation, after setting all properties.
function diagImagFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diagImagFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diagImagTo_Callback(hObject, eventdata, handles)
% hObject    handle to diagImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diagImagTo as text
%        str2double(get(hObject,'String')) returns contents of diagImagTo as a double


% --- Executes during object creation, after setting all properties.
function diagImagTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diagImagTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epsilonEdit_Callback(hObject, eventdata, handles)
% hObject    handle to epsilonEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsilonEdit as text
%        str2double(get(hObject,'String')) returns contents of epsilonEdit as a double


% --- Executes during object creation, after setting all properties.
function epsilonEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsilonEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deltaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to deltaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltaEdit as text
%        str2double(get(hObject,'String')) returns contents of deltaEdit as a double


% --- Executes during object creation, after setting all properties.
function deltaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxIterEdit_Callback(hObject, eventdata, handles)
% hObject    handle to maxIterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxIterEdit as text
%        str2double(get(hObject,'String')) returns contents of maxIterEdit as a double


% --- Executes during object creation, after setting all properties.
function maxIterEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nEdit_Callback(hObject, eventdata, handles)
% hObject    handle to nEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nEdit as text
%        str2double(get(hObject,'String')) returns contents of nEdit as a double


% --- Executes during object creation, after setting all properties.
function nEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
