clc;
clear variables;

clique_potential_initial = {[0.1, 0.7; 0.8, 0.3];
                            [0.5, 0.1; 0.1, 0.5];
                            [0.1, 0.5; 0.5, 0.1];
                            [0.9, 0.3; 0.1, 0.3]};

marginals = clique_potential_initial;
sepSize = size(marginals,1);
separators = ones(sepSize-1,2);

%Forward
for i=1:sepSize-1
    separators(i,:) = sum(marginals{i});
    marginals{i+1} = marginals{i+1}.*(separators(i,:)'*[1,1]);
end

%Backward
for i=1:sepSize-1
    separatorsPrevious = separators(sepSize-i,:);
    separators(sepSize-i,:) = sum(marginals{sepSize-i+1},2)';
    marginals{sepSize-i} = marginals{sepSize-i}.*([1;1]*(separators(sepSize-i,:)./separatorsPrevious));
end

%Normalize
for i=1:sepSize
    marginals{i} = marginals{i}/sum(sum(marginals{i}));
end

disp('Marginals:');
for i=1:sepSize
    val = marginals{i};
    fprintf('\t\t X = 0  | X = 1\n');
    fprintf('X = 0 -> %.4f | %.4f\n',val(1,:));
    fprintf('X = 1 -> %.4f | %.4f\n\n',val(2,:));
end