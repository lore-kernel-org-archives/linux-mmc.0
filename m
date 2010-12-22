From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Wed, 22 Dec 2010 01:42:33 -0500
Message-ID: <AANLkTikL6_C5ag1SPawGfdwhTNMJr2axdO_=uUnfhZA7@mail.gmail.com>
References: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
	<0A929BFA-55C4-45DF-A11D-2BC8B2B0BCEF@marvell.com>
	<AANLkTinYBj4ZtnTDPk1F1tsSgepi_OLUhx9vFdJWi3mL@mail.gmail.com>
	<9F47519A-91F9-4564-9D4A-A402F64DEE09@marvell.com>
	<AANLkTi=akCEvCVYB4XitbJ1yMTzkgakwoFezqw9Vyh2g@mail.gmail.com>
	<DEBF0B02-9D8B-45E9-9BF1-D69951833DCF@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:62511 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0LVGme convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 01:42:34 -0500
Received: by fxm18 with SMTP id 18so5236939fxm.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2010 22:42:33 -0800 (PST)
In-Reply-To: <DEBF0B02-9D8B-45E9-9BF1-D69951833DCF@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Wed, Dec 22, 2010 at 1:20 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Dec 21, 2010, at 10:14 PM, zhangfei gao wrote:
>
>> On Wed, Dec 22, 2010 at 12:52 AM, Philip Rakity <prakity@marvell.com=
> wrote:
>>>
>>> On Dec 21, 2010, at 9:37 PM, zhangfei gao wrote:
>>>
>>>> On Wed, Dec 22, 2010 at 12:09 AM, Philip Rakity <prakity@marvell.c=
om> wrote:
>>>>>
>>>>> Resend as plain test -- with additional comments.
>>>>> On Dec 21, 2010, at 4:37 AM, zhangfei gao wrote:
>>>>>
>>>>>> v3: sync to mmc-next
>>>>>>
>>>>>> Emmc speed could double if using ddr50 mode, help check
>>>>>>
>>>>>> From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:0=
0 2001
>>>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>> Date: Tue, 21 Dec 2010 19:51:38 -0500
>>>>>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>>>>>
>>>>>> =A0 =A0 =A01. spec sdhc 3.0 does not claim support 1.2v ddr mode
>>>>>> =A0 =A0 =A02. Call back function set_power is added, since some =
controller count
>>>>>> on external pmic to provide power
>>>>>> =A0 =A0 =A03. According to spec sdhc 3.0, uhs mode, including em=
mc ddr50 takes
>>>>>> effect only when 1.8v Signaling Enable bit, which used for provi=
ding
>>>>>> 1.8v.
>>>>>> =A0 =A0 =A0 =A0 So emmc ddr50 mode works after 1.8v switching pr=
ocess, though emmc
>>>>>> ddr50 could work at high voltage such as 3.3v if external pmic p=
rovide
>>>>>> voltage.
>>>>>> =A0 =A0 =A0 =A0 Limitation: emmc ddr50 mode only workable when b=
oth host and emmc
>>>>>> card support 1.70-1.90v
>>>>>
>>>>>
>>>>> signaling voltage is not the same as card voltage. =A0card voltag=
e can be 3.3v and
>>>>> signaling voltage 1.8v.
>>>> My understanding is signal voltage is io voltage, which could be l=
ow
>>>> voltage, 1.70~1.90v.
>>>> Card voltage should be keeps high voltage.
>>>> In fact, two power domain inside emmc, one is vcc, the other is vc=
cq,
>>>> this is control io domain.
>>>>>
>>>>>> =A0 =A0 =A04. According to JESD84, power down and power up is re=
quired to
>>>>>> provide low voltage 1.70-1.90v to mmc.
>>>>>>
>>>>>> =A0 =A0 =A0Verified: toshiba emmc on mmp2, with io voltage at 1.=
8v provided by
>>>>>> external pmic.
>>>>>>
>>>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>> ---
>>>>>> drivers/mmc/core/core.c =A0| =A0 13 +++++++++++++
>>>>>> drivers/mmc/core/core.h =A0| =A0 =A01 +
>>>>>> drivers/mmc/core/mmc.c =A0 | =A0 =A06 +++++-
>>>>>> drivers/mmc/host/sdhci.c | =A0 44 ++++++++++++++++++++++++++++++=
+++++++++++---
>>>>>> drivers/mmc/host/sdhci.h | =A0 14 +++++++++++++-
>>>>>> 5 files changed, 73 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>> index a8e89f3..fd657f1 100644
>>>>>> --- a/drivers/mmc/core/core.c
>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>> @@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host=
 *host)
