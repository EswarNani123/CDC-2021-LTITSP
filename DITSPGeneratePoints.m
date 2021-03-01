function s=DITSPGeneratePoints(n)
    xmax = 5; % Maximum value of x_{1}
    xmin = -5; % Minimum value of x_{1}
    ymax = 4; % Maximum value of x_{2}
    ymin = -4; % Minimum value of x_{2}
    s(:,1) = xmin+(xmax-xmin)*rand(n,1); % Generating the set s containing points that are distributed according to
    s(:,2) = ymin+(ymax-ymin)*rand(n,1); % uniform probability distribution