From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3 09/11] mmc: sdhci: enable preset value after uhs initialization
Date: Thu, 28 Apr 2011 01:16:43 -0400
Message-ID: <BANLkTi=ByrqNrG_sYQCQ+y9wfz2PTmUWDw@mail.gmail.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
	<1303291861-1788-10-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62124 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab1D1FQo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 01:16:44 -0400
Received: by qyg14 with SMTP id 14so1240684qyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 22:16:44 -0700 (PDT)
In-Reply-To: <1303291861-1788-10-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, prakity@marvell.com, subhashj@codeaurora.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Wed, Apr 20, 2011 at 5:30 AM, Arindam Nath <arindam.nath@amd.com> wr=
ote:
> According to the Host Controller spec v3.00, setting Preset Value Ena=
ble
> in the Host Control2 register lets SDCLK Frequency Select, Clock Gene=
rator
> Select and Driver Strength Select to be set automatically by the Host
> Controller based on the UHS-I mode set. This patch enables this featu=
re.
> We also reset Preset Value Enable next time before initialization.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>

Hi, Arindam

This patch cause abnormal behavior of general hs card, since
enable_preset_value(host, 1) is set to both uhs card and general card
here.
Your patch serious basically works with the fix, thanks a lot.
Additional call back to enable external regulator output voltage is
needed on our platform for testing.

Thanks

> ---
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 11 +++++++++++
> =A0drivers/mmc/host/sdhci.c | =A0 32 ++++++++++++++++++++++++++++++++
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A03 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index f3ecdef..08305ab 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -959,6 +959,13 @@ static int mmc_sd_init_card(struct mmc_host *hos=
t, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Since initialization is now complete, enable prese=
t
> + =A0 =A0 =A0 =A0* value registers.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->ops->enable_preset_value)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->enable_preset_value(host, 1)=
;
> +

Could you move this after mmc_sd_card_set_uhs, and only for uhs card.
General hs card may not properly if enable this feature.

> =A0 =A0 =A0 =A0host->card =3D card;
> =A0 =A0 =A0 =A0return 0;
>
> @@ -1109,6 +1116,10 @@ int mmc_attach_sd(struct mmc_host *host)
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> + =A0 =A0 =A0 /* Disable preset value enable if already set from last=
 time */
> + =A0 =A0 =A0 if (host->ops->enable_preset_value)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->enable_preset_value(host, 0)=
;
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * We need to get OCR a different way for SPI.
> =A0 =A0 =A0 =A0 */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9065157..c25ab83 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1614,6 +1614,37 @@ out:
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> +static void sdhci_enable_preset_value(struct mmc_host *mmc, int enab=
le)
> +{
> + =A0 =A0 =A0 struct sdhci_host *host;
> + =A0 =A0 =A0 u16 ctrl;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 host =3D mmc_priv(mmc);
> +
> + =A0 =A0 =A0 /* Host Controller v3.00 defines preset value registers=
 */
> + =A0 =A0 =A0 if (host->version < SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> +
> + =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We only enable or disable Preset Value if they are=
 not already
> + =A0 =A0 =A0 =A0* enabled or disabled respectively. Otherwise, we ba=
il out.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (enable && !(ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_PRESET_VAL_ENABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl, SDHCI_HOST_CON=
TROL2);
> + =A0 =A0 =A0 } else if (!enable && (ctrl & SDHCI_CTRL_PRESET_VAL_ENA=
BLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_PRESET_VAL_ENABLE=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl, SDHCI_HOST_CON=
TROL2);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> =A0static const struct mmc_host_ops sdhci_ops =3D {
> =A0 =A0 =A0 =A0.request =A0 =A0 =A0 =A0=3D sdhci_request,
> =A0 =A0 =A0 =A0.set_ios =A0 =A0 =A0 =A0=3D sdhci_set_ios,
> @@ -1621,6 +1652,7 @@ static const struct mmc_host_ops sdhci_ops =3D =
{
> =A0 =A0 =A0 =A0.enable_sdio_irq =3D sdhci_enable_sdio_irq,
> =A0 =A0 =A0 =A0.start_signal_voltage_switch =A0 =A0=3D sdhci_start_si=
gnal_voltage_switch,
> =A0 =A0 =A0 =A0.execute_tuning =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D sd=
hci_execute_tuning,
> + =A0 =A0 =A0 .enable_preset_value =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_e=
nable_preset_value,
> =A0};
>
> =A0/*****************************************************************=
************\
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ca7007f..2209e01 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -137,6 +137,7 @@ struct mmc_host_ops {
>
> =A0 =A0 =A0 =A0int =A0 =A0 (*start_signal_voltage_switch)(struct mmc_=
host *host, struct mmc_ios *ios);
> =A0 =A0 =A0 =A0int =A0 =A0 (*execute_tuning)(struct mmc_host *host);
> + =A0 =A0 =A0 void =A0 =A0(*enable_preset_value)(struct mmc_host *hos=
t, int enable);
> =A0};
>
> =A0struct mmc_card;
> --
> 1.7.1
>
>
