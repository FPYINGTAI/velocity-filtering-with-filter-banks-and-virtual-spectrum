function [ output_matrix ] = jilei(w,z,total_frame,x_max,y_max,vx,vy)
%jilei 将目标的所有帧积累至最后一帧
transition_matrix=[1     sin(w)/w            0      (cos(w)-1)/w;
                   0     cos(w)              0       -sin(w);
                   0     -(cos(w)-1)/w       1       sin(w)/w;
                   0     sin(w)              0       cos(w)];%%transition matrix转移矩阵F
ii=0;jj=0;zz=z;
output_matrix=zeros(x_max,y_max);
for k=1:total_frame
    for i=1:x_max
        for j=1:y_max                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            f0=(transition_matrix^(total_frame-k)*[i;vx(k);j;vy(k)])';
            ii=round(f0(1));jj=round(f0(3));
            if ii<=50&&jj<=50&&ii>=1&&jj>=1
            output_matrix(ii,jj)=output_matrix(ii,jj)+z(i,j,k);
            end
        end
    end
end

end

