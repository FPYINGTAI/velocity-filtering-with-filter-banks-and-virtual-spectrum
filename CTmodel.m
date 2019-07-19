clear all;
close all;
clc;

tic
%%
%CTģ��
% 
SIGMArmse=0;
PDflag=0;
%     for flag=1:100
        
        w=0.2;
        v=3;
        filter_number=2;
        
        theta0=0;
        x0=35;
        y0=10;%��ʼλ��
        SNR=8       ;
        I=10^(SNR/20);%Ŀ�����
        total_frame=8;%�۲���֡��
        x_max=50;
        y_max=50;%�۲��ܷ�Χ
        sigma=0.7;%�������е�sigma
        %%
        %����Ŀ����ʵ����
        for k=1:total_frame
            x(k)=x0+(cos(theta0-w*k)-cos(theta0))/w*v;
            y(k)=y0+(-sin(theta0-w*k)+sin(theta0))/w*v;
            vx(k)=sin(theta0-w*k)*v;
            vy(k)=cos(theta0-w*k)*v;
        end%Ŀ����ʵ����
        
        %%
        %����Ŀ��۲�ģ��
        for k=1:total_frame
            for i=1:x_max
                for j=1:y_max
                    z(i,j,k)=0;
                end
            end
            
        end%�����۲�ģ�ͣ��״�۲�ʱ����z��kΪʱ��֡����ijΪ�ռ�λ��
        %%
        %���ɵ���ɢĿ��
        for k=1:total_frame
            for i=1:x_max
                for j=1:y_max
                    virtual_target(i,j,k)=I*exp(-((x(k)-i)^2+(y(k)-j)^2)/(2*sigma^2));
                end
            end%���ɵ���ɢĿ��
            z(:,:,k)=virtual_target(:,:,k)+normrnd(0,1,x_max,y_max);%���Ͼ�ֵΪ0,����Ϊ1�ĸ�˹������
            %z(:,:,k)=virtual_target(:,:,k)+ones(x_max,y_max);
        end%��Ŀ����Ϣ�ƶ����۲����
        
        figure(1)
        plot(y,x,'*');
        axis([0 50 0 50]);
        xlabel('��Ԫ����/��');
        ylabel('��Ԫ����/��');
%         title('��һ�ǻ���Ŀ��CT�켣');
        figure(2)
        axis([0 50 0 50]);
        surf(z(:,:,total_frame));
        xlabel('��Ԫ����/��');
        ylabel('��Ԫ����/��');
        zlabel('�ز���ֵ/��λ1')
%         title('ĩ֡Ŀ��ز���������');
        %%
        %w�˲�����
        w_filter=w;
        w_filter_max=w-0.02*filter_number:0.02:w+0.02*filter_number;
        v_filter_max=v-0.2*filter_number:0.2:v+0.2*filter_number;
        for w_filter10=1:length(w_filter_max)
            w_filter=w_filter_max(w_filter10);
            %v�˲����飨�����һ��ͼ�ѵõ�����ʼx0,y0��֪,w,theta0��֪,vδ֪����ôvx,vkҲ��δ֪�ģ�
            for v_filter10=1:length(v_filter_max)
                v_filter=v_filter_max(v_filter10);%������֪v�ķ�ΧΪ��0.5,1.5��
                for k=1:total_frame
                    %             x_v_filter(k)=x0+(cos(theta0-w*k)-cos(theta0))/w*v_filter;
                    %             y_v_filter(k)=y0+(-sin(theta0-w*k)+sin(theta0))/w*v_filter;
                    vx_v_filter(k)=sin(theta0-w_filter*k)*v_filter;
                    vy_v_filter(k)=cos(theta0-w_filter*k)*v_filter;
                end%ÿ��vx_filter��Ŀ����ܺ���
                
                %���������һ֡
                output_matrix(:,:,w_filter10,v_filter10)=jilei(w_filter,z,total_frame,x_max,y_max,vx_v_filter,vy_v_filter);
                %        output_matrix(:,:,w_filter10,v_filter10)=jilei_virtual_spectrum(w_filter,z,total_frame,x_max,y_max,vx_v_filter,vy_v_filter,sigma);
                output_max(w_filter10,v_filter10)=max(max(output_matrix(:,:,w_filter10,v_filter10)));
            end
        end
        
        %%
        %Ѱ�����v�˲�������v�µ�Ŀ��λ��
        output_matrix_max=max(max(output_max));
        for i=1:x_max
            for j=1:y_max
                for w_filter=1:length(w_filter_max)
                    for v_filter=1:length(v_filter_max)
                        if output_matrix(i,j,w_filter,v_filter)==output_matrix_max
                            target=[i,j,w_filter,v_filter];
                        end
                    end
                end
            end
        end
        
%%        
%         �������ۺ��ͼ
%        
        figure(3)
        surf(output_matrix(:,:,3,3));
%          title('����֡������ĩ֡�ز�');
        xlabel('��Ԫ����/��');
        ylabel('��Ԫ����/��');
        zlabel('�ز���ֵ/��λ1')
        

        
       
        if abs(target(1)-x(total_frame))<=2&&abs(target(2)-y(total_frame))
            PDflag=PDflag+1;
            SIGMArmse=(target(1)-x(total_frame))^2+(target(2)-y(total_frame))^2+SIGMArmse;
        end
        
        

    
%    end
% PD=PDflag/flag;
% RMSE=sqrt(SIGMArmse/2/PDflag);
% ex=0;
% ex2=0;
% for i=10:44
%     for y=1:23
%         ex=output_matrix(i,j,3,3)+ex;
%         ex2=output_matrix(i,j,3,3)^2+ex2;
%     end
% end
% for i=15:25
%     for y=4:14
%         ex=ex-output_matrix(i,j,3,3);
%         ex2=ex2-output_matrix(i,j,3,3)^2;
%     end
% end

toc

