// Gmsh project created on Tue Dec 17 11:14:18 2024
SetFactory("OpenCASCADE");
//+
Point(1) = {-1, 0, 0, 0.25};
//+
Point(2) = {-1, 0.5, 0, 1.0};
//+
Point(3) = {-1, -0.5, 0, 1.0};
//+
Point(4) = {-1.5, -0, 0, 1.0};
//+
Point(5) = {-0.5, -0, 0, 1.0};
//+
Point(6) = {-2, 0, 0, 1.0};
//+
Point(7) = {-1, 1, 0, 1.0};
//+
Point(8) = {0, -0, 0, 1.0};
//+
Point(9) = {-1, -1, 0, 1.0};
//+
Circle(1) = {3, 4, 2};
//+
Recursive Delete {
  Curve{1}; 
}
//+
Point(10) = {-1, 0.5, 0, 1.0};
//+
Point(11) = {-1, -0.5, 0, 1.0};
//+
Circle(1) = {4, 1, 10};
//+
Circle(2) = {4, 1, 11};
//+
Circle(3) = {11, 1, 5};
//+
Circle(4) = {5, 1, 10};
//+
Circle(5) = {6, 1, 9};
//+
Circle(6) = {9, 1, 8};
//+
Circle(7) = {8, 1, 7};
//+
Circle(8) = {7, 1, 6};
//+
Line(9) = {10, 7};
//+
Line(10) = {5, 8};
//+
Line(11) = {11, 9};
//+
Line(12) = {4, 6};
//+
Curve Loop(1) = {8, -12, 1, 9};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {2, 11, -5, -12};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {3, 10, -6, -11};
//+
Plane Surface(3) = {3};
//+
Curve Loop(4) = {4, 9, -7, -10};
//+
Plane Surface(4) = {4};
//+
Curve Loop(5) = {1, -4, -3, -2};
//+
Plane Surface(5) = {5};
//+
Transfinite Curve {8, 7, 6, 5, 1, 4, 3, 2} = 15 Using Progression 1;
//+
Transfinite Curve {9, 10, 11, 12} = 30 Using Progression 0.8;
//+
Transfinite Surface {1};
//+
Transfinite Surface {2};
//+
Transfinite Surface {3};
//+
Transfinite Surface {4};
//+
Point{1} In Surface{5};