>>>>>> }
>>>>>>
>>>>>> /*
>>>>>> + * mmc select low voltage 1.70-1.95v
>>>>>> + */
>>>>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
>>>>>> +{
>>>>>> + =A0 =A0 if (!(ocr & MMC_VDD_165_195))
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>> +
>>>>>> + =A0 =A0 mmc_power_off(host);
>>>>>> + =A0 =A0 host->ocr =3D ocr & host->ocr_avail;
>>>>>> + =A0 =A0 mmc_power_up(host);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> * Cleanup when the last reference to the bus operator is dropped=
=2E
>>>>>> */
>>>>>> static void __mmc_release_bus(struct mmc_host *host)
>>>>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>>>>>> index 026c975..b05c20a 100644
>>>>>> --- a/drivers/mmc/core/core.h
>>>>>> +++ b/drivers/mmc/core/core.h
>>>>>> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
>>>>>> unsigned int width);
>>>>>> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int w=
idth,
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ddr=
);
>>>>>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>>>>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
>>>>>> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>>>>>
>>>>>> static inline void mmc_delay(unsigned int ms)
>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>> index 86cac0d..8779339 100644
>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>> @@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u=
32 ocr)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~0x7F;
>>>>>> =A0 =A0 =A0}
>>>>>>
>>>>>> - =A0 =A0 host->ocr =3D mmc_select_voltage(host, ocr);
>>>>>> + =A0 =A0 if ((ocr & MMC_VDD_165_195)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->ocr_avail & =
MMC_VDD_165_195))
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_select_low_voltage(host, ocr);
>>>>>> + =A0 =A0 else
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ocr =3D mmc_select_voltage(host,=
 ocr);
