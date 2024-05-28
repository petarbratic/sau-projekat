%% Poređenje odziva nelinearnog modela rezervoara i linearizovanog modela segveja


%konstante za nelinearni model

g = 9.81;
m = 150;
M = 5;
R = 0.15;
l = 1.5;
Iw = (l^2*m)/3;
Ir = (m*R^2)/2;
K = 1;

k1 = (M + m) * R + Iw / R;
k2 = m * l * R;
k3 = m * l;
k4 = Ir + m * l^2;
k5 = m * l * g;
k6 = M * l * R;


% Definisanje matrica sistema

A = [0        1                   0                  0;
     0        0            (k2*k5)/(k2*k3-k1*k4)     0;
     0        0                   0                  1;
     0        0            (k1*k5)/(k1*k4-k2*k3)     0];
B = [            0; 
    (-k2*K-k4)/(k2*k3-k1*k4); 
                 0;
    (-k1*K-k3)/(k1*k4-k2*k3)];
C = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]; 
D = [0; 0; 0; 0];


% Uvođenje konstanti p1, p2, p3 i p4 zbog preglednosti.
p1 = (-k2*K-k4)/(k2*k3-k1*k4);
p2 = (-k1*K-k3)/(k1*k4-k2*k3);
p3 = (k2*k5)/(k2*k3-k1*k4);
p4 = (k1*k5)/(k1*k4-k2*k3);


f = @(a)[a(4)*p2 + a(2)*p1 - 4; -p4 + a(3)*p2 + a(1)*p1 - 6;-a(2)*p1*p4 + a(2)*p2*p3 - 4;-a(1)*p1*p4 + a(1)*p2*p3 - 1];
fsolve(f, [1,1,1,1]);


a = acker(A, B, [-1, -1, -1, -1]);

a1 = a(1);
a2 = a(2);
a3 = a(3);
a4 = a(4);


