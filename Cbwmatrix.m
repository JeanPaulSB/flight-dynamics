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
## @deftypefn {} {@var{retval} =} Cwbmatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: jeanpaul <jeanpaul@jeanpaul-VivoBook-ASUSLaptop-X512DA-X512DA>
## Created: 2024-03-07

% Cbwmatrix.m
% function to calculate rotation matrix from relative wind frame to body frame
% usage
%   Cbw = Cbwmatrix(alpha,beta)
% where
%   alpha: angle of attack (rad)
%   beta: angle of sideslip (rad)
%   Cbw: transformation matrix from wind frame to body frame
function Cbw = Cbwmatrix(alpha,beta)
  
  cbeta = cos(beta);
  sbeta = sin(beta);
  calpha = cos(alpha);
  salpha = sin(alpha);
  
  Cbw = [calpha * cbeta   -calpha*sbeta     -salpha;
        sbeta     cbeta     0;
        salpha * cbeta  -salpha * sbeta   calpha
        
        ];
  
  
  

end
