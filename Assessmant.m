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

%%%%%%%%%%%%%%%%%%Работа с добавлением сотрудника%%%%%%%%%%%%%%%%
set(handles_menu_add.btn_add,'Callback',{@btn_add_Callback,handles,handles_menu_add})
set(handles_menu_add.btn_cancel,'Callback',{@btn_cancel_Callback,handles,handles_menu_add})

function btn_cancel_Callback(src,evt,handles,handles_menu_add)
delete(handles_menu_add.win_add)

function btn_add_Callback(src,evt,handles,handles_menu_add)
par=guidata(handles.win_main);
fio=get(handles_menu_add.edt_fio,'String');
k1=str2num(get(handles_menu_add.edt_k1,'String'));
k2=str2num(get(handles_menu_add.edt_k2,'String'));
k3=str2num(get(handles_menu_add.edt_k3,'String'));
k4=str2num(get(handles_menu_add.edt_k4,'String'));
k5=str2num(get(handles_menu_add.edt_k5,'String'));
k6=str2num(get(handles_menu_add.edt_k6,'String'));
k7=str2num(get(handles_menu_add.edt_k7,'String'));
k8=str2num(get(handles_menu_add.edt_k8,'String'));
k9=str2num(get(handles_menu_add.edt_k9,'String'));
s=par.xlfile;
set(handles_menu_add.edt_fio,'String','');
set(handles_menu_add.edt_k1,'String','');
set(handles_menu_add.edt_k2,'String','');
set(handles_menu_add.edt_k3,'String','');
set(handles_menu_add.edt_k4,'String','');
set(handles_menu_add.edt_k5,'String','');
set(handles_menu_add.edt_k6,'String','');
set(handles_menu_add.edt_k7,'String','');
set(handles_menu_add.edt_k8,'String','');
set(handles_menu_add.edt_k9,'String','');
[znach,names]=xlsread(s,'l3');
names=[names;[cellstr(fio) k1 k2 k3 k4 k5 k6 k7 k8 k9]];
xlswrite(s,names,'l3');
xlswrite(s,znach,'l3','B2');

guidata(handles.win_main,par)

%%%%%%%%%%%%%%%%%%Работа с различными моделями%%%%%%%%%%%%%%%%
function menu_model_Callback(src,evt,handles)
par.xlfile=get(handles.edt_file,'String');
if strcmp(par.xlfile,'')
    par.xlfile='E:\mathlab\bin\staff.xlsx';
end
guidata(handles.win_main,par)
h=open('model.fig');
% указатели на объекты окна method записываем в структуру handles_ method
handles_model=guihandles(h);
par1.typeofmodel=1;
par1.kriterii=1;
par1.k=zeros(9,3);
guidata(handles_model.win_model,par1)

set(handles_model.uipanel4,'Title','Должностные обязанности');
set(handles_model.rb_a,'Callback',{@rb_a_Callback,handles,handles_model})
set(handles_model.rb_l,'Callback',{@rb_l_Callback,handles,handles_model})
set(handles_model.rb_s,'Callback',{@rb_s_Callback,handles,handles_model})
set(handles_model.rb_t,'Callback',{@rb_t_Callback,handles,handles_model})
set(handles_model.btn_cancel,'Callback',{@btn_model_cancel_Callback,handles,handles_model})
set(handles_model.btn_ok,'Callback',{@btn_model_ok_Callback,handles,handles_model})
set(handles_model.btn_k1,'Callback',{@btn_k1_Callback,handles,handles_model})
set(handles_model.btn_k2,'Callback',{@btn_k2_Callback,handles,handles_model})
set(handles_model.btn_k3,'Callback',{@btn_k3_Callback,handles,handles_model})
set(handles_model.btn_k4,'Callback',{@btn_k4_Callback,handles,handles_model})
set(handles_model.btn_k5,'Callback',{@btn_k5_Callback,handles,handles_model})
set(handles_model.btn_k6,'Callback',{@btn_k6_Callback,handles,handles_model})
set(handles_model.btn_k7,'Callback',{@btn_k7_Callback,handles,handles_model})
set(handles_model.btn_k8,'Callback',{@btn_k8_Callback,handles,handles_model})
set(handles_model.btn_k9,'Callback',{@btn_k9_Callback,handles,handles_model})

function btn_model_cancel_Callback(src,evt,handles,handles_model)
delete(handles_model.win_model);

function btn_model_ok_Callback(src,evt,handles,handles_model)
par=guidata(handles.win_main);
fio=get(handles_model.edt_fio,'String');
[znach,names]=xlsread(par.xlfile,'l3');
NumOfRows=size(names,1);
for i=1:NumOfRows-1
    k=names(i+1,1);
    if strcmp(k,fio)
        for j=1:9
            s(j)=znach(i,j);
        end
    end
end

function btn_model_ok_Callback(src,evt,handles,handles_model)
par=guidata(handles.win_main);
fio=get(handles_model.edt_fio,'String');
[znach,names]=xlsread(par.xlfile,'l3');
NumOfRows=size(names,1);
for i=1:NumOfRows-1
    k=names(i+1,1);
    if strcmp(k,fio)
        for j=1:9
            s(j)=znach(i,j);
        end
    end
end

w(1)=get(handles_model.popup_w1,'Value');
w(2)=get(handles_model.popup_w2,'Value');
w(3)=get(handles_model.popup_w3,'Value');

all_weight=w(1)+w(2)+w(3);
assessment_after_weight_for_groups=0;

