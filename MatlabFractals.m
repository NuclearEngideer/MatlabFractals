function MatlabFractals
% Mandelbrot plots either the Mandelbrot set or a user-specified Julia set.
% Follow the onscreen prompts. Zoom with the tools dropdown in the figure
% window.
%
% Note that when plotting a Julia set, you will need to type the complex
% number in the form of A+B*i. For example: -0.79 + 0.15*1i returns a
% recognizeable Julia set.
%
% GitHub.com/NuclearEngideer ----- AveryGrieve.com

niter=50; %Starting iteration value. This increases by a default factor of 2
          %every time the plot is redrawn

MaxComputeTime=5*60; %Time in seconds for longest desired computation time
                     %default is 5 minutes 

fork = input('Type m for Mandelbrot, j for Julia: ', 's');
%spoon = something to eat soup with

colormap('jet'); %Change to play with colors (see Mathworks page on colormaps)

detail = input('Resolution (higher for more detail): ');

[x,y]=meshgrid(linspace(-2,2,detail),linspace(-2,2,detail));

%defining initial variables
multiplier=1;
run=1;

    while run ==1
        [setdata,ComputeTime]=FractalFunc(fork,x,y,multiplier);
        [x,y]=FractalZoom(setdata);
        
        %Comment the lines below out/in if you just want to keep a constant
        %iteration number or want to always increase iterations
        
        %multiplier = multiplier*2
        if ComputeTime <= MaxComputeTime
            multiplier = multiplier*2;
        else
            fprintf('Warning, Computation took %d minutes. Holding iterations constant', ComputeTime/60);
        end
    end
    

    function [setdata,ComputeTime]=FractalFunc(fork,x,y,multiplier)
        k=zeros(size(x)); %Variable with color data
        if fork=='m' %Mandelbrot set definitions
            c = x + 1i*y;
            z=zeros(size(c));
        elseif fork=='j' %Julia set definitions
            niter=niter*2; %increase iterations because julia sets are finer than the mandelbrot set
            if exist('c', 'var')==0
                fprintf('Please enter complex number for julia set in the form of A+B*i: \n');
                A=input('A: ');
                B=input('B: ');
                c=A+B*1i;
            end
            z = x + 1i*y;
        end
    
    %Plot the fractal and time it
    tic
    for n=1:niter*multiplier
        z=z.^2 + c;
        k(abs(z)>2 & k==0) = niter*multiplier-n;    
    end
    ComputeTime=toc;
    figure(1)
    set=imagesc(x(1,:),y(:,1)',k);
    setdata=get(set,'parent');
    title(sprintf('Iterations: %d', niter*multiplier))
    xlabel('Real Axis')
    ylabel('Imaginary Axis')
    axis square
    end
    
    function [x,y]=FractalZoom(setdata)
        %Send FractalFunc new X,Y data when the plot updates
        %Using a while loop so I don't have to deal with callbacks (maybe
        %I'll add them later and clean this up more)
        xlim=get(setdata, 'XLim');
        testcase=xlim(1);
        while testcase(1)-xlim(1) == 0
            pause(1)
            testcase=get(setdata, 'XLim');
        end
        xlim=get(setdata, 'XLim');
        ylim=get(setdata, 'YLim');
        [x,y]=meshgrid(linspace(xlim(1),xlim(2),detail),linspace(ylim(1),ylim(2),detail));
    end
end
