classdef knn
% model = knn(5).train(data,labels);
% err = model.test(data,labels).err();
    
    properties
        trdata;
        trlabels;
        k;
    end
    
    methods
        function this = knn(k)
            this.k=k;
        end
        
        function this = train(this,data,labels)
            this.trdata = data;
            this.trlabels = labels;
        end
        
        function guess = test(this,data,labels)
            [dataNum,~] = size(data);
            predictedlabels = zeros(dataNum,1);
            
            [trNum,~] = size(this.trdata);
            for j = 1:dataNum
                tmpdata = data(j,:);
                dis = zeros(trNum,1);
                for i = 1:trNum
                    dis(i) = norm(tmpdata-this.trdata(i,:));
                end
                [sA,index] = sort(dis);
                res = 0;
                for i = 1:this.k
                    res = res + this.trlabels(index(i));
                end
                if(res > this.k/2)
                    predictedlabels(j) = 1;
                else
                    predictedlabels(j) = 0;
                end
            end
            % return the predictions --- this bit is necessary for mlotools
            guess = results(predictedlabels);
            if exist('labels','var')
                guess.addtruelabels(labels);
            end
        end
    end
    
end

