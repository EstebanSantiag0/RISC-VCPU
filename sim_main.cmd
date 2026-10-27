## ------
## Comandos de ISim para la simulacion de comportamiento de main
## (Process Properties -> Use Custom Simulation Command File)
## ------
onerror {resume}

## reloj: empieza en 1, baja a 0 a los 500 ns, periodo 1 us
isim force add /main/CLK 1 -value 0 -time 500 ns -repeat 1 us

## se registran las senales desde 0 sin mostrarlas, se corre y despues
## se agregan a la ventana; asi ISim no salta la vista al final (180 us)
## (XLXI_4 = instancia de reg_file en main.vhf)
wave log /main/CLK /main/aluOutput /main/XLXI_4/regs

## el programa termina (PC = 0x28) en ~172 ciclos
run 1 us;

## salida de la ALU en azul, decimal con signo (dec = signed decimal)
wave add /main/CLK
wave add -radix dec -color #0000FF /main/aluOutput

## banco de registros x0..x31, cada uno en decimal con signo
set regs [group add registros]
for {set i 0} {$i < 32} {incr i} {
  wave add -into $regs -radix dec -name x$i /main/XLXI_4/regs($i)
}
