From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v5]
Date: Thu, 20 Jan 2011 22:51:42 -0500
Message-ID: <AANLkTikc5kPOx7z3D5RZxcK4eWdZUjw6p55RthrM7JiA@mail.gmail.com>
References: <AANLkTikJcVpgX7TPr4LTz44HzePKFk-Y1_9QsyUrFk-O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63220 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1AUDvo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jan 2011 22:51:44 -0500
Received: by fxm20 with SMTP id 20so1362287fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jan 2011 19:51:43 -0800 (PST)
In-Reply-To: <AANLkTikJcVpgX7TPr4LTz44HzePKFk-Y1_9QsyUrFk-O@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>

On Mon, Jan 10, 2011 at 9:56 PM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
> Update typo
>
> From 93873d40ea72b1ccd97c3629ffe555080ac4d0e4 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Sun, 9 Jan 2011 18:09:12 -0500
> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>
> =A0 =A0 =A0 =A01. Spec sdhc 3.0 does not claim support 1.2v ddr mode,=
 so sdhci.c
> return error and SDR mode is been reused.
> =A0 =A0 =A0 =A02. Call back function set_uhs is added, since some con=
troller count
> on external pmic to provide io voltage
> =A0 =A0 =A0 =A03. mmc_set_uhs is added to make host switch io voltage=
 according to uhs_mode
