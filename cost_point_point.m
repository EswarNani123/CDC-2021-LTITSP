% This function determines the optimal time between the points p and q
% Where p is the initial point and q is the final point
% Also, p = [p(1) p(2)] and q = [p(1) q(2)] 
% p and q are inputs to function
% c = Time to move from p to q, c is the output of the function
function c = cost_point_point(p,q)
if p(1)-q(1) < -0.5*abs(p(2)-q(2))*(q(2)+p(2))
            c = sqrt(4*(q(1)-p(1))+2*(p(2)^2+q(2)^2))-(q(2)+p(2));
end
if p(1)-q(1) > -0.5*abs(p(2)-q(2))*(q(2)+p(2))
            c = sqrt(4*(p(1)-q(1))+2*(p(2)^2+q(2)^2))+(q(2)+p(2));
end
if p(1)-q(1) == -0.5*abs(p(2)-q(2))*(q(2)+p(2))
            c = abs(q(2)-p(2));
end
end