From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 05/15] mmc: sd: add support for uhs bus speed mode selection
Date: Fri, 6 May 2011 06:41:37 -0400
Message-ID: <BANLkTinbxfKC_Msrov6Ds1UkRSeasho2sw@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-6-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62654 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1EFKli convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:41:38 -0400
Received: by vxi39 with SMTP id 39so3293366vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:41:38 -0700 (PDT)
In-Reply-To: <1304578151-1775-6-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> This patch adds support for setting UHS-I bus speed mode during UHS-I
> initialization procedure. Since both the host and card can support
> more than one bus speed, we select the highest speed based on both of
> their capabilities. First we set the bus speed mode for the card usin=
g
> CMD6 mode 1, and then we program the host controller to support the
> required speed mode. We also set High Speed Enable in case one of the
> UHS-I modes is selected. We take care to reset SD clock before settin=
g
> UHS mode in the Host Control2 register, and then re-enable it as per
> the Host Controller spec v3.00. We then set the clock frequency for
> the UHS-I mode selected.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 65 ++++++++++++++++++++++++++++=
++++++++++++++++++
> =A0drivers/mmc/host/sdhci.c | =A0 40 ++++++++++++++++++++++++++--
> =A0drivers/mmc/host/sdhci.h | =A0 =A06 ++++
> =A0include/linux/mmc/card.h | =A0 19 +++++++++++++
> =A0include/linux/mmc/host.h | =A0 =A05 +++
> =A05 files changed, 132 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index a6fa52f..0491978 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -457,6 +457,66 @@ static int sd_select_driver_type(struct mmc_card=
 *card, u8 *status)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
