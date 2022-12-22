function projectileBoard(xa,ya)
        x_cord = 500;
        y_cord = 90;
        %% DO NOT TOUCH THIS:  Change axis on line 4 and 5
        % Everything is pre made due to those
        x = [x_cord-93 x_cord-93 x_cord+73 x_cord+73];
        y = [y_cord-18 y_cord+32 y_cord+32 y_cord-18];
        
        fill(x,y,'white','LineStyle','none');
       
        text(x_cord-85,y_cord+25,'Ball Traveled:','FontSize',7);
        text(x_cord+65,y_cord+25,'ft','FontSize',7);
    
    
        text(x_cord-85,y_cord,'Max Height:','FontSize',7);
        text(x_cord+65,y_cord,'ft','FontSize',7);
        
        % box around the max numbers
        hold on
        line([x_cord-90 x_cord-90],[y_cord-18 y_cord+36],'Color','black');
        line([x_cord+78 x_cord+78],[y_cord-18 y_cord+36],'Color','black');
        line([x_cord-90 x_cord+78],[y_cord-18 y_cord-18],'Color','black');
        line([x_cord-90 x_cord+78],[y_cord+36 y_cord+36],'Color','black');
        
        
        
        text(x_cord+5,y_cord+25,num2str(xa),'Color','black','FontSize',7);
        text(x_cord+5,y_cord,num2str(ya),'Color','black','FontSize',7);
        
%     
%    


end