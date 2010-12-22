From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Wed, 22 Dec 2010 10:24:38 +0800
Message-ID: <AANLkTim3uu9jZm4jLLTy8F-eFpvaTsE7qyU1DFsVXgcM@mail.gmail.com>
References: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
	<5BB47468-20D7-4A7B-B8AD-FD2BA06973D5@marvell.com>
	<3C63CE33-680C-400C-AF55-12380B5950A2@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:51961 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab0LVCYk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2010 21:24:40 -0500
Received: by fxm18 with SMTP id 18so5089916fxm.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2010 18:24:38 -0800 (PST)
In-Reply-To: <3C63CE33-680C-400C-AF55-12380B5950A2@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Wed, Dec 22, 2010 at 6:41 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Dec 21, 2010, at 1:34 PM, Philip Rakity wrote:
>
>>
>> On Dec 21, 2010, at 4:37 AM, zhangfei gao wrote:
>>
>>> v3: sync to mmc-next
>>>
>>> Emmc speed could double if using ddr50 mode, help check
>>>
>>> From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:00 2=
001
>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> Date: Tue, 21 Dec 2010 19:51:38 -0500
>>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>>
>>> =A0 =A0 =A01. spec sdhc 3.0 does not claim support 1.2v ddr mode
>>> =A0 =A0 =A02. Call back function set_power is added, since some con=
troller count
>>> on external pmic to provide power
>>> =A0 =A0 =A03. According to spec sdhc 3.0, uhs mode, including emmc =
ddr50 takes
>>> effect only when 1.8v Signaling Enable bit, which used for providin=
g
>>> 1.8v.
>>> =A0 =A0 =A0 =A0 So emmc ddr50 mode works after 1.8v switching proce=
ss, though emmc
>>> ddr50 could work at high voltage such as 3.3v if external pmic prov=
ide
>>> voltage.
>>> =A0 =A0 =A0 =A0 Limitation: emmc ddr50 mode only workable when both=
 host and emmc
