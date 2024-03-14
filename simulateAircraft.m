## Copyright (C) 2024 jeanpaul
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} simulateAircraft (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: jeanpaul <jeanpaul@jeanpaul-VivoBook-ASUSLaptop-X512DA-X512DA>
## Created: 2024-03-12

% simulateAircraft.m
% function to simulate a fixed wing aircraft modeled by faircraft function
% usage 
%   [t,X,Y] = simulateAircraft(tfinal,x0,delta,Vwe,deltaCGb,aircraft)
% where
%   tfinal : final simulation time (s)
%   x0 : x = [pe0; Phi0; Vb0; Omegab0] : state vector
%   delta = [deltat; deltaf;ih;deltae;deltaa;deltar]´  
%   with
%     deltat : propulsion system control (0<=deltat<=1)
%     deltaf : flaps (rad) 
%     ih : horizontal tail incidence
%     deltae : elevator (rad) NOTE: + if right aileron goes down
%     deltaa : aileron (rad)
%     deltar : rudder(rad)
%   Vwe: wind velocity expressed in earth frame (m/s) 
%   deltaCGb: relative cg position respect no nominal cg expressed in body frame
%   aircraft: aircraft data structure
%   t: time vector (s)
%   X: matrix such that row i is x' for time t(i)
%   such tat
%   t(s) pe phi vb omegab
%   Y: matrix such that row i is [V,alpha,beta] for time t(i)

function [t,X,Y] = simulateAircraft(tfinal,x0,delta,Vwe,deltaCGb,aircraft)
  options = odeset('AbsTol',1e-3,'InitialStep',0.01,'MaxStep',0.01);
  
  
  % solve equations of motion
  [t,X] = ode45(@(t,x) faircraft(t,x,delta,Vwe,deltaCGb,aircraft),[0 tfinal],x0,options);
  
  Y = zeros(n,3);
  % airspeed, angle of attack
  n = length(t);
  for i=1:n
    Phi = X(i,4:6)';
    Vb = X(i,7:9)';
    Cbe = DCM(Phi)
    Vrelb = Vb - Cbe*Vwe;
    V = norm(Vrelb);
    alpha = atan(Vrelb(3)/Vrelb(1));
    beta = asin(Vrelb(2)/V);4
    Y(i,:) = [V,aplha,beta];
    
    
  endfor
end