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
## @deftypefn {} {@var{retval} =} DCM (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: jeanpaul <jeanpaul@jeanpaul-VivoBook-ASUSLaptop-X512DA-X512DA>
## Created: 2024-03-05

% DCM.m
% function to calculate Hmatrix such that Phidot = Hmatrix*Omegab
% usage
%   Hmatrix = H(Phi)
% where
%   Phi = [phi;theta;psi] : Euler angles (rad)
%     with
%       theta : pitch (rad)
%       psi : yaw or heading (rad)
%   Hmatrix : matrix such that Phidot = Hmatrix*Omegab

function Hmatrix = H(Phi)
  % extract euler angles from Phi
  phi = Phi(1,1);
  theta = Phi(2,1);
  psi = Phi(3,1);
  
  ctheta = cos(theta);
  ttheta = tan(theta);
  cphi = cos(phi); 
  sphi = sin(phi); 
  
  % calculate Hmatrix

  
 Hmatrix = [ 
   1  ttheta*sphi ttheta*cphi;
   0  cphi        -sphi;
   0  sphi/ctheta cphi/ctheta
];  



endfunction
