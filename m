From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Wed, 22 Dec 2010 00:37:36 -0500
Message-ID: <AANLkTinYBj4ZtnTDPk1F1tsSgepi_OLUhx9vFdJWi3mL@mail.gmail.com>
References: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
	<0A929BFA-55C4-45DF-A11D-2BC8B2B0BCEF@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:44980 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0LVFhi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 00:37:38 -0500
Received: by fxm18 with SMTP id 18so5200199fxm.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2010 21:37:36 -0800 (PST)
In-Reply-To: <0A929BFA-55C4-45DF-A11D-2BC8B2B0BCEF@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Wed, Dec 22, 2010 at 12:09 AM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> Resend as plain test -- with additional comments.
> On Dec 21, 2010, at 4:37 AM, zhangfei gao wrote:
>
>> v3: sync to mmc-next
>>
>> Emmc speed could double if using ddr50 mode, help check
>>
>> From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Tue, 21 Dec 2010 19:51:38 -0500
>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>
>> =A0 =A0 =A0 1. spec sdhc 3.0 does not claim support 1.2v ddr mode
>> =A0 =A0 =A0 2. Call back function set_power is added, since some con=
troller count
>> on external pmic to provide power
>> =A0 =A0 =A0 3. According to spec sdhc 3.0, uhs mode, including emmc =
ddr50 takes
>> effect only when 1.8v Signaling Enable bit, which used for providing
>> 1.8v.
>> =A0 =A0 =A0 =A0 =A0So emmc ddr50 mode works after 1.8v switching pro=
cess, though emmc
>> ddr50 could work at high voltage such as 3.3v if external pmic provi=
de
>> voltage.
>> =A0 =A0 =A0 =A0 =A0Limitation: emmc ddr50 mode only workable when bo=
th host and emmc
>> card support 1.70-1.90v
>
>
> signaling voltage is not the same as card voltage. =A0card voltage ca=
n be 3.3v and
> signaling voltage 1.8v.
My understanding is signal voltage is io voltage, which could be low
voltage, 1.70~1.90v.
Card voltage should be keeps high voltage.
In fact, two power domain inside emmc, one is vcc, the other is vccq,
this is control io domain.
>
>> =A0 =A0 =A0 4. According to JESD84, power down and power up is requi=
red to
>> provide low voltage 1.70-1.90v to mmc.
>>
>> =A0 =A0 =A0 Verified: toshiba emmc on mmp2, with io voltage at 1.8v =
provided by
>> external pmic.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> drivers/mmc/core/core.c =A0| =A0 13 +++++++++++++
>> drivers/mmc/core/core.h =A0| =A0 =A01 +
>> drivers/mmc/core/mmc.c =A0 | =A0 =A06 +++++-
>> drivers/mmc/host/sdhci.c | =A0 44 ++++++++++++++++++++++++++++++++++=
+++++++---
>> drivers/mmc/host/sdhci.h | =A0 14 +++++++++++++-
>> 5 files changed, 73 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index a8e89f3..fd657f1 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host *ho=
st)
>> }
>>
>> /*
>> + * mmc select low voltage 1.70-1.95v
>> + */
>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
>> +{
>> + =A0 =A0 if (!(ocr & MMC_VDD_165_195))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 mmc_power_off(host);
>> + =A0 =A0 host->ocr =3D ocr & host->ocr_avail;
>> + =A0 =A0 mmc_power_up(host);
>> +}
>> +
>> +/*
>> =A0* Cleanup when the last reference to the bus operator is dropped.
>> =A0*/
>> static void __mmc_release_bus(struct mmc_host *host)
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 026c975..b05c20a 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
>> unsigned int width);
>> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int ddr)=
;
>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
>> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>
>> static inline void mmc_delay(unsigned int ms)
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 86cac0d..8779339 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u32 o=
cr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr &=3D ~0x7F;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 host->ocr =3D mmc_select_voltage(host, ocr);
>> + =A0 =A0 if ((ocr & MMC_VDD_165_195)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->ocr_avail & MMC_=
VDD_165_195))
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_select_low_voltage(host, ocr);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ocr =3D mmc_select_voltage(host, ocr=
);
>>
>
> The patch for dual voltage cards should be a separate patch. =A0It is=
 independent of
