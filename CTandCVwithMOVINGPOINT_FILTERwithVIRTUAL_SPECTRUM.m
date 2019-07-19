clear all;
close all;
clc;

tic



    SIGMArmse=0;
    PDflag=0;
%     for flag=1:100
        
        
        v_cv=5;
        w=0.5;
        v=v_cv;
        filter_number_w=2;
        filter_number_v=2;
        
        theta0=0;
        x0=50;
        y0=20;%��ʼλ��
        SNR=6;     
        I=10^(SNR/20);%Ŀ�����
        total_frame_cv=4;%�۲���֡��/2;
%         total_frame_cv=total_frame/2;%cvģ����֡��
        total_frame=total_frame_cv*2;
        x_max=80;
        y_max=80;%�۲��ܷ�Χ
        sigma=0.7;%�������е�sigma
        %%
        %����Ŀ����ʵ����
        for k=1:total_frame_cv
            x(k)=x0+v_cv*sin(theta0)*k;
            y(k)=y0+v_cv*cos(theta0)*k;
            
        end
        for k=total_frame_cv+1:total_frame
            x(k)=x(total_frame_cv)+(cos(theta0-w*(k-total_frame_cv))-cos(theta0))/w*v;
            y(k)=y(total_frame_cv)+(-sin(theta0-w*(k-total_frame_cv))+sin(theta0))/w*v;
            vx(k)=sin(theta0-w*(k-total_frame_cv))*v;
            vy(k)=cos(theta0-w*(k-total_frame_cv))*v;
        end%Ŀ����ʵ����
        
        %%
        %         %����Ŀ��۲�ģ��
        %         for k=1:total_frame
        %             for i=1:x_max
        %                 for j=1:y_max
        %                     z(i,j,k)=0;
        %                 end
        %             end
        %
        %         end%�����۲�ģ�ͣ��״�۲�ʱ����z��kΪʱ��֡����ijΪ�ռ�λ��
        %%
        %���ɵ���ɢĿ��
        for k=1:total_frame
            for i=1:x_max
                for j=1:y_max
                    virtual_target(i,j,k)=I*exp(-((x(k)-i)^2+(y(k)-j)^2)/(2*sigma^2));
                end
            end%���ɵ���ɢĿ��
            z(:,:,k)=virtual_target(:,:,k)+normrnd(0,1,x_max,y_max);%���Ͼ�ֵΪ0,����Ϊ1�ĸ�˹������
%                           z(:,:,k)=virtual_target(:,:,k)+ones(x_max,y_max);
        end%��Ŀ����Ϣ�ƶ����۲����
        
                figure(1)
                plot(y,x,'*');
                axis([0 x_max 0 y_max]);
                xlabel('��Ԫ����/��');
                ylabel('��Ԫ����/��');
%                 title('��һ�ǻ���Ŀ��CT�켣');
                figure(2)
                axis([0 x_max 0 y_max]);
                surf(z(:,:,total_frame));
                xlabel('��Ԫ����/��');
                ylabel('��Ԫ����/��');
                zlabel('�ز���ֵ/��λ1');
        %         title('ĩ֡Ŀ��ز���������');
        
        %%
        
        %Ѱ�һ�����
        for moving_point_filter=1:total_frame
            % moving_point_filter=4;
            %CV�˲�����
            
            
            %     v_cv_filter_max=v_cv-0.2*filter_number:0.2:v_cv+0.2*filter_number;
            %     %v�˲����飨�����һ��ͼ�ѵõ�����ʼx0,y0��֪,theta0��֪,vδ֪����ôvx,vkҲ��δ֪�ģ�
            %     for v_cv_filter10=1:length(v_cv_filter_max)
            %         v_cv_filter=v_cv_filter_max(v_cv_filter10);%������֪v�ķ�ΧΪ��0.5,1.5��
            
            
            %���������һ֡
            %         output_matrix_cv(:,:,v_cv_filter10,moving_point_filter)=jilei_cv(z,moving_point_filter,theta0,x0,y0,x_max,y_max,v_cv_filter);
            %                     output_matrix(:,:,w_filter10,v_filter10)=jilei_virtual_spectrum(w_filter,z,total_frame,x_max,y_max,vx_v_filter,vy_v_filter,sigma);
            %             output_max_cv(v_cv_filter10)=max(max(output_matrix_cv(:,:,v_cv_filter10)));
            %         end
            
            %%
            %CT�˲�����
            %w�˲�����
            w_filter=w;
            w_filter_max=w-0.02*filter_number_w:0.02:w+0.02*filter_number_w;
            v_filter_max=v-0.2*filter_number_v:0.2:v+0.2*filter_number_v;
            for w_filter10=1:length(w_filter_max)
                w_filter=w_filter_max(w_filter10);
                %v�˲����飨�����һ��ͼ�ѵõ�����ʼx0,y0��֪,w,theta0��֪,vδ֪����ôvx,vkҲ��δ֪�ģ�
                for v_filter10=1:length(v_filter_max)
                    v_filter=v_filter_max(v_filter10);%������֪v�ķ�ΧΪ��0.5,1.5��
                    %CV���������һ֡
