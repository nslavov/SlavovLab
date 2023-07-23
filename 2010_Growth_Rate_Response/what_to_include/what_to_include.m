%%
Marker = { 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor'  };

gr = [0.05 0.10 0.14];
y = [-2 0 1.75];

plot( gr, y, 'ko', Marker{:}, 'k' ), hold on
plot( gr([1,3]), y([1,3]), 'r', Marker{:}, 'r' )

xlim([0.04 0.15] );
ylim([-2.2 2.2] );

clear h
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'Ytick', y,  'YtickLabel', y );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );
h(1) = xlabel( 'Growth Rate, $h^{-1}$' );    
h(2) = ylabel( '$\log_2$ Fold Change' ); 
h(3) = title( 'Good Fit: Grade 1' ); 
sett(h);
pdf( 'grade1', [9 6], 1 );

%%
Marker = { 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor'  };

gr = [0.05 0.10 0.14];
y = [-2 0 1.75];
yy = [-2 .5 1.2];

plot( gr, yy, 'ko', Marker{:}, 'k' ), hold on
plot( gr([1,3]), y([1,3]), 'r', Marker{:}, 'r' )

xlim([0.04 0.15] );
ylim([-2.2 2.2] );

clear h
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'Ytick', y,  'YtickLabel', y );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );
h(1) = xlabel( 'Growth Rate, $h^{-1}$' );    
h(2) = ylabel( '$\log_2$ Fold Change' ); 
h(3) = title( 'Poor Fit \& Monotonic: Grade 2' ); 
sett(h);
pdf( 'grade2', [9 6], 1 );

%%
Marker = { 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor'  };

gr = [0.05 0.10 0.14];
y = [-2 0 1.75];
yy = [-2 .5 1.2];

plot( gr, yy, 'ko', Marker{:}, 'k' ), hold on
plot( gr([1,3]), y([1,3]), 'r', Marker{:}, 'r' )

xlim([0.04 0.15] );
ylim([-2.2 2.2] );

clear h
set( gca, 'Xtick', gr,  'XtickLabel', gr );
set( gca, 'Ytick', y,  'YtickLabel', y );
set( gca, 'FontWeight', 'Bold', 'FontSize', 14 );
h(1) = xlabel( 'Growth Rate, $h^{-1}$' );    
h(2) = ylabel( '$\log_2$ Fold Change' ); 
h(3) = title( 'Poor Fit \& Non-monotonic: Grade 3' ); 
sett(h);
pdf( 'grade3', [9 6], 1 );