> support for dual data rate.
>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Can we support the voltage of the card?
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d5febe5..aafbb42 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_h=
ost *host)
>> =A0 =A0 =A0 host->cmd =3D NULL;
>> }
>>
>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr=
)
>> +{
>> + =A0 =A0 u16 con;
>> +
>> + =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> + =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~SDHCI_CTRL2_UHS_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_DDR50=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTROL=
2);
>> + =A0 =A0 }
>> +}
>> +
>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int cl=
ock)
>> {
>> =A0 =A0 =A0 int div;
>> @@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_host
>> *host, unsigned short power)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_DDR)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTR=
OL2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTROL=
2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->set_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_power(host,=
 pwr);
>> + =A0 =A0 }
>> +
>
> power to the card can be at 3.3v and signaling at 1.8v. =A0This is a =
legal combination.

It is legal combination, then why here should be reworked?
The Power control register is control SD bus voltage, which should be
io voltage.
Even the dual voltage emmc card can not work at both vcc and vccq are 1=
=2E8v.

> The
>> + =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_DDR)) {
> should be reworked.
>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Spec says that we should clear the power reg before=
 setting
>> =A0 =A0 =A0 =A0* a new value. Some controllers don't seem to like th=
is though.
>> @@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host *mmc=
,
>> struct mmc_ios *ios)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 sdhci_set_clock(host, ios->clock);
>> + =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>>
>> =A0 =A0 =A0 if (ios->power_mode =3D=3D MMC_POWER_OFF)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_power(host, -1);
>> @@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>> int sdhci_add_host(struct sdhci_host *host)
>> {
>> =A0 =A0 =A0 struct mmc_host *mmc;
>> - =A0 =A0 unsigned int caps, ocr_avail;
>> + =A0 =A0 unsigned int caps, caps_h =3D 0, ocr_avail;
>> =A0 =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 WARN_ON(host =3D=3D NULL);
>> @@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->version);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host-=
>caps :
>> - =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES);
>> + =A0 =A0 if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D host->caps;
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 caps =3D sdhci_readl(host, SDHCI_CAPABILIT=
IES);
>> + =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D sdhci_readl(host, SDHCI_CAPABIL=
ITIES_1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (caps & SDHCI_CAN_VDD_180) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (caps_h & SDHCI_CAN_SDR50)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_1_=
8V_DDR);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_USE_SDMA;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 6e0969e..c4bd5dd 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -145,7 +145,14 @@
>>
>> #define SDHCI_ACMD12_ERR =A0 =A0 =A00x3C
>>
>> -/* 3E-3F reserved */
>> +#define SDHCI_HOST_CONTROL2 =A00x3E
>> +#define =A0SDHCI_CTRL2_UHS_MASK =A0 =A0 =A0 =A00x0007
>> +#define =A0 SDHCI_CTRL2_SDR12 =A00x0000
>> +#define =A0 SDHCI_CTRL2_SDR25 =A00x0001
>> +#define =A0 SDHCI_CTRL2_SDR50 =A00x0002
>> +#define =A0 SDHCI_CTRL2_SDR104 0x0003
>> +#define =A0 SDHCI_CTRL2_DDR50 =A00x0004
>> +#define =A0SDHCI_CTRL2_1_8V =A0 =A00x0008
>>
>> #define SDHCI_CAPABILITIES =A0 =A00x40
>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 0x0000003F
>> @@ -167,6 +174,9 @@
>> #define =A0SDHCI_CAN_64BIT =A0 =A0 =A00x10000000
>>
>> #define SDHCI_CAPABILITIES_1 =A00x44
>> +#define =A0SDHCI_CAN_SDR50 =A0 =A0 0x00000001
>> +#define =A0SDHCI_CAN_SDR104 =A0 =A00x00000002
>> +#define =A0SDHCI_CAN_DDR50 =A0 =A0 0x00000004
>>
>> #define SDHCI_MAX_CURRENT =A0 =A0 0x48
>>
>> @@ -222,6 +232,8 @@ struct sdhci_ops {
>> =A0 =A0 =A0 void (*platform_send_init_74_clocks)(struct sdhci_host *=
host,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0u8 power_mode);
>> =A0 =A0 =A0 unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host);
>> + =A0 =A0 unsigned int =A0 =A0(*set_power)(struct sdhci_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned s=
hort power);
>> };
>>
>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> --
>> 1.7.0.4
>> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>
>
>