>>>>>>
>>>>>
>>>>> The patch for dual voltage cards should be a separate patch. =A0I=
t is independent of
>>>>> support for dual data rate.
>>>>>
>>>>>> =A0 =A0 =A0/*
>>>>>> =A0 =A0 =A0 * Can we support the voltage of the card?
>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>> index d5febe5..aafbb42 100644
>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdh=
ci_host *host)
>>>>>> =A0 =A0 =A0host->cmd =3D NULL;
>>>>>> }
>>>>>>
>>>>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int=
 ddr)
>>>>>> +{
>>>>>> + =A0 =A0 u16 con;
>>>>>> +
>>>>>> + =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>> +
>>>>>> + =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>> + =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~SDHCI_CTRL2_UHS_MASK;
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_D=
DR50;
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CON=
TROL2);
>>>>>> + =A0 =A0 }
>>>>>> +}
>>>>>> +
>>>>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned in=
t clock)
>>>>>> {
>>>>>> =A0 =A0 =A0int div;
>>>>>> @@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_=
host
>>>>>> *host, unsigned short power)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>>>> =A0 =A0 =A0}
>>>>>>
>>>>>> + =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_DDR)) =
{
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
>>>>>> +
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_C=
ONTROL2);
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CON=
TROL2);
>>>>>> +
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->set_power)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_power(h=
ost, pwr);
>>>>>> + =A0 =A0 }
>>>>>> +
>>>>>
>>>>> power to the card can be at 3.3v and signaling at 1.8v. =A0This i=
s a legal combination.
>>>>
>>>> It is legal combination, then why here should be reworked?
>>>> The Power control register is control SD bus voltage, which should=
 be
>>>> io voltage.
>>>> Even the dual voltage emmc card can not work at both vcc and vccq =
are 1.8v.
>>>>
>>>>> The
>>>>>> + =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_DDR)) =
{
>>>>> should be reworked.
>>>>>
>>>>>> =A0 =A0 =A0/*
>>>>>> =A0 =A0 =A0 * Spec says that we should clear the power reg befor=
e setting
>>>>>> =A0 =A0 =A0 * a new value. Some controllers don't seem to like t=
his though.
>>>>>> @@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host =
*mmc,
>>>>>> struct mmc_ios *ios)
>>>>>> =A0 =A0 =A0}
>>>>>>
>>>>>> =A0 =A0 =A0sdhci_set_clock(host, ios->clock);
>>>>>> + =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>>>>>>
>>>>>> =A0 =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
>>>>>> @@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>>>>> int sdhci_add_host(struct sdhci_host *host)
>>>>>> {
>>>>>> =A0 =A0 =A0struct mmc_host *mmc;
>>>>>> - =A0 =A0 unsigned int caps, ocr_avail;
>>>>>> + =A0 =A0 unsigned int caps, caps_h =3D 0, ocr_avail;
>>>>>> =A0 =A0 =A0int ret;
>>>>>>
>>>>>> =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
>>>>>> @@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *hos=
t)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
>>>>>> =A0 =A0 =A0}
>>>>>>
>>>>>> - =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? h=
ost->caps :
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES);
>>>>>> + =A0 =A0 if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D host->caps;
>>>>>> + =A0 =A0 else {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D sdhci_readl(host, SDHCI_CAPAB=
ILITIES);
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D sdhci_readl(host, SDHCI_CAP=
ABILITIES_1);
>>>>>> + =A0 =A0 }
>>>>>> +
>>>>>> + =A0 =A0 if (caps & SDHCI_CAN_VDD_180) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (caps_h & SDHCI_CAN_SDR50)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CA=
P_1_8V_DDR);
>>>>>> + =A0 =A0 }
>>>>>>
>>>>>> =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>>> index 6e0969e..c4bd5dd 100644
>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>> @@ -145,7 +145,14 @@
>>>>>>
>>>>>> #define SDHCI_ACMD12_ERR =A0 =A0 =A00x3C
>>>>>>
>>>>>> -/* 3E-3F reserved */
>>>>>> +#define SDHCI_HOST_CONTROL2 =A00x3E
>>>>>> +#define =A0SDHCI_CTRL2_UHS_MASK =A0 =A0 =A0 =A00x0007
>>>>>> +#define =A0 SDHCI_CTRL2_SDR12 =A00x0000
>>>>>> +#define =A0 SDHCI_CTRL2_SDR25 =A00x0001
>>>>>> +#define =A0 SDHCI_CTRL2_SDR50 =A00x0002
>>>>>> +#define =A0 SDHCI_CTRL2_SDR104 0x0003
>>>>>> +#define =A0 SDHCI_CTRL2_DDR50 =A00x0004
>>>>>> +#define =A0SDHCI_CTRL2_1_8V =A0 =A00x0008
>>>>>>
>>>>>> #define SDHCI_CAPABILITIES =A0 =A00x40
>>>>>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 0x0000003F
>>>>>> @@ -167,6 +174,9 @@
>>>>>> #define =A0SDHCI_CAN_64BIT =A0 =A0 =A00x10000000
>>>>>>
>>>>>> #define SDHCI_CAPABILITIES_1 =A00x44
>>>>>> +#define =A0SDHCI_CAN_SDR50 =A0 =A0 0x00000001
>>>>>> +#define =A0SDHCI_CAN_SDR104 =A0 =A00x00000002
>>>>>> +#define =A0SDHCI_CAN_DDR50 =A0 =A0 0x00000004
>>>>>>
>>>>>> #define SDHCI_MAX_CURRENT =A0 =A0 0x48
>>>>>>
>>>>>> @@ -222,6 +232,8 @@ struct sdhci_ops {
>>>>>> =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_hos=
t *host,
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 u8 power_mode);
>>>>>> =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host=
);
>>>>>> + =A0 =A0 unsigned int =A0 =A0(*set_power)(struct sdhci_host *ho=
st,
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed short power);
>>>>>> };
>>>>>>
>>>>>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>>>>> --
>>>>>> 1.7.0.4
>>>>>> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>
>>>>>
>>>>>
>>>
>>>
>>> commented out support for 1.8v in sdhci.c =A0where the check was ma=
de for the controller supporting 1.8v core voltage
>>> added printk to show ocr and host->ocr. before check to call mmc_se=
lect_low_voltage or mmc_select_voltage in mmc.c
>>>
>>> the card is recognized as DDR but we do not mount the drive since t=
he check for SDHCI_POWER_180 fails and we do not program the registers.
>>>
>>>
>>>
>>> [ =A0 =A00.000000] Linux version 2.6.37-rc6-next-20101220-00023-ge7=
c195e-dirty (philip@philip-laptop) (gcc version 4.2.0 20070413 (prerele=
ase) (CodeSourcery 2007q1-10. Marvell 2009q3-18 20090821)) #80 PREEMPT =
0
>>> [ =A0 =A00.000000] CPU: Marvell PJ4 processor [560f5815] revision 5=
 (ARMv7), cr=3D00c5387f
