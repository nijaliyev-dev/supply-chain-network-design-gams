Sets
i / Baku , Quba, Ismayilli, Samakhi, Shirvan ,Lankaran, Shaki, Khankandi, Qubadli, Qazakh, Lachin, Nakhchivan, Ganja / ,
j / Baku , Quba, Ismayilli, Samakhi, Shirvan ,Lankaran, Shaki, Khankandi, Qubadli, Qazakh, Lachin, Nakhchivan, Ganja / ,
l / Baku , Quba, Ismayilli, Samakhi, Shirvan ,Lankaran, Shaki, Khankandi, Qubadli, Qazakh, Lachin, Nakhchivan, Ganja / ,
w / Small, Medium, Large / ;


Parameter
*Customer Demand
d(j) /
  Baku 450000 ,
  Quba 4000 ,
  Ismayilli 2000 ,
  Samakhi 3000 ,
  Shirvan 2500 ,
  Lankaran 4000 ,
  Shaki 1500 ,
  Khankandi 200000 ,
  Qubadli 150000 ,
  Qazakh 3500 ,
  Lachin 250000 ,
  Nakhchivan 5500 ,
  Ganja 15000 / ,
  

*Facility Related Limit (Production Limit)
Pcap(l) /
  Baku 500000 ,
  Quba 10000 ,
  Ismayilli 10000 ,
  Samakhi 10000 ,
  Shirvan 10000 ,
  Lankaran 15000 ,
  Shaki 15000 ,
  Khankandi 250000 ,
  Qubadli 200000 ,
  Qazakh 10000 ,
  Lachin 300000 ,
  Nakhchivan 20000
  Ganja 25000 / ,

*Variable Cost in Facilities  
pVar(l) /
  Baku 8.5 ,
  Quba 3.55 ,
  Ismayilli 4.0 ,
  Samakhi 6.0 ,
  Shirvan 1.5 ,
  Lankaran 5.0 ,
  Shaki 2.0 ,
  Khankandi 1.0 ,
  Qubadli 1.5 ,
  Qazakh 5.55 ,
  Lachin 1.5 ,
  Nakhchivan 7.5
  Ganja 4.0  / ,

*Variable Cost in Warehouses
WhVar(i) /
  Baku 6.0 ,
  Quba 2.0 ,
  Ismayilli 3.5 ,
  Samakhi 5.0 ,
  Shirvan 1.55 ,
  Lankaran 4.0 ,
  Shaki 2.0 ,
  Khankandi 1.05 ,
  Qubadli 1.0 ,
  Qazakh 3.55 ,
  Lachin 1.55 ,
  Nakhchivan 7.0
  Ganja 4.5 / ,
  
*Fixed Cost in Facilities
FacFix(l) /
  Baku 16000 ,
  Quba 5000 ,
  Ismayilli 4000 ,
  Samakhi 4000 ,
  Shirvan 3500 ,
  Lankaran 5500 ,
  Shaki 6000 ,
  Khankandi 20000 ,
  Qubadli 16500 ,
  Qazakh 9000 ,
  Lachin 15000 ,
  Nakhchivan 12500 ,
  Ganja 1200 / ;
  

*Distances between Facilities and Warehouses
Table a(l,i)
           Baku Quba  Ismayilli Samakhi Shirvan Lankaran Shaki Khankandi Qubadli Qazakh  Lachin Nakhchivan Ganja
Baku        0    340     427      145     314      550     470    553       678    530    608    857       340
Quba        340   0      312      230     428      642     523    738       832    640    651    985       205
Ismayilli   427  312      0       108     306      720     331    418       510    448    520    980       225
Samakhi     145  230     108       0      224      502     449    436       614    452    533    824       268
Shirvan     314  428     306      224      0       626     315    402       540    337    427    1033      319
Lankaran    550  642     720      502     626       0      447    632       602    440    621    612       624
Shaki       470  523     331      449     315      447     0      505       535    412    500    851       346
Khankandi   553  738     418      436     402      632     505      0       120    427     90    806       406
Qubadli     678  832     510      614     540      602     535    120       0      370    180    1109      420
Qazakh      530  640     448      452     337      440     412    427       370     0     409    1330      246
Lachin      608  651     520      533     427      621     500     90       180    409     0     911       362
Nakhchivan  857  985     980      824    1033      612     851    806       1109   1330   911      0       1050
Ganja       340  205     235      268     319      624     346    406       420    246    362    1050        0  ;


Table WhFix(i,w)
               Small   Medium   Large
