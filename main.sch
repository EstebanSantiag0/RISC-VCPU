<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_4" />
        <signal name="XLXN_7(3:0)" />
        <signal name="XLXN_10" />
        <signal name="XLXN_15" />
        <signal name="XLXN_17(31:0)" />
        <signal name="CLK" />
        <signal name="XLXN_22" />
        <signal name="XLXN_25(4:0)" />
        <signal name="XLXN_24" />
        <signal name="XLXN_28(6:0)" />
        <signal name="XLXN_31(11:0)" />
        <signal name="XLXN_32(2:0)" />
        <signal name="XLXN_33(4:0)" />
        <signal name="XLXN_204(31:0)" />
        <signal name="XLXN_206(4:0)" />
        <signal name="XLXN_220(6:0)" />
        <signal name="XLXN_227(4:0)" />
        <signal name="aluOutput(31:0)" />
        <signal name="XLXN_230(31:0)" />
        <signal name="XLXN_235(31:0)" />
        <signal name="XLXN_237(31:0)" />
        <signal name="XLXN_238(31:0)" />
        <signal name="XLXN_240(31:0)" />
        <signal name="XLXN_242" />
        <signal name="XLXN_244" />
        <signal name="XLXN_245" />
        <signal name="XLXN_248(31:0)" />
        <signal name="XLXN_249(31:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Output" name="aluOutput(31:0)" />
        <blockdef name="reg_file">
            <timestamp>2026-10-20T4:17:48</timestamp>
            <rect width="256" x="64" y="-384" height="384" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-364" height="24" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="sign_extend">
            <timestamp>2026-10-20T4:17:29</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="mux2">
            <timestamp>2026-10-20T15:15:6</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="mux25">
            <timestamp>2026-10-20T15:35:16</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="alu">
            <timestamp>2026-10-22T12:10:31</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="instruction">
            <timestamp>2026-10-23T3:27:21</timestamp>
            <rect width="256" x="64" y="-384" height="384" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="320" y="-364" height="24" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <rect width="64" x="320" y="-300" height="24" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="joiner12">
            <timestamp>2026-10-23T3:34:31</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <blockdef name="data_mem">
            <timestamp>2026-10-23T14:20:53</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
        </blockdef>
        <blockdef name="control_unit">
            <timestamp>2026-10-23T14:35:5</timestamp>
            <line x2="384" y1="96" y2="96" x1="320" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-204" height="24" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-384" height="512" />
        </blockdef>
        <blockdef name="instr_rom">
            <timestamp>2026-10-23T15:42:24</timestamp>
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="256" x="64" y="-128" height="192" />
        </blockdef>
        <blockdef name="add_mod">
            <timestamp>2026-10-23T16:36:29</timestamp>
            <rect width="256" x="64" y="-384" height="384" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-364" height="24" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
        </blockdef>
        <blockdef name="less_sign">
            <timestamp>2026-10-23T17:28:35</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-64" height="128" />
        </blockdef>
        <blockdef name="pc">
            <timestamp>2026-10-23T17:25:48</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <block symbolname="reg_file" name="XLXI_4">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_22" name="we" />
            <blockpin signalname="XLXN_206(4:0)" name="a1(4:0)" />
            <blockpin signalname="XLXN_33(4:0)" name="a2(4:0)" />
            <blockpin signalname="XLXN_227(4:0)" name="ad(4:0)" />
            <blockpin signalname="XLXN_17(31:0)" name="di(31:0)" />
            <blockpin signalname="XLXN_238(31:0)" name="do1(31:0)" />
            <blockpin signalname="XLXN_235(31:0)" name="do2(31:0)" />
        </block>
        <block symbolname="sign_extend" name="XLXI_5">
            <blockpin signalname="XLXN_31(11:0)" name="imm(11:0)" />
            <blockpin signalname="XLXN_204(31:0)" name="y(31:0)" />
        </block>
        <block symbolname="mux2" name="XLXI_7">
            <blockpin signalname="XLXN_4" name="sel" />
            <blockpin signalname="XLXN_235(31:0)" name="d0(31:0)" />
            <blockpin signalname="XLXN_204(31:0)" name="d1(31:0)" />
            <blockpin signalname="XLXN_237(31:0)" name="y(31:0)" />
        </block>
        <block symbolname="mux2" name="XLXI_9">
            <blockpin signalname="XLXN_15" name="sel" />
            <blockpin signalname="XLXN_230(31:0)" name="d0(31:0)" />
            <blockpin signalname="aluOutput(31:0)" name="d1(31:0)" />
            <blockpin signalname="XLXN_17(31:0)" name="y(31:0)" />
        </block>
        <block symbolname="alu" name="XLXI_14">
            <blockpin signalname="XLXN_238(31:0)" name="a(31:0)" />
            <blockpin signalname="XLXN_237(31:0)" name="b(31:0)" />
            <blockpin signalname="XLXN_7(3:0)" name="alu_op(3:0)" />
            <blockpin signalname="aluOutput(31:0)" name="y(31:0)" />
        </block>
        <block symbolname="joiner12" name="XLXI_19">
            <blockpin signalname="XLXN_220(6:0)" name="in7(6:0)" />
            <blockpin signalname="XLXN_25(4:0)" name="in5(4:0)" />
            <blockpin signalname="XLXN_31(11:0)" name="o(11:0)" />
        </block>
        <block symbolname="mux25" name="XLXI_10">
            <blockpin signalname="XLXN_24" name="sel" />
            <blockpin signalname="XLXN_33(4:0)" name="d0(4:0)" />
            <blockpin signalname="XLXN_227(4:0)" name="d1(4:0)" />
            <blockpin signalname="XLXN_25(4:0)" name="y(4:0)" />
        </block>
        <block symbolname="instruction" name="XLXI_18">
            <blockpin signalname="XLXN_240(31:0)" name="inst(31:0)" />
            <blockpin signalname="XLXN_220(6:0)" name="func7(6:0)" />
            <blockpin signalname="XLXN_33(4:0)" name="rs2(4:0)" />
            <blockpin signalname="XLXN_206(4:0)" name="rs1(4:0)" />
            <blockpin signalname="XLXN_32(2:0)" name="func3(2:0)" />
            <blockpin signalname="XLXN_227(4:0)" name="rd(4:0)" />
            <blockpin signalname="XLXN_28(6:0)" name="opcode(6:0)" />
        </block>
        <block symbolname="data_mem" name="XLXI_82">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_10" name="we" />
            <blockpin signalname="aluOutput(31:0)" name="a(31:0)" />
            <blockpin signalname="XLXN_235(31:0)" name="di(31:0)" />
            <blockpin signalname="XLXN_230(31:0)" name="do(31:0)" />
        </block>
        <block symbolname="control_unit" name="XLXI_85">
            <blockpin signalname="XLXN_28(6:0)" name="opcode(6:0)" />
            <blockpin signalname="XLXN_32(2:0)" name="funct3(2:0)" />
            <blockpin signalname="XLXN_220(6:0)" name="funct7(6:0)" />
            <blockpin signalname="XLXN_22" name="wer" />
            <blockpin signalname="XLXN_10" name="wem" />
            <blockpin signalname="XLXN_4" name="alu_src" />
            <blockpin signalname="XLXN_15" name="alu2reg" />
            <blockpin signalname="XLXN_24" name="imm_rd" />
            <blockpin signalname="XLXN_244" name="branch" />
            <blockpin signalname="XLXN_242" name="bneg" />
            <blockpin signalname="XLXN_7(3:0)" name="alu_op(3:0)" />
        </block>
        <block symbolname="instr_rom" name="XLXI_86">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_248(31:0)" name="addr(31:0)" />
            <blockpin signalname="XLXN_240(31:0)" name="dout(31:0)" />
        </block>
        <block symbolname="add_mod" name="XLXI_87">
            <blockpin signalname="XLXN_244" name="branch" />
            <blockpin signalname="XLXN_242" name="bneg" />
            <blockpin signalname="XLXN_245" name="aluls" />
            <blockpin signalname="XLXN_220(6:0)" name="func7(6:0)" />
            <blockpin signalname="XLXN_227(4:0)" name="rd(4:0)" />
            <blockpin signalname="XLXN_248(31:0)" name="ain(31:0)" />
            <blockpin signalname="XLXN_249(31:0)" name="aout(31:0)" />
        </block>
        <block symbolname="less_sign" name="XLXI_88">
            <blockpin signalname="XLXN_245" name="less_s" />
            <blockpin signalname="aluOutput(31:0)" name="idata(31:0)" />
        </block>
        <block symbolname="pc" name="XLXI_89">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_249(31:0)" name="din(31:0)" />
            <blockpin signalname="XLXN_248(31:0)" name="dout(31:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1664" y="864" name="XLXI_4" orien="R0">
        </instance>
        <instance x="1648" y="352" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_4">
            <wire x2="2096" y1="1152" y2="1152" x1="2064" />
            <wire x2="2096" y1="384" y2="1152" x1="2096" />
            <wire x2="2128" y1="384" y2="384" x1="2096" />
        </branch>
        <branch name="XLXN_7(3:0)">
            <wire x2="2304" y1="1344" y2="1344" x1="2064" />
            <wire x2="2304" y1="816" y2="1344" x1="2304" />
            <wire x2="2544" y1="816" y2="816" x1="2304" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="2976" y1="1088" y2="1088" x1="2064" />
            <wire x2="2976" y1="784" y2="1088" x1="2976" />
            <wire x2="3072" y1="784" y2="784" x1="2976" />
        </branch>
        <instance x="2800" y="368" name="XLXI_9" orien="R0">
        </instance>
        <branch name="XLXN_15">
            <wire x2="2352" y1="1216" y2="1216" x1="2064" />
            <wire x2="2352" y1="592" y2="1216" x1="2352" />
            <wire x2="2672" y1="592" y2="592" x1="2352" />
            <wire x2="2800" y1="208" y2="208" x1="2672" />
            <wire x2="2672" y1="208" y2="592" x1="2672" />
        </branch>
        <branch name="XLXN_17(31:0)">
            <wire x2="1568" y1="64" y2="832" x1="1568" />
            <wire x2="1664" y1="832" y2="832" x1="1568" />
            <wire x2="3264" y1="64" y2="64" x1="1568" />
            <wire x2="3264" y1="64" y2="208" x1="3264" />
            <wire x2="3264" y1="208" y2="208" x1="3184" />
        </branch>
        <branch name="CLK">
            <wire x2="480" y1="1840" y2="1840" x1="400" />
            <wire x2="1584" y1="1840" y2="1840" x1="480" />
            <wire x2="560" y1="816" y2="816" x1="480" />
            <wire x2="480" y1="816" y2="992" x1="480" />
            <wire x2="480" y1="992" y2="1840" x1="480" />
            <wire x2="928" y1="992" y2="992" x1="480" />
            <wire x2="1664" y1="512" y2="512" x1="1584" />
            <wire x2="1584" y1="512" y2="1600" x1="1584" />
            <wire x2="1584" y1="1600" y2="1840" x1="1584" />
            <wire x2="3008" y1="1600" y2="1600" x1="1584" />
            <wire x2="3072" y1="720" y2="720" x1="3008" />
            <wire x2="3008" y1="720" y2="1600" x1="3008" />
        </branch>
        <branch name="XLXN_22">
            <wire x2="1664" y1="576" y2="576" x1="1600" />
            <wire x2="1600" y1="576" y2="880" x1="1600" />
            <wire x2="2080" y1="880" y2="880" x1="1600" />
            <wire x2="2080" y1="880" y2="1024" x1="2080" />
            <wire x2="2080" y1="1024" y2="1024" x1="2064" />
        </branch>
        <instance x="2544" y="848" name="XLXI_14" orien="R0">
        </instance>
        <branch name="XLXN_25(4:0)">
            <wire x2="1120" y1="464" y2="464" x1="1072" />
            <wire x2="1136" y1="384" y2="384" x1="1120" />
            <wire x2="1120" y1="384" y2="464" x1="1120" />
        </branch>
        <branch name="XLXN_28(6:0)">
            <wire x2="1552" y1="1760" y2="1760" x1="1440" />
            <wire x2="1552" y1="1024" y2="1760" x1="1552" />
            <wire x2="1680" y1="1024" y2="1024" x1="1552" />
        </branch>
        <branch name="XLXN_31(11:0)">
            <wire x2="1648" y1="320" y2="320" x1="1520" />
        </branch>
        <branch name="XLXN_32(2:0)">
            <wire x2="1664" y1="1632" y2="1632" x1="1440" />
            <wire x2="1680" y1="1184" y2="1184" x1="1664" />
            <wire x2="1664" y1="1184" y2="1632" x1="1664" />
        </branch>
        <branch name="XLXN_33(4:0)">
            <wire x2="688" y1="528" y2="528" x1="656" />
            <wire x2="656" y1="528" y2="704" x1="656" />
            <wire x2="1536" y1="704" y2="704" x1="656" />
            <wire x2="1536" y1="704" y2="1504" x1="1536" />
            <wire x2="1664" y1="704" y2="704" x1="1536" />
            <wire x2="1536" y1="1504" y2="1504" x1="1440" />
        </branch>
        <iomarker fontsize="28" x="400" y="1840" name="CLK" orien="R180" />
        <branch name="XLXN_204(31:0)">
            <wire x2="2080" y1="320" y2="320" x1="2032" />
            <wire x2="2080" y1="320" y2="512" x1="2080" />
            <wire x2="2128" y1="512" y2="512" x1="2080" />
        </branch>
        <instance x="1056" y="1792" name="XLXI_18" orien="R0">
        </instance>
        <instance x="1136" y="416" name="XLXI_19" orien="R0">
        </instance>
        <branch name="XLXN_220(6:0)">
            <wire x2="544" y1="1184" y2="1472" x1="544" />
            <wire x2="576" y1="1472" y2="1472" x1="544" />
            <wire x2="1024" y1="1184" y2="1184" x1="544" />
            <wire x2="1024" y1="1184" y2="1296" x1="1024" />
            <wire x2="1504" y1="1296" y2="1296" x1="1024" />
            <wire x2="1504" y1="1296" y2="1344" x1="1504" />
            <wire x2="1504" y1="1344" y2="1440" x1="1504" />
            <wire x2="1680" y1="1344" y2="1344" x1="1504" />
            <wire x2="1136" y1="320" y2="320" x1="1088" />
            <wire x2="1088" y1="320" y2="480" x1="1088" />
            <wire x2="1504" y1="480" y2="480" x1="1088" />
            <wire x2="1504" y1="480" y2="1296" x1="1504" />
            <wire x2="1504" y1="1440" y2="1440" x1="1440" />
        </branch>
        <instance x="688" y="624" name="XLXI_10" orien="R0">
        </instance>
        <branch name="XLXN_24">
            <wire x2="464" y1="464" y2="1872" x1="464" />
            <wire x2="2080" y1="1872" y2="1872" x1="464" />
            <wire x2="688" y1="464" y2="464" x1="464" />
            <wire x2="2080" y1="1280" y2="1280" x1="2064" />
            <wire x2="2080" y1="1280" y2="1872" x1="2080" />
        </branch>
        <branch name="XLXN_206(4:0)">
            <wire x2="1520" y1="1568" y2="1568" x1="1440" />
            <wire x2="1520" y1="640" y2="1568" x1="1520" />
            <wire x2="1664" y1="640" y2="640" x1="1520" />
        </branch>
        <branch name="XLXN_227(4:0)">
            <wire x2="688" y1="592" y2="592" x1="448" />
            <wire x2="448" y1="592" y2="1536" x1="448" />
            <wire x2="448" y1="1536" y2="1808" x1="448" />
            <wire x2="1648" y1="1808" y2="1808" x1="448" />
            <wire x2="576" y1="1536" y2="1536" x1="448" />
            <wire x2="1648" y1="1696" y2="1696" x1="1440" />
            <wire x2="1648" y1="1696" y2="1808" x1="1648" />
            <wire x2="1664" y1="768" y2="768" x1="1648" />
            <wire x2="1648" y1="768" y2="1696" x1="1648" />
        </branch>
        <instance x="2128" y="544" name="XLXI_7" orien="R0">
        </instance>
        <branch name="aluOutput(31:0)">
            <wire x2="2496" y1="1280" y2="1280" x1="2432" />
            <wire x2="2432" y1="1280" y2="1360" x1="2432" />
            <wire x2="2960" y1="1360" y2="1360" x1="2432" />
            <wire x2="2800" y1="336" y2="336" x1="2736" />
            <wire x2="2736" y1="336" y2="576" x1="2736" />
            <wire x2="2960" y1="576" y2="576" x1="2736" />
            <wire x2="2960" y1="576" y2="688" x1="2960" />
            <wire x2="2960" y1="688" y2="848" x1="2960" />
            <wire x2="3072" y1="848" y2="848" x1="2960" />
            <wire x2="2960" y1="848" y2="1360" x1="2960" />
            <wire x2="2960" y1="688" y2="688" x1="2928" />
            <wire x2="3360" y1="528" y2="528" x1="2960" />
            <wire x2="2960" y1="528" y2="576" x1="2960" />
            <wire x2="3360" y1="480" y2="528" x1="3360" />
        </branch>
        <branch name="XLXN_230(31:0)">
            <wire x2="2800" y1="272" y2="272" x1="2720" />
            <wire x2="2720" y1="272" y2="560" x1="2720" />
            <wire x2="3504" y1="560" y2="560" x1="2720" />
            <wire x2="3504" y1="560" y2="720" x1="3504" />
            <wire x2="3504" y1="720" y2="720" x1="3456" />
        </branch>
        <iomarker fontsize="28" x="3360" y="480" name="aluOutput(31:0)" orien="R270" />
        <instance x="3072" y="944" name="XLXI_82" orien="R0">
        </instance>
        <branch name="XLXN_235(31:0)">
            <wire x2="2112" y1="832" y2="832" x1="2048" />
            <wire x2="2112" y1="832" y2="912" x1="2112" />
            <wire x2="3072" y1="912" y2="912" x1="2112" />
            <wire x2="2128" y1="448" y2="448" x1="2112" />
            <wire x2="2112" y1="448" y2="832" x1="2112" />
        </branch>
        <branch name="XLXN_237(31:0)">
            <wire x2="2560" y1="384" y2="384" x1="2512" />
            <wire x2="2560" y1="384" y2="560" x1="2560" />
            <wire x2="2560" y1="560" y2="560" x1="2512" />
            <wire x2="2512" y1="560" y2="752" x1="2512" />
            <wire x2="2544" y1="752" y2="752" x1="2512" />
        </branch>
        <branch name="XLXN_238(31:0)">
            <wire x2="2064" y1="512" y2="512" x1="2048" />
            <wire x2="2064" y1="512" y2="688" x1="2064" />
            <wire x2="2544" y1="688" y2="688" x1="2064" />
        </branch>
        <instance x="1680" y="1376" name="XLXI_85" orien="R0">
        </instance>
        <instance x="928" y="1088" name="XLXI_86" orien="R0">
        </instance>
        <branch name="XLXN_240(31:0)">
            <wire x2="1056" y1="1440" y2="1440" x1="1040" />
            <wire x2="1040" y1="1440" y2="1824" x1="1040" />
            <wire x2="1488" y1="1824" y2="1824" x1="1040" />
            <wire x2="1488" y1="992" y2="992" x1="1312" />
            <wire x2="1488" y1="992" y2="1824" x1="1488" />
        </branch>
        <instance x="576" y="1632" name="XLXI_87" orien="R0">
        </instance>
        <branch name="XLXN_242">
            <wire x2="576" y1="1344" y2="1344" x1="512" />
            <wire x2="512" y1="1344" y2="1856" x1="512" />
            <wire x2="2096" y1="1856" y2="1856" x1="512" />
            <wire x2="2096" y1="1472" y2="1472" x1="2064" />
            <wire x2="2096" y1="1472" y2="1856" x1="2096" />
        </branch>
        <branch name="XLXN_244">
            <wire x2="576" y1="1280" y2="1280" x1="560" />
            <wire x2="560" y1="1280" y2="1904" x1="560" />
            <wire x2="2160" y1="1904" y2="1904" x1="560" />
            <wire x2="2160" y1="1408" y2="1408" x1="2064" />
            <wire x2="2160" y1="1408" y2="1904" x1="2160" />
        </branch>
        <branch name="XLXN_245">
            <wire x2="576" y1="1408" y2="1408" x1="496" />
            <wire x2="496" y1="1408" y2="1888" x1="496" />
            <wire x2="2944" y1="1888" y2="1888" x1="496" />
            <wire x2="2944" y1="1216" y2="1216" x1="2880" />
            <wire x2="2944" y1="1216" y2="1888" x1="2944" />
        </branch>
        <instance x="2496" y="1248" name="XLXI_88" orien="R0">
        </instance>
        <instance x="560" y="912" name="XLXI_89" orien="R0">
        </instance>
        <branch name="XLXN_248(31:0)">
            <wire x2="528" y1="1056" y2="1600" x1="528" />
            <wire x2="576" y1="1600" y2="1600" x1="528" />
            <wire x2="864" y1="1056" y2="1056" x1="528" />
            <wire x2="928" y1="1056" y2="1056" x1="864" />
            <wire x2="864" y1="928" y2="1056" x1="864" />
            <wire x2="1024" y1="928" y2="928" x1="864" />
            <wire x2="1024" y1="816" y2="816" x1="944" />
            <wire x2="1024" y1="816" y2="928" x1="1024" />
        </branch>
        <branch name="XLXN_249(31:0)">
            <wire x2="560" y1="880" y2="880" x1="496" />
            <wire x2="496" y1="880" y2="944" x1="496" />
            <wire x2="1376" y1="944" y2="944" x1="496" />
            <wire x2="1376" y1="944" y2="1280" x1="1376" />
            <wire x2="1376" y1="1280" y2="1280" x1="960" />
        </branch>
    </sheet>
</drawing>