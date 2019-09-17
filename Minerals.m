%Início%
clear all

%Carregamento dos dados%
load Planilha.txt

%Identificação do tipo de mineral a ter seus dados processados%
s = input('Escolha o mineral constante no arquivo 1-piroxênio e 2-hornblenda:');

%Designação do limite de processamento dos dados%
Planilha = Planilha.';
[lim,lim2] = size(Planilha);%Número de linhas e colunas para usar em loops%

%Reorganização da tabela%
if s==1 %Cálculo de piroxênios%
    Planilha(1,:)=(Planilha(1,:)./60.0843);%Si%
    Planilha(2,:)=(Planilha(2,:)./79.8988);%Ti%
    Planilha(3,:)=((Planilha(3,:).*2)./101.9613);%Al%
    Planilha(4,:)=((Planilha(4,:).*2)./151.9902);%Cr%
    Planilha(5,:)=(Planilha(5,:)./71.8464);%Fe%
    Planilha(6,:)=(Planilha(6,:)./70.9374);%Mn%
    Planilha(7,:)=(Planilha(7,:)./40.3044);%Mg%
    Planilha(8,:)=(Planilha(8,:)./56.0794);%Ca%
    Planilha(9,:)=((Planilha(9,:).*2)./61.97894);%Na%
    S=sum(Planilha);
    for i=1:lim2
        Planilha(:,i)=((Planilha(:,i).*4)./S(1,i));
    end
    %Gráfico do Cromo%
    Planilha(10,:)=[1:lim2];
    figure
    plot(Planilha(10,:),Planilha(4,:),'o')
    xlabel('Análise')
    ylabel('Cr(%)')
    %Proporções das moléculas e gráfico de classificação dos piroxênios%
    for i=1:lim2
        X(1,i)=((100/(Planilha(8,i)+Planilha(5,i)+Planilha(7,i)))*(Planilha(5,i)+(Planilha(8,i)/2)));
        Y(1,i)=((50*Planilha(8,i))*sqrt(3))/(Planilha(8,i)+Planilha(5,i)+Planilha(7,i));
    end
      
    load Coordenadasdodiagrama.txt
    BordasX(:,1)=(Coordenadasdodiagrama(:,2)+(Coordenadasdodiagrama(:,3))/2);
    BordasY(:,1)=((Coordenadasdodiagrama(:,3)*sqrt(3))/2);
    figure
    plot(X,Y,'o',BordasX(1:4,1),BordasY(1:4,1),'k',BordasX(5:6,1),BordasY(5:6,1),'k',BordasX(7:8,1),BordasY(7:8,1),'k',BordasX(9:10,1),BordasY(9:10,1),'k',BordasX(11:12,1),BordasY(11:12,1),'k',BordasX(13:14,1),BordasY(13:14,1),'k')%Falta plotar o resto!!!%
    axis([0,100,0,50])
    str={'diopsidio','hedembergita','augita','pigeonita','enstatita','ferrossilita'};
    text([28 55 45 44 25 65],[41 41 30 10 2.5 2.5],str)
    save Resultadopiroxenios.txt Planilha -ascii
    
