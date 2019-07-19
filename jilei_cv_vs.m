function [ output_matrix_cv ] = jilei_cv(z,total_frame_cv,theta0,x0,y0,x_max,y_max,v_cv,sigma)
%jilei_cv 将目标CV的所有帧积累至最后一帧
% transition_matrix_cv=[1     1            0      0;
%                       0     1            0      0;
%                       0     0            1      1;
%                       0     0            0      1];%%transition matrix_cv转移矩阵F_cv
ii=0;jj=0;zz=z;
output_matrix_cv=zeros(x_max,y_max);
z_virtual=zeros(x_max,y_max);
for k=1:total_frame_cv
    for i=1:x_max
        for j=1:y_max                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            fx_cv=i+v_cv*sin(theta0)*(total_frame_cv-k);
            fy_cv=j+v_cv*cos(theta0)*(total_frame_cv-k);
            ii=round(fx_cv);jj=round(fy_cv);
            if ii<=78&&jj<=78&&ii>=3&&jj>=3
                for row=round(ii)-2:1:round(ii)+2
                    for colum=round(jj)-2:1:round(jj)+2
                     z_virtual(row,colum)=z(i,j,k)*exp(-((ii-row)^2+(jj-colum)^2)/(2*sigma^2));
                     output_matrix_cv(row,colum)=output_matrix_cv(row,colum)+z_virtual(row,colum);
                    end
                end
              
            end
        end
    end
end

end

