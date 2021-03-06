function [mind pret index] = plAssociation(pa, pdata)
%Given a point and a reference set, find the best matching association
%based on the two nearest closest points (in euclidean terms). It returns
%two points which represent the endpoints of the closest line

pset = pdata.cart;
p = pa(1:2);
pret = [];
index = [];


% Cycle all the points and find the two nearest one

    infd = inf;
    mind = sqrt( (p(1)-pret(1))^2 + (p(2)-pret(2))^2 );
    
    for i = 1:size(pset,1)

        p2 = pset(i,1:2); %check the distance and save the best match
        d = sqrt( (p(1)-p2(1))^2 + (p(2)-p2(2))^2 );
        
        if d < infd
            infd = d;
            mind = infd;
            pret =  p2;
            index = i;
        end
        
    end

    % Check the nearest 5 neighbours in both directions to find the second
    % best match
    infd = inf;
    for i = 1:5
        

        p2 = pset(index+i,1:2); %check the distance and save the best match
        p3 = pset(index-i,1:2); 
        
        % We check in both directions and save the minimum
        d = sqrt( (p(1)-p2(1))^2 + (p(2)-p2(2))^2 );
        d2 = sqrt( (p(1)-p3(1))^2 + (p(2)-p3(2))^2 );
        
        [d im] = min(d,d2);
        
        if d < infd
            infd = d;
            mind2 = infd;
            pret2 = p2;
            index2 = index+(i * (-2*(im-1) + 1) ) ;
        end

        
    end

    pret = [pret pret2];
    index = [index index2];
    mind = [mind mind2];
if size(pret,1) < 2
    error('No associations found');
end

end
