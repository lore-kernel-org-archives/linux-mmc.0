From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7 3/4] mmc: host: sdhci: Add a variable to defer to
 complete requests if needed
Date: Fri, 22 Nov 2019 14:14:38 +0200
Message-ID: <983cb2b7-7887-af86-5029-120ff6d2b839@intel.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
 <0199b93bad45b7f1dc7751844ac8031b316b2fed.1574073572.git.baolin.wang7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0199b93bad45b7f1dc7751844ac8031b316b2fed.1574073572.git.baolin.wang7@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 18/11/19 12:43 PM, Baolin Wang wrote:
> From: Baolin Wang <baolin.wang@linaro.org>
> 
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
> As suggested by Adrian, we should introduce a request_atomic() API to
> indicate that a request can be called in interrupt context to remove
> the context switch when using mmc host software queue. But this should
> be done in another thread to convert the users of mmc host software queue.
> Thus we can introduce a variable in struct sdhci_host to indicate that
> we will always to defer to complete requests when using the host software
> queue.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  drivers/mmc/host/sdhci.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 850241f..4bef066 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
>  {
>  	struct mmc_data *data = mrq->data;
>  
> -	return host->pending_reset ||
> +	return host->pending_reset || host->always_defer_done ||
>  	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
>  		data->host_cookie == COOKIE_MAPPED);
>  }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d89cdb9..a73ce89 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -533,6 +533,7 @@ struct sdhci_host {
>  	bool pending_reset;	/* Cmd/data reset is pending */
>  	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
>  	bool v4_mode;		/* Host Version 4 Enable */
> +	bool always_defer_done;	/* Always defer to complete requests */
>  
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
>  	struct mmc_command *cmd;	/* Current command */
> 
