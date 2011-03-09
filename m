From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 06/12] mmc: sd: add support for uhs bus speed mode
 selection
Date: Wed, 9 Mar 2011 13:43:22 -0800
Message-ID: <58AD8858-F465-43FD-ADBF-39DDB075EB02@marvell.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-7-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57763 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750977Ab1CIVqm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Mar 2011 16:46:42 -0500
In-Reply-To: <1297762510-2696-7-git-send-email-arindam.nath@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "henry.su@amd.com" <henry.su@amd.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>


On Feb 15, 2011, at 1:35 AM, Arindam Nath wrote:

> This patch adds support for setting UHS-I bus speed mode during UHS-I
> initialization procedure. Since both the host and card can support
> more than one bus speed, we select the highest speed based on both of
> their capabilities. First we set the bus speed mode for the card using
> CMD6 mode 1, and then we program the host controller to support the
> required speed mode. We also set High Speed Enable in case one of the
> UHS-I modes is selected. Since MMC_TIMING_UHS_SDR25 is same as
> MMC_TIMING_SD_HS, we don't need to set the SDHCI_CTRL_HISPD flag for
> UHS SDR25 again. We also take care to reset SD clock before setting
> UHS mode in the Host Control2 register, and then re-enable it as per
> the Host Controller spec v3.00. We set the clock frequency for the
> UHS-I mode selected.
> 
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> ---
> drivers/mmc/core/sd.c    |   82 ++++++++++++++++++++++++++++++++++++++++++++++
> drivers/mmc/host/sdhci.c |   32 +++++++++++++++++-
> drivers/mmc/host/sdhci.h |    5 +++
> include/linux/mmc/card.h |   16 +++++++++
> include/linux/mmc/host.h |    4 ++
> 5 files changed, 137 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 9e4574d..e681385 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -464,6 +464,83 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
> 	return 0;
> }
> 
> +static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
> +{
> +	unsigned int bus_speed, timing;

warning may not be initialized.  bus_speed

> +	int err;
> +
> +	/*
> +	 * If the host doesn't support any of the UHS-I modes, fallback on
> +	 * default speed.
> +	 */
> +	if (!(card->host->caps & (MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
> +	    MMC_CAP_UHS_DDR50)))
> +		return 0;
> +
> +	if (card->host->caps & MMC_CAP_UHS_SDR104) {
> +		if (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR104) {
> +			bus_speed = UHS_SDR104_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_SDR104;
> +			card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
> +		} else if (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR50) {
> +			bus_speed = UHS_SDR50_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_SDR50;
> +			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
> +		} else if (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_DDR50) {
> +			bus_speed = UHS_DDR50_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_DDR50;
> +			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> +		} else if (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR25) {
> +			bus_speed = UHS_SDR25_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_SDR25;
> +			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> +		}
> +	} else if (card->host->caps & MMC_CAP_UHS_SDR50) {
> +		if ((card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR104) ||
> +		    (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR50)) {
> +			bus_speed = UHS_SDR50_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_SDR50;
> +			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
> +		} else if (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_DDR50) {
> +			bus_speed = UHS_DDR50_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_DDR50;
> +			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> +		} else if (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR25) {
> +			bus_speed = UHS_SDR25_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_SDR25;
> +			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> +		}
> +	} else if (card->host->caps & MMC_CAP_UHS_DDR50) {
> +		if ((card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR104) ||
> +		    (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR50) ||
> +		    (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_DDR50)) {
> +			bus_speed = UHS_DDR50_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_DDR50;
> +			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> +		} else if (card->sw_caps.uhs_bus_mode & SD_MODE_UHS_SDR25) {
> +			bus_speed = UHS_SDR25_BUS_SPEED;
> +			timing = MMC_TIMING_UHS_SDR25;
> +			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> +		}
> +	}
> +
> +	err = mmc_sd_switch(card, 1, 0, bus_speed, status);
> +	if (err)
> +		return err;
> +
> +	if ((status[16] & 0xF) != bus_speed)
> +		printk(KERN_WARNING "%s: Problem setting bus speed mode!\n",
> +			mmc_hostname(card->host));
> +	else {
> +		if (bus_speed) {
> +			mmc_set_timing(card->host, timing);
> +			mmc_set_clock(card->host, card->sw_caps.uhs_max_dtr);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> /*
>  * UHS-I specific initialization procedure
>  */
> @@ -499,6 +576,11 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
> 
> 	/* Set the driver strength for the card */
> 	err = sd_select_driver_type(card, status);
> +	if (err)
> +		goto out;
> +
> +	/* Set bus speed mode of the card */
> +	err = sd_set_bus_speed_mode(card, status);
> 
> out:
> 	kfree(status);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 5db0109..ae91c6b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1281,7 +1281,13 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 		ctrl &= ~SDHCI_CTRL_HISPD;
> 
> 	if (host->version >= SDHCI_SPEC_300) {
> -		u16 ctrl_2;
> +		u16 clk, ctrl_2;
> +
> +		/* In case of UHS-I modes, set High Speed Enable */
> +		if ((ios->timing == MMC_TIMING_UHS_SDR50) ||
> +		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
> +		    (ios->timing == MMC_TIMING_UHS_DDR50))
> +			ctrl |= SDHCI_CTRL_HISPD;
> 
> 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 		if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
> @@ -1303,7 +1309,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 			 * need to reset SD Clock Enable before changing High
> 			 * Speed Enable to avoid generating clock gliches.
> 			 */
> -			u16 clk;
> 
> 			/* Reset SD Clock Enable */
> 			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> @@ -1316,6 +1321,29 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 			clk |= SDHCI_CLOCK_CARD_EN;
> 			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> 		}
> +
> +		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		/* Select Bus Speed Mode for host */
> +		if (ios->timing == MMC_TIMING_UHS_SDR25)
> +			ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> +		else if (ios->timing == MMC_TIMING_UHS_SDR50)
> +			ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> +		else if (ios->timing == MMC_TIMING_UHS_SDR104)
> +			ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> +		else if (ios->timing == MMC_TIMING_UHS_DDR50)
> +			ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> +
> +		/* Reset SD Clock Enable */
> +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		clk &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +		/* Re-enable SD Clock */
> +		clk |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> 	} else
> 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a407b5b..5bf244d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -150,6 +150,11 @@
> #define SDHCI_ACMD12_ERR	0x3C
> 
> #define SDHCI_HOST_CONTROL2		0x3E
> +#define  SDHCI_CTRL_UHS_SDR12		0x0000
> +#define  SDHCI_CTRL_UHS_SDR25		0x0001
> +#define  SDHCI_CTRL_UHS_SDR50		0x0002
> +#define  SDHCI_CTRL_UHS_SDR104		0x0003
> +#define  SDHCI_CTRL_UHS_DDR50		0x0004
> #define  SDHCI_CTRL_VDD_180		0x0008
> #define  SDHCI_CTRL_DRV_TYPE_B		0x0000
> #define  SDHCI_CTRL_DRV_TYPE_A		0x0010
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 2d7f7a3..0b24c41 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -75,7 +75,23 @@ struct sd_ssr {
> 
> struct sd_switch_caps {
> 	unsigned int		hs_max_dtr;
> +	unsigned int		uhs_max_dtr;
> +#define UHS_SDR104_MAX_DTR	208000000
> +#define UHS_SDR50_MAX_DTR	100000000
> +#define UHS_DDR50_MAX_DTR	50000000
> +#define UHS_SDR25_MAX_DTR	50000000
> 	unsigned int		uhs_bus_mode;
> +#define UHS_SDR12_BUS_SPEED	0
> +#define UHS_SDR25_BUS_SPEED	1
> +#define UHS_SDR50_BUS_SPEED	2
> +#define UHS_SDR104_BUS_SPEED	3
> +#define UHS_DDR50_BUS_SPEED	4
> +
> +#define SD_MODE_UHS_SDR12	(1 << UHS_SDR12_BUS_SPEED)
> +#define SD_MODE_UHS_SDR25	(1 << UHS_SDR25_BUS_SPEED)
> +#define SD_MODE_UHS_SDR50	(1 << UHS_SDR50_BUS_SPEED)
> +#define SD_MODE_UHS_SDR104	(1 << UHS_SDR104_BUS_SPEED)
> +#define SD_MODE_UHS_DDR50	(1 << UHS_DDR50_BUS_SPEED)
> 	unsigned int		uhs_drv_type;
> #define SD_DRIVER_TYPE_B	0x01
> #define SD_DRIVER_TYPE_A	0x02
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e6ae4c4..0a21839 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -50,6 +50,10 @@ struct mmc_ios {
> #define MMC_TIMING_LEGACY	0
> #define MMC_TIMING_MMC_HS	1
> #define MMC_TIMING_SD_HS	2
> +#define MMC_TIMING_UHS_SDR25	MMC_TIMING_SD_HS
> +#define MMC_TIMING_UHS_SDR50	3
> +#define MMC_TIMING_UHS_SDR104	4
> +#define MMC_TIMING_UHS_DDR50	5
> 
> 	unsigned char	ddr;			/* dual data rate used */
> 
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

