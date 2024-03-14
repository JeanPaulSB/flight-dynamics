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
## @deftypefn {} {@var{retval} =} testSimulationAircraft (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: jeanpaul <jeanpaul@jeanpaul-VivoBook-ASUSLaptop-X512DA-X512DA>
## Created: 2024-03-14
% simulate aircraft

% recall aircraft data structure
Navion_aircraft;

% set CG relative position respect to nominal CG
deltaCGb = [0;0;0]

% set wind velocity
Vwe = [0;0;0];

% simulation time
tfinal = 10;

% define initial conditons



% simulate aircraft
[t,X,Y] = simulateAircraft(tfinal,x0,delta,Vwe,deltaCGb,aircraft)