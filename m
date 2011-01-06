From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Thu, 6 Jan 2011 05:30:50 -0500
Message-ID: <AANLkTik_gqFefWyu0WbFodne824cCWYKnFSKF5KUpdCc@mail.gmail.com>
References: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
	<0A929BFA-55C4-45DF-A11D-2BC8B2B0BCEF@marvell.com>
	<AANLkTinYBj4ZtnTDPk1F1tsSgepi_OLUhx9vFdJWi3mL@mail.gmail.com>
	<9F47519A-91F9-4564-9D4A-A402F64DEE09@marvell.com>
	<AANLkTi=akCEvCVYB4XitbJ1yMTzkgakwoFezqw9Vyh2g@mail.gmail.com>
	<DEBF0B02-9D8B-45E9-9BF1-D69951833DCF@marvell.com>
	<AANLkTikL6_C5ag1SPawGfdwhTNMJr2axdO_=uUnfhZA7@mail.gmail.com>
	<DD46A12B-58EB-47BA-9608-0692F8D0655C@marvell.com>
	<AANLkTi=xyj8PNfTyZfvBCkatEs2o6Jyg=YLMQFWkjCbh@mail.gmail.com>
	<B8240ACE-E9B4-4F6F-BC99-BFB0D9C82BE5@marvell.com>
	<AANLkTinkXYK-xes7ODXpcZCDp=XC6iCgTGG6VOPfkczD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64581 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab1AFKaw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 05:30:52 -0500
Received: by fxm20 with SMTP id 20so15882794fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 06 Jan 2011 02:30:50 -0800 (PST)
In-Reply-To: <AANLkTinkXYK-xes7ODXpcZCDp=XC6iCgTGG6VOPfkczD@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Mon, Jan 3, 2011 at 11:07 PM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
> On Wed, Dec 22, 2010 at 10:43 AM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>
>> On Dec 21, 2010, at 11:17 PM, zhangfei gao wrote:
>>
>>> On Wed, Dec 22, 2010 at 2:06 AM, Philip Rakity <prakity@marvell.com=
> wrote:
>>>>
>>>> On Dec 21, 2010, at 10:42 PM, zhangfei gao wrote:
>>>>
>>>>> On Wed, Dec 22, 2010 at 1:20 AM, Philip Rakity <prakity@marvell.c=
om> wrote:
>>>>>>
>>>>>> On Dec 21, 2010, at 10:14 PM, zhangfei gao wrote:
>>>>>>
>>>>>>> On Wed, Dec 22, 2010 at 12:52 AM, Philip Rakity <prakity@marvel=
l.com> wrote:
>>>>>>>>
>>>>>>>> On Dec 21, 2010, at 9:37 PM, zhangfei gao wrote:
>>>>>>>>
>>>>>>>>> On Wed, Dec 22, 2010 at 12:09 AM, Philip Rakity <prakity@marv=
ell.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Resend as plain test -- with additional comments.
>>>>>>>>>> On Dec 21, 2010, at 4:37 AM, zhangfei gao wrote:
>>>>>>>>>>
>>>>>>>>>>> v3: sync to mmc-next
>>>>>>>>>>>
>>>>>>>>>>> Emmc speed could double if using ddr50 mode, help check
>>>>>>>>>>>
>>>>>>>>>>> From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00=
:00:00 2001
>>>>>>>>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>>>>>>> Date: Tue, 21 Dec 2010 19:51:38 -0500
>>>>>>>>>>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A01. spec sdhc 3.0 does not claim support 1.2v ddr mod=
e
>>>>>>>>>>> =A0 =A02. Call back function set_power is added, since some=
 controller count
