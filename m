From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
Date: Wed, 27 Mar 2019 13:15:25 +0200
Message-ID: <508e9423-c1f9-f2cc-4aa9-2cc5b1cf40a8@intel.com>
References: <20190326110057.7055-1-faiz_abbas@ti.com>
 <20190326110057.7055-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326110057.7055-3-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

On 26/03/19 1:00 PM, Faiz Abbas wrote:
> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback") skips data resets during tuning operation. Because of this,
> a data error or data finish interrupt might still arrive after a command
> error has been handled and the mrq ended. This ends up with a "mmc0: Got
> data interrupt 0x00000002 even though no data operation was in progress"
> error message.
> 
> Fix this by adding a platform specific callback for sdhci_irq. Mark the
> mrq as a failure but wait for a data interrupt instead of calling
> finish_mrq().
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 37 +++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 5bbed477c9b1..9da2ff9ede8b 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -797,6 +797,42 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX |\
> +		      SDHCI_INT_TIMEOUT)
> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
> +
> +static irqreturn_t sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (omap_host->is_tuning && (intmask & CMD_ERR_MASK)) {
> +
> +		/*
> +		 * Since we are not resetting data lines during tuning
> +		 * operation, data error or data complete interrupts
> +		 * might still arrive. Mark this request as a failure
> +		 * but still wait for the data interrupt
> +		 */
> +		if (intmask & SDHCI_INT_TIMEOUT)
> +			host->cmd->error = -ETIMEDOUT;
> +		else
> +			host->cmd->error = -EILSEQ;
> +
> +		sdhci_finish_command(host);

Would it be possible to set SDHCI_INT_RESPONSE instead of calling
sdhci_finish_command() directly?

> +
> +		/*
> +		 * Sometimes command error interrupts and command complete
> +		 * interrupt will arrive together. Clear all command related
> +		 * interrupts here.
> +		 */
> +		sdhci_writel(host, intmask & CMD_MASK, SDHCI_INT_STATUS);
> +		intmask &= ~CMD_MASK;
> +	}
> +
> +	return intmask;
> +}
> +
>  static struct sdhci_ops sdhci_omap_ops = {
>  	.set_clock = sdhci_omap_set_clock,
>  	.set_power = sdhci_omap_set_power,
> @@ -807,6 +843,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>  	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
>  	.reset = sdhci_omap_reset,
>  	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
> +	.irq = sdhci_omap_irq,
>  };
>  
>  static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
> 
