From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [RFC] mmc: Non Default UHS Drive Strength must use board
 specific code
Date: Wed, 18 May 2011 00:49:23 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300011B9F5A38@SAUSEXMBP01.amd.com>
References: <D2C557E7-F39F-4EC5-84F8-F851AA00CE6C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:32572
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752592Ab1ERFt7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 May 2011 01:49:59 -0400
In-Reply-To: <D2C557E7-F39F-4EC5-84F8-F851AA00CE6C@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Wednesday, May 18, 2011 2:29 AM
> To: linux-mmc@vger.kernel.org
> Cc: Nath, Arindam
> Subject: [RFC] mmc: Non Default UHS Drive Strength must use board
> specific code
> 
> 
> Note:  This is being send out for comment.  We are still in the process
> of testing this change
> but we would like to have community review at this time.
> 
> 
> SD 3.0 introduced additional drive strengths for UHS.
> The card and the host can indicate 4 drive strengths as a bit
> mask.  Without local design knowledge of the board it is not
> possible to select the correct drive strength.  Unfortunately
> there is not the equivalent of ethernet auto-negotiate in the
> SD 3.0 Physical Spec at this time.
> 
> We punt the problem by asking any platform specific code to
> handle the drive strength problem.  If non is defined we default
> the drive strength to the manadory TYPE_B value.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/core/core.c  |   15 ++++++++++
>  drivers/mmc/core/core.h  |    5 +++
>  drivers/mmc/core/sd.c    |   65 ++++++++++++++++++++++++--------------
> --------
>  drivers/mmc/host/sdhci.c |   16 +++++++++++
>  drivers/mmc/host/sdhci.h |    5 +++
>  include/linux/mmc/host.h |   13 ++++++---
>  6 files changed, 84 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 68091dd..49df27b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -964,6 +964,21 @@ int mmc_set_signal_voltage(struct mmc_host *host,
> int signal_voltage, bool cmd11
>  	return err;
>  }
> 
> +unsigned int mmc_select_drive_strength(struct mmc_host *host,
> +			unsigned int bus_mode,
> +			unsigned int max_dtr,
> +			unsigned int host_drv_type,
> +			unsigned int card_drv_type)
> +{
> +	if (host->ops->select_drive_strength)
> +		return host->ops->select_drive_strength(host,
> +			bus_mode, max_dtr,
> +			host_drv_type, card_drv_type);
> +
> +	/* return default strength if no handler in driver */
> +	return MMC_SET_DRIVER_TYPE_B;
> +}
> +
>  /*
>   * Select timing parameters for host.
>   */
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index d9411ed..8bc289c 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -43,6 +43,11 @@ int mmc_set_signal_voltage(struct mmc_host *host,
> int signal_voltage,
>  			   bool cmd11);
>  void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>  void mmc_set_driver_type(struct mmc_host *host, unsigned int
> drv_type);
> +unsigned int mmc_select_drive_strength(struct mmc_host *host,
> +			unsigned int bus_mode,
> +			unsigned int max_dtr,
> +			unsigned int host_drv_type,
> +			unsigned int card_drv_type);
> 
>  static inline void mmc_delay(unsigned int ms)
>  {
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 596d0b9..a268ead 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -405,54 +405,57 @@ out:
>  	return err;
>  }
> 
> +
>  static int sd_select_driver_type(struct mmc_card *card, u8 *status)
>  {
> -	int host_drv_type = 0, card_drv_type = 0;
> +	unsigned int host_drv_type = MMC_SET_DRIVER_TYPE_B;
> +	unsigned int card_drv_type = MMC_SET_DRIVER_TYPE_B;
>  	int err;
> +	unsigned char drive_strength;
> 
>  	/*
>  	 * If the host doesn't support any of the Driver Types A,C or D,
> -	 * default Driver Type B is used.
> +	 * or there is no board specific handler then default Driver
> +	 * Type B is used.
>  	 */
>  	if (!(card->host->caps & (MMC_CAP_DRIVER_TYPE_A |
> MMC_CAP_DRIVER_TYPE_C
>  	    | MMC_CAP_DRIVER_TYPE_D)))
>  		return 0;
> 
> -	if (card->host->caps & MMC_CAP_DRIVER_TYPE_A) {
> -		host_drv_type = MMC_SET_DRIVER_TYPE_A;
> -		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_A)
> -			card_drv_type = MMC_SET_DRIVER_TYPE_A;
> -		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_B)
> -			card_drv_type = MMC_SET_DRIVER_TYPE_B;
> -		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
> -			card_drv_type = MMC_SET_DRIVER_TYPE_C;
> -	} else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
> -		host_drv_type = MMC_SET_DRIVER_TYPE_C;
> -		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
> -			card_drv_type = MMC_SET_DRIVER_TYPE_C;
> -	} else if (!(card->host->caps & MMC_CAP_DRIVER_TYPE_D)) {
> -		/*
> -		 * If we are here, that means only the default driver type
> -		 * B is supported by the host.
> -		 */
> -		host_drv_type = MMC_SET_DRIVER_TYPE_B;
> -		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_B)
> -			card_drv_type = MMC_SET_DRIVER_TYPE_B;
> -		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
> -			card_drv_type = MMC_SET_DRIVER_TYPE_C;
> -	}
> +	if (card->host->caps & MMC_CAP_DRIVER_TYPE_A)
> +		host_drv_type |= MMC_SET_DRIVER_TYPE_A;
> +
> +	if (card->host->caps & MMC_CAP_DRIVER_TYPE_C)
> +		host_drv_type |= MMC_SET_DRIVER_TYPE_C;
> +
> +	if (card->host->caps & MMC_CAP_DRIVER_TYPE_D)
> +		host_drv_type |= MMC_SET_DRIVER_TYPE_D;
> 
> -	err = mmc_sd_switch(card, 1, 2, card_drv_type, status);
> +	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_A)
> +		card_drv_type |= MMC_SET_DRIVER_TYPE_A;
> +
> +	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
> +		card_drv_type |= MMC_SET_DRIVER_TYPE_C;
> +
> +	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_D)
> +		card_drv_type |= MMC_SET_DRIVER_TYPE_D;
> +
> +	drive_strength = mmc_select_drive_strength(card->host,
> +		card->sw_caps.sd3_bus_mode,
> +		card->sw_caps.uhs_max_dtr,
> +		host_drv_type, card_drv_type);
> +
> +	err = mmc_sd_switch(card, 1, 2, drive_strength, status);
>  	if (err)
>  		return err;
> 
> -	if ((status[15] & 0xF) != card_drv_type) {
> -		printk(KERN_WARNING "%s: Problem setting driver
> strength!\n",
> -			mmc_hostname(card->host));
> +	if ((status[15] & 0xF) != drive_strength) {
> +		printk(KERN_WARNING "%s: Problem setting driver strength
> %d\n",
> +			mmc_hostname(card->host), drive_strength);
>  		return 0;
>  	}
> 
> -	mmc_set_driver_type(card->host, host_drv_type);
> +	mmc_set_driver_type(card->host, drive_strength);
> 
>  	return 0;
>  }
> @@ -488,7 +491,7 @@ static int sd_set_bus_speed_mode(struct mmc_card
> *card, u8 *status)
>  			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
>  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>  		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
> -		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
> +		   (card->sw_caps.uhs_max_dtr & SD_MODE_UHS_SDR25)) {

I think this line should not be changed, otherwise it will lose its purpose.

>  			bus_speed = UHS_SDR25_BUS_SPEED;
>  			timing = MMC_TIMING_UHS_SDR25;
>  			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cc63f5e..ebeb986 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1766,6 +1766,21 @@ static void sdhci_enable_preset_value(struct
> mmc_host *mmc, bool enable)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> 
> +static unsigned int sdhci_select_drive_strength(struct mmc_host *host,
> +			unsigned int bus_mode,
> +			unsigned int max_dtr,
> +			unsigned int host_drv_type,
> +			unsigned int card_drv_type)
> +{
> +	if (host->ops->select_drive_strength)
> +		return host->ops->select_drive_strength(host,
> +			bus_mode, max_dtr,
> +			host_drv_type, card_drv_type);
> +
> +	/* return default strength if no handler in driver */
> +	return MMC_SET_DRIVER_TYPE_B;
> +}
> +
>  static const struct mmc_host_ops sdhci_ops = {
>  	.request	= sdhci_request,
>  	.set_ios	= sdhci_set_ios,
> @@ -1774,6 +1789,7 @@ static const struct mmc_host_ops sdhci_ops = {
>  	.start_signal_voltage_switch	=
> sdhci_start_signal_voltage_switch,
>  	.execute_tuning			= sdhci_execute_tuning,
>  	.enable_preset_value		= sdhci_enable_preset_value,
> +	.select_drive_strength		= sdhci_select_drive_strength,

Do we need this here? Host Controllers who want to support this should provide their own sdhci_ops function in their respective mmc/host files. For other controllers, mmc_select_drive_strength() will always return TYPE_B as you mentioned above.

>  };
> 
> 
> /**********************************************************************
> *******\
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7e28eec..8f48aca 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -271,6 +271,11 @@ struct sdhci_ops {
>  	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
>  	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
>  	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int
> uhs);
> +	unsigned int	(*select_drive_strength)(struct sdhci_host
> *host,
> +			unsigned int bus_mode,
> +			unsigned int max_dtr,
> +			unsigned int host_drv_type,
> +			unsigned int card_drv_type);
> 
>  };
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index de32e6a..6c2aeab 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -70,10 +70,10 @@ struct mmc_ios {
> 
>  	unsigned char	drv_type;		/* driver type (A, B, C, D)
> */
> 
> -#define MMC_SET_DRIVER_TYPE_B	0
> -#define MMC_SET_DRIVER_TYPE_A	1
> -#define MMC_SET_DRIVER_TYPE_C	2
> -#define MMC_SET_DRIVER_TYPE_D	3
> +#define MMC_SET_DRIVER_TYPE_B	(1<<0)
> +#define MMC_SET_DRIVER_TYPE_A	(1<<1)
> +#define MMC_SET_DRIVER_TYPE_C	(1<<2)
> +#define MMC_SET_DRIVER_TYPE_D	(1<<3)

These defines if changed will have a different meaning altogether. The defines actually correspond to the "Function Name" column of Table 4-11 of the Physical Layer spec v3.01, which is used by mmc_sd_switch() to set the driver type for the card.

Thanks,
Arindam

>  };
> 
>  struct mmc_host_ops {
> @@ -139,6 +139,11 @@ struct mmc_host_ops {
>  	int	(*start_signal_voltage_switch)(struct mmc_host *host,
> struct mmc_ios *ios);
>  	int	(*execute_tuning)(struct mmc_host *host);
>  	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
> +	unsigned int	(*select_drive_strength)(struct mmc_host *host,
> +			unsigned int bus_mode,
> +			unsigned int max_dtr,
> +			unsigned int host_drv_type,
> +			unsigned int card_drv_type);
>  };
> 
>  struct mmc_card;
> --
> 1.7.0.4
> 
> 


