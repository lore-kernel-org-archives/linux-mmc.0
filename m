From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/4] mmc: host: sdhci: Add virtual command queue support
Date: Mon, 9 Sep 2019 15:03:32 +0300
Message-ID: <5594efd0-6076-bbb5-5aec-a6b3a21dd7ca@intel.com>
References: <cover.1567740135.git.baolin.wang@linaro.org>
 <fc8a0fe513d244375013546c3c03967510feea4a.1567740135.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc8a0fe513d244375013546c3c03967510feea4a.1567740135.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 6/09/19 6:52 AM, Baolin Wang wrote:
> Add cqhci_virt_finalize_request() to help to complete a request
> from virtual command queue.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4e9ebc8..fb5983e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -32,6 +32,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  
>  #include "sdhci.h"
> +#include "cqhci.h"
>  
>  #define DRIVER_NAME "sdhci"
>  
> @@ -2710,7 +2711,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	mmc_request_done(host->mmc, mrq);
> +	if (!cqhci_virt_finalize_request(host->mmc, mrq))
> +		mmc_request_done(host->mmc, mrq);

Please add a sdhci_ops callback for request->done then:

	if (host->ops->request_done)
		host->ops->request_done(host, mrq);
	else
		mmc_request_done(host->mmc, mrq);

>  
>  	return false;
>  }
> @@ -3133,7 +3135,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  
>  	/* Process mrqs ready for immediate completion */
>  	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> -		if (mrqs_done[i])
> +		if (mrqs_done[i] &&
> +		    !cqhci_virt_finalize_request(host->mmc, mrqs_done[i]))

sdhci does not support calling mmc->ops->request in interrupt context.
So probably, you should avoid immediate completion.

>  			mmc_request_done(host->mmc, mrqs_done[i]);
>  	}
>  
> 
