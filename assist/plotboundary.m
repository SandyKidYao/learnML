%
% MLOtools PlotBoundary
% Usage: plotboundary(data,labels,model)
%
% data is a 2 column matrix of input data
% labels is a single column of the labels
%
% 'model' is any trained MLOtools model.
%
% e.g.
%   model = svm().train(data,labels);
%   plotboundary(data,labels,model)
%

function plotboundary(features, labels, predictor, res)

    if ~exist('res','var')
        res = 200; %resolution of the boundary plotting
    end
    
    if size(features,2)~=2
        error('Plotting of decision boundary only possible for 2d data, sorry.');
    end
    
    
    %Determine bounds using the data
    mins = min(features);
    maxs = max(features);
    %or define them manually
    %mins = [-6 -6];
    %maxs = [6 6];
    
    %Generate a grid to test things on
    x_steps = mins(1):(maxs(1)-mins(1))/res:maxs(1);
    y_steps = mins(2):(maxs(2)-mins(2))/res:maxs(2);

    [X Y] = meshgrid(x_steps, y_steps);
    X = reshape(X, numel(X), 1);
    Y = reshape(Y, numel(Y), 1);

    %Test every point on the grid
    Z = predictor.test([X Y]).labels;
    
    hold on;
    %Last parameter is the number of contour lines
    contour(x_steps, y_steps, reshape(Z, numel(x_steps), numel(y_steps)), 1, 'blue','LineWidth',2);

    %Draw the data
    marker = {'rx','bo','ks','g.','m*','c+','yd'};

    if length(unique(labels))>length(marker)
        error(['Sorry, can plot a maximum of ' num2str(length(marker)) ' classes.']);
    end
    
    uniq = unique(labels);
    for i=1:length(uniq)
        plot(features(labels == uniq(i), 1), features(labels == uniq(i), 2), marker{i},'MarkerSize',10);
    end
    %plot(features(labels == 1, 1), features(labels == 1, 2), 'bo','MarkerSize',10);
    %plot(features(labels ~= 1, 1), features(labels ~= 1, 2), 'rx','MarkerSize',10);
    hold off;
    
end

