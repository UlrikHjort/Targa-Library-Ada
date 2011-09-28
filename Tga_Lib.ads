-------------------------------------------------------------------------------
--                                                                           --
--                               TGA Library                                 --
--                                                                           --
--                               Tga_Lib.ads                                 --
--                                                                           --
--                                  SPEC                                     --
--                                                                           --
--                   Copyright (C) 1996 Ulrik Hørlyk Hjort                   --
--                                                                           --
--  TGA Library is free software;  you can  redistribute it                  --
--  and/or modify it under terms of the  GNU General Public License          --
--  as published  by the Free Software  Foundation;  either version 2,       --
--  or (at your option) any later version.                                   --
--  TGA Library is distributed in the hope that it will be                   --
--  useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty    --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                  --
--  See the GNU General Public License for  more details.                    --
--  You should have  received  a copy of the GNU General                     --
--  Public License  distributed with Yolk.  If not, write  to  the  Free     --
--  Software Foundation,  51  Franklin  Street,  Fifth  Floor, Boston,       --
--  MA 02110 - 1301, USA.                                                    --
--                                                                           --
-------------------------------------------------------------------------------
with Interfaces; use Interfaces;

package Tga_Lib is

type Unsigned_24 is range 0 .. 2 ** 24-1;

type Tga_24bit_RGB_Buffer_T is array (Positive range <>, Positive range <>) of Unsigned_24;
pragma PACK(Tga_24bit_RGB_Buffer_T);

type Unsigned_8_Array_T is array (Positive range <>) of Unsigned_8;
pragma PACK(Unsigned_8_Array_T);



-----------------------------------------------------------------
-- Insert a point in tge TGA buffer
-- Parameters:
--  Tga_Buffer : Pointer To RGB Data Buffer
--  X          : Point X coordinate
--  Y          : Point Y coordinate
--  Color      : 24 bit color with nex format: RRGGBB
-----------------------------------------------------------------
procedure Insert_Point(Tga_Buffer : in out Tga_24bit_RGB_Buffer_T;
                       X : Positive ; Y : Positive; Color : Unsigned_24);

-----------------------------------------------------------------
-- Save A 24 Bit Uncompressed RGB Targa Image
-- Parameters:
--  Filename   : The Name of The File
--  Tga_Buffer : Pointer To RGB Data Buffer
--  Width      : Image Width
--  Height     : Image Height
-----------------------------------------------------------------
Procedure Save_Image(Filename : String; Tga_Buffer : in Tga_24bit_RGB_Buffer_T;
                                        Height : Unsigned_16; Width : Unsigned_16);

end Tga_Lib;
