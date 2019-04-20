function cost = costOfClosest(refImage, estImage, rc, E, D, Z)

d_max = D(1,1);

[subReferenceImage, valid] = advancedRange(refImage, rc, d_max);

if ~any(any(subReferenceImage))
	cost = 1;
	return;
end

C = 1 - E(D+1) .* ( 1 - abs( subReferenceImage - estImage(rc(1),rc(2)) )/Z );

D(valid==0 | subReferenceImage==0) = inf;
[minColumnD,v_idx_] = min(D);
[~,u_idx] = min(minColumnD);
v_idx = v_idx_(u_idx);

cost = C(v_idx,u_idx);