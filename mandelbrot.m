function mandelbrot
% Mandelbrot plots either the Mandelbrot set or a user-specified Julia set.
% Follow the onscreen prompts.
%
% When prompted, a good value for detail is between 500 and 1000.
% Increasing this in conjunction with the internal "niter" variable can
% lead to exceedingly long calculation times.
%
% A good value of "niter" is dependent on the level of zoom you wish to
% obtain. See further description in the code.
%
% Note that when plotting a Julia set, you will need to type the complex
% number in the form of A+B*1i. For example: -0.79 + 0.15*1i returns a
% recognizeable Julia set.

niter=100; %increase for zoomed detail, decrease for faster runs
%Higher value of niter will make the set more detailed at higher levels of
%zoom but will "oversharpen" the starting plots. 100 or so is a good
%intermediate for smaller zoom levels and just kind of poking around the
%function

fork = input('Type m for mandelbrot, j for julia: ', 's');

%Go to mandelbrot set if fork is m
if fork=='m'
    detail = input('level of detail (higher is more, but slower): ');
    [x,y]=meshgrid(linspace(-2,1.5,detail),linspace(-2,2,detail));
    
    %Initialize initial mandelbrot plot
    c = x + 1i*y;
    z=zeros(size(c));
    k=zeros(size(c));

    for n=1:niter
        z=z.^2 + c;
        k(abs(z)>2 & k==0) = niter-n;    
    end
    figure(1)
    mbrot=imagesc(k);
    mbrotdata=get(mbrot,'parent');
    axis square
    
    %set up way too many silly functions and variables so things stop
    %breaking
    
    xlim=get(mbrotdata, 'XLim');
    ylim=get(mbrotdata, 'YLim');
    
    slopex=(x(end)-x(1))/(xlim(2)-xlim(1));
    xchart=xlim(1);
    xreal=x(1);
    slopey=(y(end)-y(1))/(ylim(2)-ylim(1));
    ychart=ylim(1);
    yreal=y(1);
    
    %Start up zoom feature
    m=1;
    while m==1
        %Only update the chart if there's actually a zoom
        ChartXLim=get(mbrotdata, 'XLim');
        testcase=ChartXLim(1);
        while testcase(1)-ChartXLim(1) == 0
            pause(1)
            testcase=get(mbrotdata, 'XLim');
        end
        
        %Replot with the zoomed coordinates
        ChartXLim=get(mbrotdata, 'XLim');
        ChartYLim=get(mbrotdata, 'YLim');
        xlim=[slopex*(ChartXLim(1)-xchart)+xreal, slopex*(ChartXLim(2)-xchart)+xreal];
        ylim=[slopey*(ChartYLim(1)-ychart)+yreal, slopey*(ChartYLim(2)-ychart)+yreal];
        [x,y]=meshgrid(linspace(xlim(1),xlim(2),detail),linspace(ylim(1),ylim(2),detail));
        
        c = x + 1i*y;
        z=zeros(size(c));
        k=zeros(size(c));

        for n=1:niter
            z=z.^2 + c;
            k(abs(z)>2 & k==0) = niter-n;    
        end
        figure(1)
        mbrot=imagesc(k);
        mbrotdata=get(mbrot,'parent');
        axis square
        
        %Set up way too many variables for the next loop
        xlim=get(mbrotdata, 'XLim');
        ylim=get(mbrotdata, 'YLim');
    
        slopex=(x(end)-x(1))/(xlim(2)-xlim(1));
        xchart=xlim(1);
        xreal=x(1);
        slopey=(y(end)-y(1))/(ylim(2)-ylim(1));
        ychart=ylim(1);
        yreal=y(1);
    end
end

%Go to julia set if fork is j
if fork=='j'
    
    detail = input('level of detail (higher is more, but slower): ');
    [x,y]=meshgrid(linspace(-2,2,detail),linspace(-2,2,detail));
    
    %initialize starting plot of julia sets
    
    z = x + 1i*y;
    c = input('please enter complex number for julia set in the form of A+B*1i: ');
    k = zeros(size(z));
    for n=1:niter
        z=z.^2 + c;
        k(abs(z)>2 & k==0)=niter-n;
    end
    
    figure(1)
    jset=imagesc(k);
    jsetdata=get(jset,'parent');
    axis square
    
    %Set up way too many variables so things don't break
    
    xlim=get(jsetdata, 'XLim');
    ylim=get(jsetdata, 'YLim');
    
    slopex=(x(end)-x(1))/(xlim(2)-xlim(1));
    xchart=xlim(1);
    xreal=x(1);
    slopey=(y(end)-y(1))/(ylim(2)-ylim(1));
    ychart=ylim(1);
    yreal=y(1);
    
    %Start up zoom feature
    m=1;
    while m==1
        %Only update the plot when there is a zoom
        ChartXLim=get(jsetdata, 'XLim');
        testcase=ChartXLim(1);
        while testcase(1)-ChartXLim(1) == 0
            pause(1)
            testcase=get(jsetdata, 'XLim');
        end
        
        %Update graph
        ChartXLim=get(jsetdata, 'XLim');
        ChartYLim=get(jsetdata, 'YLim');
        xlim=[slopex*(ChartXLim(1)-xchart)+xreal, slopex*(ChartXLim(2)-xchart)+xreal];
        ylim=[slopey*(ChartYLim(1)-ychart)+yreal, slopey*(ChartYLim(2)-ychart)+yreal];
        [x,y]=meshgrid(linspace(xlim(1),xlim(2),detail),linspace(ylim(1),ylim(2),detail));
        
        z = x + 1i*y;
        k = zeros(size(z));

        for n=1:niter
            z=z.^2 + c;
            k(abs(z)>2 & k==0) = niter-n;    
        end
        figure(1)
        jset=imagesc(k);
        jsetdata=get(jset,'parent');
        axis square
        
        %Set up way too many variables again
        
        xlim=get(jsetdata, 'XLim');
        ylim=get(jsetdata, 'YLim');
    
        slopex=(x(end)-x(1))/(xlim(2)-xlim(1));
        xchart=xlim(1);
        xreal=x(1);
        slopey=(y(end)-y(1))/(ylim(2)-ylim(1));
        ychart=ylim(1);
        yreal=y(1);
    end
end
end
