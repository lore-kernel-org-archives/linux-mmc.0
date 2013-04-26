From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 2/4] mmc: core: Add bus_ops for runtime pm callbacks
Date: Fri, 26 Apr 2013 16:11:53 +0300
Message-ID: <517A7D19.9020704@intel.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com> <1366106437-18004-3-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39532 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938Ab3DZNG5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Apr 2013 09:06:57 -0400
In-Reply-To: <1366106437-18004-3-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

On 16/04/13 13:00, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> SDIO is the only protocol that uses runtime pm for the card device
> right now. To provide the option for sd and mmc to use runtime pm as
> well the bus_ops callback are extended with two new functions. One for
> runtime_suspend and one for runtime_resume.
> 
> This patch will also implement the callbacks for SDIO to make sure
> existing functionality is maintained. It also prepares to move
> away from using the mmc_power_restore_host API, since it is not
> needed when using runtime PM.

You have removed the bus_ops checks without explanation.  Are you sure it is
OK to do so?  I noticed that, in the SDIO case, runtime pm is not disabled
before detaching the bus making it hard to know if host->bus_ops can
disappear catastrophically during a runtime pm callback.

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Maya Erez <merez@codeaurora.org>
> Cc: Subhash Jadavani <subhashj@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Liu <kliu5@marvell.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Daniel Drake <dsd@laptop.org>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/mmc/core/bus.c  |   14 ++++++++++++--
>  drivers/mmc/core/core.c |    2 +-
>  drivers/mmc/core/core.h |    3 +++
>  drivers/mmc/core/sdio.c |   16 ++++++++++++++++
>  4 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index e219c97..d9e8c2b 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -151,15 +151,25 @@ static int mmc_bus_resume(struct device *dev)
>  static int mmc_runtime_suspend(struct device *dev)
>  {
>  	struct mmc_card *card = mmc_dev_to_card(dev);
> +	struct mmc_host *host = card->host;
> +	int ret = 0;
> +
> +	if (host->bus_ops->runtime_suspend)
> +		ret = host->bus_ops->runtime_suspend(host);
>  
> -	return mmc_power_save_host(card->host);
> +	return ret;
>  }
>  
>  static int mmc_runtime_resume(struct device *dev)
>  {
>  	struct mmc_card *card = mmc_dev_to_card(dev);
> +	struct mmc_host *host = card->host;
> +	int ret = 0;
> +
> +	if (host->bus_ops->runtime_resume)
> +		ret = host->bus_ops->runtime_resume(host);
>  
> -	return mmc_power_restore_host(card->host);
> +	return ret;
>  }
>  
>  static int mmc_runtime_idle(struct device *dev)
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f001097..b16b64a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1459,7 +1459,7 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
>   * If a host does all the power sequencing itself, ignore the
>   * initial MMC_POWER_UP stage.
>   */
> -static void mmc_power_up(struct mmc_host *host)
> +void mmc_power_up(struct mmc_host *host)
>  {
>  	int bit;
>  
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index b9f18a2..6242ffb 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -22,6 +22,8 @@ struct mmc_bus_ops {
>  	void (*detect)(struct mmc_host *);
>  	int (*suspend)(struct mmc_host *);
>  	int (*resume)(struct mmc_host *);
> +	int (*runtime_suspend)(struct mmc_host *);
> +	int (*runtime_resume)(struct mmc_host *);
>  	int (*power_save)(struct mmc_host *);
>  	int (*power_restore)(struct mmc_host *);
>  	int (*alive)(struct mmc_host *);
> @@ -44,6 +46,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
>  int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
>  void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>  void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
> +void mmc_power_up(struct mmc_host *host);
>  void mmc_power_off(struct mmc_host *host);
>  void mmc_power_cycle(struct mmc_host *host);
>  
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index aa0719a..09428c7 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1049,11 +1049,27 @@ out:
>  	return ret;
>  }
>  
> +static int mmc_sdio_runtime_suspend(struct mmc_host *host)
> +{
> +	/* No references to the card, cut the power to it. */
> +	mmc_power_off(host);
> +	return 0;
> +}
> +
> +static int mmc_sdio_runtime_resume(struct mmc_host *host)
> +{
> +	/* Restore power and re-initialize. */
> +	mmc_power_up(host);
> +	return mmc_sdio_power_restore(host);
> +}
> +
>  static const struct mmc_bus_ops mmc_sdio_ops = {
>  	.remove = mmc_sdio_remove,
>  	.detect = mmc_sdio_detect,
>  	.suspend = mmc_sdio_suspend,
>  	.resume = mmc_sdio_resume,
> +	.runtime_suspend = mmc_sdio_runtime_suspend,
> +	.runtime_resume = mmc_sdio_runtime_resume,
>  	.power_restore = mmc_sdio_power_restore,
>  	.alive = mmc_sdio_alive,
>  };
> 

