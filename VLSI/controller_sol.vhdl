library IEEE;

use IEEE.std_logic_1164.all;

entity controller is

   port( ph1, ph2, reset, op0, op1, op2, op3, op4, op5, zero : in std_logic;  
         memread, memwrite, pcchange, regwrite, irwrite0, irwrite1, irwrite2, 
         irwrite3, aluop0, aluop1, alusrca, alusrcb0, alusrcb1, pcsource0, 
         pcsource1, iord, memtoreg, regdst : out std_logic);

end controller;

architecture SYN_verilog of controller is

   component std_nand2
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component std_nor3
      port( A, B, C : in std_logic;  Y : out std_logic);
   end component;
   
   component std_nor2
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component std_nand3
      port( A, B, C : in std_logic;  Y : out std_logic);
   end component;
   
   component std_inv
      port( A : in std_logic;  Y : out std_logic);
   end component;
   
   component std_latch
      port( D, G : in std_logic;  Q : out std_logic);
   end component;
   
   signal nextstate_s2_1_port, state_s1_2_port, state_s2_1_port, 
	nextstate_s2_3_port, nextstate_s2_2_port, state_s2_3_port,
      state_s1_0_port,  
      state_s1_1_port, state_s2_2_port, nextstate_s2_0_port, 
      state_s2_0_port, state_s1_3_port, n264, n265, n266, n267, 
      n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, 
      n280, n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, 
      n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, 
      n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, n314, n315, 
      n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327, 
      n328 : std_logic;