>>> [ =A0 =A00.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing =
instruction cache
>>> [ =A0 =A00.000000] Machine: Brownstone Development Platform
>>> [ =A0 =A00.000000] Ignoring unrecognised tag 0x41000403
>>> [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache writebac=
k
>>> [ =A0 =A00.000000] On node 0 totalpages: 131072
>>> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c03713d8, nod=
e_mem_map c0390000
>>> [ =A0 =A00.000000] =A0 Normal zone: 1024 pages used for memmap
>>> [ =A0 =A00.000000] =A0 Normal zone: 0 pages reserved
>>> [ =A0 =A00.000000] =A0 Normal zone: 130048 pages, LIFO batch:31
>>> [ =A0 =A00.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
>>> [ =A0 =A00.000000] pcpu-alloc: [0] 0
>>> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility groupi=
ng on. =A0Total pages: 130048
>>> [ =A0 =A00.000000] Kernel command line: debug rootdelay=3D15 root=3D=
/dev/mmcblk0p1 rootfstype=3Dext3 console=3DttyS2,38400 mem=3D512M uart_=
dma mbr_offset=3D0x4800
>>> [ =A0 =A00.000000] PID hash table entries: 2048 (order: 1, 8192 byt=
es)
>>> [ =A0 =A00.000000] Dentry cache hash table entries: 65536 (order: 6=
, 262144 bytes)
>>> [ =A0 =A00.000000] Inode-cache hash table entries: 32768 (order: 5,=
 131072 bytes)
>>> [ =A0 =A00.000000] Memory: 512MB =3D 512MB total
>>> [ =A0 =A00.000000] Memory: 516108k/516108k available, 8180k reserve=
d, 0K highmem
>>> [ =A0 =A00.000000] Virtual kernel memory layout:
>>> [ =A0 =A00.000000] =A0 =A0 vector =A0: 0xffff0000 - 0xffff1000 =A0 =
( =A0 4 kB)
>>> [ =A0 =A00.000000] =A0 =A0 fixmap =A0: 0xfff00000 - 0xfffe0000 =A0 =
( 896 kB)
>>> [ =A0 =A00.000000] =A0 =A0 DMA =A0 =A0 : 0xffc00000 - 0xffe00000 =A0=
 ( =A0 2 MB)
>>> [ =A0 =A00.000000] =A0 =A0 vmalloc : 0xe0800000 - 0xfe000000 =A0 ( =
472 MB)
>>> [ =A0 =A00.000000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xe0000000 =A0 =
( 512 MB)
>>> [ =A0 =A00.000000] =A0 =A0 modules : 0xbf000000 - 0xc0000000 =A0 ( =
=A016 MB)
>>> [ =A0 =A00.000000] =A0 =A0 =A0 .init : 0xc0008000 - 0xc001f000 =A0 =
( =A092 kB)
>>> [ =A0 =A00.000000] =A0 =A0 =A0 .text : 0xc001f000 - 0xc035400c =A0 =
(3285 kB)
>>> [ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc0356000 - 0xc0373040 =A0 =
( 117 kB)
>>> [ =A0 =A00.000000] Preemptable hierarchical RCU implementation.
>>> [ =A0 =A00.000000] =A0RCU-based detection of stalled CPUs is disabl=
ed.
>>> [ =A0 =A00.000000] =A0Verbose stalled-CPUs detection is disabled.
>>> [ =A0 =A00.000000] NR_IRQS:320 nr_irqs:360 360
>>> [ =A0 =A00.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, =
wraps every 660764ms
>>> [ =A0 =A00.000000] Console: colour dummy device 80x30
>>> [ =A0 =A00.000166] Calibrating delay loop... 796.26 BogoMIPS (lpj=3D=
3981312)
>>> [ =A0 =A00.220135] pid_max: default: 32768 minimum: 301
>>> [ =A0 =A00.220328] Mount-cache hash table entries: 512
>>> [ =A0 =A00.220328] CPU: Testing write buffer coherency: ok
>>> [ =A0 =A00.224398] print_constraints: dummy: regulator:
>>> [ =A0 =A00.224525] NET: Registered protocol family 16
>>> [ =A0 =A00.224525] Tauros2: Disabling L2 prefetch.
>>> [ =A0 =A00.224569] Tauros2: L2 cache support initialised in ARMv6 m=
ode.
>>> [ =A0 =A00.227737] bio: create slab <bio-0> at 0
>>> [ =A0 =A00.228950] Switching to clocksource clocksource
>>> [ =A0 =A00.233848] NET: Registered protocol family 2
>>> [ =A0 =A00.234150] IP route cache hash table entries: 4096 (order: =
2, 16384 bytes)
>>> [ =A0 =A00.234482] TCP established hash table entries: 16384 (order=
: 5, 131072 bytes)
>>> [ =A0 =A00.234482] TCP bind hash table entries: 16384 (order: 4, 65=
536 bytes)
>>> [ =A0 =A00.234733] TCP: Hash tables configured (established 16384 b=
ind 16384)
>>> [ =A0 =A00.234863] TCP reno registered
>>> [ =A0 =A00.234878] UDP hash table entries: 256 (order: 0, 4096 byte=
s)
>>> [ =A0 =A00.234878] UDP-Lite hash table entries: 256 (order: 0, 4096=
 bytes)
>>> [ =A0 =A00.234901] NET: Registered protocol family 1
>>> [ =A0 =A00.235444] RPC: Registered udp transport module.
>>> [ =A0 =A00.235444] RPC: Registered tcp transport module.
>>> [ =A0 =A00.235462] RPC: Registered tcp NFSv4.1 backchannel transpor=
t module.
>>> [ =A0 =A00.237177] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, =
Inc.
>>> [ =A0 =A00.237177] msgmni has been set to 1008
>>> [ =A0 =A00.238053] io scheduler noop registered
>>> [ =A0 =A00.238087] io scheduler deadline registered
>>> [ =A0 =A00.238104] io scheduler cfq registered (default)
>>> [ =A0 =A00.238679] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (irq =3D=
 27) is a FFUART
>>> [ =A0 =A00.238852] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq =3D=
 24) is a STUART
>>> [ =A0 =A01.353048] console [ttyS2] enabled
>>> [ =A0 =A01.364154] mousedev: PS/2 mouse device common for all mice
>>> [ =A0 =A01.380867] sdhci: Secure Digital Host Controller Interface =
driver
>>> [ =A0 =A01.399304] sdhci: Copyright(c) Pierre Ossman
>>> [ =A0 =A01.412378] mmc0: no vmmc regulator found
>>> [ =A0 =A01.424539] mmc0: SDHCI controller on MMC [sdhci-pxa.2] usin=
g ADMA
>>> [ =A0 =A01.443030] mmc1: no vmmc regulator found
>>> [ =A0 =A01.455203] mmc1: SDHCI controller on MMC [sdhci-pxa.0] usin=
g ADMA
>>> [ =A0 =A01.474554] mmc2: no vmmc regulator found
>>> [ =A0 =A01.486636] mmc2: SDHCI controller on MMC [sdhci-pxa.1] usin=
g ADMA
>>> [ =A0 =A01.505238] TCP cubic registered
>>> [ =A0 =A01.514889] NET: Registered protocol family 17
>>> [ =A0 =A01.529176] Registering the dns_resolver key type
>>> [ =A0 =A01.545330] VFP support v0.3: implementor 56 architecture 2 =
part 20 variant 9 rev 5
>>> [ =A0 =A01.568612] drivers/rtc/hctosys.c: unable to open rtc device=
 (rtc0)
>>> [ =A0 =A01.587543] Waiting 15sec before mounting root device...
>>> [ =A0 =A01.604984] mmc_attach_mmc:mmc0: ocr & MMC_VDD_165_195 =3D 8=
0, host->ocr_avail & MMC_VDD_165_195 =3D 0
>>
>> Here something wrong, =A0host->ocr_avail should have 0x80, otherwise=
 ocr
>> can not get ox80 back,
>> Could you try the patch send you this morning, which is tested based
>> on mmc-next.
>>
>
>
> The host controller is NOT required to support 1.8v. =A0mmp2 supports=
 this and to show the bug
> I commented out support for this as I mentioned above. =A0If 1.8v cor=
e voltage is not supported
> by the controller by code break.

I think we should conform to spec first, then consider the special requ=
irement.
Since uhs mode, including SDR50 etc, only takes effective when 1.8v
singaling Enbale is set, which requires controller send out 1.8v io
voltage.
So only set 1.8v singaling Enbale at the condition host support 1.8v.

>
>>> [ =A0 11.688964] mmc0: Timeout waiting for hardware interrupt.
>>> [ =A0 11.688976] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER =
DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [ =A0 11.705024] sdhci: Sys addr: 0x00000000 | Version: =A00x000000=
02
>>> [ =A0 11.739657] sdhci: Blk size: 0x00007008 | Blk cnt: =A00x000000=
00
>>> [ =A0 11.739657] sdhci: Argument: 0x00000000 | Trn mode: 0x00000003
>>> [ =A0 11.756973] sdhci: Present: =A00x01fa0000 | Host ctl: 0x000000=
35
>>> [ =A0 11.791607] sdhci: Power: =A0 =A00x0000000f | Blk gap: =A00x00=
000000
>>> [ =A0 11.791607] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x00=
000207
>>> [ =A0 11.808923] sdhci: Timeout: =A00x0000000e | Int stat: 0x000000=
00
>>> [ =A0 11.826241] sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
>>> [ =A0 11.843558] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>>> [ =A0 11.860874] sdhci: Caps: =A0 =A0 0x25fcc8b2 | Caps_1: =A0 0x00=
002f77
>>> [ =A0 11.878191] sdhci: Cmd: =A0 =A0 =A00x0000133a | Max curr: 0x00=
000000
>>> [ =A0 11.895509] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x1f943808
>>> [ =A0 11.912826] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>> [ =A0 11.947936] mmc0: new high speed DDR MMC card at address 0001
>>> [ =A0 11.965402] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
>>> [ =A0 11.983931] mmcblk0: retrying using single block read
>>> [ =A0 11.999498] mmcblk0: error -84 transferring data, sector 0, nr=
 8, card status 0x900
>>> [ =A0 12.022300] end_request: I/O error, dev mmcblk0, sector 0
>>> [ =A0 12.038868] mmcblk0: error -84 transferring data, sector 1, nr=
 7, card status 0x900
>>> [ =A0 12.061745] end_request: I/O error, dev mmcblk0, sector 1
>>> [ =A0 12.078364] mmcblk0: error -84 transferring data, sector 2, nr=
 6, card status 0x900
>>> [ =A0 12.101155] end_request: I/O error, dev mmcblk0, sector 2
>>> [ =A0 12.117704] mmcblk0: error -84 transferring data, sector 3, nr=
 5, card status 0x900
>>> [ =A0 12.140507] end_request: I/O error, dev mmcblk0, sector 3
>>> [ =A0 12.157063] mmcblk0: error -84 transferring data, sector 4, nr=
 4, card status 0x900
>>> [ =A0 12.179876] end_request: I/O error, dev mmcblk0, sector 4
>>> [ =A0 12.196428] mmcblk0: error -84 transferring data, sector 5, nr=
 3, card status 0x900
>>> [ =A0 12.219233] end_request: I/O error, dev mmcblk0, sector 5
>>> [ =A0 12.235789] mmcblk0: error -84 transferring data, sector 6, nr=
 2, card status 0x900
>>> [ =A0 12.258604] end_request: I/O error, dev mmcblk0, sector 6
>>> [ =A0 12.275154] mmcblk0: error -84 transferring data, sector 7, nr=
 1, card status 0x900
>>> [ =A0 12.297970] end_request: I/O error, dev mmcblk0, sector 7
>>> [ =A0 12.314016] Buffer I/O error on device mmcblk0, logical block =
0
>>> [ =A0 12.332239] mmcblk0: retrying using single block read
>>> [ =A0 12.347777] mmcblk0: error -84 transferring data, sector 0, nr=
 8, card status 0x900
>>> [ =A0 12.370589] end_request: I/O error, dev mmcblk0, sector 0
>>> [ =A0 12.387149] mmcblk0: error -84 transferring data, sector 1, nr=
 7, card status 0x900
>>> [ =A0 12.409954] end_request: I/O error, dev mmcblk0, sector 1
>>> [ =A0 12.426510] mmcblk0: error -84 transferring data, sector 2, nr=
 6, card status 0x900
>>> [ =A0 12.449325] end_request: I/O error, dev mmcblk0, sector 2
>>> [ =A0 12.465891] mmcblk0: error -84 transferring data, sector 3, nr=
 5, card status 0x900
>>> [ =A0 12.488677] end_request: I/O error, dev mmcblk0, sector 3
>>> [ =A0 12.505239] mmcblk0: error -84 transferring data, sector 4, nr=
 4, card status 0x900
>>> [ =A0 12.528050] end_request: I/O error, dev mmcblk0, sector 4
>>> [ =A0 12.544602] mmcblk0: error -84 transferring data, sector 5, nr=
 3, card status 0x900
>>> [ =A0 12.567407] end_request: I/O error, dev mmcblk0, sector 5
>>> [ =A0 12.583965] mmcblk0: error -84 transferring data, sector 6, nr=
 2, card status 0x900
>>> [ =A0 12.606770] end_request: I/O error, dev mmcblk0, sector 6
>>> [ =A0 12.623330] mmcblk0: error -84 transferring data, sector 7, nr=
 1, card status 0x900
>>> [ =A0 12.646134] end_request: I/O error, dev mmcblk0, sector 7
>>> [ =A0 12.662188] Buffer I/O error on device mmcblk0, logical block =
0
>>> [ =A0 12.679810] =A0mmcblk0: unable to read partition table
>>> [ =A0 16.609127] VFS: Cannot open root device "mmcblk0p1" or unknow=
n-block(179,1)
>>> [ =A0 16.630132] Please append a correct "root=3D" boot option; her=
e are the available partitions:
>>> [ =A0 16.654964] b300 =A0 =A0 =A0 =A0 7757824 mmcblk0 =A0driver: mm=
cblk
>>> [ =A0 16.670806] Kernel panic - not syncing: VFS: Unable to mount r=
oot fs on unknown-block(179,1)
>>> [ =A0 16.695905] [<c002abe8>] (unwind_backtrace+0x0/0x124) from [<c=
0038518>] (panic+0x6c/0x18c)
>>> [ =A0 16.720516] [<c0038518>] (panic+0x6c/0x18c) from [<c0008d94>] =
(mount_block_root+0x1c4/0x204)
>>> [ =A0 16.745636] [<c0008d94>] (mount_block_root+0x1c4/0x204) from [=
<c0008e74>] (mount_root+0xa0/0xc4)
>>> [ =A0 16.771787] [<c0008e74>] (mount_root+0xa0/0xc4) from [<c0008fb=
4>] (prepare_namespace+0x11c/0x174)
>>> [ =A0 16.798201] [<c0008fb4>] (prepare_namespace+0x11c/0x174) from =
[<c0008750>] (kernel_init+0x108/0x14c)
>>> [ =A0 16.825393] [<c0008750>] (kernel_init+0x108/0x14c) from [<c002=
63e0>] (kernel_thread_exit+0x0/0x8)
>>>
>>>
>>>
>
>
