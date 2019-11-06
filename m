From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to
 complete data requests if needed
Date: Wed, 6 Nov 2019 12:09:42 +0200
Message-ID: <a9f42792-3432-48f2-c5c4-8b03c32995dd@intel.com>
References: <cover.1572326519.git.baolin.wang@linaro.org>
 <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang7@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 29/10/19 7:43 AM, Baolin Wang wrote:
> When using the host software queue, it will trigger the next request in
> irq handler without a context switch. But the sdhci_request() can not be
> called in interrupt context when using host software queue for some host
> drivers, due to the get_cd() ops can be sleepable.
> 
> But for some host drivers, such as Spreadtrum host driver, the card is
> nonremovable, so the get_cd() ops is not sleepable, which means we can
> complete the data request and trigger the next request in irq handler
> to remove the context switch for the Spreadtrum host driver.
> 
> Thus we still need introduce a variable in struct sdhci_host to indicate
> that we will always to defer to complete data requests if the sdhci_request()
> can not be called in interrupt context for some host drivers, when using
> the host software queue.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  drivers/mmc/host/sdhci.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 850241f..9cf2130 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
>  {
>  	struct mmc_data *data = mrq->data;
>  
> -	return host->pending_reset ||
> +	return host->pending_reset || (host->always_defer_done && data) ||

I didn't realize you still wanted to call the request function in interrupt
context.  In my view that needs a new host API
i.e. int (*request_atomic)(struct mmc_host *mmc, struct mmc_request *mrq)

>  	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
>  		data->host_cookie == COOKIE_MAPPED);
>  }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d89cdb9..38fbd18 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -533,6 +533,7 @@ struct sdhci_host {
>  	bool pending_reset;	/* Cmd/data reset is pending */
>  	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
>  	bool v4_mode;		/* Host Version 4 Enable */
> +	bool always_defer_done;	/* Always defer to complete data requests */
>  
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
>  	struct mmc_command *cmd;	/* Current command */
> 
