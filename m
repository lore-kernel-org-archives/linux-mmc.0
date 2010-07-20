From: Stephan =?ISO-8859-1?Q?S=FCrken?= <absurd@olurdix.de>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
	breaks my SD card reader [197b:2381]
Date: Tue, 20 Jul 2010 21:53:49 +0200
Message-ID: <1279655629.13390.58.camel@weslok.olx.intra>
References: <bug-15836-27@https.bugzilla.kernel.org/>
	 <201004262048.o3QKml95025961@demeter.kernel.org>
	 <20100426135800.28378e99.akpm@linux-foundation.org>
	 <20100430170614.GA22807@gargoyle.fritz.box>
	 <1272739661.10538.30.camel@weslok.olx.intra>
	 <20100501230443.GB8074@gargoyle.fritz.box>
	 <1272912441.7490.6.camel@weslok.olx.intra>
	 <20100504201302.GD13655@basil.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1H31wCt1ePljaBgZoyqv"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62822 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758581Ab0GTTzR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2010 15:55:17 -0400
In-Reply-To: <20100504201302.GD13655@basil.fritz.box>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org


--=-1H31wCt1ePljaBgZoyqv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

sorry for the delay, but I am still on it ;)

On Tue, 2010-05-04 at 22:13 +0200, Andi Kleen wrote: 
> I would suggest to check with the mmc maintainer.

linux-mmc is on CC, I hope that will suffice.

Ok, I spent some more time trying to debug this, but the only really
predictable thing seems to be that it's designed to drive me mad ;).

1st, it's definitely not just some code enabled by
CONFIG_MEMORY_HOTPLUG.
 I did a new bisect as suggested by Andi earlier (using a configuration
with CONFIG_HIBERNATION off and CONFIG_MEMORY_HOTPLUG on); the result
however was unusable as I had to change some other config in-between.
So, yes, disabling CONFIG_MEMORY_HOTPLUG seemingly consistent "fixes"
the bug, at least for kernels 2.6.30-33 using a else unchanged Debian
config. But just changing other config items (like just leaving out some
"unrelated" modules) also does the trick... 

> get initialized earlier. Presumably the timing is somewhat 
> different related to the USB scanning and the memory hotadd
> kernel being a bit slower to boot (perhaps due to the increased printks)

