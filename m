From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 06/15] mmc: sd: set current limit for uhs cards
Date: Fri, 6 May 2011 06:38:59 -0400
Message-ID: <BANLkTinCGpkWqZw-6f7thMKLE43TxokpVg@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-7-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61120 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab1EFKjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:39:00 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so3291153vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:39:00 -0700 (PDT)
In-Reply-To: <1304578151-1775-7-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> We decide on the current limit to be set for the card based on the
> Capability of Host Controller to provide current at 1.8V signalling,
> and the maximum current limit of the card as indicated by CMD6
> mode 0. We then set the current limit for the card using CMD6 mode 1.
> As per the Physical Layer Spec v3.01, the current limit switch is
> only applicable for SDR50, SDR104, and DDR50 bus speed modes. For
> other UHS-I modes, we set the default current limit of 200mA.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 63 ++++++++++++++++++++++++++++=
++++++++++++++++++
> =A0drivers/mmc/host/sdhci.c | =A0 10 +++++++
> =A0include/linux/mmc/card.h | =A0 =A09 ++++++
> =A0include/linux/mmc/host.h | =A0 =A04 +++
> =A04 files changed, 86 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 0491978..9270d82 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -517,6 +517,64 @@ static int sd_set_bus_speed_mode(struct mmc_card=
 *card, u8 *status)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int sd_set_current_limit(struct mmc_card *card, u8 *status)
> +{
> + =A0 =A0 =A0 int current_limit =3D 0;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Current limit switch is only defined for SDR50, SD=
R104, and DDR50
> + =A0 =A0 =A0 =A0* bus speed modes. For other bus speed modes, we set=
 the default
> + =A0 =A0 =A0 =A0* current limit of 200mA.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if ((card->sd_bus_speed =3D=3D UHS_SDR50_BUS_SPEED) ||
> + =A0 =A0 =A0 =A0 =A0 (card->sd_bus_speed =3D=3D UHS_SDR104_BUS_SPEED=
) ||
> + =A0 =A0 =A0 =A0 =A0 (card->sd_bus_speed =3D=3D UHS_DDR50_BUS_SPEED)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->host->caps & MMC_CAP_MAX_CURR=
ENT_800) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->sw_caps.sd3_c=
urr_limit & SD_MAX_CURRENT_800)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_800;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.=
sd3_curr_limit &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 SD_MAX_CURRENT_600)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_600;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.=
sd3_curr_limit &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 SD_MAX_CURRENT_400)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_400;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.=
sd3_curr_limit &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 SD_MAX_CURRENT_200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_200;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (card->host->caps & MMC_CAP_M=
AX_CURRENT_600) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->sw_caps.sd3_c=
urr_limit & SD_MAX_CURRENT_600)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_600;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.=
sd3_curr_limit &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 SD_MAX_CURRENT_400)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_400;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.=
sd3_curr_limit &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 SD_MAX_CURRENT_200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_200;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (card->host->caps & MMC_CAP_M=
AX_CURRENT_400) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->sw_caps.sd3_c=
urr_limit & SD_MAX_CURRENT_400)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_400;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (card->sw_caps.=
sd3_curr_limit &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 SD_MAX_CURRENT_200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_200;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (card->host->caps & MMC_CAP_M=
AX_CURRENT_200) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->sw_caps.sd3_c=
urr_limit & SD_MAX_CURRENT_200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_limit =3D SD_SET_CURRENT_LIMIT_200;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_limit =3D SD_SET_CURRENT_LIMIT_=
200;
> +
> + =A0 =A0 =A0 err =3D mmc_sd_switch(card, 1, 3, current_limit, status=
);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 if (((status[15] >> 4) & 0x0F) !=3D current_limit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Problem settin=
g current limit!\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0/*
> =A0* UHS-I specific initialization procedure
> =A0*/
> @@ -555,6 +613,11 @@ static int mmc_sd_init_uhs_card(struct mmc_card =
*card)
>
> =A0 =A0 =A0 =A0/* Set bus speed mode of the card */
> =A0 =A0 =A0 =A0err =3D sd_set_bus_speed_mode(card, status);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 /* Set current limit for the card */
> + =A0 =A0 =A0 err =3D sd_set_current_limit(card, status);
>
> =A0out:
> =A0 =A0 =A0 =A0kfree(status);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index de7e6e9..9176911 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2217,6 +2217,16 @@ int sdhci_add_host(struct sdhci_host *host)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (max_current_180 > 150)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP=
_SET_XPC_180;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Maximum current capabilities of the =
host at 1.8V */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_current_180 >=3D 800)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
MAX_CURRENT_800;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (max_current_180 >=3D 600)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
MAX_CURRENT_600;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (max_current_180 >=3D 400)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
MAX_CURRENT_400;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
MAX_CURRENT_200;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mmc->ocr_avail =3D ocr_avail;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4ef6ded..47b5ad3 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -105,6 +105,15 @@ struct sd_switch_caps {
> =A0#define SD_DRIVER_TYPE_C =A0 =A0 =A0 0x04
> =A0#define SD_DRIVER_TYPE_D =A0 =A0 =A0 0x08
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_curr_limit;
> +#define SD_SET_CURRENT_LIMIT_200 =A0 =A0 =A0 0
> +#define SD_SET_CURRENT_LIMIT_400 =A0 =A0 =A0 1
> +#define SD_SET_CURRENT_LIMIT_600 =A0 =A0 =A0 2
> +#define SD_SET_CURRENT_LIMIT_800 =A0 =A0 =A0 3
> +
> +#define SD_MAX_CURRENT_200 =A0 =A0 (1 << SD_SET_CURRENT_LIMIT_200)
> +#define SD_MAX_CURRENT_400 =A0 =A0 (1 << SD_SET_CURRENT_LIMIT_400)
> +#define SD_MAX_CURRENT_600 =A0 =A0 (1 << SD_SET_CURRENT_LIMIT_600)
> +#define SD_MAX_CURRENT_800 =A0 =A0 (1 << SD_SET_CURRENT_LIMIT_800)
> =A0};
>
> =A0struct sdio_cccr {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 6237599..52b5dc9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -203,6 +203,10 @@ struct mmc_host {
> =A0#define MMC_CAP_DRIVER_TYPE_A =A0(1 << 23) =A0 =A0 =A0 /* Host sup=
ports Driver Type A */
> =A0#define MMC_CAP_DRIVER_TYPE_C =A0(1 << 24) =A0 =A0 =A0 /* Host sup=
ports Driver Type C */
> =A0#define MMC_CAP_DRIVER_TYPE_D =A0(1 << 25) =A0 =A0 =A0 /* Host sup=
ports Driver Type D */
> +#define MMC_CAP_MAX_CURRENT_200 =A0 =A0 =A0 =A0(1 << 26) =A0 =A0 =A0=
 /* Host max current limit is 200mA */
> +#define MMC_CAP_MAX_CURRENT_400 =A0 =A0 =A0 =A0(1 << 27) =A0 =A0 =A0=
 /* Host max current limit is 400mA */
> +#define MMC_CAP_MAX_CURRENT_600 =A0 =A0 =A0 =A0(1 << 28) =A0 =A0 =A0=
 /* Host max current limit is 600mA */
> +#define MMC_CAP_MAX_CURRENT_800 =A0 =A0 =A0 =A0(1 << 29) =A0 =A0 =A0=
 /* Host max current limit is 800mA */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
> --
> 1.7.1
>
>
