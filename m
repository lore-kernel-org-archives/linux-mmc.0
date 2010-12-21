From: Philip Rakity <prakity@marvell.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Tue, 21 Dec 2010 14:41:23 -0800
Message-ID: <3C63CE33-680C-400C-AF55-12380B5950A2@marvell.com>
References: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
 <5BB47468-20D7-4A7B-B8AD-FD2BA06973D5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42918 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752862Ab0LUWq2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Dec 2010 17:46:28 -0500
In-Reply-To: <5BB47468-20D7-4A7B-B8AD-FD2BA06973D5@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>, Zhangfei Gao <zgao6@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>


On Dec 21, 2010, at 1:34 PM, Philip Rakity wrote:

>
> On Dec 21, 2010, at 4:37 AM, zhangfei gao wrote:
>
>> v3: sync to mmc-next
>>
>> Emmc speed could double if using ddr50 mode, help check
>>
>> From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:00 2001
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Tue, 21 Dec 2010 19:51:38 -0500
>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>
>>      1. spec sdhc 3.0 does not claim support 1.2v ddr mode
>>      2. Call back function set_power is added, since some controller count
>> on external pmic to provide power
>>      3. According to spec sdhc 3.0, uhs mode, including emmc ddr50 takes
>> effect only when 1.8v Signaling Enable bit, which used for providing
>> 1.8v.
>>         So emmc ddr50 mode works after 1.8v switching process, though emmc
>> ddr50 could work at high voltage such as 3.3v if external pmic provide
>> voltage.
>>         Limitation: emmc ddr50 mode only workable when both host and emmc
>> card support 1.70-1.90v
>>      4. According to JESD84, power down and power up is required to
>> provide low voltage 1.70-1.90v to mmc.
>>
>>      Verified: toshiba emmc on mmp2, with io voltage at 1.8v provided by
>> external pmic.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> drivers/mmc/core/core.c  |   13 +++++++++++++
>> drivers/mmc/core/core.h  |    1 +
>> drivers/mmc/core/mmc.c   |    6 +++++-
>> drivers/mmc/host/sdhci.c |   44 +++++++++++++++++++++++++++++++++++++++++---
>> drivers/mmc/host/sdhci.h |   14 +++++++++++++-
>> 5 files changed, 73 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index a8e89f3..fd657f1 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host *host)
>> }
>>
>> /*
>> + * mmc select low voltage 1.70-1.95v
>> + */
>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
>> +{
>> +     if (!(ocr & MMC_VDD_165_195))
>> +             return;
>> +
>> +     mmc_power_off(host);
>> +     host->ocr = ocr & host->ocr_avail;
>> +     mmc_power_up(host);
>> +}
>> +
>> +/*
>> * Cleanup when the last reference to the bus operator is dropped.
>> */
>> static void __mmc_release_bus(struct mmc_host *host)
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 026c975..b05c20a 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
>> unsigned int width);
>> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
>>                         unsigned int ddr);
>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
>> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>
>> static inline void mmc_delay(unsigned int ms)
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 86cac0d..8779339 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
>>              ocr &= ~0x7F;
>>      }
>>
>> -     host->ocr = mmc_select_voltage(host, ocr);
>> +     if ((ocr & MMC_VDD_165_195)
>> +                     && (host->ocr_avail & MMC_VDD_165_195))
>> +             mmc_select_low_voltage(host, ocr);
>> +     else
>> +             host->ocr = mmc_select_voltage(host, ocr);
>>
>>      /*
>>       * Can we support the voltage of the card?
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d5febe5..aafbb42 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>      host->cmd = NULL;
>> }
>>
>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
>> +{
>> +     u16 con;
>> +
>> +     if (ddr == MMC_SDR_MODE)
>> +             return;
>> +
>> +     con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +     if (con & SDHCI_CTRL2_1_8V) {
>> +             con &= ~SDHCI_CTRL2_UHS_MASK;
>> +             if (ddr & MMC_1_8V_DDR_MODE)
>> +                     con |= SDHCI_CTRL2_DDR50;
>> +             sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>> +     }
>> +}
>> +
>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>> {
>>      int div;
>> @@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_host
>> *host, unsigned short power)
>>              return;
>>      }
>>
>> +     if ((pwr == SDHCI_POWER_180) &&
>> +             (host->mmc->caps & MMC_CAP_1_8V_DDR)) {
>> +             u16 con;
>> +
>> +             con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +             con |= SDHCI_CTRL2_1_8V;
>> +             sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>> +
>> +             if (host->ops->set_power)
>> +                     host->ops->set_power(host, pwr);
>> +     }
>> +
>>      /*
>>       * Spec says that we should clear the power reg before setting
>>       * a new value. Some controllers don't seem to like this though.
>> @@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
>> struct mmc_ios *ios)
>>      }
>>
>>      sdhci_set_clock(host, ios->clock);
>> +     sdhci_set_ddr(host, ios->ddr);
>>
>>      if (ios->power_mode == MMC_POWER_OFF)
>>              sdhci_set_power(host, -1);
>> @@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>> int sdhci_add_host(struct sdhci_host *host)
>> {
>>      struct mmc_host *mmc;
>> -     unsigned int caps, ocr_avail;
>> +     unsigned int caps, caps_h = 0, ocr_avail;
>>      int ret;
>>
>>      WARN_ON(host == NULL);
>> @@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *host)
>>                      host->version);
>>      }
>>
>> -     caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>> -             sdhci_readl(host, SDHCI_CAPABILITIES);
>> +     if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>> +             caps = host->caps;
>> +     else {
>> +             caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +             caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>> +     }
>> +
>> +     if (caps & SDHCI_CAN_VDD_180) {
>> +             if (caps_h & SDHCI_CAN_SDR50)
>> +                     mmc->caps |= (MMC_CAP_1_8V_DDR);
>> +     }
>>
>>      if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>              host->flags |= SDHCI_USE_SDMA;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 6e0969e..c4bd5dd 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -145,7 +145,14 @@
>>
>> #define SDHCI_ACMD12_ERR      0x3C
>>
>> -/* 3E-3F reserved */
>> +#define SDHCI_HOST_CONTROL2  0x3E
>> +#define  SDHCI_CTRL2_UHS_MASK        0x0007
>> +#define   SDHCI_CTRL2_SDR12  0x0000
>> +#define   SDHCI_CTRL2_SDR25  0x0001
>> +#define   SDHCI_CTRL2_SDR50  0x0002
>> +#define   SDHCI_CTRL2_SDR104 0x0003
>> +#define   SDHCI_CTRL2_DDR50  0x0004
>> +#define  SDHCI_CTRL2_1_8V    0x0008
>>
>> #define SDHCI_CAPABILITIES    0x40
>> #define  SDHCI_TIMEOUT_CLK_MASK       0x0000003F
>> @@ -167,6 +174,9 @@
>> #define  SDHCI_CAN_64BIT      0x10000000
>>
>> #define SDHCI_CAPABILITIES_1  0x44
>> +#define  SDHCI_CAN_SDR50     0x00000001
>> +#define  SDHCI_CAN_SDR104    0x00000002
>> +#define  SDHCI_CAN_DDR50     0x00000004
>>
>> #define SDHCI_MAX_CURRENT     0x48
>>
>> @@ -222,6 +232,8 @@ struct sdhci_ops {
>>      void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>                                           u8 power_mode);
>>      unsigned int    (*get_ro)(struct sdhci_host *host);
>> +     unsigned int    (*set_power)(struct sdhci_host *host,
>> +                             unsigned short power);
>> };
>>
>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> --
>> 1.7.0.4
>> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>
>
>
>
> Does not work for me on mmp2 using linux next.  Partition table not found
> trace below
> Loading: #################################################################
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>         ########################################################
> done
> Bytes transferred = 1766924 (1af60c hex)
> MMP2>> boot
> Ready to boot zImage from 1100000
>
>
> Starting kernel ...
>
> [    0.000000] Linux version 2.6.37-rc6-next-20101220-00022-g8b35e00-dirty (root@philip-laptop) (gcc version 4.2.0 20070413 (prerelease) (CodeSourcery 2007q1-10. Marvell 2009q3-18 20090821)) #51 PREEMPT Tu0
> [    0.000000] CPU: Marvell PJ4 processor [560f5815] revision 5 (ARMv7), cr=00c5387f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: Brownstone Development Platform
> [    0.000000] Ignoring unrecognised tag 0x41000403
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] On node 0 totalpages: 131072
> [    0.000000] free_area_init_node: node 0, pgdat c03713d0, node_mem_map c0390000
> [    0.000000]   Normal zone: 1024 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 130048 pages, LIFO batch:31
> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> [    0.000000] pcpu-alloc: [0] 0
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
> [    0.000000] Kernel command line: debug rootdelay=15 root=/dev/mmcblk0p1 rootfstype=ext3 console=ttyS2,38400 mem=512M uart_dma mbr_offset=0x4800
> [    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Memory: 512MB = 512MB total
> [    0.000000] Memory: 516108k/516108k available, 8180k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
> [    0.000000]     vmalloc : 0xe0800000 - 0xfe000000   ( 472 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .init : 0xc0008000 - 0xc001f000   (  92 kB)
> [    0.000000]       .text : 0xc001f000 - 0xc0354004   (3285 kB)
> [    0.000000]       .data : 0xc0356000 - 0xc0372c40   ( 116 kB)
> [    0.000000] Preemptable hierarchical RCU implementation.
> [    0.000000]  RCU-based detection of stalled CPUs is disabled.
> [    0.000000]  Verbose stalled-CPUs detection is disabled.
> [    0.000000] NR_IRQS:320 nr_irqs:360 360
> [    0.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, wraps every 660764ms
> [    0.000000] Console: colour dummy device 80x30
> [    0.000023] Calibrating delay loop... 796.26 BogoMIPS (lpj=3981312)
> [    0.220162] pid_max: default: 32768 minimum: 301
> [    0.220323] Mount-cache hash table entries: 512
> [    0.220629] CPU: Testing write buffer coherency: ok
> [    0.224390] print_constraints: dummy: regulator:
> [    0.224390] NET: Registered protocol family 16
> [    0.224518] Tauros2: Disabling L2 prefetch.
> [    0.224560] Tauros2: L2 cache support initialised in ARMv6 mode.
> [    0.227660] bio: create slab <bio-0> at 0
> [    0.228859] Switching to clocksource clocksource
> [    0.233823] NET: Registered protocol family 2
> [    0.233966] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.234294] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> [    0.234544] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.234544] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.234661] TCP reno registered
> [    0.234674] UDP hash table entries: 256 (order: 0, 4096 bytes)
> [    0.234688] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> [    0.234868] NET: Registered protocol family 1
> [    0.235278] RPC: Registered udp transport module.
> [    0.235278] RPC: Registered tcp transport module.
> [    0.235295] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.237007] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
> [    0.237253] msgmni has been set to 1008
> [    0.237921] io scheduler noop registered
> [    0.237937] io scheduler deadline registered
> [    0.237937] io scheduler cfq registered (default)
> [    0.238510] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (irq = 27) is a FFUART
> [    0.238510] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq = 24) is a STUART
> [    1.352386] console [ttyS2] enabled
> [    1.363462] mousedev: PS/2 mouse device common for all mice
> [    1.380052] sdhci: Secure Digital Host Controller Interface driver
> [    1.398589] sdhci: Copyright(c) Pierre Ossman
> [    1.411584] set_clock_and_burst_size:mmc0: adjust = 1
> [    1.426715] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_BURST = 00C5, delay = 15, sel = 1
> [    1.452068] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 1FC5
> [    1.474880] mmc0: no vmmc regulator found
> [    1.486806] set_clock_and_burst_size:mmc0: adjust = 1
> [    1.501827] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_BURST = 00C5, delay = 15, sel = 1
> [    1.527204] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 1FC5
> [    1.549982] sdhci: =========== REGISTER DUMP (mmc0)===========
> [    1.567313] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
> [    1.584666] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
> [    1.602003] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> [    1.619344] sdhci: Present:  0x01fa0000 | Host ctl: 0x00000000
> [    1.636685] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
> [    1.654029] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
> [    1.671373] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
> [    1.688713] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
> [    1.706058] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> [    1.723399] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
> [    1.740741] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
> [    1.758081] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
> [    1.775432] sdhci: ===========================================
> [    1.792896] mmc_power_off:mmc0: ENTER
> [    1.803799] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
> [    1.825042] set_clock_and_burst_size:mmc0: adjust = 1
> [    1.825042] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_BURST = 00C5, delay = 15, sel = 1
> [    1.840029] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 1FC5
> [    1.888227] mmc0: SDHCI controller on MMC [sdhci-pxa.2] using ADMA
> [    1.906642] mmc0: mmc_rescan: trying to init card at 400000 Hz
> [    1.924028] mmc_power_up:mmc0: ENTER
> [    1.934670] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
> [    1.956225] set_clock_and_burst_size:mmc1: adjust = 1
> [    1.971333] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
> [    1.994208] generate_initial_74_clocks:mmc0 ENTER: slot->power_mode = 1,ios->power_mode = 2
> [    2.019862] set_clock_and_burst_size:mmc1: (B) SD_CLOCK_AND_BURST = 00C5, delay = 31, sel = 1
> [    2.045262] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
> [    2.068038] mmc0: starting CMD52 arg 00000c00 flags 00000195
> [    2.084902] set_clock_and_burst_size:mmc1: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 3FC5
> [    2.107679] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.126336] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
> [    2.147563] mmc0: starting CMD52 arg 80000c08 flags 00000195
> [    2.164426] mmc1: no vmmc regulator found
> [    2.176382] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.195017] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
> [    2.216291] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
> [    2.239066] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [    2.256653] set_clock_and_burst_size:mmc1: adjust = 1
> [    2.271682] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    2.290309] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> [    2.310497] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
> [    2.334306] mmc0: starting CMD8 arg 000001aa flags 000002f5
> [    2.351886] set_clock_and_burst_size:mmc1: (B) SD_CLOCK_AND_BURST = 00C5, delay = 31, sel = 1
> [    2.377254] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.395890] mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
> [    2.416880] mmc0: starting CMD5 arg 00000000 flags 000002e1
> [    2.433487] set_clock_and_burst_size:mmc1: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 3FC5
> [    2.456268] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.474916] mmc0: req failed (CMD5): -110, retrying...
> [    2.490186] sdhci: =========== REGISTER DUMP (mmc1)===========
> [    2.507544] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.526177] mmc0: req failed (CMD5): -110, retrying...
> [    2.541469] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
> [    2.558803] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.577433] mmc0: req failed (CMD5): -110, retrying...
> [    2.592713] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
> [    2.610051] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.628684] mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
> [    2.649651] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    2.666514] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> [    2.683870] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.702501] mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> [    2.723725] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    2.740589] sdhci: Present:  0x01fa0000 | Host ctl: 0x00000000
> [    2.757949] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.776577] mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> [    2.797801] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    2.814663] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
> [    2.832016] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.850651] mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> [    2.871875] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    2.888737] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
> [    2.906093] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.924743] mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> [    2.945950] mmc0: starting CMD1 arg 00000000 flags 000000e1
> [    2.962556] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
> [    2.979910] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    2.998544] mmc0: req done (CMD1): 0: 40ff8080 00000000 00000000 00000000
> [    3.018732] mmc_attach_mmc:mmc0: ocr = 40ff8080
> [    3.032230] mmc_select_low_voltage:mmc0: ENTER
> [    3.045435] mmc_power_off:mmc0: ENTER
> [    3.056313] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
> [    3.077543] set_clock_and_burst_size:mmc0: adjust = 1
> [    3.077543] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_BURST = 00C5, delay = 15, sel = 1
> [    3.092534] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 1FC5
> [    3.140629] mmc_power_up:mmc0: ENTER
> [    3.151255] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 7 width 0 timing 0
> [    3.172476] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
> [    3.189836] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 7 width 0 timing 0
> [    3.212432] generate_initial_74_clocks:mmc0 ENTER: slot->power_mode = 1,ios->power_mode = 2
> [    3.238059] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> [    3.255427] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 7 width 0 timing 0
> [    3.278878] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [    3.295554] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
> [    3.312911] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    3.331547] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> [    3.351734] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 7 width 0 timing 0
> [    3.375260] mmc0: starting CMD1 arg 40300080 flags 000000e1
> [    3.392854] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
> [    3.410196] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    3.428830] mmc0: req done (CMD1): 0: 40ff8080 00000000 00000000 00000000
> [    3.449035] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
> [    3.466388] sdhci: ===========================================
> [    3.483748] mmc0: starting CMD1 arg 40300080 flags 000000e1
> [    3.500460] mmc_power_off:mmc1: ENTER
> [    3.511342] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    3.530016] mmc0: req done (CMD1): 0: c0ff8080 00000000 00000000 00000000
> [    3.550235] mmc0: starting CMD2 arg 00000000 flags 00000067
> [    3.566816] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
> [    3.588044] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    3.606698] mmc0: req done (CMD2): 0: 45010053 454d3038 479031ce 57f97d00
> [    3.626919] mmc0: starting CMD3 arg 00010000 flags 00000015
> [    3.643513] set_clock_and_burst_size:mmc1: adjust = 1
> [    3.643513] set_clock_and_burst_size:mmc1: (B) SD_CLOCK_AND_BURST = 00C5, delay = 31, sel = 1
> [    3.658512] set_clock_and_burst_size:mmc1: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 3FC5
> [    3.706605] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    3.725253] mmc0: req done (CMD3): 0: 00000500 00000000 00000000 00000000
> [    3.745474] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 0 timing 0
> [    3.767990] mmc0: starting CMD9 arg 00010000 flags 00000007
> [    3.784621] mmc1: SDHCI controller on MMC [sdhci-pxa.0] using ADMA
> [    3.803019] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    3.821642] mmc0: req done (CMD9): 0: d00f0032 0f5903ff ffffffff 92404000
> [    3.841857] mmc0: starting CMD7 arg 00010000 flags 00000015
> [    3.858458] set_clock_and_burst_size:mmc2: adjust = 1
> [    3.873548] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    3.892206] mmc0: req done (CMD7): 0: 00000700 00000000 00000000 00000000
> [    3.912445] mmc0: starting CMD8 arg 00000000 flags 000000b5
> [    3.929016] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [    3.949502] set_clock_and_burst_size:mmc2: (B) SD_CLOCK_AND_BURST = 00C5, delay = 15, sel = 1
> [    3.974859] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
> [    3.993499] mmc0: req done (CMD8): 0: 00000900 00000000 00000000 00000000
> [    4.013703] mmc0:     512 bytes transferred: 0
> [    4.026910] mmc0: starting CMD6 arg 03b90101 flags 0000049d
> [    4.043523] set_clock_and_burst_size:mmc2: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 1FC5
> [    4.066302] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
> [    4.084943] mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> [    4.105253] mmc0: starting CMD13 arg 00010000 flags 00000195
> [    4.122127] mmc2: no vmmc regulator found
> [    4.134099] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    4.152759] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [    4.173232] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 0 timing 1
> [    4.195775] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 0 timing 1
> [    4.218842] mmc0: starting CMD6 arg 03b70201 flags 0000049d
> [    4.235428] set_clock_and_burst_size:mmc2: adjust = 1
> [    4.250456] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
> [    4.269105] mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> [    4.289300] mmc0: starting CMD13 arg 00010000 flags 00000195
> [    4.306152] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    4.324792] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [    4.345235] ------------[ cut here ]------------
> [    4.345249] WARNING: at kernel/sched.c:4000 schedule+0x25c/0x3ac()
> [    4.377317] Modules linked in:
> [    4.377317] [<c002abe8>] (unwind_backtrace+0x0/0x124) from [<c003834c>] (warn_slowpath_common+0x4c/0x64)
> [    4.386390] [<c003834c>] (warn_slowpath_common+0x4c/0x64) from [<c0038380>] (warn_slowpath_null+0x1c/0x24)
> [    4.414575] [<c0038380>] (warn_slowpath_null+0x1c/0x24) from [<c028909c>] (schedule+0x25c/0x3ac)
> [    4.469417] [<c028909c>] (schedule+0x25c/0x3ac) from [<c028922c>] (preempt_schedule+0x40/0x70)
> [    4.469417] [<c028922c>] (preempt_schedule+0x40/0x70) from [<c0039284>] (vprintk+0x36c/0x3a4)
> [    4.520387] [<c0039284>] (vprintk+0x36c/0x3a4) from [<c00392dc>] (printk+0x20/0x30)
> [    4.543167] [<c00392dc>] (printk+0x20/0x30) from [<c01efa18>] (platform_reset_exit+0x48/0x124)
> [    4.543167] [<c01efa18>] (platform_reset_exit+0x48/0x124) from [<c01ed4a8>] (sdhci_reset+0xf4/0x11c)
> [    4.595936] [<c01ed4a8>] (sdhci_reset+0xf4/0x11c) from [<c01ed878>] (sdhci_init+0x1c/0x5c)
> [    4.595936] [<c01ed878>] (sdhci_init+0x1c/0x5c) from [<c01ef87c>] (sdhci_add_host+0x5fc/0x70c)
> [    4.620516] [<c01ef87c>] (sdhci_add_host+0x5fc/0x70c) from [<c0288a44>] (sdhci_pxa_probe+0x1c0/0x27c)
> [    4.673552] [<c0288a44>] (sdhci_pxa_probe+0x1c0/0x27c) from [<c01c10d0>] (platform_drv_probe+0x1c/0x24)
> [    4.673552] [<c01c10d0>] (platform_drv_probe+0x1c/0x24) from [<c01bff94>] (driver_probe_device+0x124/0x22c)
> [    4.701490] [<c01bff94>] (driver_probe_device+0x124/0x22c) from [<c01c027c>] (__driver_attach+0x60/0x84)
> [    4.758661] [<c01c027c>] (__driver_attach+0x60/0x84) from [<c01bf074>] (bus_for_each_dev+0x4c/0x80)
> [    4.785566] [<c01bf074>] (bus_for_each_dev+0x4c/0x80) from [<c01bf8d0>] (bus_add_driver+0xc0/0x248)
> [    4.812472] [<c01bf8d0>] (bus_add_driver+0xc0/0x248) from [<c01c050c>] (driver_register+0xac/0x13c)
> [    4.812472] [<c01c050c>] (driver_register+0xac/0x13c) from [<c001f434>] (do_one_initcall+0xbc/0x18c)
> [    4.839390] [<c001f434>] (do_one_initcall+0xbc/0x18c) from [<c00086e0>] (kernel_init+0x98/0x14c)
> [    4.866546] [<c00086e0>] (kernel_init+0x98/0x14c) from [<c00263e0>] (kernel_thread_exit+0x0/0x8)
> [    4.892679] ---[ end trace 8b39c6115c20996a ]---
> [    4.932567] set_clock_and_burst_size:mmc2: (B) SD_CLOCK_AND_BURST = 00C5, delay = 15, sel = 1
> [    4.957952] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 3 timing 1
> [    4.981020] mmc0: starting CMD19 arg 00000000 flags 000000b5
> [    4.997867] mmc0:     blksz 8 blocks 1 flags 00000100 tsac 0 ms nsac 0
> [    5.017307] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [    5.035948] set_clock_and_burst_size:mmc2: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 1FC5
> [    5.058745] sdhci: =========== REGISTER DUMP (mmc2)===========
> [    5.076090] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
> [    5.093431] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
> [    5.110778] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> [    5.128113] sdhci: Present:  0x01f20000 | Host ctl: 0x00000000
> [    5.145458] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
> [    5.162801] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
> [    5.180143] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
> [    5.197490] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
> [    5.214828] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> [    5.232170] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
> [    5.249514] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
> [    5.266853] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
> [    5.284200] sdhci: ===========================================
> [    5.301664] mmc_power_off:mmc2: ENTER
> [    5.312569] mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
> [    5.333806] set_clock_and_burst_size:mmc2: adjust = 1
> [    5.333816] set_clock_and_burst_size:mmc2: (B) SD_CLOCK_AND_BURST = 00C5, delay = 15, sel = 1
> [    5.348826] set_clock_and_burst_size:mmc2: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = 1FC5
> [    5.396942] mmc2: SDHCI controller on MMC [sdhci-pxa.1] using ADMA
> [    5.415519] TCP cubic registered
> [    5.425136] NET: Registered protocol family 17
> [    5.438418] Registering the dns_resolver key type
> [    5.452421] VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 5
> [    5.475688] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    5.494606] Waiting 15sec before mounting root device...
> [   15.028875] mmc0: Timeout waiting for hardware interrupt.
> [   15.028886] sdhci: =========== REGISTER DUMP (mmc0)===========
> [   15.044932] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
> [   15.062248] sdhci: Blk size: 0x00007008 | Blk cnt:  0x00000000
> [   15.096880] sdhci: Argument: 0x00000000 | Trn mode: 0x00000003
> [   15.096880] sdhci: Present:  0x01fa0000 | Host ctl: 0x00000035
> [   15.114198] sdhci: Power:    0x0000000b | Blk gap:  0x00000000
> [   15.131514] sdhci: Wake-up:  0x00000000 | Clock:    0x00000207
> [   15.148831] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
> [   15.166148] sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
> [   15.200782] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> [   15.218099] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
> [   15.218099] sdhci: Cmd:      0x0000133a | Max curr: 0x00000000
> [   15.235416] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x1f943808
> [   15.252733] sdhci: ===========================================
> [   15.287391] mmc0: req done (CMD19): 0: 00000000 00000000 00000000 00000000
> [   15.307852] mmc0:     0 bytes transferred: -110
> [   15.321336] mmc0: starting CMD14 arg 00000000 flags 000000b5
> [   15.338178] mmc0:     blksz 8 blocks 1 flags 00000200 tsac 0 ms nsac 0
> [   15.357630] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
> [   15.376281] mmc0: req done (CMD14): 0: 00001300 00000000 00000000 00000000
> [   15.396738] mmc0:     8 bytes transferred: 0
> [   15.409456] mmc0: starting CMD6 arg 03b70601 flags 0000049d
> [   15.426403] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
> [   15.445051] mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> [   15.465275] mmc0: starting CMD13 arg 00010000 flags 00000195
> [   15.482119] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   15.500770] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [   15.521225] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 3 timing 1
> [   15.544295] mmc0: new high speed DDR MMC card at address 0001
> [   15.561727] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> [   15.575658] mmc0: starting CMD18 arg 00000000 flags 000000b5
> [   15.592556] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
> [   15.613031] mmc0:     CMD12 arg 00000000 flags 0000049d
> [   15.628605] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   15.647270] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00208002
> [   15.665927] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
> [   15.684563] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> [   15.705030] mmc0:     0 bytes transferred: -84
> [   15.718234] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> [   15.737416] mmcblk0: retrying using single block read
> [   15.752440] mmc0: starting CMD17 arg 00000000 flags 000000b5
> [   15.769301] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   15.789746] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   15.808390] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00208002
> [   15.827030] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   15.847496] mmc0:     0 bytes transferred: -84
> [   15.860718] mmc0: starting CMD13 arg 00010000 flags 00000195
> [   15.877566] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   15.896217] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [   15.916671] mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
> [   15.939470] end_request: I/O error, dev mmcblk0, sector 0
> [   15.955529] mmc0: starting CMD17 arg 00000001 flags 000000b5
> [   15.972363] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   15.992831] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.011469] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00208002
> [   16.030122] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   16.050567] mmc0:     0 bytes transferred: -84
> [   16.063872] mmc0: starting CMD13 arg 00010000 flags 00000195
> [   16.080731] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.099367] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [   16.119836] mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
> [   16.142611] end_request: I/O error, dev mmcblk0, sector 1
> [   16.158666] mmc0: starting CMD17 arg 00000002 flags 000000b5
> [   16.175513] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   16.195980] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.214626] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   16.233256] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   16.253719] mmc0:     512 bytes transferred: 0
> [   16.266939] mmc0: starting CMD17 arg 00000003 flags 000000b5
> [   16.283786] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   16.304265] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.322913] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   16.341547] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   16.362015] mmc0:     512 bytes transferred: 0
> [   16.375231] mmc0: starting CMD17 arg 00000004 flags 000000b5
> [   16.392083] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   16.412574] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.431207] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   16.449845] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   16.470309] mmc0:     512 bytes transferred: 0
> [   16.483526] mmc0: starting CMD17 arg 00000005 flags 000000b5
> [   16.500375] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   16.520858] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.539504] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   16.558136] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   16.578611] mmc0:     512 bytes transferred: 0
> [   16.591827] mmc0: starting CMD17 arg 00000006 flags 000000b5
> [   16.608668] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   16.629138] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.647771] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   16.666410] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   16.686874] mmc0:     512 bytes transferred: 0
> [   16.700094] mmc0: starting CMD17 arg 00000007 flags 000000b5
> [   16.716938] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   16.737408] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.756042] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   16.774693] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   16.795145] mmc0:     512 bytes transferred: 0
> [   16.808363] Buffer I/O error on device mmcblk0, logical block 0
> [   16.826124] mmc0: starting CMD18 arg 00000000 flags 000000b5
> [   16.842977] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
> [   16.863444] mmc0:     CMD12 arg 00000000 flags 0000049d
> [   16.878990] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   16.897629] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00208002
> [   16.916278] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
> [   16.934938] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> [   16.955390] mmc0:     0 bytes transferred: -84
> [   16.968594] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> [   16.987767] mmcblk0: retrying using single block read
> [   17.002797] mmc0: starting CMD17 arg 00000000 flags 000000b5
> [   17.019625] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.040106] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.058750] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00208002
> [   17.077391] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   17.097855] mmc0:     0 bytes transferred: -84
> [   17.111076] mmc0: starting CMD13 arg 00010000 flags 00000195
> [   17.127925] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.146577] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [   17.167029] mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
> [   17.189822] end_request: I/O error, dev mmcblk0, sector 0
> [   17.205874] mmc0: starting CMD17 arg 00000001 flags 000000b5
> [   17.222730] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.243181] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.261824] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00208002
> [   17.280461] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   17.300927] mmc0:     0 bytes transferred: -84
> [   17.314144] mmc0: starting CMD13 arg 00010000 flags 00000195
> [   17.331009] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.349648] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [   17.370113] mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
> [   17.392892] end_request: I/O error, dev mmcblk0, sector 1
> [   17.408944] mmc0: starting CMD17 arg 00000002 flags 000000b5
> [   17.425791] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.446265] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.464904] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   17.483535] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   17.504007] mmc0:     512 bytes transferred: 0
> [   17.517236] mmc0: starting CMD17 arg 00000003 flags 000000b5
> [   17.534069] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.554548] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.573192] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   17.591844] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   17.612301] mmc0:     512 bytes transferred: 0
> [   17.625513] mmc0: starting CMD17 arg 00000004 flags 000000b5
> [   17.642362] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.662846] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.681486] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   17.700125] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   17.720597] mmc0:     512 bytes transferred: 0
> [   17.733811] mmc0: starting CMD17 arg 00000005 flags 000000b5
> [   17.750656] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.771139] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.789791] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   17.808436] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   17.828888] mmc0:     512 bytes transferred: 0
> [   17.842105] mmc0: starting CMD17 arg 00000006 flags 000000b5
> [   17.858954] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.879432] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   17.898077] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   17.916717] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   17.937181] mmc0:     512 bytes transferred: 0
> [   17.950419] mmc0: starting CMD17 arg 00000007 flags 000000b5
> [   17.967247] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> [   17.987702] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [   18.006346] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
> [   18.025004] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [   18.045452] mmc0:     512 bytes transferred: 0
> [   18.058788] Buffer I/O error on device mmcblk0, logical block 0
> [   18.076456]  mmcblk0: unable to read partition table
> [   18.091572] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 3 timing 1
>
> [   20.519040] VFS: Cannot open root device "mmcblk0p1" or unknown-block(179,1)
> [   20.540046] Please append a correct "root=" boot option; here are the available partitions:
> [   20.564884] b300         7757824 mmcblk0  driver: mmcblk
> [   20.580725] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,1)
> [   20.605824] [<c002abe8>] (unwind_backtrace+0x0/0x124) from [<c0038518>] (panic+0x6c/0x18c)
> [   20.630434] [<c0038518>] (panic+0x6c/0x18c) from [<c0008d94>] (mount_block_root+0x1c4/0x204)
> [   20.655573] [<c0008d94>] (mount_block_root+0x1c4/0x204) from [<c0008e74>] (mount_root+0xa0/0xc4)
> [   20.681727] [<c0008e74>] (mount_root+0xa0/0xc4) from [<c0008fb4>] (prepare_namespace+0x11c/0x174)
> [   20.708124] [<c0008fb4>] (prepare_namespace+0x11c/0x174) from [<c0008750>] (kernel_init+0x108/0x14c)
> [   20.735311] [<c0008750>] (kernel_init+0x108/0x14c) from [<c00263e0>] (kernel_thread_exit+0x0/0x8)
>
>




