/*这个链接脚本定义了 RISC-V 程序的内存布局，主要包括以下几个部分：

.text：存放程序的可执行代码。
.rodata：存放只读数据，如常量和字符串字面量。
.eh_frame：存放异常处理数据。
.data：存放已初始化的数据。
.bss：存放未初始化的数据。
脚本还确保这些段都按照 16 字节对齐，并定义了一个 end 符号，标记程序内存区域的结束位置。
这个脚本通常用于嵌入式系统或操作系统开发，帮助有效地管理内存布局和程序的加载

这是一个针对 RISC-V 架构的链接脚本，用于定义程序各个部分在内存中的布局。当将目标文件链接成可执行文件或可加载二进制文件时，链接器会根据这个脚本来安排程序各个段的存储位置。下面是该脚本的详细解释：

1. OUTPUT_ARCH( "riscv" )
这一行告诉链接器，输出文件的目标架构是 RISC-V。它确保链接器生成适用于 RISC-V 平台的代码。
2. SECTIONS
这个关键字定义了输出文件的各个段的布局，也就是将程序的各个部分存放到内存中的位置。
3. . = 0x0;
这一行将程序的起始地址设置为 0x0，即从内存的零地址开始加载程序。
4. .text : { ... }
.text 段用于存放 可执行代码。
*(.text .text.*) 的意思是将所有以 .text 开头的部分（例如 .text、.text.foo 等）放入 .text 段，这些都是来自目标文件中的代码段。
5. .rodata : { ... }
.rodata 段用于存放 只读数据，通常包括常量、字符串字面量等在程序执行过程中不改变的数据。
ALIGN(16) 确保该段从 16 字节对齐开始，这通常是出于性能和 CPU 架构的兼容性考虑。
*(.srodata .srodata.*) 和 *(.rodata .rodata.*) 收集所有以 .srodata 和 .rodata 开头的部分，并将它们放入 .rodata 段。
6. .eh_frame : { ... }
.eh_frame 段包含异常处理相关的数据。它包括用于栈展开的必要信息，通常用于异常处理或调试。
*(.eh_frame) 和 *(.eh_frame.*) 收集所有异常处理相关的段。
7. .data : { ... }
.data 段用于存放 已初始化的数据，例如全局变量或静态变量。
ALIGN(16) 确保该段从 16 字节对齐开始。
*(.sdata .sdata.*) 和 *(.data .data.*) 收集所有以 .sdata 和 .data 开头的部分，并将它们放入 .data 段。
8. .bss : { ... }
.bss 段用于存放 未初始化的数据，这部分数据在程序启动时会被操作系统清零。例如全局变量或静态变量，如果没有显式初始化，则放入 .bss 段。
该段也按照 16 字节对齐。
*(.sbss .sbss.*) 和 *(.bss .bss.*) 收集所有以 .sbss 和 .bss 开头的部分，并将它们放入 .bss 段。
9. PROVIDE(end = .);
这一行定义了一个名为 end 的符号，它的值是当前地址（.）。这个符号通常用来标记程序内存区域的结束位置。它在堆栈和堆管理中常常被使用，也可以用来计算程序使用的内存大小。*/


OUTPUT_ARCH( "riscv" )

SECTIONS
{
 . = 0x0;
 
  .text : {
    *(.text .text.*)
  }

  .rodata : {
    . = ALIGN(16);
    *(.srodata .srodata.*) /* do not need to distinguish this from .rodata */
    . = ALIGN(16);
    *(.rodata .rodata.*)
  }

  .eh_frame : {
       *(.eh_frame)
       *(.eh_frame.*)
   }

  . = ALIGN(0x1000);
  .data : {
    . = ALIGN(16);
    *(.sdata .sdata.*) /* do not need to distinguish this from .data */
    . = ALIGN(16);
    *(.data .data.*)
  }

  .bss : {
    . = ALIGN(16);
    *(.sbss .sbss.*) /* do not need to distinguish this from .bss */
    . = ALIGN(16);
    *(.bss .bss.*)
  }

  PROVIDE(end = .);
}
