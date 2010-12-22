From: Philip Rakity <prakity@marvell.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Tue, 21 Dec 2010 22:20:01 -0800
Message-ID: <DEBF0B02-9D8B-45E9-9BF1-D69951833DCF@marvell.com>
References: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
 <0A929BFA-55C4-45DF-A11D-2BC8B2B0BCEF@marvell.com>
 <AANLkTinYBj4ZtnTDPk1F1tsSgepi_OLUhx9vFdJWi3mL@mail.gmail.com>
 <9F47519A-91F9-4564-9D4A-A402F64DEE09@marvell.com>
 <AANLkTi=akCEvCVYB4XitbJ1yMTzkgakwoFezqw9Vyh2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55340 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752450Ab0LVGYl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 01:24:41 -0500
In-Reply-To: <AANLkTi=akCEvCVYB4XitbJ1yMTzkgakwoFezqw9Vyh2g@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>


On Dec 21, 2010, at 10:14 PM, zhangfei gao wrote:

> On Wed, Dec 22, 2010 at 12:52 AM, Philip Rakity <prakity@marvell.com> wrote:
>>
>> On Dec 21, 2010, at 9:37 PM, zhangfei gao wrote:
>>
>>> On Wed, Dec 22, 2010 at 12:09 AM, Philip Rakity <prakity@marvell.com> wrote:
>>>>
>>>> Resend as plain test -- with additional comments.
>>>> On Dec 21, 2010, at 4:37 AM, zhangfei gao wrote:
>>>>
>>>>> v3: sync to mmc-next
>>>>>
>>>>> Emmc speed could double if using ddr50 mode, help check
>>>>>
>>>>> From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:00 2001
>>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>> Date: Tue, 21 Dec 2010 19:51:38 -0500
>>>>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>>>>
>>>>>      1. spec sdhc 3.0 does not claim support 1.2v ddr mode
>>>>>      2. Call back function set_power is added, since some controller count
>>>>> on external pmic to provide power
>>>>>      3. According to spec sdhc 3.0, uhs mode, including emmc ddr50 takes
>>>>> effect only when 1.8v Signaling Enable bit, which used for providing
>>>>> 1.8v.
>>>>>         So emmc ddr50 mode works after 1.8v switching process, though emmc
>>>>> ddr50 could work at high voltage such as 3.3v if external pmic provide
>>>>> voltage.
>>>>>         Limitation: emmc ddr50 mode only workable when both host and emmc
>>>>> card support 1.70-1.90v
>>>>
>>>>
>>>> signaling voltage is not the same as card voltage.  card voltage can be 3.3v and
>>>> signaling voltage 1.8v.
>>> My understanding is signal voltage is io voltage, which could be low
>>> voltage, 1.70~1.90v.
>>> Card voltage should be keeps high voltage.
>>> In fact, two power domain inside emmc, one is vcc, the other is vccq,
>>> this is control io domain.
>>>>
>>>>>      4. According to JESD84, power down and power up is required to
>>>>> provide low voltage 1.70-1.90v to mmc.
>>>>>
>>>>>      Verified: toshiba emmc on mmp2, with io voltage at 1.8v provided by
>>>>> external pmic.
>>>>>
>>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>> ---
>>>>> drivers/mmc/core/core.c  |   13 +++++++++++++
>>>>> drivers/mmc/core/core.h  |    1 +
>>>>> drivers/mmc/core/mmc.c   |    6 +++++-
>>>>> drivers/mmc/host/sdhci.c |   44 +++++++++++++++++++++++++++++++++++++++++---
>>>>> drivers/mmc/host/sdhci.h |   14 +++++++++++++-
>>>>> 5 files changed, 73 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index a8e89f3..fd657f1 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host *host)
>>>>> }
>>>>>
>>>>> /*
>>>>> + * mmc select low voltage 1.70-1.95v
>>>>> + */
>>>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
>>>>> +{
>>>>> +     if (!(ocr & MMC_VDD_165_195))
>>>>> +             return;
>>>>> +
>>>>> +     mmc_power_off(host);
>>>>> +     host->ocr = ocr & host->ocr_avail;
>>>>> +     mmc_power_up(host);
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> * Cleanup when the last reference to the bus operator is dropped.
>>>>> */
>>>>> static void __mmc_release_bus(struct mmc_host *host)
>>>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>>>>> index 026c975..b05c20a 100644
>>>>> --- a/drivers/mmc/core/core.h
>>>>> +++ b/drivers/mmc/core/core.h
>>>>> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
>>>>> unsigned int width);
>>>>> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
>>>>>                         unsigned int ddr);
>>>>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>>>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
>>>>> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>>>>
>>>>> static inline void mmc_delay(unsigned int ms)
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 86cac0d..8779339 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
>>>>>              ocr &= ~0x7F;
>>>>>      }
>>>>>
>>>>> -     host->ocr = mmc_select_voltage(host, ocr);
>>>>> +     if ((ocr & MMC_VDD_165_195)
>>>>> +                     && (host->ocr_avail & MMC_VDD_165_195))
>>>>> +             mmc_select_low_voltage(host, ocr);
>>>>> +     else
>>>>> +             host->ocr = mmc_select_voltage(host, ocr);
>>>>>
>>>>
>>>> The patch for dual voltage cards should be a separate patch.  It is independent of
>>>> support for dual data rate.
>>>>
>>>>>      /*
>>>>>       * Can we support the voltage of the card?
>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>> index d5febe5..aafbb42 100644
>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>>>>      host->cmd = NULL;
>>>>> }
>>>>>
>>>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
>>>>> +{
>>>>> +     u16 con;
>>>>> +
>>>>> +     if (ddr == MMC_SDR_MODE)
>>>>> +             return;
>>>>> +
>>>>> +     con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>> +     if (con & SDHCI_CTRL2_1_8V) {
>>>>> +             con &= ~SDHCI_CTRL2_UHS_MASK;
>>>>> +             if (ddr & MMC_1_8V_DDR_MODE)
>>>>> +                     con |= SDHCI_CTRL2_DDR50;
>>>>> +             sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>>> {
>>>>>      int div;
>>>>> @@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_host
>>>>> *host, unsigned short power)
>>>>>              return;
>>>>>      }
>>>>>
>>>>> +     if ((pwr == SDHCI_POWER_180) &&
>>>>> +             (host->mmc->caps & MMC_CAP_1_8V_DDR)) {
>>>>> +             u16 con;
>>>>> +
>>>>> +             con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>> +             con |= SDHCI_CTRL2_1_8V;
>>>>> +             sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>>> +
>>>>> +             if (host->ops->set_power)
>>>>> +                     host->ops->set_power(host, pwr);
>>>>> +     }
>>>>> +
>>>>
>>>> power to the card can be at 3.3v and signaling at 1.8v.  This is a legal combination.
>>>
>>> It is legal combination, then why here should be reworked?
>>> The Power control register is control SD bus voltage, which should be
>>> io voltage.
>>> Even the dual voltage emmc card can not work at both vcc and vccq are 1.8v.
>>>
>>>> The
>>>>> +     if ((pwr == SDHCI_POWER_180) &&
>>>>> +             (host->mmc->caps & MMC_CAP_1_8V_DDR)) {
>>>> should be reworked.
>>>>
>>>>>      /*
>>>>>       * Spec says that we should clear the power reg before setting
>>>>>       * a new value. Some controllers don't seem to like this though.
>>>>> @@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
>>>>> struct mmc_ios *ios)
>>>>>      }
>>>>>
>>>>>      sdhci_set_clock(host, ios->clock);
>>>>> +     sdhci_set_ddr(host, ios->ddr);
>>>>>
>>>>>      if (ios->power_mode == MMC_POWER_OFF)
>>>>>              sdhci_set_power(host, -1);
>>>>> @@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>>>> int sdhci_add_host(struct sdhci_host *host)
>>>>> {
>>>>>      struct mmc_host *mmc;
>>>>> -     unsigned int caps, ocr_avail;
>>>>> +     unsigned int caps, caps_h = 0, ocr_avail;
>>>>>      int ret;
>>>>>
>>>>>      WARN_ON(host == NULL);
>>>>> @@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>>                      host->version);
>>>>>      }
>>>>>
>>>>> -     caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>>>>> -             sdhci_readl(host, SDHCI_CAPABILITIES);
>>>>> +     if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>>>> +             caps = host->caps;
>>>>> +     else {
>>>>> +             caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>>>> +             caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>>> +     }
>>>>> +
>>>>> +     if (caps & SDHCI_CAN_VDD_180) {
>>>>> +             if (caps_h & SDHCI_CAN_SDR50)
>>>>> +                     mmc->caps |= (MMC_CAP_1_8V_DDR);
>>>>> +     }
>>>>>
>>>>>      if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>>>              host->flags |= SDHCI_USE_SDMA;
>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>> index 6e0969e..c4bd5dd 100644
>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>> @@ -145,7 +145,14 @@
>>>>>
>>>>> #define SDHCI_ACMD12_ERR      0x3C
>>>>>
>>>>> -/* 3E-3F reserved */
>>>>> +#define SDHCI_HOST_CONTROL2  0x3E
>>>>> +#define  SDHCI_CTRL2_UHS_MASK        0x0007
>>>>> +#define   SDHCI_CTRL2_SDR12  0x0000
>>>>> +#define   SDHCI_CTRL2_SDR25  0x0001
>>>>> +#define   SDHCI_CTRL2_SDR50  0x0002
>>>>> +#define   SDHCI_CTRL2_SDR104 0x0003
>>>>> +#define   SDHCI_CTRL2_DDR50  0x0004
>>>>> +#define  SDHCI_CTRL2_1_8V    0x0008
>>>>>
>>>>> #define SDHCI_CAPABILITIES    0x40
>>>>> #define  SDHCI_TIMEOUT_CLK_MASK       0x0000003F
>>>>> @@ -167,6 +174,9 @@
>>>>> #define  SDHCI_CAN_64BIT      0x10000000
>>>>>
>>>>> #define SDHCI_CAPABILITIES_1  0x44
>>>>> +#define  SDHCI_CAN_SDR50     0x00000001
>>>>> +#define  SDHCI_CAN_SDR104    0x00000002
>>>>> +#define  SDHCI_CAN_DDR50     0x00000004
>>>>>
>>>>> #define SDHCI_MAX_CURRENT     0x48
>>>>>
>>>>> @@ -222,6 +232,8 @@ struct sdhci_ops {
>>>>>      void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>>>>                                           u8 power_mode);
>>>>>      unsigned int    (*get_ro)(struct sdhci_host *host);
>>>>> +     unsigned int    (*set_power)(struct sdhci_host *host,
>>>>> +                             unsigned short power);
>>>>> };
>>>>>
>>>>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>>>> --
>>>>> 1.7.0.4
>>>>> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>
>>>>
>>>>
>>
>>
>> commented out support for 1.8v in sdhci.c  where the check was made for the controller supporting 1.8v core voltage
>> added printk to show ocr and host->ocr. before check to call mmc_select_low_voltage or mmc_select_voltage in mmc.c
>>
>> the card is recognized as DDR but we do not mount the drive since the check for SDHCI_POWER_180 fails and we do not program the registers.
>>
>>
>>
>> [    0.000000] Linux version 2.6.37-rc6-next-20101220-00023-ge7c195e-dirty (philip@philip-laptop) (gcc version 4.2.0 20070413 (prerelease) (CodeSourcery 2007q1-10. Marvell 2009q3-18 20090821)) #80 PREEMPT 0
>> [    0.000000] CPU: Marvell PJ4 processor [560f5815] revision 5 (ARMv7), cr=00c5387f
>> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
>> [    0.000000] Machine: Brownstone Development Platform
>> [    0.000000] Ignoring unrecognised tag 0x41000403
>> [    0.000000] Memory policy: ECC disabled, Data cache writeback
>> [    0.000000] On node 0 totalpages: 131072
>> [    0.000000] free_area_init_node: node 0, pgdat c03713d8, node_mem_map c0390000
>> [    0.000000]   Normal zone: 1024 pages used for memmap
>> [    0.000000]   Normal zone: 0 pages reserved
>> [    0.000000]   Normal zone: 130048 pages, LIFO batch:31
>> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
>> [    0.000000] pcpu-alloc: [0] 0
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
>> [    0.000000] Kernel command line: debug rootdelay=15 root=/dev/mmcblk0p1 rootfstype=ext3 console=ttyS2,38400 mem=512M uart_dma mbr_offset=0x4800
>> [    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>> [    0.000000] Memory: 512MB = 512MB total
>> [    0.000000] Memory: 516108k/516108k available, 8180k reserved, 0K highmem
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>> [    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
>> [    0.000000]     vmalloc : 0xe0800000 - 0xfe000000   ( 472 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
>> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>> [    0.000000]       .init : 0xc0008000 - 0xc001f000   (  92 kB)
>> [    0.000000]       .text : 0xc001f000 - 0xc035400c   (3285 kB)
>> [    0.000000]       .data : 0xc0356000 - 0xc0373040   ( 117 kB)
>> [    0.000000] Preemptable hierarchical RCU implementation.
>> [    0.000000]  RCU-based detection of stalled CPUs is disabled.
>> [    0.000000]  Verbose stalled-CPUs detection is disabled.
>> [    0.000000] NR_IRQS:320 nr_irqs:360 360
>> [    0.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, wraps every 660764ms
>> [    0.000000] Console: colour dummy device 80x30
>> [    0.000166] Calibrating delay loop... 796.26 BogoMIPS (lpj=3981312)
>> [    0.220135] pid_max: default: 32768 minimum: 301
>> [    0.220328] Mount-cache hash table entries: 512
>> [    0.220328] CPU: Testing write buffer coherency: ok
>> [    0.224398] print_constraints: dummy: regulator:
>> [    0.224525] NET: Registered protocol family 16
>> [    0.224525] Tauros2: Disabling L2 prefetch.
>> [    0.224569] Tauros2: L2 cache support initialised in ARMv6 mode.
>> [    0.227737] bio: create slab <bio-0> at 0
>> [    0.228950] Switching to clocksource clocksource
>> [    0.233848] NET: Registered protocol family 2
>> [    0.234150] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
>> [    0.234482] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
>> [    0.234482] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
>> [    0.234733] TCP: Hash tables configured (established 16384 bind 16384)
>> [    0.234863] TCP reno registered
>> [    0.234878] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.234878] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.234901] NET: Registered protocol family 1
>> [    0.235444] RPC: Registered udp transport module.
>> [    0.235444] RPC: Registered tcp transport module.
>> [    0.235462] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [    0.237177] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
>> [    0.237177] msgmni has been set to 1008
>> [    0.238053] io scheduler noop registered
>> [    0.238087] io scheduler deadline registered
>> [    0.238104] io scheduler cfq registered (default)
>> [    0.238679] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (irq = 27) is a FFUART
>> [    0.238852] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq = 24) is a STUART
>> [    1.353048] console [ttyS2] enabled
>> [    1.364154] mousedev: PS/2 mouse device common for all mice
>> [    1.380867] sdhci: Secure Digital Host Controller Interface driver
>> [    1.399304] sdhci: Copyright(c) Pierre Ossman
>> [    1.412378] mmc0: no vmmc regulator found
>> [    1.424539] mmc0: SDHCI controller on MMC [sdhci-pxa.2] using ADMA
>> [    1.443030] mmc1: no vmmc regulator found
>> [    1.455203] mmc1: SDHCI controller on MMC [sdhci-pxa.0] using ADMA
>> [    1.474554] mmc2: no vmmc regulator found
>> [    1.486636] mmc2: SDHCI controller on MMC [sdhci-pxa.1] using ADMA
>> [    1.505238] TCP cubic registered
>> [    1.514889] NET: Registered protocol family 17
>> [    1.529176] Registering the dns_resolver key type
>> [    1.545330] VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 5
>> [    1.568612] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
>> [    1.587543] Waiting 15sec before mounting root device...
>> [    1.604984] mmc_attach_mmc:mmc0: ocr & MMC_VDD_165_195 = 80, host->ocr_avail & MMC_VDD_165_195 = 0
>
> Here something wrong,  host->ocr_avail should have 0x80, otherwise ocr
> can not get ox80 back,
> Could you try the patch send you this morning, which is tested based
> on mmc-next.
>


The host controller is NOT required to support 1.8v.  mmp2 supports this and to show the bug
I commented out support for this as I mentioned above.  If 1.8v core voltage is not supported
by the controller by code break.

>> [   11.688964] mmc0: Timeout waiting for hardware interrupt.
>> [   11.688976] sdhci: =========== REGISTER DUMP (mmc0)===========
>> [   11.705024] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
>> [   11.739657] sdhci: Blk size: 0x00007008 | Blk cnt:  0x00000000
>> [   11.739657] sdhci: Argument: 0x00000000 | Trn mode: 0x00000003
>> [   11.756973] sdhci: Present:  0x01fa0000 | Host ctl: 0x00000035
>> [   11.791607] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
>> [   11.791607] sdhci: Wake-up:  0x00000000 | Clock:    0x00000207
>> [   11.808923] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
>> [   11.826241] sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
>> [   11.843558] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>> [   11.860874] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
>> [   11.878191] sdhci: Cmd:      0x0000133a | Max curr: 0x00000000
>> [   11.895509] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x1f943808
>> [   11.912826] sdhci: ===========================================
>> [   11.947936] mmc0: new high speed DDR MMC card at address 0001
>> [   11.965402] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
>> [   11.983931] mmcblk0: retrying using single block read
>> [   11.999498] mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
>> [   12.022300] end_request: I/O error, dev mmcblk0, sector 0
>> [   12.038868] mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
>> [   12.061745] end_request: I/O error, dev mmcblk0, sector 1
>> [   12.078364] mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
>> [   12.101155] end_request: I/O error, dev mmcblk0, sector 2
>> [   12.117704] mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
>> [   12.140507] end_request: I/O error, dev mmcblk0, sector 3
>> [   12.157063] mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
>> [   12.179876] end_request: I/O error, dev mmcblk0, sector 4
>> [   12.196428] mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
>> [   12.219233] end_request: I/O error, dev mmcblk0, sector 5
>> [   12.235789] mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
>> [   12.258604] end_request: I/O error, dev mmcblk0, sector 6
>> [   12.275154] mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
>> [   12.297970] end_request: I/O error, dev mmcblk0, sector 7
>> [   12.314016] Buffer I/O error on device mmcblk0, logical block 0
>> [   12.332239] mmcblk0: retrying using single block read
>> [   12.347777] mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
>> [   12.370589] end_request: I/O error, dev mmcblk0, sector 0
>> [   12.387149] mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
>> [   12.409954] end_request: I/O error, dev mmcblk0, sector 1
>> [   12.426510] mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
>> [   12.449325] end_request: I/O error, dev mmcblk0, sector 2
>> [   12.465891] mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
>> [   12.488677] end_request: I/O error, dev mmcblk0, sector 3
>> [   12.505239] mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
>> [   12.528050] end_request: I/O error, dev mmcblk0, sector 4
>> [   12.544602] mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
>> [   12.567407] end_request: I/O error, dev mmcblk0, sector 5
>> [   12.583965] mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
>> [   12.606770] end_request: I/O error, dev mmcblk0, sector 6
>> [   12.623330] mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
>> [   12.646134] end_request: I/O error, dev mmcblk0, sector 7
>> [   12.662188] Buffer I/O error on device mmcblk0, logical block 0
>> [   12.679810]  mmcblk0: unable to read partition table
>> [   16.609127] VFS: Cannot open root device "mmcblk0p1" or unknown-block(179,1)
>> [   16.630132] Please append a correct "root=" boot option; here are the available partitions:
>> [   16.654964] b300         7757824 mmcblk0  driver: mmcblk
>> [   16.670806] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,1)
>> [   16.695905] [<c002abe8>] (unwind_backtrace+0x0/0x124) from [<c0038518>] (panic+0x6c/0x18c)
>> [   16.720516] [<c0038518>] (panic+0x6c/0x18c) from [<c0008d94>] (mount_block_root+0x1c4/0x204)
>> [   16.745636] [<c0008d94>] (mount_block_root+0x1c4/0x204) from [<c0008e74>] (mount_root+0xa0/0xc4)
>> [   16.771787] [<c0008e74>] (mount_root+0xa0/0xc4) from [<c0008fb4>] (prepare_namespace+0x11c/0x174)
>> [   16.798201] [<c0008fb4>] (prepare_namespace+0x11c/0x174) from [<c0008750>] (kernel_init+0x108/0x14c)
>> [   16.825393] [<c0008750>] (kernel_init+0x108/0x14c) from [<c00263e0>] (kernel_thread_exit+0x0/0x8)
>>
>>
>>

