classdef logreg
%
% model = logreg(0.1,100).train(data,labels);
% err = model.test(data,labels).err();
%
    
    properties
        lr = 0.1;
        weights;
        bias;
        epoches = 100;
    end
    
    methods
        function this = logreg(lr,epoches)
            this.lr = lr;
            this.epoches = epoches;
        end
        
        function this = train(this,data,labels)
            [dataNum,dataDim] = size(data);
            this.weights = rand(dataDim,1);
            this.bias = rand();
            for i = 1:this.epoches
                for j = 1:dataNum
                    tmplabel = labels(j);
                    tmpdata = data(j,:);
                    
                    fx = 1/(1+exp(-(tmpdata*this.weights + this.bias)));
                    
                    %if((fx>0.5&&tmplabel==0)||(fx<0.5&&tmplabel==1))
                        this.weights = this.weights+this.lr*(tmplabel-fx)*tmpdata';
                        this.bias = this.bias+this.lr*(tmplabel-fx);
                    %end
                end
            end
        end
        
        function guess = test(this,data,labels)
            [dataNum,~] = size(data);
            predictedlabels = zeros(dataNum,1);
            for j = 1:dataNum
                tmpdata = data(j,:);
                fx = 1/(1+exp(-(tmpdata*this.weights + this.bias)));
                if(fx>0.5)
                    predictedlabels(j)=1;
                else
                    predictedlabels(j)=0;
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



