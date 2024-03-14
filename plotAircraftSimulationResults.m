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
## @deftypefn {} {@var{retval} =} plotAircraftSimulationResults (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: jeanpaul <jeanpaul@jeanpaul-VivoBook-ASUSLaptop-X512DA-X512DA>
## Created: 2024-03-14

% plotAircraftSimulationResults.m
% function to plot fixed wing aircraft simulation results obtained with function simulateAircraft
function plotAircraftSimulationResults(t,X,Y,aircraft)
   % init global variable
    global Vbdot;
    Vbdot = [0,0,0];
  
   % airspeed
   figure(1)
   plot(t,Y(:,1) * 3600 / 1852, 'r-');grid on;xlabel="t [s]"; ylabel="Airspeed [knots]";title(["Airspeed for", aircraft.aircraftName]);
   % angle of attack
   figure(2);
   plot(t,Y(:,2) * 180 / pi, 'r-');grid on;xlabel="t [s]"; ylabel="\alpha [deg]";title(["Angle of attack", aircraft.aircraftName]);
   % angle of sideslip
   figure(3);
   plot(t,Y(:,3) * 180 / pi, 'r-');grid on;xlabel="t [s]"; ylabel="\beta [deg]";title(["Angle of sideslip", aircraft.aircraftName]);
   % roll angle
   figure(4);
   plot(t,X(:,4) * 180 / pi, 'r-');grid on;xlabel="t [s]"; ylabel="\phi [deg]";title(["Roll angle", aircraft.aircraftName]);
   % pitch angle
   figure(5);
   plot(t,X(:,5) * 180 / pi, 'r-');grid on;xlabel="t [s]"; ylabel="\theta [deg]";title(["Pitch angle", aircraft.aircraftName]);
   % yaw angle or heading
   figure(6);
   plot(t,X(:,6) * 180 / pi, 'r-');grid on;xlabel="t [s]"; ylabel="\psi [deg]";title(["Heading angle", aircraft.aircraftName]);
   
   
   % p,q,r values
   
   % roll rate
   figure(7);
   plot(t,X(:,10), 'r-');grid on;xlabel="t [s]"; ylabel="p [deg/s]";title(["Roll rate", aircraft.aircraftName]);
   % pitch rate
   figure(8);
   plot(t,X(:,11), 'r-');grid on;xlabel="t [s]"; ylabel="q [deg/s]";title(["Pitch rate", aircraft.aircraftName]);
   % yaw rate
   figure(9);
   plot(t,X(:,12), 'r-');grid on;xlabel="t [s]"; ylabel="\psi [deg]";title(["Heading angle", aircraft.aircraftName]);
   
   % position plot
   figure(10);
   plot(X(:,2),X(:1), 'r-');axis equal;grid on;xlabel="ye -> E [m]"; ylabel="xe -> N [m] ";title(["Aicraft's position", aircraft.aircraftName]);
   
   % position plot
   figure(11);
   plot(t,-X(:1), 'r-');axis equal;grid on;xlabel=" t (s)"; ylabel="h [ft] ";title(["Aicraft's position", aircraft.aircraftName]);
   
   

endfunction
