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
## @deftypefn {} {@var{retval} =} aerodynamics (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: jeanpaul <jeanpaul@jeanpaul-VivoBook-ASUSLaptop-X512DA-X512DA>
## Created: 2024-03-07

% aerodynamics.m
% function to calculate aerodynamic forces and moments for a fixed wing aircraft 
% usage
%   [Fab,Mab] = aerodynamics(V,alpha,beta,alphadot,Omegab,deltaaero,qbar,M,deltaCGb,aircraft)
% where 
%   V: airspeed (m/s)
%   alpha: angle of attack (rad)
%   beta: angle of sideslip (rad)
%   alphadot: derivative of angle of attack (rad/s)
%   Omegab = [p;q;r] : aircraft angular velocity respect to earth expressed in body frame (rad/s)
%   deltaaero = [deltaf;ih;deltae;deltaa;deltar] : aerodynamic's control vector (rad)
%     with 
%       deltaf : flaps (rad) 
%       ih : horizontal tail incidence
%       deltae : elevator (rad) NOTE: + if right aileron goes down
%       deltaa : aileron (rad)
%       deltar : rudder(rad)
%
%   
%   qbar: dynamic pressure (Pa)
%   M: Mach number
%   deltaCGb: relative CG position respect to nominal CG expressed in body frame
%   aircraft: airfract struct
%   Fab: net aerodynamic force (N)
%   Mab: net aerodynamic moment (Nm)
%   
function [Fab,Mab] = aerodynamics(V,alpha,beta,alphadot,Omegab,deltaaero,qbar,M,deltaCGb,aircraft)
    % extract components of Omegab and deltaaero
    p = Omegab(1,1);
    q = Omegab(2,1);
    r = Omegab(3,1);
    
    deltaf = deltaaero(1,1);
    ih = deltaaero(2,1);
    deltae = deltaaero(3,1);
    delaa = deltaaero(4,1);
    deltar = deltaaero(5,1);
    
    % dimensionless aerdoynamic force cofficient
    CL = aircraft.CL0 + aircraft.CLalpha * alpha + aircraft.CLdeltaf * deltaf ...
    aircraft.CLih * ih + aircraft.CLdeltae * deltae + aircraft.cbar / (2 * V) * ( aircraft.alphadot * alphadot + aircraft.Clq*q) + ...
    aircraft.CLM*(M-aircraft.M0)
    
    CD = aircraft.CD0 + (CL - aircraft.CLmindrag)² / (pi * aircraft.A * aircraft.e ) +...
    aircraft.CDM * (M - aircraft.M0);
    
    CC = aircraft.CCbeta * beta + aircraft.CCdeltaa * deltaa + aircraft.CCdeltar * deltar + ...
    aircraft.b / (2 * V ) * (aircraft.CCp * p + aircraft.CCr * r);
    
    % dimensionless aerodynamic moment coefficient
    Cl =  aircraft.Clbeta * beta + aircraft.Cldeltaa * deltaa + aircraft.Cldeltar * deltar + ...
    aircraft.b / (2 * V ) * (aircraft.Clp * p + aircraft.Clr * r);
    
    Cm = aircraft.Cm0 + aircraft.Cmalpha * alpha + aircraft.Cmdeltaf * deltaf ...
    aircraft.Cmih * ih + aircraft.Cmdeltae * deltae + aircraft.cbar / (2 * V) * ( aircraft.alphadot * alphadot + aircraft.Cmq*q) + ...
    aircraft.CLM*(M-aircraft.M0)
    
    Cn = aircraft.Cnbeta * beta + aircraft.Cndeltaa * deltaa + aircraft.Cndeltar * deltar + ...
    aircraft.b / (2 * V ) * (aircraft.Cnp * p + aircraft.Cnr * r);
    
    % compute aerodynamic forces
    D = qbar * aircraft.S * CD;
    C = qbar * aircraft.S * CC;
    L = qbar * aircraft.S * CL;
    
    Cbw = Cbwmatrix(alpha,beta);
    
    
    % net aerodynamic force expressed in wind frame
    Faw = [-D; -C; -L];
    % net aerodynamic force expressed in body frame
    Fab = Cbw * Faw;
    
   
    % aerodynamic moments
    l = qbar * aircraft.S * aircraft.b * Cl; 
    m = qbar * aircraft.S * aircraft.cbar * Cm; 
    n = qbar * aircraft.S * aircraft.b * Cn; 
    
    Mab = [l;m;n] - cross(deltaCGb,Fab);
    
 
endfunction