> =A0 =A0 =A0 =A04. Verified on mmp2 and toshiba emmc
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =A0drivers/mmc/core/core.c =A0| =A0 18 +++++++++++++
> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A09 ++++++
> =A0drivers/mmc/host/sdhci.c | =A0 64 ++++++++++++++++++++++++++++++++=
+++++++++++---
> =A0drivers/mmc/host/sdhci.h | =A0 16 ++++++++++-
> =A0include/linux/mmc/host.h | =A0 =A02 +
> =A06 files changed, 104 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a8e89f3..1f1f185 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -623,6 +623,24 @@ static inline void mmc_set_ios(struct mmc_host *=
host)
> =A0 =A0 =A0 =A0host->ops->set_ios(host, ios);
> =A0}
>
> +int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode)
> +{
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> +
> + =A0 =A0 =A0 if (host->ops->set_uhs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->ops->set_uhs(host, uhs_mo=
de);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* According to sdhc standard spec v3=
=2E0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1.8v regulator should be stable wi=
thing 5ms
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(5);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/*
> =A0* Control chip select pin on a host.
> =A0*/
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 026c975..4b1ea7e 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
> unsigned int width);
> =A0void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int wid=
th,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ddr)=
;
> =A0u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> +int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode);
> =A0void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>
> =A0static inline void mmc_delay(unsigned int ms)
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 86cac0d..657c5ef 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -529,6 +529,15 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ddr =3D=
 MMC_1_2V_DDR_MODE;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (ddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_set_uhs(host, ddr)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: DDR mode not accepted by host "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "and re=
use MMC_SDR_MODE.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ddr =3D MMC_SDR_MODE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Activate wide bus and DDR (if supported).
> =A0 =A0 =A0 =A0 */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d5febe5..decc50f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -80,7 +80,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readw(host, SDHCI_SLOT_INT_STATU=
S));
> =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": Caps: =A0 =A0 0x%08x =
| Caps_1: =A0 0x%08x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_CAPABILITIES),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES_1)=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES_H)=
);
> =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": Cmd: =A0 =A0 =A00x%08=
x | Max curr: 0x%08x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readw(host, SDHCI_COMMAND),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_MAX_CURRENT));
> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_ho=
st *host)
> =A0 =A0 =A0 =A0host->cmd =3D NULL;
> =A0}
>
> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
> +{
> + =A0 =A0 =A0 u16 con;
> +
> + =A0 =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> + =A0 =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~SDHCI_CTRL2_UHS_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_DD=
R50;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONT=
ROL2);
> + =A0 =A0 =A0 }
> +}
> +
> =A0static void sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> =A0{
> =A0 =A0 =A0 =A0int div;
> @@ -1180,6 +1196,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0sdhci_set_clock(host, ios->clock);
> + =A0 =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>
> =A0 =A0 =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
> @@ -1237,6 +1254,35 @@ out:
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0}
>
> +static int sdhci_set_uhs(struct mmc_host *mmc, unsigned int uhs_mode=
)
> +{
> + =A0 =A0 =A0 struct sdhci_host *host;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 host =3D mmc_priv(mmc);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> + =A0 =A0 =A0 if (uhs_mode & MMC_1_8V_DDR_MODE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CO=
NTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONT=
ROL2);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
> +
> + =A0 =A0 =A0 if (host->ops->set_uhs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->ops->set_uhs(host, uhs_mo=
de);
> +
> + =A0 =A0 =A0 return ret;
> +err:
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
> + =A0 =A0 =A0 return =A0-EINVAL;
> +}
> +
> =A0static int sdhci_get_ro(struct mmc_host *mmc)
> =A0{
> =A0 =A0 =A0 =A0struct sdhci_host *host;
> @@ -1287,6 +1333,7 @@ out:
> =A0static const struct mmc_host_ops sdhci_ops =3D {
> =A0 =A0 =A0 =A0.request =A0 =A0 =A0 =A0=3D sdhci_request,
> =A0 =A0 =A0 =A0.set_ios =A0 =A0 =A0 =A0=3D sdhci_set_ios,
> + =A0 =A0 =A0 .set_uhs =A0 =A0 =A0 =A0=3D sdhci_set_uhs,
> =A0 =A0 =A0 =A0.get_ro =A0 =A0 =A0 =A0 =3D sdhci_get_ro,
> =A0 =A0 =A0 =A0.enable_sdio_irq =3D sdhci_enable_sdio_irq,
> =A0};
> @@ -1744,7 +1791,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> =A0int sdhci_add_host(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *mmc;
> - =A0 =A0 =A0 unsigned int caps, ocr_avail;
> + =A0 =A0 =A0 unsigned int caps, caps_h =3D 0, ocr_avail;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
> @@ -1767,8 +1814,17 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? ho=
st->caps :
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES);
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps =3D host->caps;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps =3D sdhci_readl(host, SDHCI_CAPABI=
LITIES);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D sdhci_readl(host, SDHCI_CAPA=
BILITIES_H);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (caps & SDHCI_CAN_VDD_180) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (caps_h & SDHCI_CAN_DDR50)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP=
_1_8V_DDR);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6e0969e..6be28a9 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -145,7 +145,14 @@
>
> =A0#define SDHCI_ACMD12_ERR =A0 =A0 =A0 0x3C
>
> -/* 3E-3F reserved */
> +#define SDHCI_HOST_CONTROL2 =A0 =A00x3E
> +#define =A0SDHCI_CTRL2_UHS_MASK =A00x0007
> +#define =A0 SDHCI_CTRL2_SDR12 =A0 =A00x0000
> +#define =A0 SDHCI_CTRL2_SDR25 =A0 =A00x0001
> +#define =A0 SDHCI_CTRL2_SDR50 =A0 =A00x0002
> +#define =A0 SDHCI_CTRL2_SDR104 =A0 0x0003
> +#define =A0 SDHCI_CTRL2_DDR50 =A0 =A00x0004
> +#define =A0SDHCI_CTRL2_1_8V =A0 =A0 =A00x0008
>
> =A0#define SDHCI_CAPABILITIES =A0 =A0 0x40
> =A0#define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 =A00x0000003F
> @@ -166,7 +173,10 @@
> =A0#define =A0SDHCI_CAN_VDD_180 =A0 =A0 0x04000000
> =A0#define =A0SDHCI_CAN_64BIT =A0 =A0 =A0 0x10000000
>
> -#define SDHCI_CAPABILITIES_1 =A0 0x44
> +#define SDHCI_CAPABILITIES_H =A0 0x44
> +#define =A0SDHCI_CAN_SDR50 =A0 =A0 =A0 0x00000001
> +#define =A0SDHCI_CAN_SDR104 =A0 =A0 =A00x00000002
> +#define =A0SDHCI_CAN_DDR50 =A0 =A0 =A0 0x00000004
>
> =A0#define SDHCI_MAX_CURRENT =A0 =A0 =A00x48
>
> @@ -222,6 +232,8 @@ struct sdhci_ops {
> =A0 =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_host=
 *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u8 power_mode);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host)=
;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*set_uhs)(struct sdhci_hos=
t *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int uhs_mode);
> =A0};
>
> =A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index bcb793e..07131b0 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -117,6 +117,8 @@ struct mmc_host_ops {
>
> =A0 =A0 =A0 =A0/* optional callback for HC quirks */
> =A0 =A0 =A0 =A0void =A0 =A0(*init_card)(struct mmc_host *host, struct=
 mmc_card *card);
> +
> + =A0 =A0 =A0 int =A0 =A0 (*set_uhs)(struct mmc_host *host, unsigned =
int uhs_mode);
> =A0};
>
> =A0struct mmc_card;
> --
> 1.7.0.4
>

Hi, Chris

What's your suggestion about this patch, thanks in advance.
