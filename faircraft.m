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
  % extract components of x and delta
  pe = x(1:3,1);
  Phi = x(4:6,1);
  Vb = x(7:9,1); 
  Omegab = x(10:12,1);
  deltat = delta(1,1);
  deltaaero = delta(2:,1)
  
  
  % evaluate translational kinematics
  pedot = Cbe'

  xdot = 3
  y = 4
  
end




