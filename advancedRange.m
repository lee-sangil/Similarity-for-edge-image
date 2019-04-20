function [submatrix, valid] = advancedRange(matrix, rc, radius)

[l_rows, lrIdx] = max([rc(1)-radius,1]);
[u_rows, urIdx] = min([rc(1)+radius,size(matrix,1)]);
[l_cols, lcIdx] = max([rc(2)-radius,1]);
[u_cols, ucIdx] = min([rc(2)+radius,size(matrix,2)]);

valid = ones(2*radius+1);
submatrix = matrix(l_rows:u_rows, l_cols:u_cols);

if lrIdx == 2
	submatrix = [zeros(1-(rc(1)-radius),size(submatrix,2)); submatrix];
	valid(1:1-(rc(1)-radius),:) = 0;
end

if urIdx == 2
	submatrix = [submatrix; zeros(rc(1)+radius-size(matrix,1),size(submatrix,2))];
	valid(end-(rc(1)+radius-size(matrix,1))+1:end,:) = 0;
end

if lcIdx == 2
	submatrix = [zeros(size(submatrix,1),1-(rc(2)-radius)) submatrix];
	valid(:,1:1-(rc(2)-radius)) = 0;
end

if ucIdx == 2
	submatrix = [submatrix zeros(size(submatrix,1),rc(2)+radius-size(matrix,2))];
	valid(:,end-(rc(2)+radius-size(matrix,2))+1:end) = 0;
end