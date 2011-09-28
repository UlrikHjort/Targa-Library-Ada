with Tga_Lib; use Tga_Lib;

procedure Tga_Test is
   Tga_Buffer : Tga_24bit_RGB_Buffer_T(1..100, 1..100);
begin

   for I in 1 .. 100 loop
      for J in 1 .. 100 loop
         Insert_Point(Tga_Buffer,I,J,16#FF0000#);
      end loop;
    end loop;

    Save_Image("Red.tga",Tga_Buffer,100,100);

   for I in 1 .. 100 loop
      for J in 1 .. 100 loop
         Insert_Point(Tga_Buffer,I,J,16#00FF00#);
      end loop;
    end loop;

    Save_Image("Green.tga",Tga_Buffer,100,100);

   for I in 1 .. 100 loop
      for J in 1 .. 100 loop
         Insert_Point(Tga_Buffer,I,J,16#0000FF#);
      end loop;
    end loop;

    Save_Image("Blue.tga",Tga_Buffer,100,100);


   for I in 1 .. 100 loop
      for J in 1 .. 100 loop
         Insert_Point(Tga_Buffer,I,J,16#FFFFFF#);
      end loop;
    end loop;

   for I in 1 .. 100 loop
      Insert_Point(Tga_Buffer,I,I,16#000000#);
    end loop;
    Save_Image("Line.tga",Tga_Buffer,100,100);
end Tga_Test;
