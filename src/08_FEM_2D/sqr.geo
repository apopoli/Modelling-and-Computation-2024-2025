ls = 0.1;

//+
Point(1) = {0, 0, 0, ls};
//+
Point(2) = {1, 0, 0, ls};
//+
Point(3) = {1, 1, 0, ls};
//+
Point(4) = {0, 1, 0, ls};

Line(1) = {1, 2};

Line(2) = {2, 3};

Line(3) = {3, 4}; // press 0 to reaload .geo file

Line(4) = {4, 1};

Curve Loop(1) = {3, 4, 1, 2};

Plane Surface(1) = {1};

// Transfinite Curve {4, -2} = 25 Using Progression 1.1;

Physical Curve("W", 5) = {4};
//+
Physical Curve("S", 6) = {1};
//+
Physical Curve("E", 7) = {2};
//+
Physical Curve("N", 8) = {3};

Mesh 2;


//+
Physical Surface("air", 9) = {1};
