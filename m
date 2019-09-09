From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 09/11] mmc: sdhci: Drop redundant check in
 sdhci_ack_sdio_irq()
Date: Mon, 9 Sep 2019 14:19:25 +0300
Message-ID: <40034b79-8e52-8ed7-2d18-1a8da498e5ea@intel.com>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
 <20190908101236.2802-10-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-10-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 8/09/19 1:12 PM, Ulf Hansson wrote:
> The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
> Therefore, let's drop the redundant check of the internal
> SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d814dc004bad..efa6cda8c991 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2163,8 +2163,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&host->lock, flags);
> -	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
> -		sdhci_enable_sdio_irq_nolock(host, true);
> +	sdhci_enable_sdio_irq_nolock(host, true);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> 
