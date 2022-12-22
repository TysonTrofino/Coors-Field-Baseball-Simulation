function plotfield(axs,fence)

    %plot the field
    axis(axs);
    hold on
    x = [66 60 60-(34/12) 48];
    y = [0 20/12 20/12 0];
    
    fill(x,y,[0.2 0 0]);
    line([axs(1),127],[0,0],'LineWidth', .5,'Color',[0.2 0 0]);
    line([127,fence],[0,0],'LineWidth', .5,'Color',[0 0.6 .3]);
    line([axs(1),axs(1)],[0,40],'LineWidth',1,'Color','black');
    projectileBoard(0,0);
    
    ylabel('Height (ft)');
    xlabel('Distance Traveled (ft)');
    
    % hitter plot
    theta = linspace(0, 2*pi);
    
    x = cos(theta);
    y = sin(theta);
    
    line([-2 0],[0 3],'Color','black');
    line([2 0], [0 3],'Color','black');
    line([0 0], [3 5],'Color','black');
    line([-2 0], [4 5],'Color','black');
    line([-2 -3],[4 7],'Color','black');
    plot(x,y+6,'k');
    
    % pitcher plot
    line([58 59],[20/12 (20/12)+3],'Color','black');
    line([60 59],[20/12 (20/12)+3],'Color','black');
   
    line([59 59], [(20/12)+3 (20/12)+6],'Color','black');
    line([61 59], [(20/12)+4.37 (20/12)+6],'Color','black');
    
    plot(59+x,y+7+(20/12),'k');
  
    x = [fence fence axs(2) axs(2)];
    y = [0 10 40 0];
    
    fill(x,y,'k');
end


