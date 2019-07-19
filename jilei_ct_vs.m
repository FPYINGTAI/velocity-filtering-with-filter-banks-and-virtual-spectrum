function [ output_matrix_ct ] = jilei_virtual_spectrum(w,z,total_frame,total_frame_cv,x_max,y_max,vx,vy,sigma)
%jilei 将目标的所有帧积累至最后一帧
transition_matrix=[1     sin(w)/w            0      (cos(w)-1)/w;
                   0     cos(w)              0       -sin(w);
                   0     -(cos(w)-1)/w       1       sin(w)/w;
                   0     sin(w)              0       cos(w)];%%transition matrix转移矩阵F
ii=0;jj=0;zz=z;
output_matrix_ct=zeros(x_max,y_max);
z_virtual=zeros(x_max,y_max);
for k=total_frame_cv+1:total_frame
    for i=1:x_max
        for j=1:y_max                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            f0=(transition_matrix^(total_frame-k)*[i;vx(k);j;vy(k)])';
            ii=f0(1);jj=f0(3);
            if ii<=78&&jj<=78&&ii>=3&&jj>=3
                for row=round(ii)-2:1:round(ii)+2
                    for colum=round(jj)-2:1:round(jj)+2
                    z_virtual(row,colum)=z(i,j,k)*exp(-((ii-row)^2+(jj-colum)^2)/(2*sigma^2));
                    output_matrix_ct(row,colum)=output_matrix_ct(row,colum)+z_virtual(row,colum);
                    end
                end        
                
            end
        end
    end
end

end