%                     output_matrix_cv(:,:,v_filter10,moving_point_filter)=jilei_cv(z,moving_point_filter,theta0,x0,y0,x_max,y_max,v_filter);
                     output_matrix_cv(:,:,v_filter10,moving_point_filter)=jilei_cv_vs(z,moving_point_filter,theta0,x0,y0,x_max,y_max,v_filter,sigma);
                    for k=moving_point_filter:total_frame
                        %             x_v_filter(k)=x0+(cos(theta0-w*k)-cos(theta0))/w*v_filter;
                        %             y_v_filter(k)=y0+(-sin(theta0-w*k)+sin(theta0))/w*v_filter;
                        vx_v_filter(k)=sin(theta0-w_filter*(k-moving_point_filter))*v_filter;
                        vy_v_filter(k)=cos(theta0-w_filter*(k-moving_point_filter))*v_filter;
                    end%ÿ��vx_filter��Ŀ����ܺ���
                    
                    %ct���������һ֡
%                     output_matrix_ct(:,:,w_filter10,v_filter10,moving_point_filter)=jilei_ct(w_filter,z,total_frame,moving_point_filter,x_max,y_max,vx_v_filter,vy_v_filter);
                           output_matrix_ct(:,:,w_filter10,v_filter10,moving_point_filter)=jilei_ct_vs(w_filter,z,total_frame,moving_point_filter,x_max,y_max,vx_v_filter,vy_v_filter,sigma);
                    
                    %%
                    %���۵�1�����ݻ��������۵�2
                   output_matrix(:,:,w_filter10,v_filter10,moving_point_filter)=jilei_movingpoint_1_2(w_filter,z,output_matrix_cv,output_matrix_ct,total_frame,moving_point_filter,x_max,y_max,vx_v_filter,vy_v_filter,w_filter10,v_filter10);
                end
            end
            %     end
        end
        %  output_max(w_filter10,v_filter10,v_cv_filter10,moving_point_filter)=(max(max(output_matrix(:,:,w_filter10,v_filter10,v_cv_filter10,moving_point_filter))));
        %  output_max_find34(v_cv_filter10,moving_point_filter)=max(max(output_max(:,:,v_cv_filter10,moving_point_filter)));
        
        % %%
        % %Ѱ����ֵ

        % output_matrix_max=0;
        %         for i=1:x_max
        %             for j=1:y_max
        %                 for moving_point_filter=1:total_frame
        %
        %                         for w_filter=1:length(w_filter_max)
        %                             for v_filter=1:length(v_filter_max)
        %                                 if output_matrix(i,j,w_filter,v_filter,moving_point_filter)>output_matrix_max
        %                                    output_matrix_max=output_matrix(i,j,w_filter,v_filter,moving_point_filter);
        %                                 end
        %                             end
        %                         end
        %
        %                 end
        %             end
        %         end
        %
        % %%
        %%
        output_matrix_max=max(max(max(max(max(output_matrix)))));
                %Ѱ�����v�˲�������v�µ�Ŀ��λ��
        for i=1:x_max
            for j=1:y_max
                for moving_point_filter=1:total_frame
                    
                    for w_filter=1:length(w_filter_max)
                        for v_filter=1:length(v_filter_max)
                            if output_matrix(i,j,w_filter,v_filter,moving_point_filter)==output_matrix_max
                                target=[i,j,w_filter,v_filter,moving_point_filter];
                            end
                        end
                    end
                    
                end
            end
        end
        
        
        if abs(target(1)-x(total_frame))<=2&&abs(target(2)-y(total_frame))
            PDflag=PDflag+1;
            SIGMArmse=(target(1)-x(total_frame))^2+(target(2)-y(total_frame))^2+SIGMArmse;
        end
        
        
        
        
%     end
%     PD=PDflag/flag;
%     RMSE=sqrt(SIGMArmse/2/PDflag);

ex=0;
ex2=0;
for i=28:73
    for y=7:60
        ex=output_matrix(i,j,target(3),target(4),target(5))+ex;
        ex2=output_matrix(i,j,target(3),target(4),target(5))^2+ex2;
    end
end
for i=45:54
    for y=30:42
        ex=ex-output_matrix(i,j,target(3),target(4),target(5));
        ex2=ex2-output_matrix(i,j,target(3),target(4),target(5))^2;
    end
end
%%        
%         �������ۺ��ͼ
       
        figure
        surf(output_matrix(:,:,target(3),target(4),target(5)));
 xlabel('��Ԫ����/��');
                ylabel('��Ԫ����/��');
                zlabel('�ز���ֵ/��λ1');
% 
toc