Then (assuming a strange race condition) I checked that 2.6.34 (I
couldn't until then build a "non-bad" 2.6.34 kernel) behaves the same;
and yes, after removing some more unrelated modules, it suddenly works.

So I did more testing with a stock 2.6.34 "Debian" kernel using a
minimal initrd and blacklisting as many modules as possible (list of
involved modules attached). With this setup, testing results became even
more random ;(. The only maybe worthy observation:

* Most (like 4 out of 5) bootups boot in a "good state" -- meaning I can
run my test again and again without failure.
* When in such a "good state", modprobing "ehci-hcd" (usb on pci pulling
in quite some internal usb devices) always triggers the "bad state".
* When in such a "good state", modprobing "r8169" (net on pci) often
(but not always) triggers the "bad state".

Ok, this all sounds a bit whacky -- but the race may be related to
(other) data on the pci bus? This would at least explain the randomness.

Anyway, I am still stumped, and lacking in-depth kernel knowledge to
further debug this -- so I'd appreciate any hints to deliver better
information.

Thx,

Stephan

--=-1H31wCt1ePljaBgZoyqv
Content-Disposition: attachment; filename=1279465070_power_boot_dmesg.2.6.34-1-amd64
Content-Type: text/plain; name=1279465070_power_boot_dmesg.2.6.34-1-amd64; charset=utf-8
Content-Transfer-Encoding: 7bit

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.34-1-amd64 (Debian 2.6.34-1~experimental.2~ab50+1) (absurd@olurdix.de) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 SMP Sun Jun 20 19:38:23 UTC 2010
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.34-1-amd64 root=/dev/mapper/weslok-root ro single
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
[    0.000000]  BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bdea8000 (usable)
[    0.000000]  BIOS-e820: 00000000bdea8000 - 00000000bdebf000 (reserved)
[    0.000000]  BIOS-e820: 00000000bdebf000 - 00000000bdf81000 (usable)
[    0.000000]  BIOS-e820: 00000000bdf81000 - 00000000bdfbf000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bdfbf000 - 00000000bdfe1000 (usable)
[    0.000000]  BIOS-e820: 00000000bdfe1000 - 00000000bdff7000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bdff7000 - 00000000be000000 (usable)
[    0.000000]  BIOS-e820: 00000000be000000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed14000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed18000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.4 present.
[    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 base 0FFF00000 mask FFFF00000 write-protect
[    0.000000]   3 base 0BE000000 mask FFE000000 uncachable
[    0.000000]   4 base 100000000 mask FC0000000 write-back
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xbe000 max_arch_pfn = 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000be000000
[    0.000000]  0000000000 - 00be000000 page 2M
[    0.000000] kernel direct mapping tables up to be000000 @ 8000-c000
[    0.000000] init_memory_mapping: 0000000100000000-0000000140000000
[    0.000000]  0100000000 - 0140000000 page 2M
[    0.000000] kernel direct mapping tables up to 140000000 @ a000-10000
[    0.000000] RAMDISK: 37c85000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000fe020 00024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 00000000bdff6120 0006C (v01 HPQOEM SLIC-MPC 00000001      01000013)
[    0.000000] ACPI: FACP 00000000bdff4000 000F4 (v04 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: DSDT 00000000bdfe4000 0B7CC (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: FACS 00000000bdf8d000 00040
[    0.000000] ACPI: DMAR 00000000bdff5000 000B0 (v01               ? 00000001      00000000)
[    0.000000] ACPI: HPET 00000000bdff3000 00038 (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: APIC 00000000bdff2000 0006C (v02 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: MCFG 00000000bdff1000 0003C (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: ASF! 00000000bdff0000 000A5 (v32 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SLIC 00000000bdfe3000 00176 (v01 HPQOEM SLIC-MPC 06040000  LTP 00000001)
[    0.000000] ACPI: BOOT 00000000bdfe2000 00028 (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 00000000bdfe1000 00655 (v01  PmRef    CpuPm 00003000 INTL 20060317)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000140000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000140000000
[    0.000000]   NODE_DATA [0000000100000000 - 0000000100004fff]
[    0.000000]   bootmap [0000000100005000 -  000000010002cfff] pages 28
[    0.000000] (10/32 early reservations) ==> bootmem [0000000000 - 0140000000]
[    0.000000]   #0 [0001000000 - 000189ae64]    TEXT DATA BSS ==> [0001000000 - 000189ae64]
[    0.000000]   #1 [0037c85000 - 0037ff0000]          RAMDISK ==> [0037c85000 - 0037ff0000]
[    0.000000]   #2 [000009e000 - 0000100000]    BIOS reserved ==> [000009e000 - 0000100000]
[    0.000000]   #3 [000189b000 - 000189b1ec]              BRK ==> [000189b000 - 000189b1ec]
[    0.000000]   #4 [0000001000 - 0000003000]       TRAMPOLINE ==> [0000001000 - 0000003000]
[    0.000000]   #5 [0000003000 - 0000007000]      ACPI WAKEUP ==> [0000003000 - 0000007000]
[    0.000000]   #6 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
[    0.000000]   #7 [000000a000 - 000000b000]          PGTABLE ==> [000000a000 - 000000b000]
[    0.000000]   #8 [0100000000 - 0100005000]        NODE_DATA ==> [0100000000 - 0100005000]
[    0.000000]   #9 [0100005000 - 010002d000]          BOOTMAP ==> [0100005000 - 010002d000]
[    0.000000]  [ffffea0000000000-ffffea00045fffff] PMD -> [ffff880100600000-ffff880103dfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000001 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00140000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000001 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000bdea8
[    0.000000]     0: 0x000bdebf -> 0x000bdf81
[    0.000000]     0: 0x000bdfbf -> 0x000bdfe1
[    0.000000]     0: 0x000bdff7 -> 0x000be000
[    0.000000]     0: 0x00100000 -> 0x00140000
[    0.000000] On node 0 totalpages: 1040178
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 107 pages reserved
[    0.000000]   DMA zone: 3834 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 759757 pages, LIFO batch:31
[    0.000000]   Normal zone: 3584 pages used for memmap
[    0.000000]   Normal zone: 258560 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000bdea8000 - 00000000bdebf000
[    0.000000] PM: Registered nosave memory: 00000000bdf81000 - 00000000bdfbf000
[    0.000000] PM: Registered nosave memory: 00000000bdfe1000 - 00000000bdff7000
[    0.000000] PM: Registered nosave memory: 00000000be000000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed14000
[    0.000000] PM: Registered nosave memory: 00000000fed14000 - 00000000fed18000
[    0.000000] PM: Registered nosave memory: 00000000fed18000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:38000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff880001a00000 s89192 r8192 d21400 u524288
[    0.000000] pcpu-alloc: s89192 r8192 d21400 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1022151
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.34-1-amd64 root=/dev/mapper/weslok-root ro single
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 4024212k/5242880k available (3073k kernel code, 1082168k absent, 136500k reserved, 3753k data, 588k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:440
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2526.874 MHz processor.
[    0.004005] Calibrating delay loop (skipped), value calculated using timer frequency.. 5053.74 BogoMIPS (lpj=10107496)
[    0.004383] Security Framework initialized
[    0.004561] SELinux:  Disabled at boot.
[    0.005001] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.009864] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.011001] Mount-cache hash table entries: 256
[    0.011312] Initializing cgroup subsys ns
[    0.011491] Initializing cgroup subsys cpuacct
[    0.011669] Initializing cgroup subsys devices
[    0.011845] Initializing cgroup subsys freezer
[    0.012011] Initializing cgroup subsys net_cls
[    0.012186] Initializing cgroup subsys blkio
[    0.012392] CPU: Physical Processor ID: 0
[    0.012567] CPU: Processor Core ID: 0
[    0.012743] mce: CPU supports 6 MCE banks
[    0.012924] CPU0: Thermal monitoring enabled (TM1)
[    0.013103] using mwait in idle threads.
[    0.013278] Performance Events: Core2 events, Intel PMU driver.
[    0.013779] ... version:                2
[    0.013954] ... bit width:              40
[    0.014128] ... generic registers:      2
[    0.014303] ... value mask:             000000ffffffffff
[    0.014479] ... max period:             000000007fffffff
[    0.014656] ... fixed-purpose events:   3
[    0.014830] ... event mask:             0000000700000003
[    0.015847] ACPI: Core revision 20100121
[    0.032074] DMAR: Host address width 36
[    0.032250] DMAR: DRHD base: 0x000000feb03000 flags: 0x0
[    0.032431] IOMMU feb03000: ver 1:0 cap c9008020e30260 ecap 1000
[    0.032609] DMAR: DRHD base: 0x000000feb02000 flags: 0x1
[    0.032789] IOMMU feb02000: ver 1:0 cap c9008020630260 ecap 1000
[    0.032967] DMAR: RMRR base: 0xf00021a4f00021a4 end: 0xf000e987f000fea5
[    0.036003] DMAR: No ATSR found
[    0.036183] Setting APIC routing to flat
[    0.036668] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.076594] CPU0: Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz stepping 0a
[    0.080000] Booting Node   0, Processors  #1
[    0.168013] Brought up 2 CPUs
[    0.172002] Total of 2 processors activated (10107.72 BogoMIPS).
[    0.172757] devtmpfs: initialized
[    0.176362] regulator: core version 0.5
[    0.176567] NET: Registered protocol family 16
[    0.176814] ACPI: bus type pci registered
[    0.177048] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.177244] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.185127] PCI: Using configuration type 1 for base access
[    0.185598] bio: create slab <bio-0> at 0
[    0.185598] ACPI: EC: Look up EC in DSDT
[    0.190694] ACPI: BIOS _OSI(Linux) query ignored
[    0.321131] ACPI: SSDT 00000000bdeb4c18 00265 (v01  PmRef  Cpu0Ist 00003000 INTL 20060317)
[    0.322259] ACPI: SSDT 00000000bdeb2618 005B3 (v01  PmRef  Cpu0Cst 00003001 INTL 20060317)
[    0.323592] ACPI: SSDT 00000000bdeb3e18 001CF (v01  PmRef    ApIst 00003000 INTL 20060317)
[    0.324520] ACPI: SSDT 00000000bdeb4f18 0008D (v01  PmRef    ApCst 00003000 INTL 20060317)
[    0.326196] ACPI: Interpreter enabled
[    0.326196] ACPI: (supports S0 S3 S4 S5)
[    0.328509] ACPI: Using IOAPIC for interrupt routing
[    0.338289] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.338686] ACPI: No dock devices found.
[    0.338862] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.339623] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.340706] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.340885] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.341064] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.341258] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xfebfffff]
[    0.341473] DMAR: Forcing write-buffer flush capability
[    0.341685] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.341688] pci 0000:00:01.0: PME# disabled
[    0.341761] pci 0000:00:1a.0: reg 20: [io  0x80e0-0x80ff]
[    0.341834] pci 0000:00:1a.1: reg 20: [io  0x80c0-0x80df]
[    0.341905] pci 0000:00:1a.7: reg 10: [mem 0xdd005c00-0xdd005fff]
[    0.341966] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.341970] pci 0000:00:1a.7: PME# disabled
[    0.342007] pci 0000:00:1b.0: reg 10: [mem 0xdd000000-0xdd003fff 64bit]
[    0.342054] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.342058] pci 0000:00:1b.0: PME# disabled
[    0.342131] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.342135] pci 0000:00:1c.0: PME# disabled
[    0.342211] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.342214] pci 0000:00:1c.1: PME# disabled
[    0.342293] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.342296] pci 0000:00:1c.3: PME# disabled
[    0.342372] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.342375] pci 0000:00:1c.4: PME# disabled
[    0.342451] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.342455] pci 0000:00:1c.5: PME# disabled
[    0.342511] pci 0000:00:1d.0: reg 20: [io  0x80a0-0x80bf]
[    0.342584] pci 0000:00:1d.1: reg 20: [io  0x8080-0x809f]
[    0.342656] pci 0000:00:1d.2: reg 20: [io  0x8060-0x807f]
[    0.342729] pci 0000:00:1d.3: reg 20: [io  0x8040-0x805f]
[    0.342799] pci 0000:00:1d.7: reg 10: [mem 0xdd005800-0xdd005bff]
[    0.342860] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.342864] pci 0000:00:1d.7: PME# disabled
[    0.343047] pci 0000:00:1f.2: reg 10: [io  0x8108-0x810f]
[    0.343053] pci 0000:00:1f.2: reg 14: [io  0x8114-0x8117]
[    0.343058] pci 0000:00:1f.2: reg 18: [io  0x8100-0x8107]
[    0.343064] pci 0000:00:1f.2: reg 1c: [io  0x8110-0x8113]
[    0.343070] pci 0000:00:1f.2: reg 20: [io  0x8020-0x803f]
[    0.343076] pci 0000:00:1f.2: reg 24: [mem 0xdd005000-0xdd0057ff]
[    0.343111] pci 0000:00:1f.2: PME# supported from D3hot
[    0.343115] pci 0000:00:1f.2: PME# disabled
[    0.343145] pci 0000:00:1f.3: reg 10: [mem 0xdd006000-0xdd0060ff 64bit]
[    0.343159] pci 0000:00:1f.3: reg 20: [io  0x8000-0x801f]
[    0.343210] pci 0000:00:1f.6: reg 10: [mem 0xdd004000-0xdd004fff 64bit]
[    0.343335] pci 0000:01:00.0: reg 10: [mem 0xd2000000-0xd2ffffff]
[    0.343356] pci 0000:01:00.0: reg 14: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.343375] pci 0000:01:00.0: reg 1c: [mem 0xd0000000-0xd1ffffff 64bit]
[    0.343389] pci 0000:01:00.0: reg 24: [io  0x7000-0x707f]
[    0.343403] pci 0000:01:00.0: reg 30: [mem 0xfff80000-0xffffffff pref]
[    0.348024] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.348202] pci 0000:00:01.0:   bridge window [io  0x7000-0x7fff]
[    0.348204] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd2ffffff]
[    0.348208] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.348306] pci 0000:02:00.0: reg 10: [mem 0xdc000000-0xdc001fff 64bit]
[    0.348405] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.348412] pci 0000:02:00.0: PME# disabled
[    0.356018] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.356197] pci 0000:00:1c.0:   bridge window [io  0x6000-0x6fff]
[    0.356200] pci 0000:00:1c.0:   bridge window [mem 0xdc000000-0xdcffffff]
[    0.356207] pci 0000:00:1c.0:   bridge window [mem 0xd3000000-0xd3ffffff 64bit pref]
[    0.356282] pci 0000:03:00.0: reg 10: [io  0x5000-0x50ff]
[    0.356303] pci 0000:03:00.0: reg 18: [mem 0xd4010000-0xd4010fff 64bit pref]
[    0.356318] pci 0000:03:00.0: reg 20: [mem 0xd4000000-0xd400ffff 64bit pref]
[    0.356327] pci 0000:03:00.0: reg 30: [mem 0xffff0000-0xffffffff pref]
[    0.356370] pci 0000:03:00.0: supports D1 D2
[    0.356371] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.356376] pci 0000:03:00.0: PME# disabled
[    0.364014] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.364193] pci 0000:00:1c.1:   bridge window [io  0x5000-0x5fff]
[    0.364197] pci 0000:00:1c.1:   bridge window [mem 0xdb000000-0xdbffffff]
[    0.364203] pci 0000:00:1c.1:   bridge window [mem 0xd4000000-0xd4ffffff 64bit pref]
[    0.364249] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    0.364428] pci 0000:00:1c.3:   bridge window [io  0x4000-0x4fff]
[    0.364432] pci 0000:00:1c.3:   bridge window [mem 0xda000000-0xdaffffff]
[    0.364438] pci 0000:00:1c.3:   bridge window [mem 0xd5000000-0xd5ffffff 64bit pref]
[    0.364520] pci 0000:06:00.0: reg 10: [mem 0xd9000000-0xd90007ff]
[    0.364531] pci 0000:06:00.0: reg 14: [mem 0xd9000d00-0xd9000d7f]
[    0.364559] pci 0000:06:00.0: reg 20: [mem 0xd9000c80-0xd9000cff]
[    0.364570] pci 0000:06:00.0: reg 24: [mem 0xd9000c00-0xd9000c7f]
[    0.364674] pci 0000:06:00.1: reg 10: [mem 0xd9000b00-0xd9000bff]
[    0.364805] pci 0000:06:00.2: reg 10: [mem 0xd9000a00-0xd9000aff]
[    0.364936] pci 0000:06:00.3: reg 10: [mem 0xd9000900-0xd90009ff]
[    0.365067] pci 0000:06:00.4: reg 10: [mem 0xd9000800-0xd90008ff]
[    0.372021] pci 0000:00:1c.4: PCI bridge to [bus 06-06]
[    0.372200] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.372204] pci 0000:00:1c.4:   bridge window [mem 0xd9000000-0xd9ffffff]
[    0.372210] pci 0000:00:1c.4:   bridge window [mem 0xd6000000-0xd6ffffff 64bit pref]
[    0.372256] pci 0000:00:1c.5: PCI bridge to [bus 07-09]
[    0.372435] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.372439] pci 0000:00:1c.5:   bridge window [mem 0xd8000000-0xd8ffffff]
[    0.372445] pci 0000:00:1c.5:   bridge window [mem 0xd7000000-0xd7ffffff 64bit pref]
[    0.372514] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a] (subtractive decode)
[    0.372695] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    0.372699] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.372705] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.372708] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.372710] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.372712] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.372714] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfebfffff] (subtractive decode)
[    0.372750] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.372987] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[    0.373071] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.373214] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.373299] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.373396] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP4._PRT]
[    0.373481] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
[    0.373617] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP6._PRT]
[    0.379814] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[    0.381588] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12)
[    0.383500] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[    0.385424] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[    0.387335] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12)
[    0.389260] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[    0.391171] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 *11 12)
[    0.393092] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.395328] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.395525] vgaarb: loaded
[    0.395742] PCI: Using ACPI for IRQ routing
[    0.396002] PCI: pci_cache_line_size set to 64 bytes
[    0.396129] reserve RAM buffer: 000000000009e000 - 000000000009ffff 
[    0.396131] reserve RAM buffer: 00000000bdea8000 - 00000000bfffffff 
[    0.396134] reserve RAM buffer: 00000000bdf81000 - 00000000bfffffff 
[    0.396136] reserve RAM buffer: 00000000bdfe1000 - 00000000bfffffff 
[    0.396138] reserve RAM buffer: 00000000be000000 - 00000000bfffffff 
[    0.396202] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.396385] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.397367] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.400016] Switching to clocksource tsc
[    0.401053] pnp: PnP ACPI init
[    0.401232] ACPI: bus type pnp registered
[    0.403689]   alloc irq_desc for 23 on node 0
[    0.403691]   alloc kstat_irqs on node 0
[    0.403938] pnp: PnP ACPI: found 12 devices
[    0.404114] ACPI: ACPI bus type pnp unregistered
[    0.404295] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.404476] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.404655] system 00:02: [io  0x0600-0x060f] has been reserved
[    0.404832] system 00:02: [io  0x0610] has been reserved
[    0.405010] system 00:02: [io  0x0800-0x080f] has been reserved
[    0.405188] system 00:02: [io  0x0810-0x0817] has been reserved
[    0.405366] system 00:02: [io  0x0820-0x0823] has been reserved
[    0.405544] system 00:02: [io  0x0400-0x047f] has been reserved
[    0.405722] system 00:02: [io  0x0500-0x053f] has been reserved
[    0.405900] system 00:02: [io  0x0380-0x038e] has been reserved
[    0.406078] system 00:02: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.406257] system 00:02: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.406436] system 00:02: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.406615] system 00:02: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.406795] system 00:02: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.406974] system 00:02: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.407154] system 00:02: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.407333] system 00:02: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.407512] system 00:02: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.407697] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.412517] pci 0000:01:00.0: no compatible bridge window for [mem 0xfff80000-0xffffffff pref]
[    0.412712] pci 0000:03:00.0: no compatible bridge window for [mem 0xffff0000-0xffffffff pref]
[    0.412957] pci 0000:01:00.0: BAR 6: can't assign mem pref (size 0x80000)
[    0.413136] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.413313] pci 0000:00:01.0:   bridge window [io  0x7000-0x7fff]
[    0.413493] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd2ffffff]
[    0.413673] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.413868] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.414046] pci 0000:00:1c.0:   bridge window [io  0x6000-0x6fff]
[    0.414227] pci 0000:00:1c.0:   bridge window [mem 0xdc000000-0xdcffffff]
[    0.414407] pci 0000:00:1c.0:   bridge window [mem 0xd3000000-0xd3ffffff 64bit pref]
[    0.414605] pci 0000:03:00.0: BAR 6: assigned [mem 0xd4020000-0xd402ffff pref]
[    0.414798] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.414975] pci 0000:00:1c.1:   bridge window [io  0x5000-0x5fff]
[    0.415157] pci 0000:00:1c.1:   bridge window [mem 0xdb000000-0xdbffffff]
[    0.415338] pci 0000:00:1c.1:   bridge window [mem 0xd4000000-0xd4ffffff 64bit pref]
[    0.415535] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    0.415717] pci 0000:00:1c.3:   bridge window [io  0x4000-0x4fff]
[    0.415897] pci 0000:00:1c.3:   bridge window [mem 0xda000000-0xdaffffff]
[    0.416078] pci 0000:00:1c.3:   bridge window [mem 0xd5000000-0xd5ffffff 64bit pref]
[    0.416276] pci 0000:00:1c.4: PCI bridge to [bus 06-06]
[    0.416453] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.416635] pci 0000:00:1c.4:   bridge window [mem 0xd9000000-0xd9ffffff]
[    0.416815] pci 0000:00:1c.4:   bridge window [mem 0xd6000000-0xd6ffffff 64bit pref]
[    0.417012] pci 0000:00:1c.5: PCI bridge to [bus 07-09]
[    0.417190] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.417372] pci 0000:00:1c.5:   bridge window [mem 0xd8000000-0xd8ffffff]
[    0.417553] pci 0000:00:1c.5:   bridge window [mem 0xd7000000-0xd7ffffff 64bit pref]
[    0.417750] pci 0000:00:1e.0: PCI bridge to [bus 0a-0a]
[    0.417926] pci 0000:00:1e.0:   bridge window [io  disabled]
[    0.418106] pci 0000:00:1e.0:   bridge window [mem disabled]
[    0.418285] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    0.418470]   alloc irq_desc for 16 on node -1
[    0.418472]   alloc kstat_irqs on node -1
[    0.418478] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.418658] pci 0000:00:01.0: setting latency timer to 64
[    0.418665]   alloc irq_desc for 17 on node -1
[    0.418666]   alloc kstat_irqs on node -1
[    0.418669] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.418850] pci 0000:00:1c.0: setting latency timer to 64
[    0.418858] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.419039] pci 0000:00:1c.1: setting latency timer to 64
[    0.419046]   alloc irq_desc for 19 on node -1
[    0.419048]   alloc kstat_irqs on node -1
[    0.419050] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.419231] pci 0000:00:1c.3: setting latency timer to 64
[    0.419239] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.419419] pci 0000:00:1c.4: setting latency timer to 64
[    0.419427] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.419607] pci 0000:00:1c.5: setting latency timer to 64
[    0.419613] pci 0000:00:1e.0: setting latency timer to 64
[    0.419617] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.419618] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.419620] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.419622] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff]
[    0.419624] pci_bus 0000:01: resource 0 [io  0x7000-0x7fff]
[    0.419625] pci_bus 0000:01: resource 1 [mem 0xd0000000-0xd2ffffff]
[    0.419627] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.419629] pci_bus 0000:02: resource 0 [io  0x6000-0x6fff]
[    0.419631] pci_bus 0000:02: resource 1 [mem 0xdc000000-0xdcffffff]
[    0.419633] pci_bus 0000:02: resource 2 [mem 0xd3000000-0xd3ffffff 64bit pref]
[    0.419634] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.419636] pci_bus 0000:03: resource 1 [mem 0xdb000000-0xdbffffff]
[    0.419638] pci_bus 0000:03: resource 2 [mem 0xd4000000-0xd4ffffff 64bit pref]
[    0.419640] pci_bus 0000:05: resource 0 [io  0x4000-0x4fff]
[    0.419641] pci_bus 0000:05: resource 1 [mem 0xda000000-0xdaffffff]
[    0.419643] pci_bus 0000:05: resource 2 [mem 0xd5000000-0xd5ffffff 64bit pref]
[    0.419645] pci_bus 0000:06: resource 0 [io  0x3000-0x3fff]
[    0.419647] pci_bus 0000:06: resource 1 [mem 0xd9000000-0xd9ffffff]
[    0.419653] pci_bus 0000:06: resource 2 [mem 0xd6000000-0xd6ffffff 64bit pref]
[    0.419655] pci_bus 0000:07: resource 0 [io  0x2000-0x2fff]
[    0.419656] pci_bus 0000:07: resource 1 [mem 0xd8000000-0xd8ffffff]
[    0.419658] pci_bus 0000:07: resource 2 [mem 0xd7000000-0xd7ffffff 64bit pref]
[    0.419660] pci_bus 0000:0a: resource 4 [io  0x0000-0x0cf7]
[    0.419662] pci_bus 0000:0a: resource 5 [io  0x0d00-0xffff]
[    0.419663] pci_bus 0000:0a: resource 6 [mem 0x000a0000-0x000bffff]
[    0.419665] pci_bus 0000:0a: resource 7 [mem 0xc0000000-0xfebfffff]
[    0.419684] NET: Registered protocol family 2
[    0.419962] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.421031] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.424792] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.425425] TCP: Hash tables configured (established 524288 bind 65536)
[    0.425605] TCP reno registered
[    0.425784] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.425997] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.426314] NET: Registered protocol family 1
[    0.426903] pci 0000:01:00.0: Boot video device
[    0.426933] PCI: CLS 64 bytes, default 64
[    0.426990] Unpacking initramfs...
[    0.489836] Freeing initrd memory: 3500k freed
[    0.491154] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.491336] Placing 64MB software IO TLB between ffff880001b9d000 - ffff880005b9d000
[    0.491530] software IO TLB at phys 0x1b9d000 - 0x5b9d000
[    0.491811] Simple Boot Flag at 0x44 set to 0x1
[    0.492260] audit: initializing netlink socket (disabled)
[    0.492447] type=2000 audit(1279464989.491:1): initialized
[    0.492960] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.494214] VFS: Disk quotas dquot_6.5.2
[    0.494424] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.494672] msgmni has been set to 7866
[    0.494993] alg: No test for stdrng (krng)
[    0.495207] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.495401] io scheduler noop registered
[    0.495576] io scheduler deadline registered
[    0.495799] io scheduler cfq registered (default)
[    0.496058] pcieport 0000:00:01.0: setting latency timer to 64
[    0.496078]   alloc irq_desc for 24 on node -1
[    0.496079]   alloc kstat_irqs on node -1
[    0.496088] pcieport 0000:00:01.0: irq 24 for MSI/MSI-X
[    0.496143] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.496178]   alloc irq_desc for 25 on node -1
[    0.496179]   alloc kstat_irqs on node -1
[    0.496186] pcieport 0000:00:1c.0: irq 25 for MSI/MSI-X
[    0.496259] pcieport 0000:00:1c.1: setting latency timer to 64
[    0.496293]   alloc irq_desc for 26 on node -1
[    0.496294]   alloc kstat_irqs on node -1
[    0.496301] pcieport 0000:00:1c.1: irq 26 for MSI/MSI-X
[    0.496375] pcieport 0000:00:1c.3: setting latency timer to 64
[    0.496409]   alloc irq_desc for 27 on node -1
[    0.496410]   alloc kstat_irqs on node -1
[    0.496417] pcieport 0000:00:1c.3: irq 27 for MSI/MSI-X
[    0.496491] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.496525]   alloc irq_desc for 28 on node -1
[    0.496526]   alloc kstat_irqs on node -1
[    0.496533] pcieport 0000:00:1c.4: irq 28 for MSI/MSI-X
[    0.496608] pcieport 0000:00:1c.5: setting latency timer to 64
[    0.496643]   alloc irq_desc for 29 on node -1
[    0.496644]   alloc kstat_irqs on node -1
[    0.496651] pcieport 0000:00:1c.5: irq 29 for MSI/MSI-X
[    0.496731] pcieport 0000:00:01.0: Requesting control of PCIe PME from ACPI BIOS
[    0.497095] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    0.497275] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.497453] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    0.497457] pcieport 0000:00:1c.0: Requesting control of PCIe PME from ACPI BIOS
[    0.497665] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    0.497844] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    0.498025] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    0.498028] pcieport 0000:00:1c.1: Requesting control of PCIe PME from ACPI BIOS
[    0.498237] pcieport 0000:00:1c.1: Signaling PME through PCIe PME interrupt
[    0.498416] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    0.498596] pcie_pme 0000:00:1c.1:pcie01: service driver pcie_pme loaded
[    0.498600] pcieport 0000:00:1c.3: Requesting control of PCIe PME from ACPI BIOS
[    0.498806] pcieport 0000:00:1c.3: Signaling PME through PCIe PME interrupt
[    0.498987] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme loaded
[    0.498991] pcieport 0000:00:1c.4: Requesting control of PCIe PME from ACPI BIOS
[    0.499200] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    0.499379] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    0.499557] pci 0000:06:00.1: Signaling PME through PCIe PME interrupt
[    0.499741] pci 0000:06:00.2: Signaling PME through PCIe PME interrupt
[    0.512760] pci 0000:06:00.3: Signaling PME through PCIe PME interrupt
[    0.512939] pci 0000:06:00.4: Signaling PME through PCIe PME interrupt
[    0.513119] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    0.513123] pcieport 0000:00:1c.5: Requesting control of PCIe PME from ACPI BIOS
[    0.513330] pcieport 0000:00:1c.5: Signaling PME through PCIe PME interrupt
[    0.513512] pcie_pme 0000:00:1c.5:pcie01: service driver pcie_pme loaded
[    0.514700] Linux agpgart interface v0.103
[    0.514934] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.515418] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
[    0.537642] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.537822] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.538038] mice: PS/2 mouse device common for all mice
[    0.538245] rtc_cmos 00:04: RTC can wake from S4
[    0.538453] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.538668] rtc0: alarms up to one month, 242 bytes nvram, hpet irqs
[    0.538861] cpuidle: using governor ladder
[    0.539049] cpuidle: using governor menu
[    0.539236] No iBFT detected.
[    0.539588] TCP cubic registered
[    0.539847] NET: Registered protocol family 10
[    0.540287] lo: Disabled Privacy Extensions
[    0.540615] Mobile IPv6
[    0.540788] NET: Registered protocol family 17
[    0.541025] PM: Resume from disk failed.
[    0.541029] registered taskstats version 1
[    0.541645] rtc_cmos 00:04: setting system clock to 2010-07-18 14:56:29 UTC (1279464989)
[    0.541875] Initalizing network drop monitor service
[    0.542091] Freeing unused kernel memory: 588k freed
[    0.542446] Write protecting the kernel read-only data: 6144k
[    0.542731] Freeing unused kernel memory: 1004k freed
[    0.543276] Freeing unused kernel memory: 848k freed
[    0.559986] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.578963] SCSI subsystem initialized
[    0.589453] libata version 3.00 loaded.
[    0.592018] ahci 0000:00:1f.2: version 3.0
[    0.592034] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.592255]   alloc irq_desc for 30 on node -1
[    0.592257]   alloc kstat_irqs on node -1
[    0.592267] ahci 0000:00:1f.2: irq 30 for MSI/MSI-X
[    0.592304] ahci: SSS flag set, parallel bus scan disabled
[    0.592504] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[    0.592699] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ccc ems sxs 
[    0.592896] ahci 0000:00:1f.2: setting latency timer to 64
[    0.615821] scsi0 : ahci
[    0.616052] scsi1 : ahci
[    0.616261] scsi2 : ahci
[    0.616468] scsi3 : ahci
[    0.616677] scsi4 : ahci
[    0.616885] scsi5 : ahci
[    0.617221] ata1: SATA max UDMA/133 abar m2048@0xdd005000 port 0xdd005100 irq 30
[    0.617416] ata2: SATA max UDMA/133 abar m2048@0xdd005000 port 0xdd005180 irq 30
[    0.617608] ata3: DUMMY
[    0.617780] ata4: DUMMY
[    0.617953] ata5: SATA max UDMA/133 abar m2048@0xdd005000 port 0xdd005300 irq 30
[    0.618147] ata6: SATA max UDMA/133 abar m2048@0xdd005000 port 0xdd005380 irq 30
[    1.092010] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.092999] ata1.00: ATA-8: ST9500325AS, 0002SPM1, max UDMA/133
[    1.093177] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.094381] ata1.00: configured for UDMA/133
[    1.108080] scsi 0:0:0:0: Direct-Access     ATA      ST9500325AS      0002 PQ: 0 ANSI: 5
[    1.996010] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.004115] ata2.00: ATAPI: HL-DT-ST BDDVDRW CT10L, YC07, max UDMA/100
[    2.013920] ata2.00: configured for UDMA/100
[    2.143196] scsi 1:0:0:0: CD-ROM            HL-DT-ST BDDVDRW CT10L    YC07 PQ: 0 ANSI: 5
[    2.460011] ata5: SATA link down (SStatus 0 SControl 300)
[    2.796010] ata6: SATA link down (SStatus 0 SControl 300)
[    2.828912] [Firmware Bug]: Invalid critical threshold (0)
[    2.830666] thermal LNXTHERM:01: registered as thermal_zone0
[    2.830848] ACPI: Thermal Zone [TZ01] (57 C)
[    3.119552] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    3.119790] sd 0:0:0:0: [sda] Write Protect is off
[    3.119969] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.119987] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.120296]  sda: sda1 sda2 sda3
[    3.493872] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.730679] device-mapper: uevent: version 1.0.3
[    3.731858] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@redhat.com
[   11.022370] PM: Starting manual resume from disk
[   11.022547] PM: Resume from partition 254:2
[   11.022548] PM: Checking hibernation image.
[   11.022899] PM: Error -22 checking image file
[   11.022900] PM: Resume from disk failed.
[   11.040990] EXT3-fs (dm-1): recovery required on readonly filesystem
[   11.041491] EXT3-fs (dm-1): write access will be enabled during recovery
[   11.335518] kjournald starting.  Commit interval 5 seconds
[   11.335710] EXT3-fs (dm-1): recovery complete
[   11.349907] EXT3-fs (dm-1): mounted filesystem with ordered data mode
[   14.304288] udevd version 125 started
[   15.223096] sdhci: Secure Digital Host Controller Interface driver
[   15.223291] sdhci: Copyright(c) Pierre Ossman
[   15.227518] sdhci-pci 0000:06:00.1: SDHCI controller found [197b:2382] (rev 0)
[   15.227732] sdhci-pci 0000:06:00.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   15.228006] sdhci-pci 0000:06:00.1: setting latency timer to 64
[   15.228048] Registered led device: mmc0::
[   15.228076] mmc0: SDHCI controller on PCI [0000:06:00.1] using DMA
[   15.228265] sdhci-pci 0000:06:00.2: SDHCI controller found [197b:2381] (rev 0)
[   15.228476] sdhci-pci 0000:06:00.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   15.228692] sdhci-pci 0000:06:00.2: Refusing to bind to secondary interface.
[   15.228878] sdhci-pci 0000:06:00.2: PCI INT A disabled
[   15.324513] mmc0: new SD card at address b368
[   15.470757] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   15.470957] Uniform CD-ROM driver Revision: 3.20
[   15.471213] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   17.180232] mmcblk0: mmc0:b368 TWTTI 489 MiB 
[   17.180452]  mmcblk0: p1 p2
[   20.750309] EXT3-fs (dm-1): using internal journal
[   21.145135] loop: module loaded
[   22.376210] Adding 24653820k swap on /dev/mapper/weslok-swap.  Priority:-1 extents:1 across:24653820k 
[   23.166504] fuse init (API version 7.13)
[   32.240867] RPC: Registered udp transport module.
[   32.241062] RPC: Registered tcp transport module.
[   32.241239] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   32.372268] Slow work thread pool: Starting up
[   32.372479] Slow work thread pool: Ready
[   32.372704] FS-Cache: Loaded
[   32.502481] FS-Cache: Netfs 'nfs' registered for caching
[   32.736177] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

