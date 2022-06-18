%%%%%%%�Ҷ�ͼ���ֵ�ָ�����
%IΪ����ͼ��
function R=Otsu(I)
    %��������
    T_H=1;
    %��������
    T_L=0;
    %��ֵ�޶�
    th=0.001;
    %��������
    T=0;
    G_max=0;
    G=zeros(10,2);
    while 1
        step=(T_H-T_L)/10;
        for i=1:11
            T_i=T_L+step*(i-1);
            g=ComputeG(I,T_i);
            G(i,:)=[g,T_i];
        end
        G=sortrows(G,1);    
        G_H=G(11,1);              
        if abs(G_H-G_max)<th
            G_max=G_H;
            T=G(11,2);
            break;
        end  
        T_H=max([G(11,2),G(10,2)]);
        T_L=min([G(11,2),G(10,2)]); 
        G_max=G_H;
        T=G(11,2);
    end
    R=I;
    ind1=find(R>=T);
    R(ind1)=1;
    ind0=find(R<T);
    R(ind0)=0;    
end