From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: check interrupt flags in ISR again
Date: Wed, 14 Mar 2012 09:39:02 +0200
Message-ID: <4F604B16.606@intel.com>
References: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com> <1331659002-13743-2-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1331659002-13743-2-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Chris Ball <cjb@laptop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 13/03/12 19:16, Alexander Stein wrote:
> When using MSI it is possible that a new MSI is sent while an earlier
> MSI is currently handled. In this case SDHCI_INT_STATUS only contains
> SDHCI_INT_RESPONSE and the ISR would not be called again. But at the end
> of the ISR SDHCI_INT_DATA_END is now also pending which would be ignored.
> 
> Fix this by rereading the interrupt flags in the ISR until no interrupt
> we care is pending.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/mmc/host/sdhci.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8d66706..654ab32 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2268,6 +2268,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  	irqreturn_t result;
>  	struct sdhci_host *host = dev_id;
>  	u32 intmask;
> +	u32 intmask_unhandled;
>  	int cardint = 0;
>  
>  	spin_lock(&host->lock);
> @@ -2286,6 +2287,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  		goto out;
>  	}
>  
> +again:
>  	DBG("*** %s got interrupt: 0x%08x\n",
>  		mmc_hostname(host->mmc), intmask);
>  
> @@ -2336,6 +2338,14 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
>  	}
>  
> +	intmask_unhandled = intmask;
> +
> +	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
> +
> +	/* Do interrupt handling again if we got new flags */
> +	if (intmask & ~intmask_unhandled)
> +		goto again;
> +
>  	intmask &= ~SDHCI_INT_BUS_POWER;
>  
>  	if (intmask & SDHCI_INT_CARD_INT)

Why not just replace mmiowb() i.e.


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..da8a101 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2353,7 +2353,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)

        result = IRQ_HANDLED;

-       mmiowb();
+       intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+       if (intmask)
+               goto again;
 out:
        spin_unlock(&host->lock);


But maybe it would be safer limiting the number of loops i.e.


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..d88247d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2268,7 +2268,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
        irqreturn_t result;
        struct sdhci_host *host = dev_id;
        u32 intmask;
-       int cardint = 0;
+       int cardint = 0, max_loops = 16;

        spin_lock(&host->lock);

@@ -2353,7 +2353,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)

        result = IRQ_HANDLED;

-       mmiowb();
+       intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+       if (intmask && --max_loops)
+               goto again;
 out:
        spin_unlock(&host->lock);