>>>>>>>>>>> on external pmic to provide power
>>>>>>>>>>> =A0 =A03. According to spec sdhc 3.0, uhs mode, including e=
mmc ddr50 takes
>>>>>>>>>>> effect only when 1.8v Signaling Enable bit, which used for =
providing
>>>>>>>>>>> 1.8v.
>>>>>>>>>>> =A0 =A0 =A0 So emmc ddr50 mode works after 1.8v switching p=
rocess, though emmc
>>>>>>>>>>> ddr50 could work at high voltage such as 3.3v if external p=
mic provide
>>>>>>>>>>> voltage.
>>>>>>>>>>> =A0 =A0 =A0 Limitation: emmc ddr50 mode only workable when =
both host and emmc
>>>>>>>>>>> card support 1.70-1.90v
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> signaling voltage is not the same as card voltage. =A0card v=
oltage can be 3.3v and
>>>>>>>>>> signaling voltage 1.8v.
>>>>>>>>> My understanding is signal voltage is io voltage, which could=
 be low
>>>>>>>>> voltage, 1.70~1.90v.
>>>>>>>>> Card voltage should be keeps high voltage.
>>>>>>>>> In fact, two power domain inside emmc, one is vcc, the other =
is vccq,
>>>>>>>>> this is control io domain.
>>>>>>>>>>
>>>>>>>>>>> =A0 =A04. According to JESD84, power down and power up is r=
equired to
>>>>>>>>>>> provide low voltage 1.70-1.90v to mmc.
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0Verified: toshiba emmc on mmp2, with io voltage at 1=
=2E8v provided by
>>>>>>>>>>> external pmic.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>>>>>>> ---
>>>>>>>>>>> drivers/mmc/core/core.c =A0| =A0 13 +++++++++++++
>>>>>>>>>>> drivers/mmc/core/core.h =A0| =A0 =A01 +
>>>>>>>>>>> drivers/mmc/core/mmc.c =A0 | =A0 =A06 +++++-
>>>>>>>>>>> drivers/mmc/host/sdhci.c | =A0 44 +++++++++++++++++++++++++=
++++++++++++++++---
>>>>>>>>>>> drivers/mmc/host/sdhci.h | =A0 14 +++++++++++++-
>>>>>>>>>>> 5 files changed, 73 insertions(+), 5 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/cor=
e.c
>>>>>>>>>>> index a8e89f3..fd657f1 100644
>>>>>>>>>>> --- a/drivers/mmc/core/core.c
>>>>>>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>>>>>>> @@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc=
_host *host)
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> /*
>>>>>>>>>>> + * mmc select low voltage 1.70-1.95v
>>>>>>>>>>> + */
>>>>>>>>>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr=
)
>>>>>>>>>>> +{
>>>>>>>>>>> + =A0 =A0 if (!(ocr & MMC_VDD_165_195))
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>>>>>>> +
>>>>>>>>>>> + =A0 =A0 mmc_power_off(host);
>>>>>>>>>>> + =A0 =A0 host->ocr =3D ocr & host->ocr_avail;
>>>>>>>>>>> + =A0 =A0 mmc_power_up(host);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +/*
>>>>>>>>>>> * Cleanup when the last reference to the bus operator is dr=
opped.
>>>>>>>>>>> */
>>>>>>>>>>> static void __mmc_release_bus(struct mmc_host *host)
>>>>>>>>>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/cor=
e.h
>>>>>>>>>>> index 026c975..b05c20a 100644
>>>>>>>>>>> --- a/drivers/mmc/core/core.h
>>>>>>>>>>> +++ b/drivers/mmc/core/core.h
>>>>>>>>>>> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *h=
ost,
>>>>>>>>>>> unsigned int width);
>>>>>>>>>>> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned =
int width,
>>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int dd=
r);
>>>>>>>>>>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>>>>>>>>>>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr=
);
>>>>>>>>>>> void mmc_set_timing(struct mmc_host *host, unsigned int tim=
ing);
>>>>>>>>>>>
>>>>>>>>>>> static inline void mmc_delay(unsigned int ms)
>>>>>>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.=
c
>>>>>>>>>>> index 86cac0d..8779339 100644
>>>>>>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>>>>>>> @@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *ho=
st, u32 ocr)
>>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~0x7F;
>>>>>>>>>>> =A0 =A0}
>>>>>>>>>>>
>>>>>>>>>>> - =A0 =A0 host->ocr =3D mmc_select_voltage(host, ocr);
>>>>>>>>>>> + =A0 =A0 if ((ocr & MMC_VDD_165_195)
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->ocr_ava=
il & MMC_VDD_165_195))
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_select_low_voltage(host, ocr)=
;
>>>>>>>>>>> + =A0 =A0 else
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ocr =3D mmc_select_voltage(=
host, ocr);
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The patch for dual voltage cards should be a separate patch.=
 =A0It is independent of