elseif s==2 %Cálculo de anfibólios%
    Planilha(1,:)=(Planilha(1,:)./60.0843);%Si%
    Planilha(2,:)=(Planilha(2,:)./79.8988);%Ti%
    Planilha(3,:)=(Planilha(3,:)./101.9613);%Al%
    Planilha(4,:)=(Planilha(4,:)./151.9902);%Cr%
    Planilha(5,:)=(Planilha(5,:)./71.8464);%Fe%
    Planilha(6,:)=(Planilha(6,:)./70.9374);%Mn%
    Planilha(7,:)=(Planilha(7,:)./40.3044);%Mg%
    Planilha(8,:)=(Planilha(8,:)./56.0794);%Ca%
    Planilha(9,:)=(Planilha(9,:)./61.97894);%Na%
    Planilha(10,:)=(Planilha(10,:)./94.196);%K%
    %Cálculo da proporção de óxidos%
    Propoxidos(1,:)=(Planilha(1,:).*2);%Si%
    Propoxidos(2,:)=(Planilha(2,:).*2);%Ti%
    Propoxidos(3,:)=(Planilha(3,:).*3);%Al%
    Propoxidos(4,:)=(Planilha(4,:).*3);%Cr%
    Propoxidos(5,:)=Planilha(5,:);%Fe%
    Propoxidos(6,:)=Planilha(6,:);%Mn%
    Propoxidos(7,:)=Planilha(7,:);%Mg%
    Propoxidos(8,:)=Planilha(8,:);%Ca%
    Propoxidos(9,:)=Planilha(9,:);%Na%
    Propoxidos(10,:)=Planilha(10,:);%K%
    S=sum(Propoxidos);
    
    Cations(1,:)=((Planilha(1,:).*23)./S(1,:));%Si%
    Cations(2,:)=((Planilha(2,:).*23)./S(1,:));%Ti%
    Cations(3,:)=(((Planilha(3,:).*23).*2)./S(1,:));%Al%
    Cations(4,:)=(((Planilha(4,:).*23).*2)./S(1,:));%Cr%
    Cations(5,:)=((Planilha(5,:).*23)./S(1,:));%Fe%
    Cations(6,:)=((Planilha(6,:).*23)./S(1,:));%Mn%
    Cations(7,:)=((Planilha(7,:).*23)./S(1,:));%Mg%
    Cations(8,:)=((Planilha(8,:).*23)./S(1,:));%Ca%
    Cations(9,:)=(((Planilha(9,:).*23).*2)./S(1,:));%Na%
    Cations(10,:)=(((Planilha(10,:).*23).*2)./S(1,:));%K%
    %Fatores de correção do balanço de cargar para determinar a quantidade de Fe3+%
    S2(1,:)=sum(Cations(1:8,:));
    S1(1,:)=sum(Cations(1:7,:));

    for i=1:lim2
        Ca(:,i)=((Cations(:,i).*15)./S2(1,i));
        Mn(:,i)=((Cations(:,i).*13)./S1(1,i));
        
        if Mn(8,i)<1.5
            Cargas(1,i)=(4.*Ca(1,i))+(4.*Ca(2,i))+(3.*Ca(3,i))+(3.*Ca(4,i))+(2.*Ca(5,i))+(2.*Ca(6,i))+(2.*Ca(7,i))+(2.*Ca(8,i))+(Ca(9,i))+(Ca(10,i));
        else
            Cargas(1,i)=(4.*Mn(1,i))+(4.*Mn(2,i))+(3.*Mn(3,i))+(3.*Mn(4,i))+(2.*Mn(5,i))+(2.*Mn(6,i))+(2.*Mn(7,i))+(2.*Mn(8,i))+(Mn(9,i))+(Mn(10,i));
        end
        
        if sum(Mn(1:3,i))<8%Cátions a serem distribuídos nos sítios%
            Cationsd(:,i)=Ca(:,i);
        else
            Cationsd(:,i)=Mn(:,i);
        end
        
        if Cargas(1,i)<=46%Determinação do Fe3+%
            Fe3(1,i)=(46-Cargas(1,i));
        else
            Fe3(1,i)=0;
        end
    end
    M=vertcat(Cationsd,Fe3);
    for i=1:lim2%Alterar. Correção do Fe2+ após cálculo do Fe3+, pois M será usado para distribuir os cátions em seus respectivos sítios%
        if sum(Mn(1:3,i))<8
            M(5,i)=Ca(5,i)-M(11,i);
        else
            M(5,i)=Mn(5,i)-M(11,i);
        end
    end
%Distribuição dos cátions%
%Sítio T%
    Cationsdefinitivos(1,:)=M(1,:);%Si%
    for i=1:lim2
        if 8-Cationsdefinitivos(1,i)<M(3,i)%AlIV%
            Cationsdefinitivos(2,i)=8-M(1,i);
            Cationsdefinitivos(3,i)=0;
        else
            Cationsdefinitivos(2,i)=M(3,i);
            Cationsdefinitivos(3,i)=(8-Cationsdefinitivos(1,i))-M(3,i);%TiIV se houver%
        end
    