--=-1H31wCt1ePljaBgZoyqv
Content-Disposition: attachment; filename=1279465070_power_boot_dmesg.2.6.34-1-amd64.lsmod
Content-Type: text/plain; name=1279465070_power_boot_dmesg.2.6.34-1-amd64.lsmod; charset=utf-8
Content-Transfer-Encoding: 7bit

Module                  Size  Used by
nfsd                  256006  2 
exportfs                3242  1 nfsd
nfs                   242626  0 
lockd                  58867  2 nfsd,nfs
fscache                30322  1 nfs
nfs_acl                 2039  2 nfsd,nfs
auth_rpcgss            33652  2 nfsd,nfs
sunrpc                162440  6 nfsd,nfs,lockd,nfs_acl,auth_rpcgss
fuse                   50718  1 
ext2                   53750  1 
loop                   11910  2 
mmc_block               7836  0 
tpm_tis                 7344  0 
tpm                     9901  1 tpm_tis
tpm_bios                4529  1 tpm
sr_mod                 12618  0 
cdrom                  29406  1 sr_mod
sdhci_pci               6338  0 
sdhci                  14102  1 sdhci_pci
mmc_core               47651  2 mmc_block,sdhci
led_class               2187  1 sdhci
ext3                  107158  1 
jbd                    38117  1 ext3
mbcache                 5058  2 ext2,ext3
sha256_generic          8700  2 
aes_x86_64              7348  2 
aes_generic            25706  1 aes_x86_64
cbc                     2547  1 
dm_crypt               10816  1 
dm_mirror              11881  0 
dm_region_hash          6864  1 dm_mirror
dm_log                  7677  2 dm_mirror,dm_region_hash
dm_snapshot            25072  0 
dm_mod                 55622  20 dm_crypt,dm_mirror,dm_log,dm_snapshot
sd_mod                 30877  3 
crc_t10dif              1284  1 sd_mod
thermal                12009  0 
fan                     3274  0 
thermal_sys            12006  2 thermal,fan
ahci                   34368  2 
libata                135105  1 ahci
scsi_mod              124629  3 sr_mod,sd_mod,libata

--=-1H31wCt1ePljaBgZoyqv--

