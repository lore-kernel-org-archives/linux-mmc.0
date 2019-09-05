From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 06/11] mmc: core: Clarify that the ->ack_sdio_irq()
 callback is mandatory
Date: Thu, 5 Sep 2019 10:33:54 -0700
Message-ID: <20190905173354.GK70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-7-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-7-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:02PM +0200, Ulf Hansson wrote:
> For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
> the ->ack_sdio_irq() is already mandatory, which was not the case for those
> host drivers that called sdio_run_irqs() directly.
> 
> As there are no longer any drivers calling sdio_run_irqs(), let's clarify
> the code by dropping the unnecessary check and explicitly state that the
> callback is mandatory in the header file.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 0962a4357d54..d7965b53a6d2 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -115,8 +115,7 @@ static void sdio_run_irqs(struct mmc_host *host)
>  	mmc_claim_host(host);
>  	if (host->sdio_irqs) {
>  		process_sdio_pending_irqs(host);
> -		if (host->ops->ack_sdio_irq)
> -			host->ops->ack_sdio_irq(host);
> +		host->ops->ack_sdio_irq(host);
>  	}
>  	mmc_release_host(host);
>  }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0c0a565c7ff1..ecdc1b0b1313 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -128,6 +128,7 @@ struct mmc_host_ops {
>  	int	(*get_cd)(struct mmc_host *host);
>  
>  	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
> +	/* Mandatory callback when using MMC_CAP2_SDIO_IRQ_NOTHREAD. */
>  	void	(*ack_sdio_irq)(struct mmc_host *host);
>  
>  	/* optional callback for HC quirks */

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