>>> card support 1.70-1.90v
>>> =A0 =A0 =A04. According to JESD84, power down and power up is requi=
red to
>>> provide low voltage 1.70-1.90v to mmc.
>>>
>>> =A0 =A0 =A0Verified: toshiba emmc on mmp2, with io voltage at 1.8v =
provided by
>>> external pmic.
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> ---
>>> drivers/mmc/core/core.c =A0| =A0 13 +++++++++++++
>>> drivers/mmc/core/core.h =A0| =A0 =A01 +
>>> drivers/mmc/core/mmc.c =A0 | =A0 =A06 +++++-
>>> drivers/mmc/host/sdhci.c | =A0 44 +++++++++++++++++++++++++++++++++=
++++++++---
>>> drivers/mmc/host/sdhci.h | =A0 14 +++++++++++++-
>>> 5 files changed, 73 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index a8e89f3..fd657f1 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host *h=
ost)
>>> }
>>>
>>> /*
>>> + * mmc select low voltage 1.70-1.95v
>>> + */
>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
>>> +{
>>> + =A0 =A0 if (!(ocr & MMC_VDD_165_195))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> +
>>> + =A0 =A0 mmc_power_off(host);
>>> + =A0 =A0 host->ocr =3D ocr & host->ocr_avail;
>>> + =A0 =A0 mmc_power_up(host);
>>> +}
>>> +
>>> +/*
>>> * Cleanup when the last reference to the bus operator is dropped.
>>> */
>>> static void __mmc_release_bus(struct mmc_host *host)
>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>>> index 026c975..b05c20a 100644
>>> --- a/drivers/mmc/core/core.h
>>> +++ b/drivers/mmc/core/core.h
>>> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
>>> unsigned int width);
>>> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int widt=
h,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ddr);
>>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
>>> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>>
>>> static inline void mmc_delay(unsigned int ms)
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 86cac0d..8779339 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u32 =
ocr)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~0x7F;
>>> =A0 =A0 =A0}
>>>
>>> - =A0 =A0 host->ocr =3D mmc_select_voltage(host, ocr);
>>> + =A0 =A0 if ((ocr & MMC_VDD_165_195)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->ocr_avail & MMC=
_VDD_165_195))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_select_low_voltage(host, ocr);
>>> + =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ocr =3D mmc_select_voltage(host, oc=
r);
>>>
>>> =A0 =A0 =A0/*
>>> =A0 =A0 =A0 * Can we support the voltage of the card?
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index d5febe5..aafbb42 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_=
host *host)
>>> =A0 =A0 =A0host->cmd =3D NULL;
>>> }
>>>
>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int dd=
r)
>>> +{
>>> + =A0 =A0 u16 con;
>>> +
>>> + =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> +
>>> + =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> + =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~SDHCI_CTRL2_UHS_MASK;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_DDR5=
0;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTRO=
L2);
>>> + =A0 =A0 }
>>> +}
>>> +
>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int c=
lock)
>>> {
>>> =A0 =A0 =A0int div;
>>> @@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_hos=
t
>>> *host, unsigned short power)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>> =A0 =A0 =A0}
>>>
>>> + =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_DDR)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONT=
ROL2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTRO=
L2);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->set_power)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_power(host=
, pwr);
>>> + =A0 =A0 }
>>> +
>>> =A0 =A0 =A0/*
>>> =A0 =A0 =A0 * Spec says that we should clear the power reg before s=
etting
>>> =A0 =A0 =A0 * a new value. Some controllers don't seem to like this=
 though.
>>> @@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host *mm=
c,
>>> struct mmc_ios *ios)
>>> =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0sdhci_set_clock(host, ios->clock);
>>> + =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>>>
>>> =A0 =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
>>> @@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>> int sdhci_add_host(struct sdhci_host *host)
>>> {
>>> =A0 =A0 =A0struct mmc_host *mmc;
>>> - =A0 =A0 unsigned int caps, ocr_avail;
>>> + =A0 =A0 unsigned int caps, caps_h =3D 0, ocr_avail;
>>> =A0 =A0 =A0int ret;
>>>
>>> =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
>>> @@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *host)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
>>> =A0 =A0 =A0}
>>>
>>> - =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host=
->caps :
>>> - =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES);
>>> + =A0 =A0 if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D host->caps;
>>> + =A0 =A0 else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D sdhci_readl(host, SDHCI_CAPABILI=
TIES);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D sdhci_readl(host, SDHCI_CAPABI=
LITIES_1);
>>> + =A0 =A0 }
>>> +
>>> + =A0 =A0 if (caps & SDHCI_CAN_VDD_180) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (caps_h & SDHCI_CAN_SDR50)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_1=
_8V_DDR);
>>> + =A0 =A0 }
>>>
>>> =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 6e0969e..c4bd5dd 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -145,7 +145,14 @@
>>>
>>> #define SDHCI_ACMD12_ERR =A0 =A0 =A00x3C
>>>
>>> -/* 3E-3F reserved */
>>> +#define SDHCI_HOST_CONTROL2 =A00x3E
>>> +#define =A0SDHCI_CTRL2_UHS_MASK =A0 =A0 =A0 =A00x0007
>>> +#define =A0 SDHCI_CTRL2_SDR12 =A00x0000
>>> +#define =A0 SDHCI_CTRL2_SDR25 =A00x0001
>>> +#define =A0 SDHCI_CTRL2_SDR50 =A00x0002
>>> +#define =A0 SDHCI_CTRL2_SDR104 0x0003
>>> +#define =A0 SDHCI_CTRL2_DDR50 =A00x0004
>>> +#define =A0SDHCI_CTRL2_1_8V =A0 =A00x0008
>>>
>>> #define SDHCI_CAPABILITIES =A0 =A00x40
>>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 0x0000003F
>>> @@ -167,6 +174,9 @@
>>> #define =A0SDHCI_CAN_64BIT =A0 =A0 =A00x10000000
>>>
>>> #define SDHCI_CAPABILITIES_1 =A00x44
>>> +#define =A0SDHCI_CAN_SDR50 =A0 =A0 0x00000001
>>> +#define =A0SDHCI_CAN_SDR104 =A0 =A00x00000002
>>> +#define =A0SDHCI_CAN_DDR50 =A0 =A0 0x00000004
>>>
>>> #define SDHCI_MAX_CURRENT =A0 =A0 0x48
>>>
>>> @@ -222,6 +232,8 @@ struct sdhci_ops {
>>> =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_host *=
host,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u8 power_mode);
>>> =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host);
>>> + =A0 =A0 unsigned int =A0 =A0(*set_power)(struct sdhci_host *host,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned =
short power);
>>> };
>>>
>>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>> --
>>> 1.7.0.4
>>> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>
>>
>>
>>
>> Does not work for me on mmp2 using linux next. =A0Partition table no=
t found
>> trace below
>> Loading: ###########################################################=
######
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> =A0 =A0 =A0 =A0 ####################################################=
####
>> done
>> Bytes transferred =3D 1766924 (1af60c hex)
>> MMP2>> boot
>> Ready to boot zImage from 1100000
>>
>>
>> Starting kernel ...
>>
>> [ =A0 =A00.000000] Linux version 2.6.37-rc6-next-20101220-00022-g8b3=
5e00-dirty (root@philip-laptop) (gcc version 4.2.0 20070413 (prerelease=
) (CodeSourcery 2007q1-10. Marvell 2009q3-18 20090821)) #51 PREEMPT Tu0
>> [ =A0 =A00.000000] CPU: Marvell PJ4 processor [560f5815] revision 5 =
(ARMv7), cr=3D00c5387f
>> [ =A0 =A00.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing i=
nstruction cache
>> [ =A0 =A00.000000] Machine: Brownstone Development Platform
>> [ =A0 =A00.000000] Ignoring unrecognised tag 0x41000403
>> [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache writeback
>> [ =A0 =A00.000000] On node 0 totalpages: 131072
>> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c03713d0, node=
_mem_map c0390000
>> [ =A0 =A00.000000] =A0 Normal zone: 1024 pages used for memmap
>> [ =A0 =A00.000000] =A0 Normal zone: 0 pages reserved
>> [ =A0 =A00.000000] =A0 Normal zone: 130048 pages, LIFO batch:31
>> [ =A0 =A00.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
>> [ =A0 =A00.000000] pcpu-alloc: [0] 0
>> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility groupin=
g on. =A0Total pages: 130048
>> [ =A0 =A00.000000] Kernel command line: debug rootdelay=3D15 root=3D=
/dev/mmcblk0p1 rootfstype=3Dext3 console=3DttyS2,38400 mem=3D512M uart_=
dma mbr_offset=3D0x4800
>> [ =A0 =A00.000000] PID hash table entries: 2048 (order: 1, 8192 byte=
s)
>> [ =A0 =A00.000000] Dentry cache hash table entries: 65536 (order: 6,=
 262144 bytes)
>> [ =A0 =A00.000000] Inode-cache hash table entries: 32768 (order: 5, =
131072 bytes)
>> [ =A0 =A00.000000] Memory: 512MB =3D 512MB total
>> [ =A0 =A00.000000] Memory: 516108k/516108k available, 8180k reserved=
, 0K highmem
>> [ =A0 =A00.000000] Virtual kernel memory layout:
>> [ =A0 =A00.000000] =A0 =A0 vector =A0: 0xffff0000 - 0xffff1000 =A0 (=
 =A0 4 kB)
>> [ =A0 =A00.000000] =A0 =A0 fixmap =A0: 0xfff00000 - 0xfffe0000 =A0 (=
 896 kB)
>> [ =A0 =A00.000000] =A0 =A0 DMA =A0 =A0 : 0xffc00000 - 0xffe00000 =A0=
 ( =A0 2 MB)
>> [ =A0 =A00.000000] =A0 =A0 vmalloc : 0xe0800000 - 0xfe000000 =A0 ( 4=
72 MB)
>> [ =A0 =A00.000000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xe0000000 =A0 (=
 512 MB)
>> [ =A0 =A00.000000] =A0 =A0 modules : 0xbf000000 - 0xc0000000 =A0 ( =A0=
16 MB)
>> [ =A0 =A00.000000] =A0 =A0 =A0 .init : 0xc0008000 - 0xc001f000 =A0 (=
 =A092 kB)
>> [ =A0 =A00.000000] =A0 =A0 =A0 .text : 0xc001f000 - 0xc0354004 =A0 (=
3285 kB)
>> [ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc0356000 - 0xc0372c40 =A0 (=
 116 kB)
>> [ =A0 =A00.000000] Preemptable hierarchical RCU implementation.
>> [ =A0 =A00.000000] =A0RCU-based detection of stalled CPUs is disable=
d.
>> [ =A0 =A00.000000] =A0Verbose stalled-CPUs detection is disabled.
>> [ =A0 =A00.000000] NR_IRQS:320 nr_irqs:360 360
>> [ =A0 =A00.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, w=
raps every 660764ms
>> [ =A0 =A00.000000] Console: colour dummy device 80x30
>> [ =A0 =A00.000023] Calibrating delay loop... 796.26 BogoMIPS (lpj=3D=
3981312)
>> [ =A0 =A00.220162] pid_max: default: 32768 minimum: 301
>> [ =A0 =A00.220323] Mount-cache hash table entries: 512
>> [ =A0 =A00.220629] CPU: Testing write buffer coherency: ok
>> [ =A0 =A00.224390] print_constraints: dummy: regulator:
>> [ =A0 =A00.224390] NET: Registered protocol family 16
>> [ =A0 =A00.224518] Tauros2: Disabling L2 prefetch.
>> [ =A0 =A00.224560] Tauros2: L2 cache support initialised in ARMv6 mo=
de.
>> [ =A0 =A00.227660] bio: create slab <bio-0> at 0
>> [ =A0 =A00.228859] Switching to clocksource clocksource
>> [ =A0 =A00.233823] NET: Registered protocol family 2
>> [ =A0 =A00.233966] IP route cache hash table entries: 4096 (order: 2=
, 16384 bytes)
>> [ =A0 =A00.234294] TCP established hash table entries: 16384 (order:=
 5, 131072 bytes)
>> [ =A0 =A00.234544] TCP bind hash table entries: 16384 (order: 4, 655=
36 bytes)
>> [ =A0 =A00.234544] TCP: Hash tables configured (established 16384 bi=
nd 16384)
>> [ =A0 =A00.234661] TCP reno registered
>> [ =A0 =A00.234674] UDP hash table entries: 256 (order: 0, 4096 bytes=
)
>> [ =A0 =A00.234688] UDP-Lite hash table entries: 256 (order: 0, 4096 =
bytes)
>> [ =A0 =A00.234868] NET: Registered protocol family 1
>> [ =A0 =A00.235278] RPC: Registered udp transport module.
>> [ =A0 =A00.235278] RPC: Registered tcp transport module.
>> [ =A0 =A00.235295] RPC: Registered tcp NFSv4.1 backchannel transport=
 module.
>> [ =A0 =A00.237007] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, I=
nc.
>> [ =A0 =A00.237253] msgmni has been set to 1008
>> [ =A0 =A00.237921] io scheduler noop registered
>> [ =A0 =A00.237937] io scheduler deadline registered
>> [ =A0 =A00.237937] io scheduler cfq registered (default)
>> [ =A0 =A00.238510] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (irq =3D =
27) is a FFUART
>> [ =A0 =A00.238510] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq =3D =
24) is a STUART
>> [ =A0 =A01.352386] console [ttyS2] enabled
>> [ =A0 =A01.363462] mousedev: PS/2 mouse device common for all mice
>> [ =A0 =A01.380052] sdhci: Secure Digital Host Controller Interface d=
river
>> [ =A0 =A01.398589] sdhci: Copyright(c) Pierre Ossman
>> [ =A0 =A01.411584] set_clock_and_burst_size:mmc0: adjust =3D 1
>> [ =A0 =A01.426715] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 15, sel =3D 1
>> [ =A0 =A01.452068] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 1FC5
>> [ =A0 =A01.474880] mmc0: no vmmc regulator found
>> [ =A0 =A01.486806] set_clock_and_burst_size:mmc0: adjust =3D 1
>> [ =A0 =A01.501827] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 15, sel =3D 1
>> [ =A0 =A01.527204] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 1FC5
>> [ =A0 =A01.549982] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER=
 DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ =A0 =A01.567313] sdhci: Sys addr: 0x00000000 | Version: =A00x00000=
002
>> [ =A0 =A01.584666] sdhci: Blk size: 0x00000000 | Blk cnt: =A00x00000=
000
>> [ =A0 =A01.602003] sdhci: Argument: 0x00000000 | Trn mode: 0x0000000=
0
>> [ =A0 =A01.619344] sdhci: Present: =A00x01fa0000 | Host ctl: 0x00000=
000
>> [ =A0 =A01.636685] sdhci: Power: =A0 =A00x00000000 | Blk gap: =A00x0=
0000000
>> [ =A0 =A01.654029] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x0=
0000000
>> [ =A0 =A01.671373] sdhci: Timeout: =A00x00000000 | Int stat: 0x00000=
000
>> [ =A0 =A01.688713] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff000=
3
>> [ =A0 =A01.706058] sdhci: AC12 err: 0x00000000 | Slot int: 0x0000000=
0
>> [ =A0 =A01.723399] sdhci: Caps: =A0 =A0 0x25fcc8b2 | Caps_1: =A0 0x0=
0002f77
>> [ =A0 =A01.740741] sdhci: Cmd: =A0 =A0 =A00x00000000 | Max curr: 0x0=
0000000
>> [ =A0 =A01.758081] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000=
0
>> [ =A0 =A01.775432] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> [ =A0 =A01.792896] mmc_power_off:mmc0: ENTER
>> [ =A0 =A01.803799] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 =
width 0 timing 0
>> [ =A0 =A01.825042] set_clock_and_burst_size:mmc0: adjust =3D 1
>> [ =A0 =A01.825042] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 15, sel =3D 1
>> [ =A0 =A01.840029] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 1FC5
>> [ =A0 =A01.888227] mmc0: SDHCI controller on MMC [sdhci-pxa.2] using=
 ADMA
>> [ =A0 =A01.906642] mmc0: mmc_rescan: trying to init card at 400000 H=
z
>> [ =A0 =A01.924028] mmc_power_up:mmc0: ENTER
>> [ =A0 =A01.934670] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21=
 width 0 timing 0
>> [ =A0 =A01.956225] set_clock_and_burst_size:mmc1: adjust =3D 1
>> [ =A0 =A01.971333] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 V=
dd 21 width 0 timing 0
>> [ =A0 =A01.994208] generate_initial_74_clocks:mmc0 ENTER: slot->powe=
r_mode =3D 1,ios->power_mode =3D 2
>> [ =A0 =A02.019862] set_clock_and_burst_size:mmc1: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 31, sel =3D 1
>> [ =A0 =A02.045262] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 V=
dd 21 width 0 timing 0
>> [ =A0 =A02.068038] mmc0: starting CMD52 arg 00000c00 flags 00000195
>> [ =A0 =A02.084902] set_clock_and_burst_size:mmc1: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 3FC5
>> [ =A0 =A02.107679] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.126336] mmc0: req done (CMD52): -110: 00000000 00000000 0=
0000000 00000000
>> [ =A0 =A02.147563] mmc0: starting CMD52 arg 80000c08 flags 00000195
>> [ =A0 =A02.164426] mmc1: no vmmc regulator found
>> [ =A0 =A02.176382] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.195017] mmc0: req done (CMD52): -110: 00000000 00000000 0=
0000000 00000000
>> [ =A0 =A02.216291] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 V=
dd 21 width 0 timing 0
>> [ =A0 =A02.239066] mmc0: starting CMD0 arg 00000000 flags 000000c0
>> [ =A0 =A02.256653] set_clock_and_burst_size:mmc1: adjust =3D 1
>> [ =A0 =A02.271682] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A02.290309] mmc0: req done (CMD0): 0: 00000000 00000000 00000=
000 00000000
>> [ =A0 =A02.310497] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 V=
dd 21 width 0 timing 0
>> [ =A0 =A02.334306] mmc0: starting CMD8 arg 000001aa flags 000002f5
>> [ =A0 =A02.351886] set_clock_and_burst_size:mmc1: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 31, sel =3D 1
>> [ =A0 =A02.377254] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.395890] mmc0: req done (CMD8): -110: 00000000 00000000 00=
000000 00000000
>> [ =A0 =A02.416880] mmc0: starting CMD5 arg 00000000 flags 000002e1
>> [ =A0 =A02.433487] set_clock_and_burst_size:mmc1: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 3FC5
>> [ =A0 =A02.456268] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.474916] mmc0: req failed (CMD5): -110, retrying...
>> [ =A0 =A02.490186] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER=
 DUMP (mmc1)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ =A0 =A02.507544] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.526177] mmc0: req failed (CMD5): -110, retrying...
