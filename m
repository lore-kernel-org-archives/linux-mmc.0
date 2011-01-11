From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v4]
Date: Mon, 10 Jan 2011 21:21:00 -0500
Message-ID: <AANLkTi=PO+oKsSibcZSpCXEduYLNnm8+sdK3BWcz7_cO@mail.gmail.com>
References: <AANLkTi=EP1dJEEHa49N26s0Hfsq_fie69aqTtNAqbvzZ@mail.gmail.com>
	<5207861A-5CC3-4F04-A429-35ED564E86C1@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38559 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab1AKCVB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2011 21:21:01 -0500
Received: by fxm20 with SMTP id 20so19501720fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jan 2011 18:21:00 -0800 (PST)
In-Reply-To: <5207861A-5CC3-4F04-A429-35ED564E86C1@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Mark Brown <markb@marvell.com>

On Mon, Jan 10, 2011 at 7:06 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Jan 9, 2011, at 3:50 AM, zhangfei gao wrote:
>
>> From d65af1e0a51bd4cc6b7a55b48df2bc23ccb84f2d Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Sun, 9 Jan 2011 18:09:12 -0500
>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>
>> =A0 =A0 =A0 1. spec sdhc 3.0 does not claim support 1.2v ddr mode
>> =A0 =A0 =A0 2. Call back function set_uhs is added, since some contr=
oller count
>> on external pmic to provide io voltage
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> drivers/mmc/core/core.c =A0| =A0 17 ++++++++++++
>> drivers/mmc/core/core.h =A0| =A0 =A01 +
>> drivers/mmc/core/mmc.c =A0 | =A0 =A05 +++
>> drivers/mmc/host/sdhci.c | =A0 62 ++++++++++++++++++++++++++++++++++=
+++++++++--
>> drivers/mmc/host/sdhci.h | =A0 14 +++++++++-
>> include/linux/mmc/host.h | =A0 =A02 +
>> 6 files changed, 97 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index a8e89f3..964b44f 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -623,6 +623,23 @@ static inline void mmc_set_ios(struct mmc_host =
*host)
>> =A0 =A0 =A0 host->ops->set_ios(host, ios);
>> }
>>
>> +int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode)
>> +{
>> + =A0 =A0 int ret =3D -EINVAL;
>> +
>> + =A0 =A0 if (host->ops->set_uhs) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->ops->set_uhs(host, uhs_mode)=
;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* According to sdhc standard spec v3.0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1.8v regulator should be stable withi=
ng 5ms
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(5);
>
> The delay should be set in set_uhs IHMO
mmc_delay is defined in core.h, and it already consider schedule case,
so it's better to put here.
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> /*
>> =A0* Control chip select pin on a host.
>> =A0*/
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 026c975..4b1ea7e 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
>> unsigned int width);
>> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int ddr)=
;
>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>> +int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode);
>> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>
>> static inline void mmc_delay(unsigned int ms)
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 86cac0d..4dac82f 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -529,6 +529,11 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ddr =3D =
MMC_1_2V_DDR_MODE;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (ddr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_set_uhs(host, ddr))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ddr =3D MMC_SDR_MODE;
>> + =A0 =A0 }
>> +
>
>
> This code is setting 1.8v signaling on the host controller before the=
 switch command to ask the card to go to DDR mode and use 1.8v signalli=
ng.
> Is this valid before the card has moved into that state ?
Since time is needed to wait for voltage to be stable, so it should be
put before switch.

>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Activate wide bus and DDR (if supported).
>> =A0 =A0 =A0 =A0*/
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d5febe5..906f85b 100644
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
>> @@ -1180,6 +1196,7 @@ static void sdhci_set_ios(struct mmc_host *mmc=
,
>> struct mmc_ios *ios)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 sdhci_set_clock(host, ios->clock);
>> + =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>>
>> =A0 =A0 =A0 if (ios->power_mode =3D=3D MMC_POWER_OFF)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_power(host, -1);
>> @@ -1237,6 +1254,35 @@ out:
>> =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
>> }
>>
>> +static int sdhci_set_uhs(struct mmc_host *mmc, unsigned int uhs_mod=
e)
>> +{
>> + =A0 =A0 struct sdhci_host *host;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 host =3D mmc_priv(mmc);
>> +
>> + =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> + =A0 =A0 if (host->mmc->caps & MMC_CAP_1_8V_DDR) {
>
> since only 1_8V is supported is the if check necessary. =A0 =A0Failur=
e would imply the core layer was broken.

Typo, here is check uhs_mode, if (uhs_mode & MMC_1_8V_DDR_MODE), since
MMC_1_2V_DDR_MODE is not supported.
And failure is already considered according to return value, re-use SDR=
 mode

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTR=
OL2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTROL=
2);
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
>> +
>> + =A0 =A0 if (host->ops->set_uhs)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->ops->set_uhs(host, uhs_mode)=
;
>> +
>> + =A0 =A0 return ret;
>> +err:
>> + =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
>> + =A0 =A0 return =A0-EINVAL;
>> +}
>> +
>> static int sdhci_get_ro(struct mmc_host *mmc)
>> {
>> =A0 =A0 =A0 struct sdhci_host *host;
>> @@ -1287,6 +1333,7 @@ out:
>> static const struct mmc_host_ops sdhci_ops =3D {
>> =A0 =A0 =A0 .request =A0 =A0 =A0 =A0=3D sdhci_request,
>> =A0 =A0 =A0 .set_ios =A0 =A0 =A0 =A0=3D sdhci_set_ios,
>> + =A0 =A0 .set_uhs =A0 =A0 =A0 =A0=3D sdhci_set_uhs,
>> =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D sdhci_get_ro,
>> =A0 =A0 =A0 .enable_sdio_irq =3D sdhci_enable_sdio_irq,
>> };
>> @@ -1744,7 +1791,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>> int sdhci_add_host(struct sdhci_host *host)
>> {
>> =A0 =A0 =A0 struct mmc_host *mmc;
>> - =A0 =A0 unsigned int caps, ocr_avail;
>> + =A0 =A0 unsigned int caps, caps_h =3D 0, ocr_avail;
>> =A0 =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 WARN_ON(host =3D=3D NULL);
>> @@ -1767,8 +1814,17 @@ int sdhci_add_host(struct sdhci_host *host)
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
>
> SDHCI_CAN_ DDR50 - =A0wrong bit being checked.
Thanks, mistake here.

> missing check for SD 3.0 Controller -- see my patch
> see chris comments on the name caps_h

I think use caps_h and SDHCI_CAPABILITIES_H is OK, since it is high 32
bits of capabilities register.

>
>> =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_USE_SDMA;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 6e0969e..f8e94b9 100644
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
>> + =A0 =A0 unsigned int =A0 =A0(*set_uhs)(struct sdhci_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned i=
nt uhs_mode);
>> };
>>
>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index bcb793e..07131b0 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -117,6 +117,8 @@ struct mmc_host_ops {
>>
>> =A0 =A0 =A0 /* optional callback for HC quirks */
>> =A0 =A0 =A0 void =A0 =A0(*init_card)(struct mmc_host *host, struct m=
mc_card *card);
>> +
>> + =A0 =A0 int =A0 =A0 (*set_uhs)(struct mmc_host *host, unsigned int=
 uhs_mode);
>> };
>>
>> struct mmc_card;
>> --
>> 1.7.0.4
>> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>
>
>
