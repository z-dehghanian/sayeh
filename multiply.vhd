
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity multiply8bit is
port( a,b: in std_logic_vector(7 downto 0);
    p: out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of multiply8bit is

component Full_Adder is
port( A,B,Carry_in: in std_logic;
    Sum,Carry_out: out std_logic
    );
end component;

component Half_Adder is
  port( A,B: in std_logic;
      Sum,Carry: out std_logic);

end component;

signal ch,cg,cf,ce,cd,cc,cb,ca : std_logic_vector(7 downto 1); 
signal s : std_logic_vector(62 downto 0) ;
signal sumh,sumg,sumf,sume,sumd,sumc,sumb : std_logic_vector( 7 downto 2 ) ;
begin 
  
    
  p(0) <= a(0) and b(0) ;
  h1 : Half_Adder port map(s(1) , s(2),p(1) ,ch(1));
    s(1)<=a(0) and b(1);
    s(2)<=a(1) and b(0);
  h2 : Full_Adder port map( s(3), s(4),s(5),sumh(2),ch(2));
    s(3)<=a(0) and b(2);
    s(4)<=a(1) and b(1);
    s(5)<=a(2) and b(0);
  
  h3 : Full_Adder port map( s(6),s(7) ,s(8),sumh(3),ch(3));
  s(6)<=a(1) and b(2);
  s(7)<=a(2) and b(1);
  s(8)<=a(0) and b(3);
  h4 : Full_Adder port map(s(9) ,s(10) ,s(11),sumh(4),ch(4));
  s(9)<=a(0) and b(4);
  s(10)<=a(1) and b(3);
  s(11)<=a(2) and b(2);
  h5 : Full_Adder port map(s(12),s(13) ,s(14),sumh(5),ch(5));
  s(12)<=a(2) and b(3) ;
  s(13)<=a(1) and b(4);
  s(14)<=a(0) and b(5);
  h6 : Full_Adder port map(s(15) ,s(16) ,s(17),sumh(6),ch(6));
  s(15)<=a(2) and b(4);
  s(16)<=a(1) and b(5);
  s(17)<=a(0) and b(6);
  h7 : Full_Adder port map(s(18) ,s(19) ,s(20),sumh(7),ch(7));
  s(18)<=a(2) and b(5);
  s(19)<=a(1) and b(6);
  s(20)<=a(0) and b(7);
  
 
  g1 : Half_Adder port map(sumh(2) ,ch(1) ,p(2) ,cg(1));
  g2 : Full_Adder port map(s(21) ,sumh(3) ,ch(2),sumg(2),cg(2));
  s(21)<=a(3) and b(0);
  g3 : Full_Adder port map(s(22) ,sumh(4) ,ch(3),sumg(3),cg(3));
  s(22)<=a(3) and b(1);
  g4 : Full_Adder port map( s(23),sumh(5) ,ch(4),sumg(4),cg(4));
  s(23)<=a(3) and b(2);
  g5 : Full_Adder port map(s(24),sumh(6) ,ch(5),sumg(5),cg(5));
  s(24)<=a(3) and b(3) ;
  g6 : Full_Adder port map(s(25),sumh(7) ,ch(6),sumg(6),cg(6));
  s(25)<=a(3) and b(4) ;
  g7 : Full_Adder port map( s(26), s(27),ch(7),sumg(7),cg(7));
  s(26)<=a(1) and b(7);
  s(27)<=a(2) and b(6);
    
  f1 : Half_Adder port map(sumg(2) ,cg(1) ,p(3) ,cf(1));
  f2 : Full_Adder port map(s(28) ,sumg(3) ,cg(2),sumf(2),cf(2));
  s(28)<=a(4) and b(0);
  f3 : Full_Adder port map( s(29),sumg(4) ,cg(3),sumf(3),cf(3));
  s(29)<=a(4) and b(1);
  f4 : Full_Adder port map( s(30),sumg(5) ,cg(4),sumf(4),cf(4));
  s(30)<=a(4) and b(2);
  f5 : Full_Adder port map( s(31),sumg(6) ,cg(5),sumf(5),cf(5));
  s(31)<=a(4) and b(3);
  f6 : Full_Adder port map(s(32) ,sumg(7) ,cg(6),sumf(6),cf(6));
  s(32)<=a(3) and b(5);
  f7 : Full_Adder port map(s(33) , s(34),cg(7),sumf(7),cf(7));
  s(33)<=a(2) and b(7);
  s(34)<=a(3) and b(6);
  
  e1 : Half_Adder port map(sumf(2) ,cf(1) ,p(4) ,ce(1));
  e2 : Full_Adder port map(s(35) ,sumf(3) ,cf(2),sume(2),ce(2));
  s(35)<=a(5) and b(0);
  e3 : Full_Adder port map(s(36) ,sumf(4) ,cf(3),sume(3),ce(3));
  s(36)<=a(5) and b(1);
  e4 : Full_Adder port map( s(37),sumf(5) ,cf(4),sume(4),ce(4));
  s(37)<=a(5) and b(2);
  e5 : Full_Adder port map( s(38),sumf(6) ,cf(5),sume(5),ce(5));
  s(38)<=a(4) and b(4);
  e6 : Full_Adder port map( s(39) ,sumf(7) ,cf(6),sume(6),ce(6));
  s(39)<=a(4) and b(5);
  e7 : Full_Adder port map(s(40),s(41),cf(7),sume(7),ce(7));
  s(40)<=a(4) and b(6) ;
  s(41)<=a(3) and b(7) ;
  
  d1 : Half_Adder port map(sume(2) ,ce(1) ,p(5) ,cd(1));
  d2 : Full_Adder port map(s(42) ,sume(3) ,ce(2),sumd(2),cd(2));
  s(42)<=a(6) and b(0);
  d3 : Full_Adder port map( s(43),sume(4) ,ce(3),sumd(3),cd(3));
  s(43)<=a(6) and b(1);
  d4 : Full_Adder port map(s(44) ,sume(5) ,ce(4),sumd(4),cd(4));
  s(44)<=a(5) and b(3);
  d5 : Full_Adder port map(s(45),sume(6) ,ce(5),sumd(5),cd(5));
  s(45)<=a(5) and b(4) ;
  d6 : Full_Adder port map(s(46) ,sume(7) ,ce(6),sumd(6),cd(6));
  s(46)<=a(5) and b(5);
  d7 : Full_Adder port map( s(47),s(48) ,ce(7),sumd(7),cd(7));
  s(47)<=a(5) and b(6);
  s(48)<=a(4) and b(7);
  
  c1 : Half_Adder port map(sumd(2) ,cd(1) ,p(6) ,cc(1));
c2 : Full_Adder port map(s(49) ,sumd(3) ,cd(2),sumc(2),cc(2));
  s(49)<=a(7) and b(0);
  c3 : Full_Adder port map(s(50) ,sumd(4) ,cd(3),sumc(3),cc(3));
  s(50)<=a(6) and b(2);
  c4 : Full_Adder port map(s(51) ,sumd(5) ,cd(4),sumc(4),cc(4));
  s(51)<=a(6) and b(3);
  c5 : Full_Adder port map(s(52) ,sumd(6) ,cd(5),sumc(5),cc(5));
  s(52)<=a(6) and b(4);
  c6 : Full_Adder port map(s(53) ,sumd(7) ,cd(6),sumc(6),cc(6));
  s(53)<=a(6) and b(5);
  c7 : Full_Adder port map(s(54) ,s(55),cd(7),sumc(7),cc(7));
  s(54)<=a(6) and b(6);
  s(55)<=a(5) and b(7) ;
  
  b1 : Half_Adder port map(sumc(2) ,cc(1) ,p(7) ,cb(1));
  b2 : Full_Adder port map(s(56) ,sumc(3) ,cc(2),sumb(2),cb(2));
  s(56)<=a(7) and b(1);
  b3 : Full_Adder port map(s(57) ,sumc(4) ,cc(3),sumb(3),cb(3));
  s(57)<=a(7) and b(2);
  b4 : Full_Adder port map(s(58) ,sumc(5) ,cc(4),sumb(4),cb(4));
  s(58)<=a(7) and b(3);
  b5 : Full_Adder port map(s(59) ,sumc(6) ,cc(5),sumb(5),cb(5));
  s(59)<=a(7) and b(4);
  b6 : Full_Adder port map(s(60) ,sumc(7) ,cc(6),sumb(6),cb(6));
  s(60)<=a(7) and b(5);
  b7 : Full_Adder port map(s(61) ,s(62) ,cc(7),sumb(7),cb(7));
  s(61)<=a(7) and b(6);
  s(62)<=a(6) and b(7);
  
  a1 : Half_Adder port map(sumb(2) ,cb(1) ,p(8) ,ca(1));
  a2 : Full_Adder port map(ca(1),sumb(3) ,cb(2),p(9),ca(2));
  a3 : Full_Adder port map(ca(2) ,sumb(4) ,cb(3),p(10),ca(3));
  a4 : Full_Adder port map(ca(3) ,sumb(5) ,cb(4),p(11),ca(4));
  a5 : Full_Adder port map(ca(4) ,sumb(6) ,cb(5),p(12),ca(5));
  a6 : Full_Adder port map(ca(5) ,sumb(7) ,cb(6),p(13),ca(6));
  a7 : Half_Adder port map(ca(6) ,cb(7),p(14),p(15));
  
  
  
end behavioral ;