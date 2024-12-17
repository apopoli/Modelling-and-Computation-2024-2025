// Gmsh project created on Tue Dec 17 09:57:44 2024
SetFactory("OpenCASCADE");

d = 1.0; // distance between conductors - 1 m
r0 = 0.1; // radius of each TL conductor - 10 cm
rext = 2.0; // radius of external boundary (much larger for real-life calculations)

//+
Circle(1) = {-d/2, 0, 0, r0, 0, 2*Pi}; // TL_L
//+
Circle(2) = {d/2, 0, 0, r0, 0, 2*Pi}; // TL_R
//+
Circle(3) = {0, 0, 0, rext, 0, 2*Pi}; // external domain

//+
Curve Loop(1) = {3};
//+
Curve Loop(2) = {1};
//+
Curve Loop(3) = {2};
//+
Plane Surface(1) = {1, 2, 3}; // AIR
//+
Curve Loop(4) = {1};
//+
Plane Surface(2) = {4}; // TL_L
//+
Curve Loop(5) = {2};
//+
Plane Surface(3) = {5}; // TL_R
//+
Physical Curve("ext", 6) = {3};
//+
Physical Surface("air", 7) = {1};
//+
Physical Surface("TL_L", 8) = {2};
//+
Physical Surface("TL_R", 9) = {3};

// REFINE MESH (mesh->define->transfinite->curve)


//+
Transfinite Curve {1} = 20 Using Progression 1;
//+
Transfinite Curve {2} = 20 Using Progression 1;
//+
Transfinite Curve {3} = 50 Using Progression 1;
