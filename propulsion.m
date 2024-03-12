% propulsion.
% function to calculate propulsion system forces and moments
% usage
%    [Ftb,Mtb] = propulsion(deltat,deltaCGb,aircraft)
% where
%   deltat: propulsion system control (0<=deltat<=1)
%   deltaCGb: relative cg position respect no nominal cg expressed in body framedeltaCGb:
%   Ftb: net propulsion system force (N)
%   Mtb: net propulsion system moment (Nm)



function [Ftb,Mtb] = propulsion(deltat,deltaCGb,aircraft)
  
  Ftb = [1;0;0]  * aircraft.Tmax * deltat;
  Mtb = -cross(deltaCGb,Ftb);

endfunction
