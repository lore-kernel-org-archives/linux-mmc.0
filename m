From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 11/11] mmc: sdhci: Convert to use sdio_irq_enabled()
Date: Thu, 5 Sep 2019 12:02:46 -0700
Message-ID: <20190905190246.GC133864@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-12-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-12-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:07PM +0200, Ulf Hansson wrote:
> Instead of keeping track of whether SDIO IRQs have been enabled via an
> internal sdhci status flag, avoid the open-coding and convert into using
> sdio_irq_enabled().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 7 +------
>  drivers/mmc/host/sdhci.h | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a7df22ed65aa..4b4db41aec50 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2142,11 +2142,6 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  		pm_runtime_get_noresume(host->mmc->parent);
>  
>  	spin_lock_irqsave(&host->lock, flags);
> -	if (enable)
> -		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
> -	else
> -		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
> -
>  	sdhci_enable_sdio_irq_nolock(host, enable);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> @@ -3380,7 +3375,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
>  	host->runtime_suspended = false;
>  
>  	/* Enable SDIO IRQ */
> -	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
> +	if (sdio_irq_enabled(mmc))
>  		sdhci_enable_sdio_irq_nolock(host, true);
>  
>  	/* Enable Card Detection */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 8effaac61c3a..a29c4cd2d92e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -512,7 +512,6 @@ struct sdhci_host {
>  #define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
>  #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
>  #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
> -#define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
>  #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
>  #define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
>  #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