>> [ =A0 =A02.541469] sdhci: Sys addr: 0x00000000 | Version: =A00x00000=
002
>> [ =A0 =A02.558803] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.577433] mmc0: req failed (CMD5): -110, retrying...
>> [ =A0 =A02.592713] sdhci: Blk size: 0x00000000 | Blk cnt: =A00x00000=
000
>> [ =A0 =A02.610051] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.628684] mmc0: req done (CMD5): -110: 00000000 00000000 00=
000000 00000000
>> [ =A0 =A02.649651] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> [ =A0 =A02.666514] sdhci: Argument: 0x00000000 | Trn mode: 0x0000000=
0
>> [ =A0 =A02.683870] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.702501] mmc0: req done (CMD55): -110: 00000000 00000000 0=
0000000 00000000
>> [ =A0 =A02.723725] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> [ =A0 =A02.740589] sdhci: Present: =A00x01fa0000 | Host ctl: 0x00000=
000
>> [ =A0 =A02.757949] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.776577] mmc0: req done (CMD55): -110: 00000000 00000000 0=
0000000 00000000
>> [ =A0 =A02.797801] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> [ =A0 =A02.814663] sdhci: Power: =A0 =A00x00000000 | Blk gap: =A00x0=
0000000
>> [ =A0 =A02.832016] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.850651] mmc0: req done (CMD55): -110: 00000000 00000000 0=
0000000 00000000
>> [ =A0 =A02.871875] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> [ =A0 =A02.888737] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x0=
0000000
>> [ =A0 =A02.906093] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
018000
>> [ =A0 =A02.924743] mmc0: req done (CMD55): -110: 00000000 00000000 0=
0000000 00000000
>> [ =A0 =A02.945950] mmc0: starting CMD1 arg 00000000 flags 000000e1
>> [ =A0 =A02.962556] sdhci: Timeout: =A00x00000000 | Int stat: 0x00000=
000
>> [ =A0 =A02.979910] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A02.998544] mmc0: req done (CMD1): 0: 40ff8080 00000000 00000=
000 00000000
>> [ =A0 =A03.018732] mmc_attach_mmc:mmc0: ocr =3D 40ff8080
>> [ =A0 =A03.032230] mmc_select_low_voltage:mmc0: ENTER
>> [ =A0 =A03.045435] mmc_power_off:mmc0: ENTER
>> [ =A0 =A03.056313] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 =
width 0 timing 0
>> [ =A0 =A03.077543] set_clock_and_burst_size:mmc0: adjust =3D 1
>> [ =A0 =A03.077543] set_clock_and_burst_size:mmc0: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 15, sel =3D 1
>> [ =A0 =A03.092534] set_clock_and_burst_size:mmc0: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 1FC5
>> [ =A0 =A03.140629] mmc_power_up:mmc0: ENTER
>> [ =A0 =A03.151255] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 7 =
width 0 timing 0
>> [ =A0 =A03.172476] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff000=
3
>> [ =A0 =A03.189836] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 V=
dd 7 width 0 timing 0
>> [ =A0 =A03.212432] generate_initial_74_clocks:mmc0 ENTER: slot->powe=
r_mode =3D 1,ios->power_mode =3D 2
>> [ =A0 =A03.238059] sdhci: AC12 err: 0x00000000 | Slot int: 0x0000000=
0
>> [ =A0 =A03.255427] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 V=
dd 7 width 0 timing 0
>> [ =A0 =A03.278878] mmc0: starting CMD0 arg 00000000 flags 000000c0
>> [ =A0 =A03.295554] sdhci: Caps: =A0 =A0 0x25fcc8b2 | Caps_1: =A0 0x0=
0002f77
>> [ =A0 =A03.312911] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A03.331547] mmc0: req done (CMD0): 0: 00000000 00000000 00000=
000 00000000
>> [ =A0 =A03.351734] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 V=
dd 7 width 0 timing 0
>> [ =A0 =A03.375260] mmc0: starting CMD1 arg 40300080 flags 000000e1
>> [ =A0 =A03.392854] sdhci: Cmd: =A0 =A0 =A00x00000000 | Max curr: 0x0=
0000000
>> [ =A0 =A03.410196] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A03.428830] mmc0: req done (CMD1): 0: 40ff8080 00000000 00000=
000 00000000
>> [ =A0 =A03.449035] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000=
0
>> [ =A0 =A03.466388] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> [ =A0 =A03.483748] mmc0: starting CMD1 arg 40300080 flags 000000e1
>> [ =A0 =A03.500460] mmc_power_off:mmc1: ENTER
>> [ =A0 =A03.511342] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A03.530016] mmc0: req done (CMD1): 0: c0ff8080 00000000 00000=
000 00000000
>> [ =A0 =A03.550235] mmc0: starting CMD2 arg 00000000 flags 00000067
>> [ =A0 =A03.566816] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 =
width 0 timing 0
>> [ =A0 =A03.588044] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A03.606698] mmc0: req done (CMD2): 0: 45010053 454d3038 47903=
1ce 57f97d00
>> [ =A0 =A03.626919] mmc0: starting CMD3 arg 00010000 flags 00000015
>> [ =A0 =A03.643513] set_clock_and_burst_size:mmc1: adjust =3D 1
>> [ =A0 =A03.643513] set_clock_and_burst_size:mmc1: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 31, sel =3D 1
>> [ =A0 =A03.658512] set_clock_and_burst_size:mmc1: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 3FC5
>> [ =A0 =A03.706605] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A03.725253] mmc0: req done (CMD3): 0: 00000500 00000000 00000=
000 00000000
>> [ =A0 =A03.745474] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 V=
dd 7 width 0 timing 0
>> [ =A0 =A03.767990] mmc0: starting CMD9 arg 00010000 flags 00000007
>> [ =A0 =A03.784621] mmc1: SDHCI controller on MMC [sdhci-pxa.0] using=
 ADMA