%Sítio C%
        Cationsdefinitivos(4,i)=M(3,i)-Cationsdefinitivos(2,i);%AlVI%
        Cationsdefinitivos(5,i)=M(2,i)-Cationsdefinitivos(3,i);%TiVI%
        Cationsdefinitivos(6,i)=M(11,i);%Fe3+%
        Cationsdefinitivos(7,i)=M(4,i);%Cr%
        if (((5-Cationsdefinitivos(4,i))-Cationsdefinitivos(5,i))-Cationsdefinitivos(6,i))-Cationsdefinitivos(7,i)<M(7,i)%Condicional do Mg abarcando Fe2+ e Mn%
            Cationsdefinitivos(8,i)=(((5-Cationsdefinitivos(4,i))-Cationsdefinitivos(5,i))-Cationsdefinitivos(6,i))-Cationsdefinitivos(7,i);
            Cationsdefinitivos(9,i)=0;
            Cationsdefinitivos(10,i)=0;
        else
            Cationsdefinitivos(8,i)=M(7,i);
            if ((((5-Cationsdefinitivos(4,i))-Cationsdefinitivos(5,i))-Cationsdefinitivos(6,i))-Cationsdefinitivos(7,i))-M(7,i)<M(5,i)%Condicional do Fe2+ englobando o Mn%                  
                Cationsdefinitivos(9,i)=((((5-Cationsdefinitivos(4,i))-Cationsdefinitivos(5,i))-Cationsdefinitivos(6,i))-Cationsdefinitivos(7,i))-M(7,i);
                Cationsdefinitivos(10,i)=0;
            else
                Cationsdefinitivos(9,i)=M(5,i);
                if (((((5-Cationsdefinitivos(4,i))-Cationsdefinitivos(5,i))-Cationsdefinitivos(6,i))-Cationsdefinitivos(7,i))-M(7,i))-M(5,i)<M(6,i)%Condicional do Mn%
                    Cationsdefinitivos(10,i)=(((((5-Cationsdefinitivos(4,i))-Cationsdefinitivos(5,i))-Cationsdefinitivos(6,i))-Cationsdefinitivos(7,i))-M(7,i))-M(5,i);
                else
                    Cationsdefinitivos(10,i)=M(6,i);
                end
            end
        end
    
%Sítio B%
        Cationsdefinitivos(11,i)=M(7,i)-Cationsdefinitivos(8,i);%Mg%
        Cationsdefinitivos(12,i)=M(5,i)-Cationsdefinitivos(9,i);%Fe2+%
        Cationsdefinitivos(13,i)=M(6,i)-Cationsdefinitivos(10,i);%Mn%
        Cationsdefinitivos(14,i)=M(8,i);%Ca%
        if ((((2-Cationsdefinitivos(11,i))-Cationsdefinitivos(12,i))-Cationsdefinitivos(13,i))-Cationsdefinitivos(14,i))<M(9,i)%Condicional do Na%
            Cationsdefinitivos(15,i)=(((2-Cationsdefinitivos(11,i))-Cationsdefinitivos(12,i))-Cationsdefinitivos(13,i))-Cationsdefinitivos(14,i);
        else
            Cationsdefinitivos(15,i)=M(9,i);
        end
    
%Sítio A%
        Cationsdefinitivos(16,i)=M(9,i)-Cationsdefinitivos(15,i);%Na%
        Cationsdefinitivos(17,i)=M(10,i);%K%
    end
    
