function [ output_matrix ] = jilei_movingpoint_1_2(w,z,output_matrix_cv,output_matrix_ct,total_frame,total_frame_cv,x_max,y_max,vx,vy,w_filter10,v_filter10)
%jilei_movingpoint_1_2 积累点1的数据积累至积累点2
transition_matrix=[1     sin(w)/w            0      (cos(w)-1)/w;
                   0     cos(w)              0       -sin(w);
                   0     -(cos(w)-1)/w       1       sin(w)/w;
                   0     sin(w)              0       cos(w)];%%transition matrix转移矩阵F
ii=0;jj=0;zz=z;
output_matrix=output_matrix_ct(:,:,w_filter10,v_filter10,total_frame_cv);
% output_matrix=zeros(x_max,y_max);
k=total_frame_cv;
for i=1:x_max
    for j=1:y_max
        f0=(transition_matrix^(total_frame-k)*[i;vx(k);j;vy(k)])';
        ii=round(f0(1));jj=round(f0(3));
        if ii<=x_max&&jj<=y_max&&ii>=1&&jj>=1
            output_matrix(ii,jj)=output_matrix(ii,jj)+output_matrix_cv(i,j,v_filter10,total_frame_cv);
        end
    end
end
end