>> [ =A0 =A03.803019] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A03.821642] mmc0: req done (CMD9): 0: d00f0032 0f5903ff fffff=
fff 92404000
>> [ =A0 =A03.841857] mmc0: starting CMD7 arg 00010000 flags 00000015
>> [ =A0 =A03.858458] set_clock_and_burst_size:mmc2: adjust =3D 1
>> [ =A0 =A03.873548] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A03.892206] mmc0: req done (CMD7): 0: 00000700 00000000 00000=
000 00000000
>> [ =A0 =A03.912445] mmc0: starting CMD8 arg 00000000 flags 000000b5
>> [ =A0 =A03.929016] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 t=
sac 100 ms nsac 0
>> [ =A0 =A03.949502] set_clock_and_burst_size:mmc2: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 15, sel =3D 1
>> [ =A0 =A03.974859] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000003
>> [ =A0 =A03.993499] mmc0: req done (CMD8): 0: 00000900 00000000 00000=
000 00000000
>> [ =A0 =A04.013703] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 =A04.026910] mmc0: starting CMD6 arg 03b90101 flags 0000049d
>> [ =A0 =A04.043523] set_clock_and_burst_size:mmc2: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 1FC5
>> [ =A0 =A04.066302] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000003
>> [ =A0 =A04.084943] mmc0: req done (CMD6): 0: 00000800 00000000 00000=
000 00000000
>> [ =A0 =A04.105253] mmc0: starting CMD13 arg 00010000 flags 00000195
>> [ =A0 =A04.122127] mmc2: no vmmc regulator found
>> [ =A0 =A04.134099] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A04.152759] mmc0: req done (CMD13): 0: 00000900 00000000 0000=
0000 00000000
>> [ =A0 =A04.173232] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 V=
dd 7 width 0 timing 1
>> [ =A0 =A04.195775] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0=
 Vdd 7 width 0 timing 1
>> [ =A0 =A04.218842] mmc0: starting CMD6 arg 03b70201 flags 0000049d
>> [ =A0 =A04.235428] set_clock_and_burst_size:mmc2: adjust =3D 1
>> [ =A0 =A04.250456] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000003
>> [ =A0 =A04.269105] mmc0: req done (CMD6): 0: 00000800 00000000 00000=
000 00000000
>> [ =A0 =A04.289300] mmc0: starting CMD13 arg 00010000 flags 00000195
>> [ =A0 =A04.306152] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000001
>> [ =A0 =A04.324792] mmc0: req done (CMD13): 0: 00000900 00000000 0000=
0000 00000000
>> [ =A0 =A04.345235] ------------[ cut here ]------------
>> [ =A0 =A04.345249] WARNING: at kernel/sched.c:4000 schedule+0x25c/0x=
3ac()
>> [ =A0 =A04.377317] Modules linked in:
>> [ =A0 =A04.377317] [<c002abe8>] (unwind_backtrace+0x0/0x124) from [<=
c003834c>] (warn_slowpath_common+0x4c/0x64)
>> [ =A0 =A04.386390] [<c003834c>] (warn_slowpath_common+0x4c/0x64) fro=
m [<c0038380>] (warn_slowpath_null+0x1c/0x24)
>> [ =A0 =A04.414575] [<c0038380>] (warn_slowpath_null+0x1c/0x24) from =
[<c028909c>] (schedule+0x25c/0x3ac)
>> [ =A0 =A04.469417] [<c028909c>] (schedule+0x25c/0x3ac) from [<c02892=
2c>] (preempt_schedule+0x40/0x70)
>> [ =A0 =A04.469417] [<c028922c>] (preempt_schedule+0x40/0x70) from [<=
c0039284>] (vprintk+0x36c/0x3a4)
>> [ =A0 =A04.520387] [<c0039284>] (vprintk+0x36c/0x3a4) from [<c00392d=
c>] (printk+0x20/0x30)
>> [ =A0 =A04.543167] [<c00392dc>] (printk+0x20/0x30) from [<c01efa18>]=
 (platform_reset_exit+0x48/0x124)
