% faircraft.m
% function to define the mathematical model for a fixed wing aircraft
% usage
% [xdot,y] = faircraft(t,x,delta,Vwe,deltaCGb,aircraft)
% where
% t : time (s)
% x = [pe; Phi; Vb; Omegab] : state vector
% with
%   Pe: aircraft cg position respect to earth expressed in earth frame (s)
%   Phi: [phi; theta; psi] : Euler angles (rad)
%   Vb = -[u;v;w] : aircraft velocity respect to earth expressed in body frame (m/s)
%   Omegab = [p;q;r] : aircraft angular velocity respect to earth expressed in body frame (rad/s)
% delta = [deltat; deltaf;ih;deltae;deltaa;deltar]´  
% with
%   deltat : propulsion system control (0<=deltat<=1)
%   deltaf : flaps (rad) 
%   ih : horizontal tail incidence
%   deltae : elevator (rad) NOTE: + if right aileron goes down
%   deltaa : aileron (rad)
%   deltar : rudder(rad)
%   deltaaero: [deltaf;ih;deltae;deltaa;deltar] aerodynamic's control vector (rad)
% Vwe: wind velocity expressed in earth frame (m/s) 
% deltaCGb: relative cg position respect no nominal cg expressed in body frame
% aircraft: aircraft data structure
% xdot = [pedot,phidot,Vbdot,Omegabdot] : derivative of state vector
% with
%    pedot = Ve : aircraft CG velocity respecto to earth expressed in earth frame (m/s)
%    Phidot = [phidot;thetadot;psidot] : derivate of Euler angles (rad / s)
%    Vbdot = [udot; vdot; wdot] : airfract velocity respect to earth expressed in body frame (m/s²)
%    Omegabdot = [pdot;qdot;rdot] : derivative of aircraft angular velocity relative to earth (rad/s²)
% y = [V; alpha; beta] : airspeed (m/s), angle of attack (rad), angle of sideslip (rad)
% delta
% Vwe
% deltaCGb
% aircraft

function [xdot,y] = faircraft(t,x,delta,Vwe,deltaCGb,aircraft)
  % declare Vbdot as global variable
  global Vbdot;
  
  % extract components of x and delta
  pe = x(1:3,1);
  h = -pe(3);
  Phi = x(4:6,1);
  Vb = x(7:9,1); 
  Omegab = x(10:12,1);
  deltat = delta(1,1);
  deltaaero = delta(2:,1)
  
  Cbe = DCM(Phi);
  % evaluate translational kinematics
  pedot = Cbe'*Vb;
  % evaluate rotational kinematics
  Phidot = H(Phi)*Omegab;
  % compute weight
  Ge = [0; 0; aircraft.g]
  Gb = Cbe*Ge;
  Wb = aircraft.m * Gb;
  % compute airspeed
  V = norm(Vrelb);
  % compute aerodynamic forces and moments
  % compute relative velocity
  Vrelb = Vb-Cbe*Vwe;
  % compute angle of attack
  theta = atan(Vrelb(3)/Vrelb(1));
  % sideslip angle
  sideslip = asin(Vrelb(2)/V);
  % derivative of relative velocity
  Vrelbdot = Vbdot+Omegab+cross(Omegab,Cbe*Vwe);
  % compute
  alphadot = (Vrelbdot(3) * Vrelb(1) - Vrelbdot(1) * Vrelb(3)) / (Vrelb(1)^2);
  
  % compute standard atmosphere parameters
  [rho,P,T,a] = atmosphere(h);
  
  % compute mach number
  M = V / a;
  % dynamic pressure
  qbar = 0.5*rho*V^2
  % aerodynamic forces and moments
  [Fab,Mab] = aerodynamics(V,alpha,beta,alphadot,Omegab,deltaaero,qbar,M,deltaCGb,aircraft);
  [Ftb,Mtb] = propulsion(deltat,deltaCGb,aircraft);
   
   % net force expressed in body frame
   Fnetb = Wb + Fab + Ftb;
  
   % compute translational dynamics
   Vbdot = Fnetb / aircraft.m - cross(Omegab,Vb);
   
   % net moment expressed in body frame
   Mnetb = Mab + Mtb
   
   % rotational dynamics
   Omegabdot = aircraft.Ibinv * (Mnetb - cross(Omegab,aircraft.Ib*Omegab));
   
   xdot = [pedot; Phidot; Vbdot; Omegabdot];
   y = [V; alpha; beta]
   
  
end 




