%par1=guidata(handles_model.win_model);
%guidata(handles_model.win_model,par1);
%s='E:\mathlab\bin\staff.xlsx';
%xlswrite(s,par1.k,'l8','B2');
function Assessmant
H=open('Personnel_assessment_.fig');
% указатели на объекты основного окна integral записываем в структуру handles
handles=guihandles(H);
set(handles.menu_add,'Callback',{@menu_add_Callback,handles})
set(handles.menu_comparison,'Callback',{@menu_comparison_Callback,handles})
set(handles.menu_plots,'Callback',{@menu_plots_Callback,handles})
set(handles.menu_del,'Callback',{@menu_del_Callback,handles})
set(handles.menu_exit,'Callback',{@menu_exit_Callback,handles})
set(handles.menu_model,'Callback',{@menu_model_Callback,handles})
set(handles.menu_rating,'Callback',{@menu_rating_Callback,handles})
set(handles.btn_load,'Callback',{@btn_load_Callback,handles})
set(handles.btn_load_all,'Callback',{@btn_load_all_Callback,handles})

function btn_load_Callback(src,evt,handles)
[FileName, PathName] = uigetfile;
set(handles.edt_file,'String',[PathName,FileName]);

function btn_load_all_Callback(src,evt,handles)
set(handles.menu_staff,'Enable','On');
set(handles.menu_rating,'Enable','On');
set(handles.menu_model,'Enable','On');
set(handles.menu_analysis,'Enable','On');
par.xlfile=get(handles.edt_file,'String');
guidata(handles.win_main,par)

function menu_exit_Callback(src,evt,handles)
delete(handles.win_main)

function menu_del_Callback(src,evt,handles)
par.xlfile=get(handles.edt_file,'String');
guidata(handles.win_main,par)
h=open('delete_staff.fig');
handles_menu_delete=guihandles(h);
set(handles_menu_delete.btn_delete,'Callback',{@btn_delete_staff_Callback,handles,handles_menu_delete})
set(handles_menu_delete.btn_cancel,'Callback',{@btn_cancel_del_Callback,handles,handles_menu_delete})

function btn_delete_staff_Callback(src,evt,handles,handles_menu_delete)
par=guidata(handles.win_main);
s=par.xlfile;
fio=get(handles_menu_delete.edt_fio,'String');
[znach,names]=xlsread(s,'l3');
NumOfRows=size(names,1);
t=0;
for i=1:9
    names1(1,i+1)=names(1,i+1);
end
ii=2;
for i=1:NumOfRows-1
    k=names(i+1,1);
    if ~(strcmp(k,fio))
        names1(ii,1)=k;
        for j=1:9
        znach1(ii-1,j)=znach(i,j);
        end
        ii=ii+1;
    else
        t=1;
    end
end
if t==0
    h = errordlg('Такого сотрудника нет в списке', 'Ошибка');
end
xlswrite(s,names1,'l4');
xlswrite(s,znach1,'l4','B2');
delete(handles_menu_delete.win_delete_staff)

function btn_cancel_del_Callback(src,evt,handles,handles_menu_delete)
delete(handles_menu_delete.win_delete_staff)

function menu_add_Callback(src,evt,handles)
par.xlfile=get(handles.edt_file,'String');
par.typeofmodel=1;
guidata(handles.win_main,par)
h=open('add_personnel.fig');
handles_menu_add=guihandles(h);