>> [ =A0 =A04.543167] [<c01efa18>] (platform_reset_exit+0x48/0x124) fro=
m [<c01ed4a8>] (sdhci_reset+0xf4/0x11c)
>> [ =A0 =A04.595936] [<c01ed4a8>] (sdhci_reset+0xf4/0x11c) from [<c01e=
d878>] (sdhci_init+0x1c/0x5c)
>> [ =A0 =A04.595936] [<c01ed878>] (sdhci_init+0x1c/0x5c) from [<c01ef8=
7c>] (sdhci_add_host+0x5fc/0x70c)
>> [ =A0 =A04.620516] [<c01ef87c>] (sdhci_add_host+0x5fc/0x70c) from [<=
c0288a44>] (sdhci_pxa_probe+0x1c0/0x27c)
>> [ =A0 =A04.673552] [<c0288a44>] (sdhci_pxa_probe+0x1c0/0x27c) from [=
<c01c10d0>] (platform_drv_probe+0x1c/0x24)
>> [ =A0 =A04.673552] [<c01c10d0>] (platform_drv_probe+0x1c/0x24) from =
[<c01bff94>] (driver_probe_device+0x124/0x22c)
>> [ =A0 =A04.701490] [<c01bff94>] (driver_probe_device+0x124/0x22c) fr=
om [<c01c027c>] (__driver_attach+0x60/0x84)
>> [ =A0 =A04.758661] [<c01c027c>] (__driver_attach+0x60/0x84) from [<c=
01bf074>] (bus_for_each_dev+0x4c/0x80)
>> [ =A0 =A04.785566] [<c01bf074>] (bus_for_each_dev+0x4c/0x80) from [<=
c01bf8d0>] (bus_add_driver+0xc0/0x248)
>> [ =A0 =A04.812472] [<c01bf8d0>] (bus_add_driver+0xc0/0x248) from [<c=
01c050c>] (driver_register+0xac/0x13c)
>> [ =A0 =A04.812472] [<c01c050c>] (driver_register+0xac/0x13c) from [<=
c001f434>] (do_one_initcall+0xbc/0x18c)
>> [ =A0 =A04.839390] [<c001f434>] (do_one_initcall+0xbc/0x18c) from [<=
c00086e0>] (kernel_init+0x98/0x14c)
>> [ =A0 =A04.866546] [<c00086e0>] (kernel_init+0x98/0x14c) from [<c002=
63e0>] (kernel_thread_exit+0x0/0x8)
>> [ =A0 =A04.892679] ---[ end trace 8b39c6115c20996a ]---
>> [ =A0 =A04.932567] set_clock_and_burst_size:mmc2: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 15, sel =3D 1
>> [ =A0 =A04.957952] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0=
 Vdd 7 width 3 timing 1
>> [ =A0 =A04.981020] mmc0: starting CMD19 arg 00000000 flags 000000b5
>> [ =A0 =A04.997867] mmc0: =A0 =A0 blksz 8 blocks 1 flags 00000100 tsa=
c 0 ms nsac 0
>> [ =A0 =A05.017307] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00=
000002
>> [ =A0 =A05.035948] set_clock_and_burst_size:mmc2: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 1FC5
>> [ =A0 =A05.058745] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER=
 DUMP (mmc2)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ =A0 =A05.076090] sdhci: Sys addr: 0x00000000 | Version: =A00x00000=
002
>> [ =A0 =A05.093431] sdhci: Blk size: 0x00000000 | Blk cnt: =A00x00000=
000
>> [ =A0 =A05.110778] sdhci: Argument: 0x00000000 | Trn mode: 0x0000000=
0
>> [ =A0 =A05.128113] sdhci: Present: =A00x01f20000 | Host ctl: 0x00000=
000
>> [ =A0 =A05.145458] sdhci: Power: =A0 =A00x00000000 | Blk gap: =A00x0=
0000000
>> [ =A0 =A05.162801] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x0=
0000000
>> [ =A0 =A05.180143] sdhci: Timeout: =A00x00000000 | Int stat: 0x00000=
000
>> [ =A0 =A05.197490] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff000=
3
>> [ =A0 =A05.214828] sdhci: AC12 err: 0x00000000 | Slot int: 0x0000000=
0
>> [ =A0 =A05.232170] sdhci: Caps: =A0 =A0 0x25fcc8b2 | Caps_1: =A0 0x0=
0002f77
>> [ =A0 =A05.249514] sdhci: Cmd: =A0 =A0 =A00x00000000 | Max curr: 0x0=
0000000
>> [ =A0 =A05.266853] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000=
0
>> [ =A0 =A05.284200] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> [ =A0 =A05.301664] mmc_power_off:mmc2: ENTER
>> [ =A0 =A05.312569] mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 =
width 0 timing 0
>> [ =A0 =A05.333806] set_clock_and_burst_size:mmc2: adjust =3D 1
>> [ =A0 =A05.333816] set_clock_and_burst_size:mmc2: (B) SD_CLOCK_AND_B=
URST =3D 00C5, delay =3D 15, sel =3D 1
>> [ =A0 =A05.348826] set_clock_and_burst_size:mmc2: (A) SD_CLOCK_AND_B=
URST_SIZE_SETUP =3D 1FC5
>> [ =A0 =A05.396942] mmc2: SDHCI controller on MMC [sdhci-pxa.1] using=
 ADMA
