From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct
 sdhci_ops
Date: Mon, 28 Oct 2019 10:19:02 +0200
Message-ID: <50696230-75f4-3de4-7424-c33d531ee159@intel.com>
References: <cover.1571722391.git.baolin.wang@linaro.org>
 <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang7@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 22/10/19 8:58 AM, Baolin Wang wrote:
> Add request_done ops for struct sdhci_ops as a preparation in case some
> host controllers have different method to complete one request, such as
> supporting request completion of MMC software queue.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c |   12 ++++++++++--
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b056400..850241f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	mmc_request_done(host->mmc, mrq);
> +	if (host->ops->request_done)
> +		host->ops->request_done(host, mrq);

For hsq, couldn't this result in sdhci_request() being called interrupt
context here.

To prevent that you would need to add a condition to sdhci_defer_done() so
it always defers when using hsq.

That would be a separate patch.

> +	else
> +		mmc_request_done(host->mmc, mrq);
>  
>  	return false;
>  }
> @@ -3157,7 +3160,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  
>  	/* Process mrqs ready for immediate completion */
>  	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> -		if (mrqs_done[i])
> +		if (!mrqs_done[i])
> +			continue;
> +
> +		if (host->ops->request_done)
> +			host->ops->request_done(host, mrqs_done[i]);
> +		else
>  			mmc_request_done(host->mmc, mrqs_done[i]);
>  	}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0ed3e0e..d89cdb9 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -644,6 +644,8 @@ struct sdhci_ops {
>  	void	(*voltage_switch)(struct sdhci_host *host);
>  	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
>  				   dma_addr_t addr, int len, unsigned int cmd);
> +	void	(*request_done)(struct sdhci_host *host,
> +				struct mmc_request *mrq);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 
