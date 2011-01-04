From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V2 2/2] sdhci: Support for SD/MMC Dual Data Rate
Date: Mon, 3 Jan 2011 22:39:46 -0500
Message-ID: <AANLkTi=ERwn3W8tvt3NNS3Xiq93mhy7TV7vAT9dwjvaq@mail.gmail.com>
References: <35CD48DB-A420-4319-968D-400D45EE9C0D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59199 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab1ADDjs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jan 2011 22:39:48 -0500
Received: by fxm20 with SMTP id 20so13754018fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jan 2011 19:39:46 -0800 (PST)
In-Reply-To: <35CD48DB-A420-4319-968D-400D45EE9C0D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On Sun, Jan 2, 2011 at 11:45 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> mmc->caps MMC_CAP_1_8V_DDR is set by looking at cabability_1
> register if sd 3.0 controller.
>
> Support for dual data rate (DDR50) with 1_8V signalling added
> with optional call back to enable external control of signalling
> voltage.
>
> no support for 1.2V core voltage since SD 3.0 does not support
> this.
>
> **** QUESTION ****
> should this be part of regulator framework ?
>
> delay for signaling voltage to settle set to 5ms (per spec).
>
> this code does not change the voltage supplied to the card.
> It assumes that this is correctly handled in the core/ layer.
>
> There is no requirement that the card voltage be at 1.8v
> for DDR to work. =A0This violates DDR specification for
> SD Host Controller 3.0 since explicitly states card voltage
> is 3.3v while signalling voltage is set to 1.8v.
>
> tested on mmp2 -- brownstone -- under linux-next.
>
> Note: =A0this board design runs a fixed voltage to the card and
> signaling voltage cannot be changed.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 53 ++++++++++++++++++++++++++++++++=
++++++++++---
> =A0drivers/mmc/host/sdhci.h | =A0 =A05 ++++
> =A02 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d5febe5..805f850 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -84,6 +84,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
> =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": Cmd: =A0 =A0 =A00x%08=
x | Max curr: 0x%08x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readw(host, SDHCI_COMMAND),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_MAX_CURRENT));
> + =A0 =A0 =A0 printk(KERN_DEBUG DRIVER_NAME ": HostCtrl2:0x%08x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readw(host, SDHCI_HOST_CONTROL_2)=
);
>
> =A0 =A0 =A0 =A0if (host->flags & SDHCI_USE_ADMA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_DEBUG DRIVER_NAME ": ADMA =
Err: 0x%08x | ADMA Ptr: 0x%08x\n",
> @@ -986,6 +988,38 @@ static void sdhci_finish_command(struct sdhci_ho=
st *host)
> =A0 =A0 =A0 =A0host->cmd =3D NULL;
> =A0}
>
> +/*
> + * Handle 1.8V signaling for DDR. No need to check for other
> + * DDR values since driver supports ONLY 1_8V DDR. =A0This is
> + * set by the MMC_CAP_1_8V_DDR. =A01_2V DDR is not supported.
> + */
> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
> +{
> + =A0 =A0 =A0 u16 con;
> +
> + =A0 =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL_2);
> + =A0 =A0 =A0 con |=3D SDCTRL_2_SDH_V18_EN;
> + =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
> +
> + =A0 =A0 =A0 /* Change sigalling voltage and wait for it to be stabl=
e */
> + =A0 =A0 =A0 if (host->ops->set_signaling_voltage)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_signaling_voltage(host, =
18);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(5);

In fact, have considered this method before, mdelay(5) in
spin_lock_irqsave is terrible, since timer can not update system time,
and android must die.

> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We can fail here but there is no higher level reco=
very
> + =A0 =A0 =A0 =A0* since the card is already past the switch to ddr
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL_2);
> + =A0 =A0 =A0 con &=3D ~SDCTRL_2_UHS_MODE_MASK;
> + =A0 =A0 =A0 con |=3D SDCTRL_2_UHS_MODE_SEL_DDR50;
> + =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
> +}
> +
> =A0static void sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> =A0{
> =A0 =A0 =A0 =A0int div;
> @@ -1180,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0sdhci_set_clock(host, ios->clock);
> + =A0 =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>
> =A0 =A0 =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
> @@ -1744,7 +1779,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> =A0int sdhci_add_host(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *mmc;
> - =A0 =A0 =A0 unsigned int caps, ocr_avail;
> + =A0 =A0 =A0 unsigned int caps, caps_h, ocr_avail;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
> @@ -1767,8 +1802,19 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? ho=
st->caps :
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES);
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_MISSING_CAPS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps =3D host->caps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D 0;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps =3D sdhci_readl(host, SDHCI_CAPABI=
LITIES);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D sdhci_readl(=
host, SDHCI_CAPABILITIES_1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (caps_h & SDHCI_CAN_DDR50)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_1_8V_DDR;
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
> @@ -1905,7 +1951,6 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr_avail |=3D MMC_VDD_29_30 | MMC_VDD=
_30_31;
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_VDD_180)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr_avail |=3D MMC_VDD_165_195;
> -
> =A0 =A0 =A0 =A0mmc->ocr_avail =3D ocr_avail;
> =A0 =A0 =A0 =A0mmc->ocr_avail_sdio =3D ocr_avail;
> =A0 =A0 =A0 =A0if (host->ocr_avail_sdio)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 36f3861..d976e4f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -182,6 +182,9 @@
> =A0#define =A0SDHCI_CAN_64BIT =A0 =A0 =A0 0x10000000
>
> =A0#define SDHCI_CAPABILITIES_1 =A0 0x44
> +#define =A0SDHCI_CAN_SDR50 =A0 =A0 =A0 0x00000001
> +#define =A0SDHCI_CAN_SDR104 =A0 =A0 =A00x00000002
> +#define =A0SDHCI_CAN_DDR50 =A0 =A0 =A0 0x00000004
>
> =A0#define SDHCI_MAX_CURRENT =A0 =A0 =A00x48
>
> @@ -237,6 +240,8 @@ struct sdhci_ops {
> =A0 =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_host=
 *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u8 power_mode);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host)=
;
> + =A0 =A0 =A0 unsigned int =A0 =A0(*set_signaling_voltage)(struct sdh=
ci_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d short voltage);
> =A0};
>
> =A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
