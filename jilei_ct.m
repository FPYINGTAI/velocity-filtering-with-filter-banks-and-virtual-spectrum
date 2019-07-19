function [ output_matrix_ct ] = jilei_ct(w,z,total_frame,total_frame_cv,x_max,y_max,vx,vy)
%jilei_ct 将目标CT的所有帧积累至最后一帧
transition_matrix=[1     sin(w)/w            0      (cos(w)-1)/w;
                   0     cos(w)              0       -sin(w);
                   0     -(cos(w)-1)/w       1       sin(w)/w;
                   0     sin(w)              0       cos(w)];%%transition matrix转移矩阵F
ii=0;jj=0;zz=z;
output_matrix_ct=zeros(x_max,y_max);
for k=total_frame_cv+1:total_frame
% k=total_frame_cv;    
    for i=1:x_max
        for j=1:y_max                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            f0=(transition_matrix^(total_frame-k)*[i;vx(k);j;vy(k)])';
            ii=round(f0(1));jj=round(f0(3));
            if ii<=x_max&&jj<=y_max&&ii>=1&&jj>=1
            output_matrix_ct(ii,jj)=output_matrix_ct(ii,jj)+z(i,j,k);
            end
        end
    end
end

end