for i=1:3
    par1=guidata(handles_model.win_model);
    sum_weight_for_criterii=par1.k(3*(i-1)+1,1)+par1.k(3*(i-1)+2,1)+par1.k(3*(i-1)+3,1);
    guidata(handles_model.win_model,par1);
    assessment_after_weight(i)=0;
    for j=1:3
        par1=guidata(handles_model.win_model);
        niz=par1.k(3*(i-1)+j,2);
        verh=par1.k(3*(i-1)+j,3);
        model=par1.typeofmodel;
        guidata(handles_model.win_model,par1);
        assessment_for_criterii(handles_model,niz,verh,s(3*(i-1)+j),model,5,1);
         par1=guidata(handles_model.win_model);
        assessment_after_weight(i)= assessment_after_weight(i)+(par1.k(3*(i-1)+j,1)/sum_weight_for_criterii)*par1.assessment;
        guidata(handles_model.win_model,par1);
    end
  for j=1:9
        par1=guidata(handles_model.win_model);
        niz=par1.k(3*(i-1)+j,2);
        verh=par1.k(3*(i-1)+j,3);
        model=par1.typeofmodel;
        guidata(handles_model.win_model,par1);
        assessment_for_criterii(handles_model,niz,verh,s(3*(i-1)+j),model,5,1);
         par1=guidata(handles_model.win_model);
        assessment_after_weight(i)= assessment_after_weight(i)+(par1.k(3*(i-1)+j,1)/sum_weight_for_criterii)*par1.assessment;
        guidata(handles_model.win_model,par1);
    end
    if i==1
        set(handles_model.txt_itog1,'String',assessment_after_weight(i));
        set(handles_model.itog1,'Visible','On');
    elseif i==2
         set(handles_model.txt_itog2,'String',assessment_after_weight(i));
        set(handles_model.itog2,'Visible','On');
        elseif i==3
            set(handles_model.txt_itog3,'String',assessment_after_weight(i));
        set(handles_model.itog3,'Visible','On');
    end
        
assessment_after_weight_for_groups=assessment_after_weight_for_groups+(w(i)/all_weight)*assessment_after_weight(i);    
end
par1=guidata(handles_model.win_model);
set(handles_model.text_answer,'Visible','On');
set(handles_model.text_ans,'String',assessment_after_weight_for_groups);
%set(handles_model.text_ans,'String',all_weight);
guidata(handles_model.win_model,par1)




% Считает оценку сотрудника sotr по критерию, используя данную модель,
% верх, низ
function assessment_for_criterii(handles_model,niz,verh,sotr,model,diap,i)
if i==1
par1=guidata(handles_model.win_model);
elseif i==2
    par1=guidata(handles_model.win_rating);
else 
    par1=guidata(handles_model.win_comparison);
end
switch model
    case 1
if sotr<=niz 
    par1.assessment=0;
elseif sotr>=verh
   par1.assessment=1;
else
    par1.assessment=(sotr-niz)/(verh-niz);
end
    case 2
    b1=2; b2=4; b3=1;
a1=b1/(b1*niz+b2*(verh-niz)+b3*(diap-verh));
a2=b2/(b1*niz+b2*(verh-niz)+b3*(diap-verh));
a3=b3/(b1*niz+b2*(verh-niz)+b3*(diap-verh));
if sotr<=niz
    par1.assessment=sotr*a1;
elseif sotr>=verh
    par1.assessment=niz*a1+(verh-niz)*a2+a3*(diap-verh-diap+sotr);
else
    par1.assessment=niz*a1+(sotr-niz)*a2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if i==1
guidata(handles_model.win_model,par1)
elseif i==2
guidata(handles_model.win_rating,par1)
else
guidata(handles_model.win_comparison,par1) 
end


function rb_a_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.typeofmodel=1;
guidata(handles_model.win_model,par1)
function rb_l_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.typeofmodel=2;
guidata(handles_model.win_model,par1)
function rb_s_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.typeofmodel=3;
guidata(handles_model.win_model,par1)
function rb_t_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.typeofmodel=4;
guidata(handles_model.win_model,par1)

%%%%%%%%%%%%%Работа с заданием критериев в моделях%%%%%%%%%%
function btn_k1_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=1;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Cкорость работы"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})


function btn_k2_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=2;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Качество работы"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

function btn_k3_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=3;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Проф.знания"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

function btn_k4_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=4;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Инициативность"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

function btn_k5_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=5;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Ответственность"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

function btn_k6_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=6;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Пунктуальность"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

function btn_k7_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=7;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Лидерские качества"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

function btn_k8_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=8;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Целеустремленность"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

function btn_k9_Callback(src,evt,handles,handles_model)
par1=guidata(handles_model.win_model);
par1.criterii=9;
guidata(handles_model.win_model,par1)
h=open('criterion.fig');
handles_criteria=guihandles(h);

