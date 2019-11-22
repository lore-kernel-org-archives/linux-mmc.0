From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7 2/4] mmc: host: sdhci: Add request_done ops for struct
 sdhci_ops
Date: Fri, 22 Nov 2019 14:13:23 +0200
Message-ID: <8f5adf0c-bd92-db11-bea0-8856d49395f8@intel.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
 <2f16c4f2b98474b79584e0bf338ebb6fb4f6617d.1574073572.git.baolin.wang7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2f16c4f2b98474b79584e0bf338ebb6fb4f6617d.1574073572.git.baolin.wang7@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 18/11/19 12:43 PM, Baolin Wang wrote:
> From: Baolin Wang <baolin.wang@linaro.org>
> 
> Add request_done ops for struct sdhci_ops as a preparation in case some
> host controllers have different method to complete one request, such as
> supporting request completion of MMC software queue.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
