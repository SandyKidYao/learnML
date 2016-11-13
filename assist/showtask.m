function showtask(data,labels)

marker = {'rx','bo','g.','ks','m*','c+','yd'};

labelset = unique(labels);

if length(labelset)>length(marker)
    error(['Sorry, can only show max of ' length(marker) ' classes']);
end

figure
for i=1:length(labelset)

    plot( data(labels==labelset(i),1), data(labels==labelset(i),2), marker{i},'MarkerSize',8);
    hold on
        
end

minx1 = min(data(:,1));
minx2 = min(data(:,2));
maxx1 = max(data(:,1));
maxx2 = max(data(:,2));
rangex1 = range(data(:,1));
rangex2 = range(data(:,2));
f = 0.5; %amount of space around the points (bigger = more)
axis([ minx1-rangex1*f maxx1+rangex1*f minx2-rangex2*f maxx2+rangex2*f ]);