>>>>>>>>>> support for dual data rate.
>>>>>>>>>>
>>>>>>>>>>> =A0 =A0/*
>>>>>>>>>>> =A0 =A0 * Can we support the voltage of the card?
>>>>>>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sd=
hci.c
>>>>>>>>>>> index d5febe5..aafbb42 100644
>>>>>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>>>>>> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struc=
t sdhci_host *host)
>>>>>>>>>>> =A0 =A0host->cmd =3D NULL;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigne=
d int ddr)
>>>>>>>>>>> +{
>>>>>>>>>>> + =A0 =A0 u16 con;
>>>>>>>>>>> +
>>>>>>>>>>> + =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>>>>>>> +
>>>>>>>>>>> + =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>>>>>>> + =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~SDHCI_CTRL2_UHS_MASK;
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CT=
RL2_DDR50;
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOS=
T_CONTROL2);
>>>>>>>>>>> + =A0 =A0 }
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> static void sdhci_set_clock(struct sdhci_host *host, unsign=
ed int clock)
>>>>>>>>>>> {
>>>>>>>>>>> =A0 =A0int div;
>>>>>>>>>>> @@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct s=
dhci_host
>>>>>>>>>>> *host, unsigned short power)
>>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0return;
>>>>>>>>>>> =A0 =A0}
>>>>>>>>>>>
>>>>>>>>>>> + =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_D=
DR)) {
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
>>>>>>>>>>> +
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_H=
OST_CONTROL2);
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOS=
T_CONTROL2);
>>>>>>>>>>> +
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->set_power)
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_po=
wer(host, pwr);
>>>>>>>>>>> + =A0 =A0 }
>>>>>>>>>>> +
>>>>>>>>>>
>>>>>>>>>> power to the card can be at 3.3v and signaling at 1.8v. =A0T=
his is a legal combination.
>>>>>>>>>
>>>>>>>>> It is legal combination, then why here should be reworked?
>>>>>>>>> The Power control register is control SD bus voltage, which s=
hould be
>>>>>>>>> io voltage.
>>>>>>>>> Even the dual voltage emmc card can not work at both vcc and =
vccq are 1.8v.
>>>>>>>>>
>>>>>>>>>> The
>>>>>>>>>>> + =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_D=
DR)) {
>>>>>>>>>> should be reworked.
>>>>>>>>>>
>>>>>>>>>>> =A0 =A0/*
>>>>>>>>>>> =A0 =A0 * Spec says that we should clear the power reg befo=
re setting
>>>>>>>>>>> =A0 =A0 * a new value. Some controllers don't seem to like =
this though.
>>>>>>>>>>> @@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_=
host *mmc,
>>>>>>>>>>> struct mmc_ios *ios)
>>>>>>>>>>> =A0 =A0}
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0sdhci_set_clock(host, ios->clock);
>>>>>>>>>>> + =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
>>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
>>>>>>>>>>> @@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>>>>>>>>>> int sdhci_add_host(struct sdhci_host *host)
>>>>>>>>>>> {
>>>>>>>>>>> =A0 =A0struct mmc_host *mmc;
>>>>>>>>>>> - =A0 =A0 unsigned int caps, ocr_avail;
>>>>>>>>>>> + =A0 =A0 unsigned int caps, caps_h =3D 0, ocr_avail;
>>>>>>>>>>> =A0 =A0int ret;
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0WARN_ON(host =3D=3D NULL);
>>>>>>>>>>> @@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host=
 *host)
>>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
>>>>>>>>>>> =A0 =A0}
>>>>>>>>>>>
>>>>>>>>>>> - =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS=
) ? host->caps :
>>>>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILIT=
IES);
>>>>>>>>>>> + =A0 =A0 if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D host->caps;
>>>>>>>>>>> + =A0 =A0 else {
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D sdhci_readl(host, SDHCI_=
CAPABILITIES);
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D sdhci_readl(host, SDHC=
I_CAPABILITIES_1);
>>>>>>>>>>> + =A0 =A0 }
>>>>>>>>>>> +
>>>>>>>>>>> + =A0 =A0 if (caps & SDHCI_CAN_VDD_180) {
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (caps_h & SDHCI_CAN_SDR50)
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (M=
MC_CAP_1_8V_DDR);
>>>>>>>>>>> + =A0 =A0 }
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
>>>>>>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sd=
hci.h
>>>>>>>>>>> index 6e0969e..c4bd5dd 100644
>>>>>>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>>>>>>> @@ -145,7 +145,14 @@
>>>>>>>>>>>
>>>>>>>>>>> #define SDHCI_ACMD12_ERR =A0 =A0 =A00x3C
>>>>>>>>>>>
>>>>>>>>>>> -/* 3E-3F reserved */
>>>>>>>>>>> +#define SDHCI_HOST_CONTROL2 =A00x3E
>>>>>>>>>>> +#define =A0SDHCI_CTRL2_UHS_MASK =A0 =A0 =A0 =A00x0007
>>>>>>>>>>> +#define =A0 SDHCI_CTRL2_SDR12 =A00x0000
>>>>>>>>>>> +#define =A0 SDHCI_CTRL2_SDR25 =A00x0001
>>>>>>>>>>> +#define =A0 SDHCI_CTRL2_SDR50 =A00x0002
>>>>>>>>>>> +#define =A0 SDHCI_CTRL2_SDR104 0x0003
>>>>>>>>>>> +#define =A0 SDHCI_CTRL2_DDR50 =A00x0004
>>>>>>>>>>> +#define =A0SDHCI_CTRL2_1_8V =A0 =A00x0008
>>>>>>>>>>>
>>>>>>>>>>> #define SDHCI_CAPABILITIES =A0 =A00x40
>>>>>>>>>>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 0x0000003F
>>>>>>>>>>> @@ -167,6 +174,9 @@
>>>>>>>>>>> #define =A0SDHCI_CAN_64BIT =A0 =A0 =A00x10000000
>>>>>>>>>>>
>>>>>>>>>>> #define SDHCI_CAPABILITIES_1 =A00x44
>>>>>>>>>>> +#define =A0SDHCI_CAN_SDR50 =A0 =A0 0x00000001
>>>>>>>>>>> +#define =A0SDHCI_CAN_SDR104 =A0 =A00x00000002
>>>>>>>>>>> +#define =A0SDHCI_CAN_DDR50 =A0 =A0 0x00000004
>>>>>>>>>>>
>>>>>>>>>>> #define SDHCI_MAX_CURRENT =A0 =A0 0x48
>>>>>>>>>>>
>>>>>>>>>>> @@ -222,6 +232,8 @@ struct sdhci_ops {
>>>>>>>>>>> =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_ho=
st *host,
>>>>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u8 power_mode);
>>>>>>>>>>> =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *hos=
t);
>>>>>>>>>>> + =A0 =A0 unsigned int =A0 =A0(*set_power)(struct sdhci_hos=
t *host,
>>>>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
nsigned short power);
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>>>>>>>>>> --
>>>>>>>>>>> 1.7.0.4
>>>>>>>>>>> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> commented out support for 1.8v in sdhci.c =A0where the check w=
as made for the controller supporting 1.8v core voltage
>>>>>>>> added printk to show ocr and host->ocr. before check to call m=
mc_select_low_voltage or mmc_select_voltage in mmc.c
>>>>>>>>
>>>>>>>> the card is recognized as DDR but we do not mount the drive si=
nce the check for SDHCI_POWER_180 fails and we do not program the regis=
ters.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> [ =A0 =A00.000000] Linux version 2.6.37-rc6-next-20101220-0002=
3-ge7c195e-dirty (philip@philip-laptop) (gcc version 4.2.0 20070413 (pr=
erelease) (CodeSourcery 2007q1-10. Marvell 2009q3-18 20090821)) #80 PRE=
EMPT 0
>>>>>>>> [ =A0 =A00.000000] CPU: Marvell PJ4 processor [560f5815] revis=
ion 5 (ARMv7), cr=3D00c5387f
>>>>>>>> [ =A0 =A00.000000] CPU: VIPT nonaliasing data cache, VIPT alia=
sing instruction cache
>>>>>>>> [ =A0 =A00.000000] Machine: Brownstone Development Platform
>>>>>>>> [ =A0 =A00.000000] Ignoring unrecognised tag 0x41000403
>>>>>>>> [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache wri=
teback
>>>>>>>> [ =A0 =A00.000000] On node 0 totalpages: 131072
>>>>>>>> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c03713d8=
, node_mem_map c0390000
>>>>>>>> [ =A0 =A00.000000] =A0 Normal zone: 1024 pages used for memmap
>>>>>>>> [ =A0 =A00.000000] =A0 Normal zone: 0 pages reserved
>>>>>>>> [ =A0 =A00.000000] =A0 Normal zone: 130048 pages, LIFO batch:3=
1
>>>>>>>> [ =A0 =A00.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*3=
2768
>>>>>>>> [ =A0 =A00.000000] pcpu-alloc: [0] 0
>>>>>>>> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility g=
rouping on. =A0Total pages: 130048
>>>>>>>> [ =A0 =A00.000000] Kernel command line: debug rootdelay=3D15 r=
oot=3D/dev/mmcblk0p1 rootfstype=3Dext3 console=3DttyS2,38400 mem=3D512M=
 uart_dma mbr_offset=3D0x4800
>>>>>>>> [ =A0 =A00.000000] PID hash table entries: 2048 (order: 1, 819=
2 bytes)
>>>>>>>> [ =A0 =A00.000000] Dentry cache hash table entries: 65536 (ord=
er: 6, 262144 bytes)
>>>>>>>> [ =A0 =A00.000000] Inode-cache hash table entries: 32768 (orde=
r: 5, 131072 bytes)
>>>>>>>> [ =A0 =A00.000000] Memory: 512MB =3D 512MB total
>>>>>>>> [ =A0 =A00.000000] Memory: 516108k/516108k available, 8180k re=
served, 0K highmem
>>>>>>>> [ =A0 =A00.000000] Virtual kernel memory layout:
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 vector =A0: 0xffff0000 - 0xffff1000=
 =A0 ( =A0 4 kB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 fixmap =A0: 0xfff00000 - 0xfffe0000=
 =A0 ( 896 kB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 DMA =A0 =A0 : 0xffc00000 - 0xffe000=
00 =A0 ( =A0 2 MB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 vmalloc : 0xe0800000 - 0xfe000000 =A0=
 ( 472 MB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xe0000000=
 =A0 ( 512 MB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 modules : 0xbf000000 - 0xc0000000 =A0=
 ( =A016 MB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 =A0 .init : 0xc0008000 - 0xc001f000=
 =A0 ( =A092 kB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 =A0 .text : 0xc001f000 - 0xc035400c=
 =A0 (3285 kB)
>>>>>>>> [ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc0356000 - 0xc0373040=
 =A0 ( 117 kB)
>>>>>>>> [ =A0 =A00.000000] Preemptable hierarchical RCU implementation=
=2E
>>>>>>>> [ =A0 =A00.000000] =A0RCU-based detection of stalled CPUs is d=
isabled.
>>>>>>>> [ =A0 =A00.000000] =A0Verbose stalled-CPUs detection is disabl=
ed.
>>>>>>>> [ =A0 =A00.000000] NR_IRQS:320 nr_irqs:360 360
>>>>>>>> [ =A0 =A00.000000] sched_clock: 32 bits at 6MHz, resolution 15=
3ns, wraps every 660764ms
>>>>>>>> [ =A0 =A00.000000] Console: colour dummy device 80x30
>>>>>>>> [ =A0 =A00.000166] Calibrating delay loop... 796.26 BogoMIPS (=
lpj=3D3981312)
>>>>>>>> [ =A0 =A00.220135] pid_max: default: 32768 minimum: 301
>>>>>>>> [ =A0 =A00.220328] Mount-cache hash table entries: 512
>>>>>>>> [ =A0 =A00.220328] CPU: Testing write buffer coherency: ok
>>>>>>>> [ =A0 =A00.224398] print_constraints: dummy: regulator:
>>>>>>>> [ =A0 =A00.224525] NET: Registered protocol family 16
>>>>>>>> [ =A0 =A00.224525] Tauros2: Disabling L2 prefetch.
>>>>>>>> [ =A0 =A00.224569] Tauros2: L2 cache support initialised in AR=
Mv6 mode.
>>>>>>>> [ =A0 =A00.227737] bio: create slab <bio-0> at 0
>>>>>>>> [ =A0 =A00.228950] Switching to clocksource clocksource
>>>>>>>> [ =A0 =A00.233848] NET: Registered protocol family 2
>>>>>>>> [ =A0 =A00.234150] IP route cache hash table entries: 4096 (or=
der: 2, 16384 bytes)
>>>>>>>> [ =A0 =A00.234482] TCP established hash table entries: 16384 (=
order: 5, 131072 bytes)
>>>>>>>> [ =A0 =A00.234482] TCP bind hash table entries: 16384 (order: =
4, 65536 bytes)
>>>>>>>> [ =A0 =A00.234733] TCP: Hash tables configured (established 16=
384 bind 16384)
>>>>>>>> [ =A0 =A00.234863] TCP reno registered
>>>>>>>> [ =A0 =A00.234878] UDP hash table entries: 256 (order: 0, 4096=
 bytes)
>>>>>>>> [ =A0 =A00.234878] UDP-Lite hash table entries: 256 (order: 0,=
 4096 bytes)
>>>>>>>> [ =A0 =A00.234901] NET: Registered protocol family 1
>>>>>>>> [ =A0 =A00.235444] RPC: Registered udp transport module.
>>>>>>>> [ =A0 =A00.235444] RPC: Registered tcp transport module.
>>>>>>>> [ =A0 =A00.235462] RPC: Registered tcp NFSv4.1 backchannel tra=
nsport module.
>>>>>>>> [ =A0 =A00.237177] JFFS2 version 2.2. (NAND) .. 2001-2006 Red =
Hat, Inc.
>>>>>>>> [ =A0 =A00.237177] msgmni has been set to 1008
>>>>>>>> [ =A0 =A00.238053] io scheduler noop registered
>>>>>>>> [ =A0 =A00.238087] io scheduler deadline registered
>>>>>>>> [ =A0 =A00.238104] io scheduler cfq registered (default)
>>>>>>>> [ =A0 =A00.238679] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (ir=
q =3D 27) is a FFUART
>>>>>>>> [ =A0 =A00.238852] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (ir=
q =3D 24) is a STUART
>>>>>>>> [ =A0 =A01.353048] console [ttyS2] enabled
>>>>>>>> [ =A0 =A01.364154] mousedev: PS/2 mouse device common for all =
mice
>>>>>>>> [ =A0 =A01.380867] sdhci: Secure Digital Host Controller Inter=
face driver
>>>>>>>> [ =A0 =A01.399304] sdhci: Copyright(c) Pierre Ossman
>>>>>>>> [ =A0 =A01.412378] mmc0: no vmmc regulator found
>>>>>>>> [ =A0 =A01.424539] mmc0: SDHCI controller on MMC [sdhci-pxa.2]=
 using ADMA
>>>>>>>> [ =A0 =A01.443030] mmc1: no vmmc regulator found
>>>>>>>> [ =A0 =A01.455203] mmc1: SDHCI controller on MMC [sdhci-pxa.0]=
 using ADMA
>>>>>>>> [ =A0 =A01.474554] mmc2: no vmmc regulator found
>>>>>>>> [ =A0 =A01.486636] mmc2: SDHCI controller on MMC [sdhci-pxa.1]=
 using ADMA
>>>>>>>> [ =A0 =A01.505238] TCP cubic registered
>>>>>>>> [ =A0 =A01.514889] NET: Registered protocol family 17
>>>>>>>> [ =A0 =A01.529176] Registering the dns_resolver key type
>>>>>>>> [ =A0 =A01.545330] VFP support v0.3: implementor 56 architectu=
re 2 part 20 variant 9 rev 5
>>>>>>>> [ =A0 =A01.568612] drivers/rtc/hctosys.c: unable to open rtc d=
evice (rtc0)
>>>>>>>> [ =A0 =A01.587543] Waiting 15sec before mounting root device..=
=2E
>>>>>>>> [ =A0 =A01.604984] mmc_attach_mmc:mmc0: ocr & MMC_VDD_165_195 =
=3D 80, host->ocr_avail & MMC_VDD_165_195 =3D 0
>>>>>>>
>>>>>>> Here something wrong, =A0host->ocr_avail should have 0x80, othe=
rwise ocr
>>>>>>> can not get ox80 back,
>>>>>>> Could you try the patch send you this morning, which is tested =
based
>>>>>>> on mmc-next.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> The host controller is NOT required to support 1.8v. =A0mmp2 sup=
ports this and to show the bug
>>>>>> I commented out support for this as I mentioned above. =A0If 1.8=
v core voltage is not supported
>>>>>> by the controller by code break.
>>>>>
>>>>> I think we should conform to spec first, then consider the specia=
l requirement.
>>>>> Since uhs mode, including SDR50 etc, only takes effective when 1.=
8v
>>>>> singaling Enbale is set, which requires controller send out 1.8v =
io
>>>>> voltage.
>>>>> So only set 1.8v singaling Enbale at the condition host support 1=
=2E8v.
>>>>>
>>>>
>>>> We do not agree that this is what the spec says. SD Host Controlle=
r spec
>>>> says 3.3v core voltage and 1.8v signaling. =A0I did not see a requ=
irement
>>>> in eMMC spec requiring that high voltage cards cannot support DDR.
>>>
>>> Spec "SD Host Controller Standard Specification Version 3.00" page
>>> 83/157, Host Control 2 Register, bit 02-00, UHS mode select
>>
>>
>> The section refers to signaling voltage not core voltage:
>>
>> "This field is used to select one of the UHS-1 modes and effective w=
hen 1.8V
>> Signaling Enable is set to 1.
>>
>> 1.8v Signaling Enable =A0--- This bit controls the voltage =A0regula=
tor for i/o cell. =A03.3V is
>> supplied to the the card regardless of signaling voltage".
>
> Since mmp2 use external pmic, so we can not verify via mmp2.
> Two voltage is provide for sd/emmc, one is vcc, the other is vccq,
> which is control io voltage.
>
> My understanding is
> The SD standards only define vccq. The vcc is independent and based o=
n
> the part and most likely cannot be switched.
> The power control register (0x29) selects which vccq to provide. (for
> e.g 0x7 =3D 3.3v, 0x5=3D1.8v)
> The sdhci host control2 (0x3e) selects the type of signalling used by
> the IO pad. By default 3.3 but if you enable then 1.8v ("1.8v
> signalling enable" bit).

The vcc provide voltage to core, since MLC NAND die inside, so vcc
should should keep to high voltage, such as 3.3v.
mmc/sd can not work when vcc=3D1.8v.

The io voltage is vccq in fact, which controlled by power control
register (0x29), while host control2 (0x3e) selects the type of
signalling.
So if want to enable 1.8v io voltage, both power control register and
host control2 need to set.

It is true, emmc ddr50 mode could work at io voltage is 3.3v, but UHS
mode only effective when io voltage is 1.8v, so if totally according
to spec, emmc have no chance to work at io voltage is 3.3v.
But if the voltage is provide by external pmic, both "1.8v signalling
enable" bit and sdhci host control2 (0x3e) are dummy, like mmp2, there
is no such limitation.
Since dual voltage and ddr50 both come out at v4.4, and the features
should be both supported at the same emmc.
So it is OK to enable ddr50 in low io voltage mode.

Thanks