%Cálculo dos parâmetros%
    for i=1:lim2
        Parametros(1,i)=Cationsdefinitivos(1,i)+(Cationsdefinitivos(2,i)./15)-(2.*Cationsdefinitivos(3,i))-(Cationsdefinitivos(4,i)./2)-(Cationsdefinitivos(5,i)./1.8)+(Cationsdefinitivos(6,i)./9)+(M(5,i)./3.3)+(M(7,i)./26)+(Cationsdefinitivos(14,i)./5)+(Cationsdefinitivos(15,i)./1.3)+(Cationsdefinitivos(16,i)./15)+((1-Cationsdefinitivos(16,i)-Cationsdefinitivos(17,i))./2.3);%Si*%
        Parametros(2,i)=M(7,i)+(Cationsdefinitivos(1,i)./47)-(Cationsdefinitivos(4,i)./9)-(1.3.*Cationsdefinitivos(5,i))+(Cationsdefinitivos(6,i)./3.7)+(M(5,i)./5.2)-(Cationsdefinitivos(14,i)./20)-(Cationsdefinitivos(16,i)./2.8)+((1-Cationsdefinitivos(16,i)-Cationsdefinitivos(17,i))./9.5);%Mg*%
        Parametros(3,i)=Cationsdefinitivos(2,i)+Cationsdefinitivos(4,i);%AlT%
        Parametros(4,i)=((-151.487).*Parametros(1,i))+2041;%T%
        Parametros(5,i)=(1.644.*Parametros(2,i))-4.01;%NNO%
        Parametros(6,i)=19.209.*exp(1.438.*Parametros(3,i));%P%
        Parametros(7,i)=((-25018.7./(Parametros(4,i)+273.15))+12.981+((0.046.*((10.*Parametros(6,i)-1)))./(Parametros(4,i)+273.15))-(0.5117.*log(Parametros(4,i)+273.15))+Parametros(5,i));%fO2%
    end

%Plotagem dos gráficos respectivos%
    load Graficoanfibolios.txt;
    x=linspace(700,1100,100);%TvslogfO2%
    y1=16.134.*log(x)-121.68;
    y2=16.134.*log(x)-119.68;
    figure
    plot(Parametros(4,:),Parametros(7,:),'o',x,y1,'k',x,y2,'k')
    axis([700,1100,-14,-8])
    str={'NNO','NNO+2'};
    text([850 760],[-13 -11],str)
    xlabel('T(ºC)')
    ylabel('logfO2')

    if Cationsdefinitivos(16,1)+Cationsdefinitivos(17,1)>=0.5
        figure
        plot(Cationsdefinitivos(1,:),(M(7,:)./(M(7,:)+M(5,:))),'o',Graficoanfibolios(1:2,1),Graficoanfibolios(1:2,2),'k',Graficoanfibolios(3:4,1),Graficoanfibolios(3:4,2),'k',Graficoanfibolios(5:6,1),Graficoanfibolios(5:6,2),'k')
        axis([4.5,7.5,0.0,1.0])
        str={'edenita','ferro-edenita',{'pargasita(AlVI>=Fe3+)','pargasita(AlVI<Fe3+)','kaersutita(Ti>=0.5)'},{'ferropargasita(AlVI>=Fe3+)','hastingsita(AlVI<Fe3+)','ferrokaersutita(Ti>=0.5)'},'magnesiosadanagaita','sadanagaita'};
        text([7.0 7.0 6.0 6.0 5.0 5.0],[0.75 0.25 0.75 0.25 0.75 0.25],str)
        xlabel('Si')
        ylabel('Mg/Mg+Fe2+')
    else
        figure
        plot(Cationsdefinitivos(1,:),(M(7,:)./(M(7,:)+M(5,:))),'o',Graficoanfibolios(7:8,1),Graficoanfibolios(7:8,2),'k',Graficoanfibolios(9:10,1),Graficoanfibolios(9:10,2),'k',Graficoanfibolios(11:12,1),Graficoanfibolios(11:12,2),'k',Graficoanfibolios(13:14,1),Graficoanfibolios(13:14,2),'k')
        axis([5.5,8.0,0.0,1.0])
        str={'actinolita','ferro-actinolita','magnesiohornblenda','ferrohornblenda','tschemarquita','ferrotschemarquita','tremolita'};
        text([7.6 7.52 6.75 6.75 5.75 5.75 7.6],[0.7 0.25 0.75 0.25 0.75 0.25 0.95],str)
        xlabel('Si')
        ylabel('Mg/Mg+Fe2+')
    end

Saida=vertcat(Cationsdefinitivos,Parametros);
%Arquivo de saída%
save Resultadoanfibolios.txt Saida -ascii
end

%Fim%
