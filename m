From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable
	(clock-gating)
Date: Fri, 17 Sep 2010 14:40:31 +0100
Message-ID: <20100917134031.GA11462@console-pimps.org>
References: <4C91BD5A.1040804@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:49714 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750831Ab0IQNkc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2010 09:40:32 -0400
Content-Disposition: inline
In-Reply-To: <4C91BD5A.1040804@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>

On Thu, Sep 16, 2010 at 03:46:50PM +0900, Jaehoon Chung wrote:
> Hi all,
>   This is a RFC patch that support clock-gating for saving power consumption.
>   I found mmc_host_enable/mmc_host_disable function in core.c
>   (using MMC_CAP_DSIABLE. i think that use when host enable/disable)
>   So, i used that functions and implemented some functions in sdhci-s3c.c & sdhci.c
> 
> i want any feedback. how do you think about this patch?
> Plz let me know...
> 
> Thank you all
> 
>  Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>  Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> ---
>  drivers/mmc/host/sdhci-s3c.c |   36 ++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c     |   30 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h     |    4 ++++
>  3 files changed, 70 insertions(+), 0 deletions(-)

[...]

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 401527d..fa2e55d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1245,7 +1245,37 @@ out:
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +static int sdhci_enable_clk(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret = 0;
> +
> +	if (host->old_clock != 0 && host->clock == 0) {
> +		if (host->ops->enable)
> +			ret = host->ops->enable(host);
> +		sdhci_set_clock(host, host->old_clock);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sdhci_disable_clk(struct mmc_host *mmc, int lazy)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret = 0;
> +
> +	if (host->clock != 0) {
> +		host->old_clock = host->clock;
> +		sdhci_set_clock(host, 0);
> +		if (host->ops->disable)
> +			ret = host->ops->disable(host, lazy);
> +	}
> +	return ret;
> +}
> +
>  static const struct mmc_host_ops sdhci_ops = {
> +	.enable		= sdhci_enable_clk,
> +	.disable	= sdhci_disable_clk,
>  	.request	= sdhci_request,
>  	.set_ios	= sdhci_set_ios,
>  	.get_ro		= sdhci_get_ro,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d316bc7..0c6f143 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -278,6 +278,8 @@ struct sdhci_host {
>  	unsigned int		timeout_clk;	/* Timeout freq (KHz) */
>  
>  	unsigned int		clock;		/* Current clock (MHz) */
> +	unsigned int		old_clock;	/* Old clock (MHz) */
> +	unsigned int		clk_cnt;	/* Clock user count */
>  	u8			pwr;		/* Current voltage */
>  
>  	struct mmc_request	*mrq;		/* Current request */
> @@ -323,6 +325,8 @@ struct sdhci_ops {
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> +	int		(*enable)(struct sdhci_host *host);
> +	int		(*disable)(struct sdhci_host *host, int lazy);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

I could have misunderstood something, but do you really need this new
'old_clock' member? Is the previous clock value not stored in
host->ios.clock?
