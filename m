From: <subhashj@codeaurora.org>
Subject: RE: [PATCH v2 07/12] mmc: sd: set current limit for uhs cards
Date: Thu, 10 Mar 2011 13:46:08 +0530
Message-ID: <000901cbdefb$6bdb8fe0$4392afa0$@org>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com> <1299238369-1768-8-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:2366 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab1CJIQO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 03:16:14 -0500
In-Reply-To: <1299238369-1768-8-git-send-email-arindam.nath@amd.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Arindam Nath' <arindam.nath@amd.com>, cjb@laptop.org
Cc: zhangfei.gao@gmail.com, prakity@marvell.com, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com



> -----Original Message-----
> From: Arindam Nath [mailto:anath.amd@gmail.com] On Behalf Of Arindam
> Nath
> Sent: Friday, March 04, 2011 5:03 PM
> To: cjb@laptop.org
> Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
> subhashj@codeaurora.org; linux-mmc@vger.kernel.org; henry.su@amd.com;
> aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> Subject: [PATCH v2 07/12] mmc: sd: set current limit for uhs cards
> 
> We decide on the current limit to be set for the card based on the
> Capability of Host Controller to provide current at 1.8V signalling,
> and the maximum current limit of the card as indicated by CMD6
> mode 0. We then set the current limit for the card using CMD6 mode 1.
> 
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> ---
>  drivers/mmc/core/sd.c    |   45
> +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c |   24 ++++++++++++++++++++++++
>  include/linux/mmc/card.h |    9 +++++++++
>  include/linux/mmc/host.h |    1 +
>  4 files changed, 79 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index ec0d8e6..df98a2c 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -550,6 +550,46 @@ static int sd_set_bus_speed_mode(struct mmc_card
> *card, u8 *status)
>  	return 0;
>  }
> 
> +static int sd_set_current_limit(struct mmc_card *card, u8 *status)
> +{
> +	struct mmc_host *host = card->host;
> +	int mmc_host_max_current_180, current_limit;
> +	int err;
> +
> +	/* sanity check */
> +	if (!host->ops->get_max_current_180)
> +		return 0;
> +
> +	/* Maximum current supported by host at 1.8V */
> +	mmc_host_max_current_180 = host->ops->get_max_current_180(host);

I don't think this should be mmc_ops. Max. current limit supported by host
should be one of the MMC_CAP*.
In your case you can read the "SDHCI_MAX_CURRENT" register during the probe
and can set the appropriate MMC_CAP* from below:
#define MMC_CAP_MAX_CURRENT_200	(1 << xx)
#define MMC_CAP_MAX_CURRENT_400	(1 << (xx+1))
#define MMC_CAP_MAX_CURRENT_600	(1 << (xx+2))
#define MMC_CAP_MAX_CURRENT_800	(1 << (xx+3))

> +
> +	if (mmc_host_max_current_180 >= 800) {
> +		if (card->sw_caps.uhs_curr_limit & SD_MAX_CURRENT_800)
> +			current_limit = SD_SET_CURRENT_LIMIT_800;
> +		else if (card->sw_caps.uhs_curr_limit & SD_MAX_CURRENT_600)
> +			current_limit = SD_SET_CURRENT_LIMIT_600;
> +		else if (card->sw_caps.uhs_curr_limit & SD_MAX_CURRENT_400)
> +			current_limit = SD_SET_CURRENT_LIMIT_400;
> +	} else if (mmc_host_max_current_180 >= 600) {
> +		if (card->sw_caps.uhs_curr_limit & SD_MAX_CURRENT_600)
> +			current_limit = SD_SET_CURRENT_LIMIT_600;
> +		else if (card->sw_caps.uhs_curr_limit & SD_MAX_CURRENT_400)
> +			current_limit = SD_SET_CURRENT_LIMIT_400;
> +	} else if (mmc_host_max_current_180 >= 400)
> +		if (card->sw_caps.uhs_curr_limit & SD_MAX_CURRENT_400)
> +			current_limit = SD_SET_CURRENT_LIMIT_400;
> +

What will be value of current_limit if (mmc_host_max_current_180 < 400)

> +	err = mmc_sd_switch(card, 1, 3, current_limit, status);
> +	if (err)
> +		return err;
> +
> +	if (((status[15] >> 4) & 0x0F) != current_limit)
> +		printk(KERN_WARNING "%s: Problem setting current limit!\n",
> +			mmc_hostname(card->host));
> +
> +	return 0;
> +}
> +
>  /*
>   * UHS-I specific initialization procedure
>   */
> @@ -590,6 +630,11 @@ static int mmc_sd_init_uhs_card(struct mmc_card
> *card)
> 
>  	/* Set bus speed mode of the card */
>  	err = sd_set_bus_speed_mode(card, status);
> +	if (err)
> +		goto out;
> +
> +	/* Set current limit for the card */
> +	err = sd_set_current_limit(card, status);
> 
>  out:
>  	kfree(status);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f127fa2..245cc39 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1462,12 +1462,36 @@ static int
> sdhci_start_signal_voltage_switch(struct mmc_host *mmc)
>  	return -EAGAIN;
>  }
> 
> +static int sdhci_get_max_current_180(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host;
> +	u32 max_current_caps;
> +	unsigned long flags;
> +	int max_current_180;
> +
> +	host = mmc_priv(mmc);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	/* Maximum current is 4 times the register value for 1.8V */
> +	max_current_180 = ((max_current_caps &
> SDHCI_MAX_CURRENT_180_MASK) >>
> +			   SDHCI_MAX_CURRENT_180_SHIFT) *
> +			   SDHCI_MAX_CURRENT_MULTIPLIER;
> +
> +	return max_current_180;
> +}
> +
>  static const struct mmc_host_ops sdhci_ops = {
>  	.request	= sdhci_request,
>  	.set_ios	= sdhci_set_ios,
>  	.get_ro		= sdhci_get_ro,
>  	.enable_sdio_irq = sdhci_enable_sdio_irq,
>  	.start_signal_voltage_switch	=
> sdhci_start_signal_voltage_switch,
> +	.get_max_current_180		= sdhci_get_max_current_180,
>  };
> 
> 
> /**********************************************************************
> *******\
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 0b24c41..a6811ae 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -98,6 +98,15 @@ struct sd_switch_caps {
>  #define SD_DRIVER_TYPE_C	0x04
>  #define SD_DRIVER_TYPE_D	0x08
>  	unsigned int		uhs_curr_limit;
> +#define SD_SET_CURRENT_LIMIT_200	0
> +#define SD_SET_CURRENT_LIMIT_400	1
> +#define SD_SET_CURRENT_LIMIT_600	2
> +#define SD_SET_CURRENT_LIMIT_800	3
> +
> +#define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
> +#define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
> +#define SD_MAX_CURRENT_600	(1 << SD_SET_CURRENT_LIMIT_600)
> +#define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
>  };
> 
>  struct sdio_cccr {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4dfff6d..e84cd05 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -128,6 +128,7 @@ struct mmc_host_ops {
>  	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
> 
>  	int	(*start_signal_voltage_switch)(struct mmc_host *host);
> +	int	(*get_max_current_180)(struct mmc_host *mmc);
>  };
> 
>  struct mmc_card;
> --
> 1.7.1