begin   
   U124 : std_nand2 port map( A => n264, B => n265, Y => memread);
   U125 : std_nand2 port map( A => n266, B => n267, Y => regwrite);
   U126 : std_nor3 port map( A => n264, B => state_s2_1_port, C => n268, Y => 
                           irwrite2);
   U127 : std_nor2 port map( A => state_s2_1_port, B => n269, Y => irwrite3);
   U128 : std_nor2 port map( A => pcsource0, B => pcsource1, Y => 
                           n270);
   U129 : std_nand2 port map( A => n271, B => n272, Y => alusrca);
   U130 : std_nand2 port map( A => n264, B => n273, Y => alusrcb0);
   U131 : std_nor2 port map( A => n274, B => n275, Y => alusrcb1);
   U132 : std_nor2 port map( A => n277, B => memwrite, Y => n276);
   U133 : std_nor3 port map( A => n278, B => state_s2_2_port, C => n279, Y => 
                           regdst);
   U134 : std_nor2 port map( A => reset, B => n280, Y => nextstate_s2_0_port);
   U135 : std_nor2 port map( A => reset, B => n281, Y => nextstate_s2_1_port);
   U136 : std_nor2 port map( A => reset, B => n282, Y => nextstate_s2_2_port);
   U137 : std_nor2 port map( A => reset, B => n283, Y => nextstate_s2_3_port);
   U138 : std_nand3 port map( A => n264, B => n284, C => n285, Y => pcchange);
   U139 : std_nor3 port map( A => n286, B => n287, C => n288, Y => n283);
   U140 : std_nor3 port map( A => n289, B => n290, C => n291, Y => n282);
   U141 : std_nand2 port map( A => n278, B => n293, Y => n292);
   U142 : std_nor3 port map( A => n294, B => n295, C => n290, Y => n281);
   U143 : std_nor2 port map( A => op1, B => n297, Y => n296);
   U144 : std_nor3 port map( A => n298, B => n296, C => n291, Y => n280);
   U145 : std_nand2 port map( A => state_s2_3_port, B => n268, Y => n279);
   U146 : std_inv port map( A => state_s2_1_port, Y => n278);
   U147 : std_inv port map( A => state_s2_0_port, Y => n268);
   U148 : std_inv port map( A => state_s2_2_port, Y => n299);
   U149 : std_nand2 port map( A => state_s2_2_port, B => n278, Y => n275);
   U150 : std_nor2 port map( A => n268, B => state_s2_2_port, Y => n293);
   U151 : std_nand2 port map( A => n293, B => state_s2_3_port, Y => n271);
   U152 : std_nor2 port map( A => n275, B => n268, Y => n300);
   U153 : std_nor2 port map( A => state_s2_0_port, B => state_s2_3_port, Y => 
                           n301);
   U154 : std_nor3 port map( A => op0, B => op1, C => n303, Y => n302);
   U155 : std_nand2 port map( A => n301, B => n305, Y => n304);
   U156 : std_inv port map( A => op2, Y => n306);
   U157 : std_nand3 port map( A => n306, B => n307, C => n308, Y => n297);
   U158 : std_inv port map( A => op3, Y => n309);
   U159 : std_nand3 port map( A => n302, B => n306, C => op3, Y => n310);
   U160 : std_nor2 port map( A => state_s2_2_port, B => state_s2_3_port, Y => 
                           n311);
   U161 : std_nor3 port map( A => op4, B => op3, C => n297, Y => n312);
   U162 : std_nand2 port map( A => n313, B => n314, Y => n290);
   U163 : std_nor3 port map( A => n316, B => n277, C => n287, Y => n315);
   U164 : std_nand2 port map( A => n311, B => n268, Y => n269);
   U165 : std_nor2 port map( A => n268, B => n299, Y => n317);
   U166 : std_nand2 port map( A => n307, B => n318, Y => n303);
   U167 : std_nor2 port map( A => n304, B => n306, Y => n319);
   U168 : std_nor2 port map( A => op0, B => n304, Y => n308);
   U169 : std_nand3 port map( A => n320, B => n313, C => n321, Y => n286);
   U170 : std_nand2 port map( A => n322, B => n323, Y => n288);
   U171 : std_nand2 port map( A => n324, B => n325, Y => n289);
   U172 : std_nand3 port map( A => n326, B => n327, C => n321, Y => n294);
   U173 : std_nand2 port map( A => n269, B => n321, Y => n298);
   U174 : std_nand3 port map( A => state_s2_2_port, B => state_s2_1_port, C => 
                           n301, Y => n327);
   U175 : std_nand2 port map( A => n300, B => state_s2_3_port, Y => n313);
   U176 : std_nor3 port map( A => state_s2_1_port, B => state_s2_2_port, C => 
                           n279, Y => memwrite);
   U177 : std_nor3 port map( A => n268, B => n278, C => n264, Y => 
                           irwrite0);
   U178 : std_inv port map( A => irwrite0, Y => n325);
   U179 : std_nor2 port map( A => n269, B => n278, Y => irwrite1);
   U180 : std_inv port map( A => irwrite1, Y => n326);
   U181 : std_nor2 port map( A => n271, B => state_s2_1_port, Y => aluop1)
                           ;
   U182 : std_inv port map( A => aluop1, Y => n320);
   U183 : std_nor2 port map( A => n271, B => n278, Y => pcsource0);
   U184 : std_nor2 port map( A => n275, B => n279, Y => pcsource1);
   U185 : std_inv port map( A => pcsource1, Y => n284);
   U186 : std_nor3 port map( A => n278, B => state_s2_3_port, C => n328, Y => 
                           memtoreg);
   U187 : std_inv port map( A => memtoreg, Y => n266);
   U188 : std_nand3 port map( A => n302, B => n309, C => n319, Y => n321);
   U189 : std_inv port map( A => n312, Y => n323);
   U190 : std_nand2 port map( A => state_s2_1_port, B => n274, Y => n267);
   U191 : std_nand3 port map( A => n293, B => state_s2_1_port, C => zero, Y => 
                           n285);
   U192 : std_nand2 port map( A => op3, B => n300, Y => n322);
   U193 : std_nor3 port map( A => n297, B => op1, C => n318, Y => n316);
   U194 : std_nor2 port map( A => n310, B => n304, Y => n287);
   U195 : std_nand2 port map( A => n300, B => n309, Y => n314);
   U196 : std_nand2 port map( A => op1, B => n312, Y => n324);
   U197 : std_nand2 port map( A => n301, B => state_s2_1_port, Y => n265);
   U198 : std_nand2 port map( A => n301, B => n278, Y => n273);
   U199 : std_inv port map( A => n279, Y => n274);
   U200 : std_inv port map( A => op5, Y => n307);
   U201 : std_inv port map( A => op4, Y => n318);
   U202 : std_inv port map( A => n300, Y => n272);
   U203 : std_inv port map( A => n311, Y => n264);
   U204 : std_inv port map( A => n275, Y => n305);
   U205 : std_inv port map( A => n317, Y => n328);
   U206 : std_inv port map( A => n327, Y => n277);
   U207 : std_inv port map( A => n315, Y => n291);
   U208 : std_inv port map( A => n292, Y => n295);
   U209 : std_inv port map( A => n276, Y => iord);
   U210 : std_inv port map( A => n270, Y => aluop0);
   state_s1_reg_3_label : std_latch port map( D => nextstate_s2_3_port, G => 
                           ph2, Q => state_s1_3_port);
   state_s1_reg_2_label : std_latch port map( D => nextstate_s2_2_port, G => 
                           ph2, Q => state_s1_2_port);
   state_s1_reg_1_label : std_latch port map( D => nextstate_s2_1_port, G => 
                           ph2, Q => state_s1_1_port);
   state_s1_reg_0_label : std_latch port map( D => nextstate_s2_0_port, G => 
                           ph2, Q => state_s1_0_port);
   state_s2_reg_3_label : std_latch port map( D => state_s1_3_port, G => ph1, Q
                           => state_s2_3_port);
   state_s2_reg_2_label : std_latch port map( D => state_s1_2_port, G => ph1, Q
                           => state_s2_2_port);
   state_s2_reg_1_label : std_latch port map( D => state_s1_1_port, G => ph1, Q
                           => state_s2_1_port);
   state_s2_reg_0_label : std_latch port map( D => state_s1_0_port, G => ph1, Q
                           => state_s2_0_port);

end SYN_verilog;
