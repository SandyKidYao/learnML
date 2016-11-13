% Results class for MLOtools objects.
%
% Create with:
%   r = results(labels);
%
% Query with:
%   r.err()
% to access the error against the stored labels.
%   r.err(truelabels)
% for an arbitrary other set.
%
classdef results < handle
    
    properties
        
        truelabels; %true labels
        labels;     %predicted labels
        probs;      %predicted posterior probs
        
    end
   
    methods
    
        %constructor
        function obj = results( labels )
            obj.labels = labels;
        end

        function addtruelabels( this, truelabels )
            this.truelabels = truelabels;
        end
        
        function addposteriors( this, probs )
            this.probs = probs;
          
            %should check that probs coincides with truelabels!
        end
        
        %calculate classification error
        function e = err( this, newtruelabels )
            
            if exist('newtruelabels','var')
                    e = mean( this.labels ~= newtruelabels );
            else
                if isempty(this.truelabels)
                    error('Error: No ground truth labels stored in results object.');
                else
                    e = mean( this.labels ~= this.truelabels );
                end
            end
            
        end
        
        %calculate classification accuracy
        function a = acc( this, newtruelabels )
            
            if exist('newtruelabels','var')
                    a = mean( this.labels == newtruelabels );
            else
                if isempty(this.truelabels)
                    error('Error: No ground truth labels stored in results object.');
                else
                    a = mean( this.labels == this.truelabels );
                end
            end
            
        end
        
        %calculate balanced error
        function e = ber( this, newtruelabels )
            
            if exist('newtruelabels','var')
                
                    classes = unique(newtruelabels);
                    for i=1:length(classes)
                        classlabel = classes(i);
                        idx = find(newtruelabels==classlabel);
                        e(i) = mean(this.labels(idx) ~= newtruelabels(idx));
                    end
                    e = mean(e);

            else
                
                if isempty(this.truelabels)
                    error('Error: No ground truth labels stored in results object.');
                else
                    e = mean( this.labels ~= this.truelabels );
                    
                    classes = unique(this.truelabels);
                    for i=1:length(classes)
                        classlabel = classes(i);
                        idx = find(this.truelabels==classlabel);
                        e(i) = mean(this.labels(idx) ~= this.truelabels(idx));
                    end
                    e = mean(e);
                    
                end
            end
            
        end
        
        function f = fmeasure( this )

            %NB: positive class is 2, negative class is 1
            TN = sum((this.truelabels==1 & this.labels==1));
            TP = sum((this.truelabels==2 & this.labels==2));
            FN = sum((this.truelabels==2 & this.labels==1));
            FP = sum((this.truelabels==1 & this.labels==2));
            
            %prec = TP/(TP+FP);
            %rec = TP/(TP+FN);
            %f = harmmean([prec rec]);
            
            f = 2*TP / (2*TP + FN + FP);
        
        end
        

        function m = mse( this )
        
            m = sum( sqrt( (this.truelabels - this.labels).^2 ) );
            
        end
        
        function x = pearson( this )
        
            for i=1:size(this.truelabels,2)
                m = corrcoef( this.truelabels(:,i), this.labels(:,i) );
                x(i) = m(1,2);
            end
            
        end
        
        
        function x = coeffdeterm( this, baseline )

            %x = var(this.truelabels-this.labels) / var(this.truelabels-baseline);

            if ~exist('baseline','var')
                baseline = mean(this.truelabels);
            end
            
            y = this.truelabels;
            f = this.labels;
            
            x = 1 - sum( (y-f).^2, 1 ) ./ sum( (y-repmat(baseline,size(this.labels,1),1)).^2, 1 );
        
        end
            
       
       
    end%methods

    
end
