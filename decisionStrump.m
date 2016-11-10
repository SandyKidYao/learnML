classdef decisionStrump
%
% model = decisionStrump(0.2).train(data,labels);
% err = model.test(data,labels);
%
% Dvlp log:
% 11.7
%   1. for training method, need to check whether the data and labels meet
%   requirement: data and labels shuuld be 1-d vectors with same dimension
%   and labels should be made up with 0 and 1
%
%   2. for testing method, a result set like comp61011 tools may need to be
%   developed to plot the boundary
%
    properties
        lr = 0.1;
        threshold = 0;
    end
    
    methods
        
        function this = decisionStrump(lr)
            this.lr = lr;
        end
        
        function this = train(this,data,labels)
            [dataNum, ~] = size(data);
            dataMin = min(data(:,1));
            dataMax = max(data(:,1));
            minErr = dataNum;
            for i = dataMin :this.lr: dataMax
                numErr = numberOfErrors(this,data,labels);
                if numErr <= minErr
                    minErr = numErr;
                    this.threshold = i;
                end
            end
        end
        
        function res = test(this,data,labels)
            [dataNum, ~] = size(data);
            numErr = numberOfErrors(this,data,labels);
            res = numErr/dataNum;
            
        end
        
        function err = numberOfErrors(this,data,labels)
            [dataNum, ~] = size(data);
            err = 0;
            for i = 1:dataNum
                if(data(i,1)>this.threshold && labels(i) == 0) 
                    err=err+1;
                end
                if(data(i,1)<=this.threshold && labels(i) == 1) 
                    err=err+1;
                end
            end
            % return err = 0;
        end
    end
    
end