set(handles_criteria.text_k,'String','Заполните информацию по критерию "Интеллект.потенциал"');
set(handles_criteria.btn_add,'Callback',{@btn_add_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_cancel,'Callback',{@btn_cancel_c_Callback,handles_model,handles_criteria})
set(handles_criteria.btn_plot,'Callback',{@btn_plot_onecriterii_Callback,handles_model,handles_criteria})

%%%%%%%%%%%%%%%%%Окно с информацией о критериях%%%%%%%%%%%%%%%%
function btn_plot_onecriterii_Callback(src,evt,handles_model,handles_criteria)
set(handles_criteria.axes1,'Visible','On');
par1=guidata(handles_model.win_model);
niz=get(handles_criteria.popup_niz,'Value');
verh=get(handles_criteria.popup_verh,'Value');
cla;
diap=5;
if par1.typeofmodel==1 
   x=0:0.1:5;
x(x<=niz)=0;
x((x>niz) & (x<verh))=(x((x>niz) & (x<verh))-niz)/(verh-niz);
x(x>=verh)=1;
elseif par1.typeofmodel==2
    b1=2; b2=4; b3=1;
a1=b1/(b1*niz+b2*(verh-niz)+b3*(5-verh));
a2=b2/(b1*niz+b2*(verh-niz)+b3*(5-verh));
a3=b3/(b1*niz+b2*(verh-niz)+b3*(5-verh));
x=0:0.1:5;
x(x<=niz)=x(x<=niz)*a1;
x((x>niz)&(x<verh))=niz*a1+(x((x>niz) & (x<verh))-niz)*a2;
x(x>=verh)=niz*a1+(verh-niz)*a2+a3*(-verh+x(x>=verh)); 
elseif par1.typeofmodel==3
    h=2/(diap-niz);
    x=0:0.1:diap;
    x(x<=niz)=0;
    x((x>niz)&(x<verh))=h*((x((x>niz) & (x<verh))).^2-niz*niz)/(2*(verh-niz))-h*niz*(x((x>niz) & (x<verh))-niz)/(verh-niz);
    x(x>=verh)=h*(verh-niz)/2+h*((x(x>=verh)).^2-verh*verh)/(2*(verh-diap))-h*diap*(x(x>=verh)-verh)/(verh-diap);
else
   h=2/(diap+(verh-niz));
x=0:0.1:diap;
x(x<=niz)=x(x<=niz).^2*h/(2*niz);
x((x>niz)&(x<verh))=niz*h/2+h*(x((x>niz) & (x<verh))-niz);
x(x>=verh)=h*niz/2+h*(verh-niz)-h*((x(x>=verh)).^2-verh*verh)/(2*(5-verh))-h*verh*verh/(5-verh)+h*verh*x(x>=verh)/(5-verh)+h*(x(x>=verh)-verh);
end
xlim([0 5])
hold on
ylim([0 2])
hold on
plot(0:0.1:5,x,'LineWidth',3,'color','blue')
    
    
    
guidata(handles_model.win_model,par1)



function btn_add_c_Callback(src,evt,handles_model,handles_criteria)
par1=guidata(handles_model.win_model);
weight=get(handles_criteria.popup_weight,'Value');
niz=get(handles_criteria.popup_niz,'Value');
verh=get(handles_criteria.popup_verh,'Value');
weight=weight;
niz=niz;
verh=verh;
i=par1.criterii;
par1.k(i,1)=weight;
par1.k(i,2)=niz;
par1.k(i,3)=verh;
guidata(handles_model.win_model,par1)
switch i
    case 1
        set(handles_model.check_k1,'Value',1)
    case 2
        set(handles_model.check_k2,'Value',1)
    case 3
        set(handles_model.check_k3,'Value',1)
    case 4
        set(handles_model.check_k4,'Value',1)
    case 5
        set(handles_model.check_k5,'Value',1)
    case 6
        set(handles_model.check_k6,'Value',1)
    case 7
        set(handles_model.check_k7,'Value',1)
    case 8
        set(handles_model.check_k8,'Value',1)
    case 9
        set(handles_model.check_k9,'Value',1)
end
delete(handles_criteria.win_criterion);

function btn_cancel_c_Callback(src,evt,handles_model,handles_criteria)
delete(handles_criteria.win_criterion);

function menu_rating_Callback(src,evt,handles)
h=open('rating_of_personnel.fig');
handles_rating=guihandles(h);
par=guidata(handles.win_main);
[znach,names]=xlsread(par.xlfile,'l3');
NumOfRows=size(names,1);
for i=1:NumOfRows-1
  names_of_rows(i)=names(i+1,1);
end
for i=1:9
    names_of_colunms(i)=names(1,i+1);
end
set(handles_rating.tab_of_personnel,'data', znach);
set(handles_rating.tab_of_personnel,'ColumnName',names_of_colunms);
set(handles_rating.tab_of_personnel,'RowName',names_of_rows);
par2.typeofmodel=1;
par2.kriterii=1;
par2.k=zeros(9,3);
par2.krit=zeros(9,2);
par2.rb_for_krit=1;
guidata(handles_rating.win_rating,par2)
set(handles_rating.rb_a,'Callback',{@rb_a_rating_Callback,handles,handles_rating})
set(handles_rating.rb_l,'Callback',{@rb_l_rating_Callback,handles,handles_rating})
set(handles_rating.rb_s,'Callback',{@rb_s_rating_Callback,handles,handles_rating})
set(handles_rating.rb_t,'Callback',{@rb_t_rating_Callback,handles,handles_rating})
set(handles_rating.pb_cancel,'Callback',{@pb_rating_cancel_Callback,handles,handles_rating})
set(handles_rating.pb_count,'Callback',{@pb_rating_count_Callback,handles,handles_rating})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

h=open('rating_of_personnel.fig');
handles_rating=guihandles(h);
par=guidata(handles.win_main);
[znach,names]=xlsread(par.xlfile,'l3');
NumOfRows=size(names,1);
for i=1:NumOfRows-1
  names_of_rows(i)=names(i+1,1);
end
for i=1:9
    names_of_colunms(i)=names(1,i+1);
end
set(handles_rating.tab_of_personnel,'data', znach);
set(handles_rating.tab_of_personnel,'ColumnName',names_of_colunms);
set(handles_rating.tab_of_personnel,'RowName',names_of_rows);
par2.typeofmodel=1;
par2.kriterii=1;
par2.k=zeros(9,3);
par2.krit=zeros(9,2);
par2.rb_for_krit=1;
guidata(handles_rating.win_rating,par2)
set(handles_rating.rb_a,'Callback',{@rb_a_rating_Callback,handles,handles_rating})
set(handles_rating.rb_l,'Callback',{@rb_l_rating_Callback,handles,handles_rating})
set(handles_rating.rb_s,'Callback',{@rb_s_rating_Callback,handles,handles_rating})
set(handles_rating.rb_t,'Callback',{@rb_t_rating_Callback,handles,handles_rating})
set(handles_rating.pb_cancel,'Callback',{@pb_rating_cancel_Callback,handles,handles_rating})
set(handles_rating.pb_count,'Callback',{@pb_rating_count_Callback,handles,handles_rating})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

set(handles_rating.pb_k1,'Callback',{@pb_k1_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k2,'Callback',{@pb_k2_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k3,'Callback',{@pb_k3_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k4,'Callback',{@pb_k4_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k5,'Callback',{@pb_k5_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k6,'Callback',{@pb_k6_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k7,'Callback',{@pb_k7_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k8,'Callback',{@pb_k8_rating_Callback,handles,handles_rating})
set(handles_rating.pb_k9,'Callback',{@pb_k9_rating_Callback,handles,handles_rating})


function rb_a_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.typeofmodel=1;
guidata(handles_rating.win_rating,par2)
function rb_l_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.typeofmodel=2;
guidata(handles_rating.win_rating,par2)
function rb_s_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.typeofmodel=3;
guidata(handles_rating.win_rating,par2)
function rb_t_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.typeofmodel=4;
guidata(handles_rating.win_rating,par2)

function pb_rating_cancel_Callback(src,evt,handles,handles_rating)
delete(handles_rating.win_rating);

function pb_k1_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=1;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_k2_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=2;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_cancel_criterii_rating_Callback(src,evt,handles_rating,handles_criteria_for_rating)
delete(handles_criteria_for_rating.win_criteria_for_rating);
function pb_k3_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=3;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_k4_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=4;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_k5_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=5;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_k6_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=6;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_k7_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=7;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_k8_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=8;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})
function pb_k9_rating_Callback(src,evt,handles,handles_rating)
par2=guidata(handles_rating.win_rating);
par2.criterii=9;
guidata(handles_rating.win_rating,par2)
h=open('criterion_for_rating.fig');
handles_criteria_for_rating=guihandles(h);
set(handles_criteria_for_rating.pb_add_criterion,'Callback',{@pb_add_criterion_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.pb_cancel,'Callback',{@pb_cancel_criterii_rating_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_no,'Callback',{@rb_no_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_niz,'Callback',{@rb_only_niz_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_only_verh,'Callback',{@rb_only_verh_Callback,handles_rating,handles_criteria_for_rating})
set(handles_criteria_for_rating.rb_both,'Callback',{@rb_both_Callback,handles_rating,handles_criteria_for_rating})

function rb_no_Callback(src,evt,handles_rating,handles_criteria_for_rating)
par2=guidata(handles_rating.win_rating);
par2.rb_for_krit=1;
set(handles_criteria_for_rating.popup_krit_niz,'Visible','Off');
set(handles_criteria_for_rating.txt_krit1,'Visible','Off');
set(handles_criteria_for_rating.popup_krit_verh,'Visible','Off');
set(handles_criteria_for_rating.txt_krit2,'Visible','Off');
guidata(handles_rating.win_rating,par2)
function rb_only_niz_Callback(src,evt,handles_rating,handles_criteria_for_rating)
par2=guidata(handles_rating.win_rating);
par2.rb_for_krit=2;
guidata(handles_rating.win_rating,par2)
set(handles_criteria_for_rating.popup_krit_niz,'Visible','On');
set(handles_criteria_for_rating.txt_krit1,'Visible','On');
set(handles_criteria_for_rating.popup_krit_verh,'Visible','Off');
set(handles_criteria_for_rating.txt_krit2,'Visible','Off');
function rb_only_verh_Callback(src,evt,handles_rating,handles_criteria_for_rating)
par2=guidata(handles_rating.win_rating);
par2.rb_for_krit=3;
guidata(handles_rating.win_rating,par2)
set(handles_criteria_for_rating.popup_krit_verh,'Visible','On');
set(handles_criteria_for_rating.txt_krit2,'Visible','On');
set(handles_criteria_for_rating.popup_krit_niz,'Visible','Off');
set(handles_criteria_for_rating.txt_krit1,'Visible','Off');
function rb_both_Callback(src,evt,handles_rating,handles_criteria_for_rating)
par2=guidata(handles_rating.win_rating);
par2.rb_for_krit=4;
guidata(handles_rating.win_rating,par2)
set(handles_criteria_for_rating.popup_krit_verh,'Visible','On');
set(handles_criteria_for_rating.txt_krit2,'Visible','On');
set(handles_criteria_for_rating.popup_krit_niz,'Visible','On');
set(handles_criteria_for_rating.txt_krit1,'Visible','On');
function pb_add_criterion_Callback(src,evt,handles_rating,handles_criteria_for_rating)
par2=guidata(handles_rating.win_rating);
weight=get(handles_criteria_for_rating.popup_weight,'Value');
niz=get(handles_criteria_for_rating.popup_niz,'Value');
verh=get(handles_criteria_for_rating.popup_verh,'Value');
krit_niz=get(handles_criteria_for_rating.popup_krit_niz,'Value');
krit_verh=get(handles_criteria_for_rating.popup_krit_verh,'Value');
i=par2.criterii;
par2.k(i,1)=weight;
par2.k(i,2)=niz;
par2.k(i,3)=verh;
switch par2.rb_for_krit
    case 2
     par2.krit(i,1)=krit_niz;
    case 3
     par2.krit(i,2)=krit_verh;
    case 4 
     par2.krit(i,1)=krit_niz;
     par2.krit(i,2)=krit_verh;
end
guidata(handles_rating.win_rating,par2)
switch i
    case 1
       set(handles_rating.check_k1,'Value',1) 
    case 2
        set(handles_rating.check_k2,'Value',1)
    case 3
        set(handles_rating.check_k3,'Value',1)
    case 4
        set(handles_rating.check_k4,'Value',1)
    case 5
        set(handles_rating.check_k5,'Value',1)
    case 6
       set(handles_rating.check_k6,'Value',1)
    case 7
       set(handles_rating.check_k7,'Value',1)
    case 8
   set(handles_rating.check_k8,'Value',1)
    case 9
   set(handles_rating.check_k9,'Value',1)
end   
delete(handles_criteria_for_rating.win_criteria_for_rating);

function pb_rating_count_Callback(src,evt,handles,handles_rating)
par=guidata(handles.win_main);
[znach,names]=xlsread(par.xlfile,'l3');
%names_of_colunms=names(1,20);
names_of_colunms=cellstr('total');
for i=1:9
    names_of_colunms(i+1)=names(1,i+1);
end
NumOfRows=size(znach,1);
w(1)=get(handles_rating.popup_weight_group1,'Value');
w(2)=get(handles_rating.popup_weight_group2,'Value');
w(3)=get(handles_rating.popup_weight_group3,'Value');
all_weight=w(1)+w(2)+w(2);

par2=guidata(handles_rating.win_rating);
k=1;
for i=1:NumOfRows
    t=0;
    for j=1:9
           if znach(i,j)<par2.krit(j,1)
               t=1;    
           end
         if and(par2.krit(j,2)~=0,znach(i,j)>par2.krit(j,2))
               t=1;
          end
    end
           if t==0
           sotr_name(k)=names(i+1);
               for l=1:9
               sotr_ball(k,l)=znach(i,l);
               end
               k=k+1;
           end
end
vsego_sotr=k-1;
guidata(handles_rating.win_rating,par2);
if vsego_sotr~=0
for k=1:vsego_sotr
    for l=1:9
    s(k,l)=sotr_ball(k,l);
    end
    assessment_after_weight_for_groups=0;
for i=1:3
    par2=guidata(handles_rating.win_rating);
    sum_weight_for_criterii=par2.k(3*(i-1)+1,1)+par2.k(3*(i-1)+2,1)+par2.k(3*(i-1)+3,1);
    guidata(handles_rating.win_rating,par2);
    assessment_after_weight(i)=0;
    for j=1:3
        par2=guidata(handles_rating.win_rating);
        niz=par2.k(3*(i-1)+j,2);
        verh=par2.k(3*(i-1)+j,3);
        model=par2.typeofmodel;
        guidata(handles_rating.win_rating,par2);
        assessment_for_criterii(handles_rating,niz,verh,s(k,3*(i-1)+j),model,5,2);
         par2=guidata(handles_rating.win_rating);
        assessment_after_weight(i)= assessment_after_weight(i)+(par2.k(3*(i-1)+j,1)/sum_weight_for_criterii)*par2.assessment;
        guidata(handles_rating.win_rating,par2);
    end
    assessment_after_weight_for_groups=assessment_after_weight_for_groups+(w(i)/all_weight)*assessment_after_weight(i); 
end  

sotr_ball_for_all(k)=assessment_after_weight_for_groups;
end

for i = 1:vsego_sotr % сортируем
    for j = 1:vsego_sotr-i
        if sotr_ball_for_all(j) < sotr_ball_for_all(j+1)
            x=sotr_ball_for_all(j); sotr_ball_for_all(j)=sotr_ball_for_all(j+1); sotr_ball_for_all(j+1)=x;
            for l=1:9
            y=sotr_ball(j,l); sotr_ball(j,l)=sotr_ball(j+1,l); sotr_ball(j+1,l)=y;
            end
            z=sotr_name(j); sotr_name(j)=sotr_name(j+1); sotr_name(j+1)=z;
        end
    end
end


for i = 1:vsego_sotr % сортируем
    for j = 1:vsego_sotr-i
        if sotr_ball_for_all(j) < sotr_ball_for_all(j+1)
            x=sotr_ball_for_all(j); sotr_ball_for_all(j)=sotr_ball_for_all(j+1); sotr_ball_for_all(j+1)=x;
            for l=1:9
            y=sotr_ball(j,l); sotr_ball(j,l)=sotr_ball(j+1,l); sotr_ball(j+1,l)=y;
            end
            z=sotr_name(j); sotr_name(j)=sotr_name(j+1); sotr_name(j+1)=z;
        end
    end
end
    sotrudnik.name=sotr_name;
    sotrudnik.ball_vsego=sotr_ball_for_all;
    sotrudnik.balli=sotr_ball;
    names_of_rows=sotrudnik.name';

    for i = 1:vsego_sotr
        sotr_data(i,1)=sotr_ball_for_all(i);
        for j=1:9
            sotr_data(i,j+1)=sotr_ball(i,j);
        end
    end
    
set(handles_rating.tab_of_personnel,'data', sotr_data);
set(handles_rating.tab_of_personnel,'ColumnName',names_of_colunms);
set(handles_rating.tab_of_personnel,'RowName',names_of_rows);
set(handles_rating.tab_of_personnel,'Visible', 'On');
else
    h = errordlg('Нет сотрудников, удовлетворяющих условиям', 'Ошибка');
end


%Сравнение 
function menu_comparison_Callback(src,evt,handles)
h=open('win_for_comparison.fig');
% указатели на объекты окна method записываем в структуру handles_ method
handles_comparison=guihandles(h);
par=guidata(handles.win_main);
[znach,names]=xlsread(par.xlfile,'l3');
set(handles_comparison.rb_k1,'String',names(1,2));
set(handles_comparison.rb_k2,'String',names(1,3));
set(handles_comparison.rb_k3,'String',names(1,4));
set(handles_comparison.rb_k4,'String',names(1,5));
set(handles_comparison.rb_k5,'String',names(1,6));
set(handles_comparison.rb_k6,'String',names(1,7));
set(handles_comparison.rb_k7,'String',names(1,8));
set(handles_comparison.rb_k8,'String',names(1,9));
set(handles_comparison.rb_k9,'String',names(1,10));
set(handles_comparison.txt_k1,'String',names(1,2));
set(handles_comparison.txt_k2,'String',names(1,3));
set(handles_comparison.txt_k3,'String',names(1,4));
set(handles_comparison.txt_k4,'String',names(1,5));
set(handles_comparison.txt_k5,'String',names(1,6));
set(handles_comparison.txt_k6,'String',names(1,7));
set(handles_comparison.txt_k7,'String',names(1,8));
set(handles_comparison.txt_k8,'String',names(1,9));
set(handles_comparison.txt_k9,'String',names(1,10));
par3.criterii=1;
par3.k=zeros(9,3);
guidata(handles_comparison.win_comparison,par3);
set(handles_comparison.pb_add_criterii,'Callback',{@pb_comparison_add_criterii_Callback,handles,handles_comparison})
set(handles_comparison.pb_count_and_compare,'Callback',{@pb_count_and_compare_Callback,handles,handles_comparison})

%a=handles_comparison.rb_k2.Value;

%set(handles_comparison.table,'data', a);

%set(handles_comparison.rb_k1,'Callback',{@rb_comparison_k1_Callback,handles,handles_model})

%function rb_comparison_k1_Callback(src,evt,handles,handles_model)
%par3=guidata(handles_comparison.win_comparison);
%par3.criterii=1;
%guidata(handles_comparison.win_comparison,par3)

function pb_comparison_add_criterii_Callback(src,evt,handles,handles_comparison)
par3=guidata(handles_comparison.win_comparison);
weight=get(handles_comparison.popup_weight,'Value');
niz=get(handles_comparison.popup_niz,'Value')-1;
verh=get(handles_comparison.popup_verh,'Value');

a=handles_comparison.rb_k1.Value;
if a==1 
    par3.criterii=1;
end
a=handles_comparison.rb_k2.Value;
if a==1 
    par3.criterii=2;
end
a=handles_comparison.rb_k3.Value;
if a==1 
    par3.criterii=3;
end
a=handles_comparison.rb_k4.Value;
if a==1 
    par3.criterii=4;
end
a=handles_comparison.rb_k5.Value;
if a==1 
    par3.criterii=5;
end
a=handles_comparison.rb_k6.Value;
if a==1 
    par3.criterii=6;
end
a=handles_comparison.rb_k7.Value;
if a==1 
    par3.criterii=7;
end
a=handles_comparison.rb_k8.Value;
if a==1 
    par3.criterii=8;
end
a=handles_comparison.rb_k9.Value;
if a==1 
    par3.criterii=9;
end

 for r=1:4
    assessment_after_weight_for_groups(r)=assessment_after_weight_for_groups(r)+(w(i)/all_weight)*assessment_after_weight(i,r); 
    end 
i=par3.criterii;
switch i
    case 1
       set(handles_comparison.edit_k1_weight,'String',weight);
       set(handles_comparison.edit_k1_niz,'String',niz);
       set(handles_comparison.edit_k1_verh,'String',verh);
    case 2
       set(handles_comparison.edit_k2_weight,'String',weight);
       set(handles_comparison.edit_k2_niz,'String',niz);
       set(handles_comparison.edit_k2_verh,'String',verh);
    case 3
       set(handles_comparison.edit_k3_weight,'String',weight);
       set(handles_comparison.edit_k3_niz,'String',niz);
       set(handles_comparison.edit_k3_verh,'String',verh);
    case 4
       set(handles_comparison.edit_k4_weight,'String',weight);
       set(handles_comparison.edit_k4_niz,'String',niz);
       set(handles_comparison.edit_k4_verh,'String',verh);
    case 5
       set(handles_comparison.edit_k5_weight,'String',weight);
       set(handles_comparison.edit_k5_niz,'String',niz);
       set(handles_comparison.edit_k5_verh,'String',verh);
    case 6
       set(handles_comparison.edit_k6_weight,'String',weight);
       set(handles_comparison.edit_k6_niz,'String',niz);
       set(handles_comparison.edit_k6_verh,'String',verh);
    case 7
       set(handles_comparison.edit_k7_weight,'String',weight);
       set(handles_comparison.edit_k7_niz,'String',niz);
       set(handles_comparison.edit_k7_verh,'String',verh);
    case 8
       set(handles_comparison.edit_k8_weight,'String',weight);
       set(handles_comparison.edit_k8_niz,'String',niz);
       set(handles_comparison.edit_k8_verh,'String',verh);
    case 9
       set(handles_comparison.edit_k9_weight,'String',weight);
       set(handles_comparison.edit_k9_niz,'String',niz);
       set(handles_comparison.edit_k9_verh,'String',verh);
end   
       par3.k(i,1)=weight;
       par3.k(i,2)=niz;
       par3.k(i,3)=verh;
       
guidata(handles_comparison.win_comparison,par3);


function pb_count_and_compare_Callback(src,evt,handles,handles_comparison)
par=guidata(handles.win_main);
[znach,names]=xlsread(par.xlfile,'l3');
%names_of_colunms=names(1,20);
names_of_colunms(1)=cellstr('model_a');
names_of_colunms(2)=cellstr('model_l');
names_of_colunms(3)=cellstr('model_s');
names_of_colunms(4)=cellstr('model_t');
NumOfRows=size(znach,1)+2;
names(NumOfRows,1)=cellstr('Sotr_with_all_max');
names(NumOfRows+1,1)=cellstr('Ideal_sotr');
for i=1:NumOfRows
    names_of_rows(i)=names(i+1,1);
end
w(1)=get(handles_comparison.popup_group1_weight,'Value');
w(2)=get(handles_comparison.popup_group2_weight,'Value');
w(3)=get(handles_comparison.popup_group3_weight,'Value');
all_weight=w(1)+w(2)+w(2);

par2=guidata(handles_comparison.win_comparison);
for r=1:9
znach(NumOfRows-1,r)=par2.k(r,3);
znach(NumOfRows,r)=5;
end
guidata(handles_comparison.win_comparison,par2);


for k=1:NumOfRows
    for l=1:9
    s(k,l)=znach(k,l);
    end
    for r=1:4
    assessment_after_weight_for_groups(r)=0;
    end
for i=1:3
    par2=guidata(handles_comparison.win_comparison);
    sum_weight_for_criterii=par2.k(3*(i-1)+1,1)+par2.k(3*(i-1)+2,1)+par2.k(3*(i-1)+3,1);
    guidata(handles_comparison.win_comparison,par2);
    for r=1:4
    assessment_after_weight(i,r)=0;
    end
    for j=1:3
        par2=guidata(handles_comparison.win_comparison);
        niz=par2.k(3*(i-1)+j,2);
        verh=par2.k(3*(i-1)+j,3);
        guidata(handles_comparison.win_comparison,par2);
        assessment_for_criterii(handles_comparison,niz,verh,s(k,3*(i-1)+j),1,5,3);
        par2=guidata(handles_comparison.win_comparison);
        assessment_after_weight(i,1)= assessment_after_weight(i,1)+(par2.k(3*(i-1)+j,1)/sum_weight_for_criterii)*par2.assessment;
        guidata(handles_comparison.win_comparison,par2);
        
        assessment_for_criterii(handles_comparison,niz,verh,s(k,3*(i-1)+j),2,5,3);
        par2=guidata(handles_comparison.win_comparison);
        assessment_after_weight(i,2)= assessment_after_weight(i,2)+(par2.k(3*(i-1)+j,1)/sum_weight_for_criterii)*par2.assessment;
        guidata(handles_comparison.win_comparison,par2);
        
        assessment_for_criterii(handles_comparison,niz,verh,s(k,3*(i-1)+j),3,5,3);
        par2=guidata(handles_comparison.win_comparison);
        assessment_after_weight(i,3)= assessment_after_weight(i,3)+(par2.k(3*(i-1)+j,1)/sum_weight_for_criterii)*par2.assessment;
        guidata(handles_comparison.win_comparison,par2);
        
        assessment_for_criterii(handles_comparison,niz,verh,s(k,3*(i-1)+j),4,5,3);
        par2=guidata(handles_comparison.win_comparison);
        assessment_after_weight(i,4)= assessment_after_weight(i,4)+(par2.k(3*(i-1)+j,1)/sum_weight_for_criterii)*par2.assessment;
        guidata(handles_comparison.win_comparison,par2);
    end
    for r=1:4
    assessment_after_weight_for_groups(r)=assessment_after_weight_for_groups(r)+(w(i)/all_weight)*assessment_after_weight(i,r); 
    end 
end  
for r=1:4
sotr_ball_for_all(k,r)=assessment_after_weight_for_groups(r);
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
   
set(handles_comparison.table,'data', sotr_ball_for_all);
set(handles_comparison.table,'ColumnName',names_of_colunms);
set(handles_comparison.table,'RowName',names_of_rows);
set(handles_comparison.table,'Visible', 'On');


function menu_plots_Callback(src,evt,handles)
h=open('win_for_plots.fig');
handles_plots=guihandles(h);
%par3.criterii=1;
%guidata(handles_comparison.win_comparison,par3);
set(handles_plots.pb_plot,'Callback',{@pb_plot_Callback,handles,handles_plots})
%set(handles_comparison.pb_count_and_compare,'Callback',{@pb_count_and_compare_Callback,handles,handles_comparison})

function pb_plot_Callback(src,evt,handles,handles_plots)
niz1=get(handles_plots.popup_niz_1,'Value');
niz2=get(handles_plots.popup_niz_2,'Value');
verh1=get(handles_plots.popup_verh_1,'Value');
verh2=get(handles_plots.popup_verh_2,'Value');
weight1=get(handles_plots.popup_weight_1,'Value');
weight2=get(handles_plots.popup_weight_2,'Value');
diap=5; maxkolbal=5;

a=handles_plots.rb_plot_1.Value;

if a==0
f1=figure; 
figure('Name','Графики полезности сотрудника по двум критериям');
subplot(2,2,1);
x1=opredel_a(niz1,verh1,maxkolbal);
y1=opredel_a(niz2,verh2,maxkolbal);
[xx1,yy1]=meshgrid(x1,y1);
z1=znachwithmax(xx1,yy1,verh1,verh2 ,weight1,weight2,maxkolbal);
x1=0:0.1:maxkolbal;
y1=0:0.1:maxkolbal;
[x1,y1]=meshgrid(x1,y1);
%surf(x,y,z);
mesh(x1,y1,z1);
title('График A-модели ');
axis([0 maxkolbal 0 maxkolbal 0 1]);


subplot(2,2,2);
x2=opredel_l(niz1,verh1,1,8,2,maxkolbal);
y2=opredel_l(niz2,verh2,2,9,1,maxkolbal);
[xx2,yy2]=meshgrid(x2,y2);
z2=znachwithmax(xx2,yy2,verh1,verh2 ,weight1,weight2,maxkolbal);
x2=0:0.1:maxkolbal;
y2=0:0.1:maxkolbal;
[x2,y2]=meshgrid(x2,y2);
%surf(x,y,z);
mesh(x2,y2,z2);
title('График L-модели ');
axis([0 maxkolbal 0 maxkolbal 0 1]);


subplot(2,2,3);
x3=opredel_s(niz1,verh1,maxkolbal);
y3=opredel_s(niz2,verh2,maxkolbal);
[xx3,yy3]=meshgrid(x3,y3);
z3=znachwithmax(xx3,yy3,verh1,verh2 ,weight1,weight2,maxkolbal);
x3=0:0.1:maxkolbal;
y3=0:0.1:maxkolbal;
[x3,y3]=meshgrid(x3,y3);
%surf(x,y,z);
mesh(x3,y3,z3);
title('График S-модели ');
axis([0 maxkolbal 0 maxkolbal 0 1]);

subplot(2,2,4);
x4=opredel_t(niz1,verh1,maxkolbal);
y4=opredel_t(niz2,verh2,maxkolbal);
[xx4,yy4]=meshgrid(x4,y4);
z4=znachwithmax(xx4,yy4,verh1,verh2 ,weight1,weight2,maxkolbal);
x4=0:0.1:maxkolbal;
y4=0:0.1:maxkolbal;
[x4,y4]=meshgrid(x4,y4);
%surf(x,y,z);
mesh(x4,y4,z4);
title('График T-модели ');
axis([0 maxkolbal 0 maxkolbal 0 1]);

else
f1=figure; 
figure('Name','Графики линий уровня и линий тока');
subplot(2,2,1);

x1=opredel_a(niz1,verh1,maxkolbal);
y1=opredel_a(niz2,verh2,maxkolbal);
[xx1,yy1]=meshgrid(x1,y1);
z1=xx1*weight1/(weight1+weight2)+yy1*weight2/(weight1+weight2);
x1=0:0.1:maxkolbal;
y1=x1';
[x1,y1]=meshgrid(x1,y1);
[px1,py1]=gradient(z1);
contour(x1,y1,z1)
hold on
%quiver(x,y,px,py,0.8)
hold off
title('Линии уровня/тока A-модели');
streamslice(x1,y1,px1,py1,0.8)
axis([0 maxkolbal 0 maxkolbal]);

subplot(2,2,2);
x1=opredel_l(niz1,verh1,1,8,2,maxkolbal);
y1=opredel_l(niz2,verh2,2,9,1,maxkolbal);
[xx1,yy1]=meshgrid(x1,y1);
z1=xx1*weight1/(weight1+weight2)+yy1*weight2/(weight1+weight2);
x1=0:0.1:maxkolbal;
y1=x1';
[x1,y1]=meshgrid(x1,y1);
[px1,py1]=gradient(z1);
contour(x1,y1,z1)
hold on
%quiver(x,y,px,py,0.8)
hold off
title('Линии уровня/тока L-модели');
streamslice(x1,y1,px1,py1,0.8)
axis([0 maxkolbal 0 maxkolbal]);

subplot(2,2,3);
x1=opredel_s(niz1,verh1,maxkolbal);
y1=opredel_s(niz2,verh2,maxkolbal);
[xx1,yy1]=meshgrid(x1,y1);
z1=xx1*weight1/(weight1+weight2)+yy1*weight2/(weight1+weight2);
x1=0:0.1:maxkolbal;
y1=x1';
[x1,y1]=meshgrid(x1,y1);
[px1,py1]=gradient(z1);
contour(x1,y1,z1)
hold on
%quiver(x,y,px,py,0.8)
hold off
title('Линии уровня/тока S-модели');
streamslice(x1,y1,px1,py1,0.8)
axis([0 maxkolbal 0 maxkolbal]);

subplot(2,2,4);
x1=opredel_t(niz1,verh1,maxkolbal);
y1=opredel_t(niz2,verh2,maxkolbal);
[xx1,yy1]=meshgrid(x1,y1);
z1=xx1*weight1/(weight1+weight2)+yy1*weight2/(weight1+weight2);
x1=0:0.1:maxkolbal;
y1=x1';
[x1,y1]=meshgrid(x1,y1);
[px1,py1]=gradient(z1);
contour(x1,y1,z1)
hold on
%quiver(x,y,px,py,0.8)
hold off
title('Линии уровня/тока T-модели');
streamslice(x1,y1,px1,py1,0.8)
axis([0 maxkolbal 0 maxkolbal]);

end

function x=opredel_a(niz1,verh1,diap)
x=0:0.1:diap;
x(x<=niz1)=0;
x((x>niz1)&(x<verh1))=(x((x>niz1) & (x<verh1))-niz1)/(verh1-niz1);
x(x>=verh1)=1;

function x=opredel_l(niz1,verh1,b1,b2,b3,diap)
a1=b1/(b1*niz1+b2*(verh1-niz1)+b3*(diap-verh1));
a2=b2/(b1*niz1+b2*(verh1-niz1)+b3*(diap-verh1));
a3=b3/(b1*niz1+b2*(verh1-niz1)+b3*(diap-verh1));
x=0:0.1:diap;
x(x<=niz1)=x(x<=niz1)*a1;
x((x>niz1)&(x<verh1))=niz1*a1+(x((x>niz1) & (x<verh1))-niz1)*a2;
x(x>=verh1)=niz1*a1+(verh1-niz1)*a2+a3*(diap-verh1-diap+x(x>=verh1));


function x=opredel_s(niz1,verh1,diap)
h=2/(diap-niz1);
x=0:0.1:diap;
x(x<=niz1)=0;

x((x>niz1)&(x<verh1))=h*((x((x>niz1) & (x<verh1))).^2-niz1*niz1)/(2*(verh1-niz1))-h*niz1*(x((x>niz1) & (x<verh1))-niz1)/(verh1-niz1);
x(x>=verh1)=h*(verh1-niz1)/2+h*((x(x>=verh1)).^2-verh1*verh1)/(2*(verh1-diap))-h*diap*(x(x>=verh1)-verh1)/(verh1-diap);

function x=opredel_t(niz1,verh1,diap)
h=2/(diap+(verh1-niz1));
x=0:0.1:diap;
x(x<=niz1)=x(x<=niz1).^2*h/(2*niz1);
x((x>niz1)&(x<verh1))=niz1*h/2+h*(x((x>niz1) & (x<verh1))-niz1);
x(x>=verh1)=h*niz1/2+h*(verh1-niz1)-h*((x(x>=verh1)).^2-verh1*verh1)/(2*(5-verh1))-h*verh1*verh1/(5-verh1)+h*verh1*x(x>=verh1)/(5-verh1)+h*(x(x>=verh1)-verh1);



function z=znachwithmax(x,y,verh1,verh2,weight1, weight2,diap)
z(1:diap*10+1,1:diap*10+1)=0;
for k=1:diap*10+1
    for j=1:diap*10+1
    z(k,j)=(weight1/(weight1+weight2))*x(k,j)+(weight2/(weight1+weight2))*y(k,j);
    end
end
