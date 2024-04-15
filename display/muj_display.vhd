

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity dominik_zkouska is
    port (
        clk     : in    std_logic;
        BTNU    : in    STD_LOGIC;
        BTND    : in    STD_LOGIC;
        BTNL    : in    STD_LOGIC;
        BTNR    : in    STD_LOGIC;
        output_display : out STD_LOGIC_VECTOR(7 downto 0):=b"0000_0000";
        AN : out STD_LOGIC_VECTOR(7 downto 0);
        seg_debug : out STD_LOGIC_VECTOR(6 downto 0);
        CA    : out   std_logic;                    --! Cathode of segment A
        CB    : out   std_logic;                    --! Cathode of segment B
        CC    : out   std_logic;                    --! Cathode of segment C
        CD    : out   std_logic;                    --! Cathode of segment D
        CE    : out   std_logic;                    --! Cathode of segment E
        CF    : out   std_logic;                    --! Cathode of segment F
        CG    : out   std_logic                     --! Cathode of segment G
    );
end entity dominik_zkouska;


architecture behavioral of dominik_zkouska is
    signal  seg: STD_LOGIC_VECTOR(6 downto 0 );
    signal counter : integer range 0 to 7 := 0;
    signal counter_BTN : INTEGER range 0 to 7 := 0;
    signal AN_save: STD_LOGIC_VECTOR(7 downto 0):=b"1111_1111";
    signal BTND_save:STD_LOGIC:= '0';
    signal BTNU_save: STD_LOGIC:= '0';
    signal BTNR_save: STD_LOGIC:= '0';
    signal BTNL_save: STD_LOGIC:= '0';
    signal seg_save_0: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    signal seg_save_1: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    signal seg_save_2: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    signal seg_save_3: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    signal seg_save_4: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    signal seg_save_5: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    signal seg_save_6: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    signal seg_save_7: STD_LOGIC_VECTOR(6 downto 0):=b"1000_000";
    
begin
    


    CA <= seg(0);
    CB <= seg(1);
    CC <= seg(2);
    CD <= seg(3);
    CE <= seg(4);
    CF <= seg(5); 
    CG <= seg(6);

    
    display_show : process(clk) --
    begin
        if (rising_edge(clk)) then
            if counter < 7 then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;
            
            case counter is
                when 0 =>
                    seg <= seg_save_0;
                    AN <= b"0111_1111";
                    seg_debug<=seg_save_0;
                when 1 =>
                    seg <= seg_save_1;
                    AN <= b"1011_1111";
                    seg_debug<= seg_save_1;
                when 2 =>
                    seg <= seg_save_2;
                    AN <= b"1101_1111";
                    seg_debug<= seg_save_2;
                when 3 =>
                    seg <= seg_save_3;
                    AN <= b"1110_1111";
                    seg_debug<= seg_save_3;
                when 4 =>
                    seg <= seg_save_4;
                    AN <=b"1111_0111";
                    seg_debug<= seg_save_4;
                when 5 =>
                    seg <= seg_save_5;
                    AN <=b"1111_1011";
                    seg_debug<= seg_save_5;
                when 6 =>
                    seg <= seg_save_6;
                    AN <=b"1111_1101";
                    seg_debug<= seg_save_6;
                when 7 =>
                    seg <= seg_save_7;
                    AN <=b"1111_1110";
                    seg_debug<= seg_save_7;
            end case;

        end if;
    end process display_show;
    
    Button_values : process(clk)
    begin
        if (rising_edge(clk)) then
            
            if (BTNU = '1') then
                BTNU_save<='1';
                BTND_save<='0';
            end if;
            
            if (BTND = '1') then
                BTND_save<='1';
                BTNU_save<='0';
            end if;
            
        end if;
    end process Button_values;
    
    
    
    seg_values : process(clk)
    begin
        if (rising_edge(clk)) then
            
            if(AN_save(7)='0') then
                
                if (BTNU='1') then
                    seg_save_0<= b"1001_111";
                    output_display(7)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_0<= b"1000_000";
                    output_display(7)<='0';
                end if;
            end if;
            
            if(AN_save(6)='0') then
                
                if (BTNU='1') then
                    seg_save_1<= b"1001_111";
                    output_display(6)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_1<= b"1000_000";
                    output_display(6)<='0';
                end if;
            end if;
            
            if(AN_save(5)='0') then
                
                if (BTNU='1') then
                    seg_save_2<= b"1001_111";
                    output_display(5)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_2<= b"1000_000";
                    output_display(5)<='0';
                end if;
            end if;
            
            if(AN_save(4)='0') then
                
                if (BTNU='1') then
                    seg_save_3<= b"1001_111";
                    output_display(4)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_3<= b"1000_000";
                    output_display(4)<='0';
                end if;
            end if;
            
            if(AN_save(3)='0') then
                
                if (BTNU='1') then
                    seg_save_4<= b"1001_111";
                    output_display(3)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_4<= b"1000_000";
                    output_display(3)<='0';
                end if;
            end if;
            
            if(AN_save(2)='0') then
                
                if (BTNU='1') then
                    seg_save_5<= b"1001_111";
                    output_display(2)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_5<= b"1000_000";
                    output_display(2)<='0';
                end if;
            end if;
            
            if(AN_save(1)='0') then
                
                if (BTNU='1') then
                    seg_save_6<= b"1001_111";
                    output_display(1)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_6<= b"1000_000";
                    output_display(1)<='0';
                end if;
            end if;
            
            if(AN_save(0)='0') then
                
                if (BTNU='1') then
                    seg_save_7<= b"1001_111";
                    output_display(0)<='1';
                end if;
                
                if (BTND='1') then
                    seg_save_7<= b"1000_000";
                    output_display(0)<='0';
                end if;
            end if;
        end if;
    end process seg_values;
    
    AN_moving : process (clk)
    begin
        if (rising_edge (clk)) then
            if (BTNR = '1') then
                if (counter_BTN = 7) then
                    counter_BTN <=0;
                else
                    counter_BTN <= counter_BTN + 1;
                end if;
            end if;
            
            if (BTNL = '1') then
                if (counter_BTN = 0) then
                    counter_BTN <=7;
                else
                    counter_BTN <= counter_BTN - 1;
                end if;
            end if;
            
            case counter_BTN is
                when 0 =>   AN_save    <= b"0111_1111";
                when 1 =>   AN_save    <= b"1011_1111";
                when 2 =>   AN_save    <= b"1101_1111";
                when 3 =>   AN_save    <= b"1110_1111";
                when 4 =>   AN_save    <= b"1111_0111";
                when 5 =>   AN_save    <= b"1111_1011";
                when 6 =>   AN_save    <= b"1111_1101";
                when 7 =>   AN_save    <= b"1111_1110";
                when others => null;
            end case;
        end if;
        
    end process AN_moving;
    
end architecture behavioral;



