/**********************************************************************/
/*                                                                    */
/*             -------                                                */
/*            /   SOC  \                                              */
/*           /    GEN   \                                             */
/*          /     LIB    \                                            */
/*          ==============                                            */
/*          |            |                                            */
/*          |____________|                                            */
/*                                                                    */
/*  Generic model for a rate divider                                  */
/*                                                                    */
/*  Author(s):                                                        */
/*      - John Eaton, jt_eaton@opencores.org                          */
/*                                                                    */
/**********************************************************************/
/*                                                                    */
/*    Copyright (C) <2010>  <Ouabache Design Works>                   */
/*                                                                    */
/*  This source file may be used and distributed without              */
/*  restriction provided that this copyright statement is not         */
/*  removed from the file and that any derivative work contains       */
/*  the original copyright notice and the associated disclaimer.      */
/*                                                                    */
/*  This source file is free software; you can redistribute it        */
/*  and/or modify it under the terms of the GNU Lesser General        */
/*  Public License as published by the Free Software Foundation;      */
/*  either version 2.1 of the License, or (at your option) any        */
/*  later version.                                                    */
/*                                                                    */
/*  This source is distributed in the hope that it will be            */
/*  useful, but WITHOUT ANY WARRANTY; without even the implied        */
/*  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR           */
/*  PURPOSE.  See the GNU Lesser General Public License for more      */
/*  details.                                                          */
/*                                                                    */
/*  You should have received a copy of the GNU Lesser General         */
/*  Public License along with this source; if not, download it        */
/*  from http://www.opencores.org/lgpl.shtml                          */
/*                                                                    */
/**********************************************************************/



module 
cde_divider
  
#(parameter   SIZE=4,
  parameter   SAMPLE=0,            
  parameter   RESET=1            
 )  
(
input  wire              clk,
input  wire              reset,
input  wire              enable,
input  wire [SIZE-1:0]   divider_in,
output  reg              divider_out
                         );

reg  [SIZE-1:0]        divide_cnt;

always@(posedge clk)
  if(reset)            divider_out    <= RESET;
  else
  if(!enable)          divider_out    <= 1'b0;  
  else                 divider_out    <=  ( divide_cnt == SAMPLE );       



always@(posedge clk)
  if(reset)            divide_cnt    <= divider_in;
  else
  if(!enable)          divide_cnt    <= divide_cnt;
  else
  if(!(|divide_cnt))   divide_cnt    <= divider_in;
  else                 divide_cnt    <= divide_cnt - 'b1;





   
endmodule



