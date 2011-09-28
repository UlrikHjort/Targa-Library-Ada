-------------------------------------------------------------------------------
--                                                                           --
--                               TGA Library                                 --
--                                                                           --
--                               Tga_Lib.adb                                 --
--                                                                           --
--                                  BODY                                     --
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
with Ada.Sequential_IO;

package body Tga_Lib is

   -----------------------------------------------------------------
   -- Write TGA Header for a 24 bit uncompressed RGB TGA Image
   -- Parameters:
   --  Filename   : The Name of The File
   --  Width      : Image Width
   --  Height     : Image Height
   -----------------------------------------------------------------
   procedure Write_Header(Filename : String; Height : Unsigned_16; Width : Unsigned_16) is
      Tga_Header : Unsigned_8_Array_T (1..18) := (others => 0);

      package Seq_IO is new Ada.Sequential_IO(Unsigned_8);
      use Seq_IO;

      Output_File : Seq_IO.FILE_TYPE;

   begin
      Tga_Header(3) := 2;
      Tga_Header(13) := Unsigned_8(16#00FF# and Width);
      Tga_Header(14) := Unsigned_8(16#00FF# and Shift_Right(Width,8));
      Tga_Header(15) := Unsigned_8(16#00FF# and Height);
      Tga_Header(16) := Unsigned_8(16#00FF# and Shift_Right(height,8));
      Tga_Header(17) := 24;
      Tga_Header(18) := 32;

      Create(Output_File, Out_File, Filename);

      for I in Tga_Header'First .. Tga_Header'Last loop
         Write(Output_File, Tga_Header(I));
         end loop;
     Close(Output_File);
   end Write_Header;


   -----------------------------------------------------------------
   -- Insert a point in tge TGA buffer
   -- Parameters:
   --  Tga_Buffer : Pointer To RGB Data Buffer
   --  X          : Point X coordinate
   --  Y          : Point Y coordinate
   --  Color      : 24 bit color with nex format: RRGGBB
   -----------------------------------------------------------------
   procedure Insert_Point(Tga_Buffer : in out Tga_24bit_RGB_Buffer_T;
                          X : Positive ; Y : Positive; Color : Unsigned_24) is

      R : constant Unsigned_32 := 16#000000FF# and Shift_Right(Unsigned_32(Color),16);
      G : constant Unsigned_32 := 16#00FF0000# and Shift_Left(Unsigned_32(Color),8);
      B : constant Unsigned_32 := 16#0000FF00# and Shift_Left(Unsigned_32(Color),8);

   begin
          Tga_Buffer(X,Y) := Unsigned_24(R or G or B);
   end Insert_Point;


   -----------------------------------------------------------------
   -- Save A 24 Bit Uncompressed RGB Targa Image
   -- Parameters:
   --  Filename   : The Name of The File
   --  Tga_Buffer : Pointer To RGB Data Buffer
   --  Width      : Image Width
   --  Height     : Image Height
   -----------------------------------------------------------------
   Procedure Save_Image(Filename : String; Tga_Buffer : in Tga_24bit_RGB_Buffer_T;
                                        Height : Unsigned_16; Width : Unsigned_16) is

    package Seq_IO is new Ada.Sequential_IO(Tga_24bit_RGB_Buffer_T);
      use Seq_IO;

      Output_File : Seq_IO.FILE_TYPE;

 begin
     Write_Header(Filename, Height, Width);
     Open(Output_File, Append_File, Filename);
     Write(Output_File, Tga_Buffer);
     Close(Output_File);
   end Save_Image;
end Tga_Lib;