>> [ =A0 =A05.415519] TCP cubic registered
>> [ =A0 =A05.425136] NET: Registered protocol family 17
>> [ =A0 =A05.438418] Registering the dns_resolver key type
>> [ =A0 =A05.452421] VFP support v0.3: implementor 56 architecture 2 p=
art 20 variant 9 rev 5
>> [ =A0 =A05.475688] drivers/rtc/hctosys.c: unable to open rtc device =
(rtc0)
>> [ =A0 =A05.494606] Waiting 15sec before mounting root device...
>> [ =A0 15.028875] mmc0: Timeout waiting for hardware interrupt.
>> [ =A0 15.028886] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER D=
UMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ =A0 15.044932] sdhci: Sys addr: 0x00000000 | Version: =A00x0000000=
2
>> [ =A0 15.062248] sdhci: Blk size: 0x00007008 | Blk cnt: =A00x0000000=
0
>> [ =A0 15.096880] sdhci: Argument: 0x00000000 | Trn mode: 0x00000003
>> [ =A0 15.096880] sdhci: Present: =A00x01fa0000 | Host ctl: 0x0000003=
5
>> [ =A0 15.114198] sdhci: Power: =A0 =A00x0000000b | Blk gap: =A00x000=
00000
>> [ =A0 15.131514] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x000=
00207
>> [ =A0 15.148831] sdhci: Timeout: =A00x0000000e | Int stat: 0x0000000=
0
>> [ =A0 15.166148] sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
>> [ =A0 15.200782] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>> [ =A0 15.218099] sdhci: Caps: =A0 =A0 0x25fcc8b2 | Caps_1: =A0 0x000=
02f77
>> [ =A0 15.218099] sdhci: Cmd: =A0 =A0 =A00x0000133a | Max curr: 0x000=
00000
>> [ =A0 15.235416] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x1f943808
>> [ =A0 15.252733] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> [ =A0 15.287391] mmc0: req done (CMD19): 0: 00000000 00000000 000000=
00 00000000
>> [ =A0 15.307852] mmc0: =A0 =A0 0 bytes transferred: -110
>> [ =A0 15.321336] mmc0: starting CMD14 arg 00000000 flags 000000b5
>> [ =A0 15.338178] mmc0: =A0 =A0 blksz 8 blocks 1 flags 00000200 tsac =
0 ms nsac 0
>> [ =A0 15.357630] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0003
>> [ =A0 15.376281] mmc0: req done (CMD14): 0: 00001300 00000000 000000=
00 00000000
>> [ =A0 15.396738] mmc0: =A0 =A0 8 bytes transferred: 0
>> [ =A0 15.409456] mmc0: starting CMD6 arg 03b70601 flags 0000049d
>> [ =A0 15.426403] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0003
>> [ =A0 15.445051] mmc0: req done (CMD6): 0: 00000800 00000000 0000000=
0 00000000
>> [ =A0 15.465275] mmc0: starting CMD13 arg 00010000 flags 00000195
>> [ =A0 15.482119] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 15.500770] mmc0: req done (CMD13): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 15.521225] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 V=
dd 7 width 3 timing 1
>> [ =A0 15.544295] mmc0: new high speed DDR MMC card at address 0001
>> [ =A0 15.561727] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
>> [ =A0 15.575658] mmc0: starting CMD18 arg 00000000 flags 000000b5
>> [ =A0 15.592556] mmc0: =A0 =A0 blksz 512 blocks 8 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 15.613031] mmc0: =A0 =A0 CMD12 arg 00000000 flags 0000049d
>> [ =A0 15.628605] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 15.647270] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020=
8002
>> [ =A0 15.665927] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0003
>> [ =A0 15.684563] mmc0: req done (CMD18): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 15.705030] mmc0: =A0 =A0 0 bytes transferred: -84
>> [ =A0 15.718234] mmc0: =A0 =A0 (CMD12): 0: 00000b00 00000000 0000000=
0 00000000
>> [ =A0 15.737416] mmcblk0: retrying using single block read
>> [ =A0 15.752440] mmc0: starting CMD17 arg 00000000 flags 000000b5
>> [ =A0 15.769301] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 15.789746] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 15.808390] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020=
8002
>> [ =A0 15.827030] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 15.847496] mmc0: =A0 =A0 0 bytes transferred: -84
>> [ =A0 15.860718] mmc0: starting CMD13 arg 00010000 flags 00000195
>> [ =A0 15.877566] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 15.896217] mmc0: req done (CMD13): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 15.916671] mmcblk0: error -84 transferring data, sector 0, nr =
8, card status 0x900
>> [ =A0 15.939470] end_request: I/O error, dev mmcblk0, sector 0
>> [ =A0 15.955529] mmc0: starting CMD17 arg 00000001 flags 000000b5
>> [ =A0 15.972363] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 15.992831] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.011469] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020=
8002
>> [ =A0 16.030122] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.050567] mmc0: =A0 =A0 0 bytes transferred: -84
>> [ =A0 16.063872] mmc0: starting CMD13 arg 00010000 flags 00000195
>> [ =A0 16.080731] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.099367] mmc0: req done (CMD13): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.119836] mmcblk0: error -84 transferring data, sector 1, nr =
7, card status 0x900
>> [ =A0 16.142611] end_request: I/O error, dev mmcblk0, sector 1
>> [ =A0 16.158666] mmc0: starting CMD17 arg 00000002 flags 000000b5
>> [ =A0 16.175513] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 16.195980] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.214626] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 16.233256] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.253719] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 16.266939] mmc0: starting CMD17 arg 00000003 flags 000000b5
>> [ =A0 16.283786] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 16.304265] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.322913] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 16.341547] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.362015] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 16.375231] mmc0: starting CMD17 arg 00000004 flags 000000b5
>> [ =A0 16.392083] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 16.412574] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.431207] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 16.449845] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.470309] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 16.483526] mmc0: starting CMD17 arg 00000005 flags 000000b5
>> [ =A0 16.500375] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 16.520858] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.539504] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 16.558136] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.578611] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 16.591827] mmc0: starting CMD17 arg 00000006 flags 000000b5
>> [ =A0 16.608668] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 16.629138] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.647771] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 16.666410] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.686874] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 16.700094] mmc0: starting CMD17 arg 00000007 flags 000000b5
>> [ =A0 16.716938] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 16.737408] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.756042] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 16.774693] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.795145] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 16.808363] Buffer I/O error on device mmcblk0, logical block 0
>> [ =A0 16.826124] mmc0: starting CMD18 arg 00000000 flags 000000b5
>> [ =A0 16.842977] mmc0: =A0 =A0 blksz 512 blocks 8 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 16.863444] mmc0: =A0 =A0 CMD12 arg 00000000 flags 0000049d
>> [ =A0 16.878990] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 16.897629] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020=
8002
>> [ =A0 16.916278] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0003
>> [ =A0 16.934938] mmc0: req done (CMD18): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 16.955390] mmc0: =A0 =A0 0 bytes transferred: -84
>> [ =A0 16.968594] mmc0: =A0 =A0 (CMD12): 0: 00000b00 00000000 0000000=
0 00000000
>> [ =A0 16.987767] mmcblk0: retrying using single block read
>> [ =A0 17.002797] mmc0: starting CMD17 arg 00000000 flags 000000b5
>> [ =A0 17.019625] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.040106] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.058750] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020=
8002
>> [ =A0 17.077391] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.097855] mmc0: =A0 =A0 0 bytes transferred: -84
>> [ =A0 17.111076] mmc0: starting CMD13 arg 00010000 flags 00000195
>> [ =A0 17.127925] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.146577] mmc0: req done (CMD13): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.167029] mmcblk0: error -84 transferring data, sector 0, nr =
8, card status 0x900
>> [ =A0 17.189822] end_request: I/O error, dev mmcblk0, sector 0
>> [ =A0 17.205874] mmc0: starting CMD17 arg 00000001 flags 000000b5
>> [ =A0 17.222730] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.243181] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.261824] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020=
8002
>> [ =A0 17.280461] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.300927] mmc0: =A0 =A0 0 bytes transferred: -84
>> [ =A0 17.314144] mmc0: starting CMD13 arg 00010000 flags 00000195
>> [ =A0 17.331009] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.349648] mmc0: req done (CMD13): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.370113] mmcblk0: error -84 transferring data, sector 1, nr =
7, card status 0x900
>> [ =A0 17.392892] end_request: I/O error, dev mmcblk0, sector 1
>> [ =A0 17.408944] mmc0: starting CMD17 arg 00000002 flags 000000b5
>> [ =A0 17.425791] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.446265] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.464904] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 17.483535] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.504007] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 17.517236] mmc0: starting CMD17 arg 00000003 flags 000000b5
>> [ =A0 17.534069] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.554548] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.573192] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 17.591844] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.612301] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 17.625513] mmc0: starting CMD17 arg 00000004 flags 000000b5
>> [ =A0 17.642362] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.662846] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.681486] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 17.700125] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.720597] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 17.733811] mmc0: starting CMD17 arg 00000005 flags 000000b5
>> [ =A0 17.750656] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.771139] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.789791] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 17.808436] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.828888] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 17.842105] mmc0: starting CMD17 arg 00000006 flags 000000b5
>> [ =A0 17.858954] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.879432] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 17.898077] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 17.916717] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 17.937181] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 17.950419] mmc0: starting CMD17 arg 00000007 flags 000000b5
>> [ =A0 17.967247] mmc0: =A0 =A0 blksz 512 blocks 1 flags 00000200 tsa=
c 100 ms nsac 0
>> [ =A0 17.987702] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0001
>> [ =A0 18.006346] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000=
0002
>> [ =A0 18.025004] mmc0: req done (CMD17): 0: 00000900 00000000 000000=
00 00000000
>> [ =A0 18.045452] mmc0: =A0 =A0 512 bytes transferred: 0
>> [ =A0 18.058788] Buffer I/O error on device mmcblk0, logical block 0
>> [ =A0 18.076456] =A0mmcblk0: unable to read partition table
>> [ =A0 18.091572] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 V=
dd 7 width 3 timing 1
>>
>> [ =A0 20.519040] VFS: Cannot open root device "mmcblk0p1" or unknown=
-block(179,1)
>> [ =A0 20.540046] Please append a correct "root=3D" boot option; here=
 are the available partitions:
