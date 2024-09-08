# Enable TUI mode
#tui enable

# Change directory to 'build' (if needed)
cd build

# Load the ELF file from the 'build' directory
file fsbl.elf

# Connect to the remote target (via OpenOCD)
target extended-remote localhost:3333

# Load the binary (if needed)
load

# Set breakpoints
break main
break __tx_irq_handler
break *0x2ffc8a68
break IRQ_Handler
break system_stm32mp15x_A7_azurertos.c:312
break MainThread_Entry
# break ThreadOne_Entry
# break ThreadTwo_Entry

# (Optional) Display the layout of registers
#layout regs