> +{
> + =A0 =A0 =A0 unsigned int bus_speed =3D 0, timing =3D 0;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the host doesn't support any of the UHS-I modes=
, fallback on
> + =A0 =A0 =A0 =A0* default speed.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_U=
HS_SDR25 |
> + =A0 =A0 =A0 =A0 =A0 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CA=
P_UHS_DDR50)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
> + =A0 =A0 =A0 =A0 =A0 (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR10=
4)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_speed =3D UHS_SDR10=
4_BUS_SPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing =3D MMC_TIMING_U=
HS_SDR104;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.uhs_max_d=
tr =3D UHS_SDR104_MAX_DTR;
> + =A0 =A0 =A0 } else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(card->sw_caps.sd3_bus_mode & SD=
_MODE_UHS_DDR50)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_speed =3D UHS_DDR50=
_BUS_SPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing =3D MMC_TIMING_U=
HS_DDR50;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.uhs_max_d=
tr =3D UHS_DDR50_MAX_DTR;
> + =A0 =A0 =A0 } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_UHS_SDR50)) && (card->s=
w_caps.sd3_bus_mode &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SD_MODE_UHS_SDR50)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_speed =3D UHS_SDR50=
_BUS_SPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing =3D MMC_TIMING_U=
HS_SDR50;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.uhs_max_d=
tr =3D UHS_SDR50_MAX_DTR;
> + =A0 =A0 =A0 } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS=
_SDR25)) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(card->sw_caps.sd3_bus_mode & SD=
_MODE_UHS_SDR25)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_speed =3D UHS_SDR25=
_BUS_SPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing =3D MMC_TIMING_U=
HS_SDR25;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.uhs_max_d=
tr =3D UHS_SDR25_MAX_DTR;
> + =A0 =A0 =A0 } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS=
_SDR25 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_UHS_SDR12)) && (card->s=
w_caps.sd3_bus_mode &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SD_MODE_UHS_SDR12)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_speed =3D UHS_SDR12=
_BUS_SPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing =3D MMC_TIMING_U=
HS_SDR12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.uhs_max_d=
tr =3D UHS_SDR12_MAX_DTR;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 card->sd_bus_speed =3D bus_speed;
> + =A0 =A0 =A0 err =3D mmc_sd_switch(card, 1, 0, bus_speed, status);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 if ((status[16] & 0xF) !=3D bus_speed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Problem settin=
g bus speed mode!\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
));
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->host, timing);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_clock(card->host, card->sw_caps=
=2Euhs_max_dtr);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0/*
> =A0* UHS-I specific initialization procedure
> =A0*/
> @@ -490,6 +550,11 @@ static int mmc_sd_init_uhs_card(struct mmc_card =
*card)
>
> =A0 =A0 =A0 =A0/* Set the driver strength for the card */
> =A0 =A0 =A0 =A0err =3D sd_select_driver_type(card, status);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 /* Set bus speed mode of the card */
> + =A0 =A0 =A0 err =3D sd_set_bus_speed_mode(card, status);
>
> =A0out:
> =A0 =A0 =A0 =A0kfree(status);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 309240c..de7e6e9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1244,7 +1244,16 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_HISPD;
>
> =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_300) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 ctrl_2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 clk, ctrl_2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int clock;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* In case of UHS-I modes, set High Spe=
ed Enable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ios->timing =3D=3D MMC_TIMING_UHS_=
SDR50) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_=
UHS_SDR104) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_=
UHS_DDR50) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_=
UHS_SDR25) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_=
UHS_SDR12))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_HI=
SPD;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl_2 =3D sdhci_readw(host, SDHCI_HOS=
T_CONTROL2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_E=
NABLE)) {
> @@ -1267,8 +1276,6 @@ static void sdhci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * need to reset SD Cl=
ock Enable before changing High
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Speed Enable to avo=
id generating clock gliches.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 clk;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int clock;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Reset SD Clock Enab=
le */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk =3D sdhci_readw(ho=
st, SDHCI_CLOCK_CONTROL);
> @@ -1282,6 +1289,33 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->clock =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_clock(host, =
clock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST=
_CONTROL2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Select Bus Speed Mode for host */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 &=3D ~SDHCI_CTRL_UHS_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_UHS_S=
DR12)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_=
UHS_SDR12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ios->timing =3D=3D MMC_TIMING_=
UHS_SDR25)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_=
UHS_SDR25;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ios->timing =3D=3D MMC_TIMING_=
UHS_SDR50)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_=
UHS_SDR50;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ios->timing =3D=3D MMC_TIMING_=
UHS_SDR104)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_=
UHS_SDR104;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ios->timing =3D=3D MMC_TIMING_=
UHS_DDR50)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_=
UHS_DDR50;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reset SD Clock Enable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D sdhci_readw(host, SDHCI_CLOCK_C=
ONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk &=3D ~SDHCI_CLOCK_CARD_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, clk, SDHCI_CLOCK_CON=
TROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl_2, SDHCI_HOST_C=
ONTROL2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Re-enable SD Clock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D host->clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clock =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_clock(host, clock);
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_writeb(host, ctrl, SDHCI_HOST_CO=
NTROL1);
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 04c41a4..5b12793 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -149,6 +149,12 @@
> =A0#define SDHCI_ACMD12_ERR =A0 =A0 =A0 0x3C
>
> =A0#define SDHCI_HOST_CONTROL2 =A0 =A0 =A0 =A0 =A0 =A00x3E
> +#define =A0SDHCI_CTRL_UHS_MASK =A0 =A0 =A0 =A0 =A0 0x0007
> +#define =A0 SDHCI_CTRL_UHS_SDR12 =A0 =A0 =A0 =A0 0x0000
> +#define =A0 SDHCI_CTRL_UHS_SDR25 =A0 =A0 =A0 =A0 0x0001
> +#define =A0 SDHCI_CTRL_UHS_SDR50 =A0 =A0 =A0 =A0 0x0002
> +#define =A0 SDHCI_CTRL_UHS_SDR104 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
003
> +#define =A0 SDHCI_CTRL_UHS_DDR50 =A0 =A0 =A0 =A0 0x0004
> =A0#define =A0SDHCI_CTRL_VDD_180 =A0 =A0 =A0 =A0 =A0 =A00x0008
> =A0#define =A0SDHCI_CTRL_DRV_TYPE_MASK =A0 =A0 =A00x0030
> =A0#define =A0 SDHCI_CTRL_DRV_TYPE_B =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x0000
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 5393272..4ef6ded 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -81,7 +81,24 @@ struct sd_ssr {
>
> =A0struct sd_switch_caps {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0uhs_max_dtr;
> +#define UHS_SDR104_MAX_DTR =A0 =A0 208000000
> +#define UHS_SDR50_MAX_DTR =A0 =A0 =A0100000000
> +#define UHS_DDR50_MAX_DTR =A0 =A0 =A050000000
> +#define UHS_SDR25_MAX_DTR =A0 =A0 =A0UHS_DDR50_MAX_DTR
> +#define UHS_SDR12_MAX_DTR =A0 =A0 =A025000000
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_bus_mode;
> +#define UHS_SDR12_BUS_SPEED =A0 =A00
> +#define UHS_SDR25_BUS_SPEED =A0 =A01
> +#define UHS_SDR50_BUS_SPEED =A0 =A02
> +#define UHS_SDR104_BUS_SPEED =A0 3
> +#define UHS_DDR50_BUS_SPEED =A0 =A04
> +
> +#define SD_MODE_UHS_SDR12 =A0 =A0 =A0(1 << UHS_SDR12_BUS_SPEED)
> +#define SD_MODE_UHS_SDR25 =A0 =A0 =A0(1 << UHS_SDR25_BUS_SPEED)
> +#define SD_MODE_UHS_SDR50 =A0 =A0 =A0(1 << UHS_SDR50_BUS_SPEED)
> +#define SD_MODE_UHS_SDR104 =A0 =A0 (1 << UHS_SDR104_BUS_SPEED)
> +#define SD_MODE_UHS_DDR50 =A0 =A0 =A0(1 << UHS_DDR50_BUS_SPEED)
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_drv_type;
> =A0#define SD_DRIVER_TYPE_B =A0 =A0 =A0 0x01
> =A0#define SD_DRIVER_TYPE_A =A0 =A0 =A0 0x02
> @@ -166,6 +183,8 @@ struct mmc_card {
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0 =A0 =A0 =A0 =A0**info; =A0 =A0 =
=A0 =A0 /* info strings */
> =A0 =A0 =A0 =A0struct sdio_func_tuple =A0*tuples; =A0 =A0 =A0 =A0/* u=
nknown common tuples */
>
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd_bus_speed; =A0 /=
* Bus Speed Mode set for the card */
> +
> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 *debugfs_root;
> =A0};
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 949e4d5..6237599 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -50,6 +50,11 @@ struct mmc_ios {
> =A0#define MMC_TIMING_LEGACY =A0 =A0 =A00
> =A0#define MMC_TIMING_MMC_HS =A0 =A0 =A01
> =A0#define MMC_TIMING_SD_HS =A0 =A0 =A0 2
> +#define MMC_TIMING_UHS_SDR12 =A0 MMC_TIMING_LEGACY
> +#define MMC_TIMING_UHS_SDR25 =A0 MMC_TIMING_SD_HS
> +#define MMC_TIMING_UHS_SDR50 =A0 3
> +#define MMC_TIMING_UHS_SDR104 =A04
> +#define MMC_TIMING_UHS_DDR50 =A0 5
>
> =A0 =A0 =A0 =A0unsigned char =A0 ddr; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0/* dual data rate used */
>
> --
> 1.7.1
>
>
