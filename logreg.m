classdef logreg
%
% model = logreg(0.1,100).train(data,labels);
% err = model.test(data,labels);
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
                    
                    if((fx>0.5&&tmplabel==0)||(fx<0.5&&tmplabel==1))
                        this.weights = this.weights+this.lr*(tmplabel-fx)*tmpdata';
                        this.bias = this.bias+this.lr*(tmplabel-fx);
                    end
                end
            end
        end
        
        function err = test(this,data,labels)
            [dataNum,~] = size(data);
            err=0;
            for j = 1:dataNum
                tmplabel = labels(j);
                tmpdata = data(j,:);
                fx = 1/(1+exp(-(tmpdata*this.weights + this.bias)));
                if((fx>0.5&&tmplabel==0)||(fx<0.5&&tmplabel==1))
                    err=err+1;
                end
            end
            err = err/dataNum;
        end
    end
    
end