If I use only the code in /drivers/mmc/core/  that handles dual voltage -- and no code in /drivers/mmc/host I can boot.

The code for dual voltage should be a separate patch and not coupled to ddr since mmc cards may switch to lower
voltages after they come up in high voltage mode and NOT support ddr.

trace (working) below

[    0.000000] Linux version 2.6.37-rc6-next-20101220-00022-g8b35e00-dirty (philip@philip-laptop) (gcc version 4.2.0 20070413 (prerelease) (CodeSourcery 2007q1-10. Marvell 2009q3-18 20090821)) #61 PREEMPT 0
[    0.000000] CPU: Marvell PJ4 processor [560f5815] revision 5 (ARMv7), cr=00c5387f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Brownstone Development Platform
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c03713d0, node_mem_map c0390000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130048 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: debug rootdelay=15 root=/dev/mmcblk0p1 rootfstype=ext3 console=ttyS2,38400 mem=512M uart_dma mbr_offset=0x4800
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 516108k/516108k available, 8180k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xe0800000 - 0xfe000000   ( 472 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc001f000   (  92 kB)
[    0.000000]       .text : 0xc001f000 - 0xc0354004   (3285 kB)
[    0.000000]       .data : 0xc0356000 - 0xc0373020   ( 117 kB)
[    0.000000] Preemptable hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:320 nr_irqs:360 360
[    0.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, wraps every 660764ms
[    0.000000] Console: colour dummy device 80x30
[    0.000167] Calibrating delay loop... 796.26 BogoMIPS (lpj=3981312)
[    0.220131] pid_max: default: 32768 minimum: 301
[    0.220162] Mount-cache hash table entries: 512
[    0.220631] CPU: Testing write buffer coherency: ok
[    0.224391] print_constraints: dummy: regulator:
[    0.224391] NET: Registered protocol family 16
[    0.224517] Tauros2: Disabling L2 prefetch.
[    0.224570] Tauros2: L2 cache support initialised in ARMv6 mode.
[    0.227697] bio: create slab <bio-0> at 0
[    0.228912] Switching to clocksource clocksource
[    0.233930] NET: Registered protocol family 2
[    0.234072] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.234401] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.234401] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.234650] TCP: Hash tables configured (established 16384 bind 16384)
[    0.234780] TCP reno registered
[    0.234780] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.234795] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.234972] NET: Registered protocol family 1
[    0.235374] RPC: Registered udp transport module.
[    0.235374] RPC: Registered tcp transport module.
[    0.235392] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.237085] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
[    0.237085] msgmni has been set to 1008
[    0.238008] io scheduler noop registered
[    0.238008] io scheduler deadline registered
[    0.238090] io scheduler cfq registered (default)
[    0.238599] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (irq = 27) is a FFUART
[    0.238775] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq = 24) is a STUART
[    1.352989] console [ttyS2] enabled
[    1.363373] mousedev: PS/2 mouse device common for all mice
[    1.380672] sdhci: Secure Digital Host Controller Interface driver
[    1.399242] sdhci: Copyright(c) Pierre Ossman
[    1.412215] mmc0: no vmmc regulator found
[    1.424406] sdhci_set_power:mmc0: power = 00000000
[    1.438778] mmc0: SDHCI controller on MMC [sdhci-pxa.2] using ADMA
[    1.457200] sdhci_set_power:mmc0: power = 00200000
[    1.471542] mmc1: no vmmc regulator found
[    1.483715] sdhci_set_power:mmc1: power = 00000000
[    1.498030] sdhci_set_power:mmc0: power = 00200000
[    1.513088] mmc1: SDHCI controller on MMC [sdhci-pxa.0] using ADMA
[    1.531472] sdhci_set_power:mmc0: power = 00200000
[    1.545753] mmc2: no vmmc regulator found
[    1.557943] sdhci_set_power:mmc2: power = 00000000
[    1.572204] sdhci_set_power:mmc0: power = 00200000
[    1.587505] mmc2: SDHCI controller on MMC [sdhci-pxa.1] using ADMA
[    1.605918] sdhci_set_power:mmc0: power = 00200000
[    1.622197] TCP cubic registered
[    1.632049] NET: Registered protocol family 17
[    1.645356] Registering the dns_resolver key type
[    1.659409] VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 5
[    1.682583] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.701636] Waiting 15sec before mounting root device...
[    1.718121] sdhci_set_power:mmc0: power = 00000000
[    1.732404] sdhci_set_power:mmc0: power = 00000080
[    1.758997] sdhci_set_power:mmc0: power = 00000080
[    1.788946] sdhci_set_power:mmc0: power = 00000080
[    1.804346] sdhci_set_power:mmc0: power = 00000080
[    1.840050] sdhci_set_power:mmc0: power = 00000080
[    1.867346] sdhci_set_power:mmc0: power = 00000080
[    1.881618] sdhci_set_power:mmc0: power = 00000080
[    1.896694] sdhci_set_power:mmc0: power = 00000080
[   11.928938] mmc0: Timeout waiting for hardware interrupt.
[   11.928938] sdhci: =========== REGISTER DUMP (mmc0)===========
[   11.944969] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
[   11.979601] sdhci: Blk size: 0x00007008 | Blk cnt:  0x00000000
[   11.979601] sdhci: Argument: 0x00000000 | Trn mode: 0x00000003
[   11.996918] sdhci: Present:  0x01fa0000 | Host ctl: 0x00000035
[   12.031551] sdhci: Power:    0x0000000b | Blk gap:  0x00000000
[   12.031551] sdhci: Wake-up:  0x00000000 | Clock:    0x00000207
[   12.048867] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[   12.066185] sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
[   12.083502] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   12.100818] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
[   12.118137] sdhci: Cmd:      0x0000133a | Max curr: 0x00000000
[   12.152770] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x1f943808
[   12.170085] sdhci: ===========================================
[   12.187575] sdhci_set_power:mmc0: power = 00000080
[   12.201880] mmc0: new high speed MMC card at address 0001
[   12.218242] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
[   12.236802]  mmcblk0: p1
[   12.244539] sdhci_set_power:mmc0: power = 00000080
[   16.722250] EXT3-fs: barriers not enabled
[   16.761481] EXT3-fs (mmcblk0p1):
[   16.770850] kjournald starting.  Commit interval 5 seconds
[   16.787682] warning: mounting unchecked fs, running e2fsck is recommended
[   16.809039] EXT3-fs (mmcblk0p1): using internal journal
[   16.824079] EXT3-fs (mmcblk0p1): recovery complete
[   16.839879] EXT3-fs (mmcblk0p1): mounted filesystem with ordered data mode
[   16.859865] VFS: Mounted root (ext3 filesystem) on device 179:1.
[   16.878365] Freeing init memory: 92K
init started:  BusyBox v1.01 (2009.03.10-14:28+0000) multi-call binary
telnetd: daemon: No such file or directory
cannot open /dev/null
[   17.221024] udevd (56): /proc/56/oom_adj is deprecated, please use /proc/56/oom_score_adj instead.
cannot open /dev/null
modprobe: could not parse modules.dep

error initializing udevd socket
cannot open /dev/null
error initializing udevd socket
cannot open /dev/null
error initializing udevd socket
modprobe: could not parse modules.dep
