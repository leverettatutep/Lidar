function data = gauss2d(X,Y,Sigma,mu)
data =  3*(1-X).^2.*exp(-(X.^2) - (Y+1).^2) ...
   - 10*(X/5 - X.^3 - Y.^5).*exp(-X.^2-Y.^2) ...
   - 1/3*exp(-(X+1).^2 - Y.^2);
% return;
%     % set the random seed:
%     randn('state',[2979743726;1541610269]);
% 
%     % create a random sigma, mu:
%     Sigma = cov(randn(100,2));
%     mu = randn(2,1);
% 
%     % compute, plot the cdf
%     [X,Y] = meshgrid(-3:.2:3);
    XY = cat(3,X,Y);
    % subtract mu
    XYmmu = bsxfun(@minus,XY,shiftdim(mu(:),-2));

    isigXY = squeeze(sum(bsxfun(@times,shiftdim(inv(Sigma),-2),XYmmu),3));
    XYisXY = sum(isigXY .* XYmmu,3);

    normcdf = (1/(2*pi*sqrt(det(Sigma)))) * exp(-0.5 * XYisXY);
%     surf(X,Y,normcdf);
%     data = [X,Y,normcdf];
    data = normcdf;
end