>> [ =A0 20.564884] b300 =A0 =A0 =A0 =A0 7757824 mmcblk0 =A0driver: mmc=
blk
>> [ =A0 20.580725] Kernel panic - not syncing: VFS: Unable to mount ro=
ot fs on unknown-block(179,1)
>> [ =A0 20.605824] [<c002abe8>] (unwind_backtrace+0x0/0x124) from [<c0=
038518>] (panic+0x6c/0x18c)
>> [ =A0 20.630434] [<c0038518>] (panic+0x6c/0x18c) from [<c0008d94>] (=
mount_block_root+0x1c4/0x204)
>> [ =A0 20.655573] [<c0008d94>] (mount_block_root+0x1c4/0x204) from [<=
c0008e74>] (mount_root+0xa0/0xc4)
>> [ =A0 20.681727] [<c0008e74>] (mount_root+0xa0/0xc4) from [<c0008fb4=
>] (prepare_namespace+0x11c/0x174)
>> [ =A0 20.708124] [<c0008fb4>] (prepare_namespace+0x11c/0x174) from [=
<c0008750>] (kernel_init+0x108/0x14c)
>> [ =A0 20.735311] [<c0008750>] (kernel_init+0x108/0x14c) from [<c0026=
3e0>] (kernel_thread_exit+0x0/0x8)
>>
>>
>
>
>
>
> If I use only the code in /drivers/mmc/core/ =A0that handles dual vol=
tage -- and no code in /drivers/mmc/host I can boot.
>
> The code for dual voltage should be a separate patch and not coupled =
to ddr since mmc cards may switch to lower
> voltages after they come up in high voltage mode and NOT support ddr.
>
> trace (working) below
>
> [ =A0 =A00.000000] Linux version 2.6.37-rc6-next-20101220-00022-g8b35=
e00-dirty (philip@philip-laptop) (gcc version 4.2.0 20070413 (prereleas=
e) (CodeSourcery 2007q1-10. Marvell 2009q3-18 20090821)) #61 PREEMPT 0
> [ =A0 =A00.000000] CPU: Marvell PJ4 processor [560f5815] revision 5 (=
ARMv7), cr=3D00c5387f
> [ =A0 =A00.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing in=
struction cache
> [ =A0 =A00.000000] Machine: Brownstone Development Platform
> [ =A0 =A00.000000] Ignoring unrecognised tag 0x41000403
> [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache writeback
> [ =A0 =A00.000000] On node 0 totalpages: 131072
> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c03713d0, node_=
mem_map c0390000
> [ =A0 =A00.000000] =A0 Normal zone: 1024 pages used for memmap
> [ =A0 =A00.000000] =A0 Normal zone: 0 pages reserved
> [ =A0 =A00.000000] =A0 Normal zone: 130048 pages, LIFO batch:31
> [ =A0 =A00.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
> [ =A0 =A00.000000] pcpu-alloc: [0] 0
> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping=
 on. =A0Total pages: 130048
> [ =A0 =A00.000000] Kernel command line: debug rootdelay=3D15 root=3D/=
dev/mmcblk0p1 rootfstype=3Dext3 console=3DttyS2,38400 mem=3D512M uart_d=
ma mbr_offset=3D0x4800
> [ =A0 =A00.000000] PID hash table entries: 2048 (order: 1, 8192 bytes=
)
> [ =A0 =A00.000000] Dentry cache hash table entries: 65536 (order: 6, =
262144 bytes)
> [ =A0 =A00.000000] Inode-cache hash table entries: 32768 (order: 5, 1=
31072 bytes)
> [ =A0 =A00.000000] Memory: 512MB =3D 512MB total
> [ =A0 =A00.000000] Memory: 516108k/516108k available, 8180k reserved,=
 0K highmem
> [ =A0 =A00.000000] Virtual kernel memory layout:
> [ =A0 =A00.000000] =A0 =A0 vector =A0: 0xffff0000 - 0xffff1000 =A0 ( =
=A0 4 kB)
> [ =A0 =A00.000000] =A0 =A0 fixmap =A0: 0xfff00000 - 0xfffe0000 =A0 ( =
896 kB)
> [ =A0 =A00.000000] =A0 =A0 DMA =A0 =A0 : 0xffc00000 - 0xffe00000 =A0 =
( =A0 2 MB)
> [ =A0 =A00.000000] =A0 =A0 vmalloc : 0xe0800000 - 0xfe000000 =A0 ( 47=
2 MB)
> [ =A0 =A00.000000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xe0000000 =A0 ( =
512 MB)
> [ =A0 =A00.000000] =A0 =A0 modules : 0xbf000000 - 0xc0000000 =A0 ( =A0=
16 MB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .init : 0xc0008000 - 0xc001f000 =A0 ( =
=A092 kB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .text : 0xc001f000 - 0xc0354004 =A0 (3=
285 kB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc0356000 - 0xc0373020 =A0 ( =
117 kB)
> [ =A0 =A00.000000] Preemptable hierarchical RCU implementation.
> [ =A0 =A00.000000] =A0RCU-based detection of stalled CPUs is disabled=
=2E
> [ =A0 =A00.000000] =A0Verbose stalled-CPUs detection is disabled.
> [ =A0 =A00.000000] NR_IRQS:320 nr_irqs:360 360
> [ =A0 =A00.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, wr=
aps every 660764ms
> [ =A0 =A00.000000] Console: colour dummy device 80x30
> [ =A0 =A00.000167] Calibrating delay loop... 796.26 BogoMIPS (lpj=3D3=
981312)
> [ =A0 =A00.220131] pid_max: default: 32768 minimum: 301
> [ =A0 =A00.220162] Mount-cache hash table entries: 512
> [ =A0 =A00.220631] CPU: Testing write buffer coherency: ok
> [ =A0 =A00.224391] print_constraints: dummy: regulator:
> [ =A0 =A00.224391] NET: Registered protocol family 16
> [ =A0 =A00.224517] Tauros2: Disabling L2 prefetch.
> [ =A0 =A00.224570] Tauros2: L2 cache support initialised in ARMv6 mod=
e.
> [ =A0 =A00.227697] bio: create slab <bio-0> at 0
> [ =A0 =A00.228912] Switching to clocksource clocksource
> [ =A0 =A00.233930] NET: Registered protocol family 2
> [ =A0 =A00.234072] IP route cache hash table entries: 4096 (order: 2,=
 16384 bytes)
> [ =A0 =A00.234401] TCP established hash table entries: 16384 (order: =
5, 131072 bytes)
> [ =A0 =A00.234401] TCP bind hash table entries: 16384 (order: 4, 6553=
6 bytes)
> [ =A0 =A00.234650] TCP: Hash tables configured (established 16384 bin=
d 16384)
> [ =A0 =A00.234780] TCP reno registered
> [ =A0 =A00.234780] UDP hash table entries: 256 (order: 0, 4096 bytes)
> [ =A0 =A00.234795] UDP-Lite hash table entries: 256 (order: 0, 4096 b=
ytes)
> [ =A0 =A00.234972] NET: Registered protocol family 1
> [ =A0 =A00.235374] RPC: Registered udp transport module.
> [ =A0 =A00.235374] RPC: Registered tcp transport module.
> [ =A0 =A00.235392] RPC: Registered tcp NFSv4.1 backchannel transport =
module.
> [ =A0 =A00.237085] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, In=
c.
> [ =A0 =A00.237085] msgmni has been set to 1008
> [ =A0 =A00.238008] io scheduler noop registered
> [ =A0 =A00.238008] io scheduler deadline registered
> [ =A0 =A00.238090] io scheduler cfq registered (default)
> [ =A0 =A00.238599] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (irq =3D 2=
7) is a FFUART
> [ =A0 =A00.238775] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq =3D 2=
4) is a STUART
> [ =A0 =A01.352989] console [ttyS2] enabled
> [ =A0 =A01.363373] mousedev: PS/2 mouse device common for all mice
> [ =A0 =A01.380672] sdhci: Secure Digital Host Controller Interface dr=
iver
> [ =A0 =A01.399242] sdhci: Copyright(c) Pierre Ossman
> [ =A0 =A01.412215] mmc0: no vmmc regulator found
> [ =A0 =A01.424406] sdhci_set_power:mmc0: power =3D 00000000
> [ =A0 =A01.438778] mmc0: SDHCI controller on MMC [sdhci-pxa.2] using =
ADMA
> [ =A0 =A01.457200] sdhci_set_power:mmc0: power =3D 00200000
> [ =A0 =A01.471542] mmc1: no vmmc regulator found
> [ =A0 =A01.483715] sdhci_set_power:mmc1: power =3D 00000000
> [ =A0 =A01.498030] sdhci_set_power:mmc0: power =3D 00200000
> [ =A0 =A01.513088] mmc1: SDHCI controller on MMC [sdhci-pxa.0] using =
ADMA
> [ =A0 =A01.531472] sdhci_set_power:mmc0: power =3D 00200000
> [ =A0 =A01.545753] mmc2: no vmmc regulator found
> [ =A0 =A01.557943] sdhci_set_power:mmc2: power =3D 00000000
> [ =A0 =A01.572204] sdhci_set_power:mmc0: power =3D 00200000
> [ =A0 =A01.587505] mmc2: SDHCI controller on MMC [sdhci-pxa.1] using =
ADMA
> [ =A0 =A01.605918] sdhci_set_power:mmc0: power =3D 00200000
> [ =A0 =A01.622197] TCP cubic registered
> [ =A0 =A01.632049] NET: Registered protocol family 17
> [ =A0 =A01.645356] Registering the dns_resolver key type
> [ =A0 =A01.659409] VFP support v0.3: implementor 56 architecture 2 pa=
rt 20 variant 9 rev 5
> [ =A0 =A01.682583] drivers/rtc/hctosys.c: unable to open rtc device (=
rtc0)
> [ =A0 =A01.701636] Waiting 15sec before mounting root device...
> [ =A0 =A01.718121] sdhci_set_power:mmc0: power =3D 00000000
> [ =A0 =A01.732404] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 =A01.758997] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 =A01.788946] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 =A01.804346] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 =A01.840050] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 =A01.867346] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 =A01.881618] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 =A01.896694] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 11.928938] mmc0: Timeout waiting for hardware interrupt.
> [ =A0 11.928938] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER DU=
MP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ =A0 11.944969] sdhci: Sys addr: 0x00000000 | Version: =A00x00000002
> [ =A0 11.979601] sdhci: Blk size: 0x00007008 | Blk cnt: =A00x00000000
> [ =A0 11.979601] sdhci: Argument: 0x00000000 | Trn mode: 0x00000003
> [ =A0 11.996918] sdhci: Present: =A00x01fa0000 | Host ctl: 0x00000035
> [ =A0 12.031551] sdhci: Power: =A0 =A00x0000000b | Blk gap: =A00x0000=
0000
> [ =A0 12.031551] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x0000=
0207
> [ =A0 12.048867] sdhci: Timeout: =A00x0000000e | Int stat: 0x00000000
> [ =A0 12.066185] sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
> [ =A0 12.083502] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> [ =A0 12.100818] sdhci: Caps: =A0 =A0 0x25fcc8b2 | Caps_1: =A0 0x0000=
2f77
> [ =A0 12.118137] sdhci: Cmd: =A0 =A0 =A00x0000133a | Max curr: 0x0000=
0000
> [ =A0 12.152770] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x1f943808
> [ =A0 12.170085] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [ =A0 12.187575] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 12.201880] mmc0: new high speed MMC card at address 0001
> [ =A0 12.218242] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> [ =A0 12.236802] =A0mmcblk0: p1
> [ =A0 12.244539] sdhci_set_power:mmc0: power =3D 00000080
> [ =A0 16.722250] EXT3-fs: barriers not enabled
> [ =A0 16.761481] EXT3-fs (mmcblk0p1):
> [ =A0 16.770850] kjournald starting. =A0Commit interval 5 seconds
> [ =A0 16.787682] warning: mounting unchecked fs, running e2fsck is re=
commended
> [ =A0 16.809039] EXT3-fs (mmcblk0p1): using internal journal
> [ =A0 16.824079] EXT3-fs (mmcblk0p1): recovery complete
> [ =A0 16.839879] EXT3-fs (mmcblk0p1): mounted filesystem with ordered=
 data mode
> [ =A0 16.859865] VFS: Mounted root (ext3 filesystem) on device 179:1.
> [ =A0 16.878365] Freeing init memory: 92K
> init started: =A0BusyBox v1.01 (2009.03.10-14:28+0000) multi-call bin=
ary
> telnetd: daemon: No such file or directory
> cannot open /dev/null
> [ =A0 17.221024] udevd (56): /proc/56/oom_adj is deprecated, please u=
se /proc/56/oom_score_adj instead.
> cannot open /dev/null
> modprobe: could not parse modules.dep
>
> error initializing udevd socket
> cannot open /dev/null
> error initializing udevd socket
> cannot open /dev/null
> error initializing udevd socket
> modprobe: could not parse modules.dep
>

The patch is tested on latest mmc-next, with sdhci-pxa interface,
clk_delay=3D0x1f.
The latest git log is.
mmc: sdhci: Enable bus-width test for JMicron controllers.

How about sending you patches used locally.

Thanks
