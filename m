From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 09/15] mmc: sdhci: enable preset value after uhs initialization
Date: Fri, 6 May 2011 06:40:04 -0400
Message-ID: <BANLkTikxs6wkvEv0qCe9g+Aw-66qn0Ge7A@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-10-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61120 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1EFKkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:40:04 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so3291153vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:40:04 -0700 (PDT)
In-Reply-To: <1304578151-1775-10-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> According to the Host Controller spec v3.00, setting Preset Value Ena=
ble
> in the Host Control2 register lets SDCLK Frequency Select, Clock Gene=
rator
> Select and Driver Strength Select to be set automatically by the Host
> Controller based on the UHS-I mode set. This patch enables this featu=
re.
> Since Preset Value Enable makes sense only for UHS-I cards, we enable=
 this
> feature after successfull UHS-I initialization. We also reset Preset =
Value
> Enable next time before initialization.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 11 +++++++++++
> =A0drivers/mmc/host/sdhci.c | =A0 32 ++++++++++++++++++++++++++++++++
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A03 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 84cb8c3..851c8fc 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -931,6 +931,13 @@ static int mmc_sd_init_card(struct mmc_host *hos=
t, u32 ocr,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Card is an ultra-high-speed card */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_sd_card_set_uhs(card);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Since initialization is now comple=
te, enable preset
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* value registers for UHS-I cards.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->enable_preset_value)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->enable_prese=
t_value(host, 1);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Attempt to change to high-speed (if=
 supported)
> @@ -1101,6 +1108,10 @@ int mmc_attach_sd(struct mmc_host *host)
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> + =A0 =A0 =A0 /* Disable preset value enable if already set since las=
t time */
> + =A0 =A0 =A0 if (host->ops->enable_preset_value)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->enable_preset_value(host, 0)=
;
> +
> =A0 =A0 =A0 =A0err =3D mmc_send_app_op_cond(host, 0, &ocr);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 85775cf..cb767a0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1655,6 +1655,37 @@ out:
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
> @@ -1662,6 +1693,7 @@ static const struct mmc_host_ops sdhci_ops =3D =
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