Baku            1000    3500    9500
Quba            400     1000    3950
Ismayilli       350     900     5600
Samakhi         300     1550    3500
Shirvan         350     1280    4800
Lankaran        500     1000    2500
Shaki           350     1500    3950
Khankandi       1200    4500    9000
Qubadli         900     2500    7900
Qazakh          350     1300    2950
Lachin          950     2550    6950
Nakhchivan      500     2500    4990
Ganja           450     1600    4800;


Table transWC(i,j)
           Baku Quba  Ismayilli Samakhi Shirvan Lankaran Shaki Khankandi Qubadli Qazakh Lachin Nakhchivan Ganja
Baku        0    350     437      155     324      560     480    563       688     540    618    867       350
Quba        350   0      322      240     438      652     533    748       842     650    661    995       200
Ismayilli   437  322      0       118     316      730     341    428       520     458    530    990       245
Samakhi     155  240     118       0      234      512     459    446       624     462    543    834       278
Shirvan     324  438     316      234      0       636     325    412       550     347    437    1043      329
Lankaran    560  652     730      512     636       0      457    642       612     450    631    622       634
Shaki       480  533     341      459     325      457     0      515       545     422    510    861       356
Khankandi   563  748     428      446     412      642     515      0       130     437    100    906       416
Qubadli     688  842     520      624     550      612     545    130       0       380    190    1119      430
Qazakh      540  650     458      462     347      450     422    437       380      0     419    1400      256
Lachin      618  661     530      543     437      631     510    100       190     419     0     921       372
Nakhchivan  867  995     990      834    1043      622     861    906       1119    1400   921      0       1067
Ganja       350  200     245      278     329      634     356    416       430     256    372    1067        0  ;

*FACILITY EXTENT
Table Whcap(i,w)
                Small    Medium      Large
Baku            5000     450000     6000000
Quba            5000     300000     5600000
Ismayilli       5000     400000     5500000
Samakhi         25000    350000     5850000
Shirvan         4500     255000     4000000
Lankaran        3000     500000     5450000
Shaki           1500     345000     3050000
Khankandi       3500     505500     6500000
Qubadli         2000     250000     1850000
Qazakh          6500     180000     4500000
Lachin          2500     105000     2750000
Nakhchivan      5000     300000     4550000
Ganja           4500     400500     5250000 ;


Variable
z ;

Positive Variable
H(l,i) ;

Binary Variable
x(i,j) ,
y(i,w) ;

Binary Variable
r(l) ;

Equations
obj ,
assign_1 ,
limit_0 ,
limit_1 ,
limit_2 ,
limit_3 ,
selection ,
capacity ,
capacity_1 ,
capacity_2 ,
assign_3 ;


obj .. sum((l,i), a(l,i)*H(l,i)) + sum((l,i), pVar(l)*H(l,i)) + sum(l, r(l)*FacFix(l)) + sum((i,j), d(j)*transWC(i,j)*x(i,j)) + sum((i,j), WhVar(i)*d(j)*x(i,j)) + sum((i,w), y(i,w)*WhFix(i,w)) =e=z ;
assign_1 (j).. sum(i, x(i,j)) =e= 1 ;
limit_0 .. sum(l, r(l)) =g= 4 ;
limit_1 .. sum(l, r(l)) =l= 5 ;
limit_2 .. sum((i,w), y(i,w)) =g= 5 ;
limit_3 .. sum((i,w), y(i,w)) =l= 7 ; 
selection (i).. sum(w, y(i,w)) =l= 1 ;
capacity (i).. sum(j, d(j)*x(i,j)) =l= sum(w, Whcap(i,w)*y(i,w)) ;
capacity_1 (i).. sum(l, H(l,i)) =e= sum(j, x(i,j)*d(j)) ;
capacity_2 (l).. sum(i, H(l,i)) =l= Pcap(l) * r (l) ;
assign_3 (i,j).. x(i,j) =l= sum(w, y(i,w)) ;

Model P_Median /all/ ;
Solve P_Median using mip minimizing z ;
Display P_Median.modelstat, P_Median.solvestat;
Display z.l, x.l, y.l, H.l, r.l;

execute_unload 'results.gdx', z.l, x.l, y.l, H.l, r.l ;
execute 'gdxxrw.exe results.gdx output=results.xlsx';
execute 'gdxxrw.exe results.gdx  index=z rng=Sheet1!B1';
execute 'gdxxrw.exe results.gdx  index=x rng=Sheet1!B40';
execute 'gdxxrw.exe results.gdx  index=y rng=Sheet1!B80';
execute 'gdxxrw.exe results.gdx  index=H rng=Sheet1!B100';
execute 'gdxxrw.exe results.gdx  index=r rng=Sheet1!B200';

