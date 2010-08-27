From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH FINAL] sdhci-clk-gating-support
Date: Fri, 27 Aug 2010 21:26:22 +0100
Message-ID: <20100827202622.GS23079@void.printf.net>
References: <5005677.340441278667763470.JavaMail.weblogic@epml07>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38858 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646Ab0H0U0X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 16:26:23 -0400
Content-Disposition: inline
In-Reply-To: <5005677.340441278667763470.JavaMail.weblogic@epml07>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: MADHAV SINGHCHAUHAN <singh.madhav@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

I reviewed this patch, but still feel uneasy about merging it -- it's 
hard to know if any controllers will handle this badly, or suffer
performance problems if their clock takes a long time to stabilize.

Is pushing to -mm a reasonable thing to do if we want more testing, or
should we hold off?  I could test on some of the hardware collection at
OLPC report any performance/power changes I see, if that would help.
Does anyone else have feedback on the general approach?

- Chris.

On Fri, Jul 09, 2010 at 09:29:23AM +0000, MADHAV SINGHCHAUHAN wrote:
> Hi Chris ,
> I have taken up you suggestion and coming with new patch.Also we have done perfromance analysis
> using fileop/iozone and performance is not effected by this patch,regarding the power consumption,
> after applying patch it saves 15 mA.
> 
> From 3663ee85ce718c9607bc0968a5143e01d86919ed Mon Sep 17 00:00:00 2001
> From: Madhav Chauhan <singh.madhav@samsung.com>
> Date: Fri, 9 Jul 2010 20:02:06 +0530
> Subject: [PATCH] sdhci-clk-gating-support
> 
> This patch implements clock gating support in sdhci layer. It will
> enable the clock when host controller start sending request
> to attached device and will disable it once it finish the command.
> Now this patch provides option so that some host controllers
> can be avoided using this functionality using mmc_host caps.
> 
> Signed-off-by: Madhav Chauhan <singh.madhav@samsung.com>, Nitish Ambastha <nitish.a@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |   35 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h |    6 ++++++
>  include/linux/mmc/host.h |    1 +
>  3 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..5ed7c50 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1103,6 +1103,9 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> +	if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> +		sdhci_clk_enable(host);	/*Enable clock as transfer starts now*/
> +
>  	WARN_ON(host->mrq != NULL);
>  
>  #ifndef SDHCI_USE_LEDS_CLASS
> @@ -1310,6 +1313,10 @@ static void sdhci_tasklet_finish(unsigned long param)
>  		sdhci_reset(host, SDHCI_RESET_DATA);
>  	}
>  
> +	if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> +		/*Disable clock as command has been processed*/
> +		sdhci_clk_disable(host);
> +
>  	host->mrq = NULL;
>  	host->cmd = NULL;
>  	host->data = NULL;
> @@ -1597,6 +1604,9 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
>  
>  	sdhci_disable_card_detection(host);
>  
> +	if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> +		sdhci_clk_enable(host);	/* Enable clock */
> +
>  	ret = mmc_suspend_host(host->mmc);
>  	if (ret)
>  		return ret;
> @@ -1626,6 +1636,11 @@ int sdhci_resume_host(struct sdhci_host *host)
>  	mmiowb();
>  
>  	ret = mmc_resume_host(host->mmc);
> +
> +	if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> +		/*Now device has wake up disable it*/
> +		sdhci_clk_disable(host);
> +
>  	sdhci_enable_card_detection(host);
>  
>  	return ret;
> @@ -1654,6 +1669,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	host = mmc_priv(mmc);
> +
> +	host->clk_restore = 0;	/* For clock gating */
> +
>  	host->mmc = mmc;
>  
>  	return host;
> @@ -1984,6 +2002,23 @@ void sdhci_free_host(struct sdhci_host *host)
>  
>  EXPORT_SYMBOL_GPL(sdhci_free_host);
>  
> +void sdhci_clk_enable(struct sdhci_host *host)
> +{
> +	if (host->clk_restore && host->clock == 0)
> +		sdhci_set_clock(host, host->clk_restore);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_clk_enable);
> +
> +void sdhci_clk_disable(struct sdhci_host *host)
> +{
> +	if (host->clock != 0) {
> +		host->clk_restore = host->clock;
> +		sdhci_set_clock(host, 0);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_clk_disable);
> +
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..5031d33 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -292,6 +292,8 @@ struct sdhci_host {
>  
>  	struct timer_list	timer;		/* Timer for timeouts */
>  
> +	unsigned int		clk_restore;	/* For Clock Gating */
> +
>  	unsigned long		private[0] ____cacheline_aligned;
>  };
>  
> @@ -410,6 +412,10 @@ static inline void *sdhci_priv(struct sdhci_host *host)
>  extern int sdhci_add_host(struct sdhci_host *host);
>  extern void sdhci_remove_host(struct sdhci_host *host, int dead);
>  
> +/*For Clock Gating*/
> +extern void sdhci_clk_enable(struct sdhci_host *host);
> +extern void sdhci_clk_disable(struct sdhci_host *host);
> +
>  #ifdef CONFIG_PM
>  extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
>  extern int sdhci_resume_host(struct sdhci_host *host);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..b5c3563 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -155,6 +155,7 @@ struct mmc_host {
>  #define MMC_CAP_DISABLE		(1 << 7)	/* Can the host be disabled */
>  #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
>  #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
> +#define MMC_CAP_CLOCK_GATING	(1 << 10)	/* Clock Gating feature */
>  
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>  
> -- 
> 1.7.0.4

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
