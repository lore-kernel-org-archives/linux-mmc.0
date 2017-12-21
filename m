From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 05/12] mmc: sdhci-omap: Workaround for Errata i802
Date: Thu, 21 Dec 2017 11:09:35 +0200
Message-ID: <8ada81f8-7e67-8d77-471a-502f6ec10b2b@intel.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-6-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214130941.26666-6-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

On 14/12/17 15:09, Kishon Vijay Abraham I wrote:
> Errata i802 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
> (SPRZ429K July 2014–Revised March 2017 [1]) mentions
> DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
> during the tuning procedure and it has to be disabled during the
> tuning procedure Implement workaround for Errata i802 here..
> 
> [1] -> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index df8a0a472996..b20f4c79ccc6 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -266,6 +266,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_omap_host *omap_host;
>  	struct device *dev;
> +	u32 ier = host->ier;
>  
>  	pltfm_host = sdhci_priv(host);
>  	omap_host = sdhci_pltfm_priv(pltfm_host);
> @@ -283,6 +284,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	reg |= DLL_SWT;
>  	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
>  
> +	/*
> +	 * OMAP5/DRA74X/DRA72x Errata i802:
> +	 * DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
> +	 * during the tuning procedure. So disable it during the
> +	 * tuning procedure.
> +	 */
> +	ier &= ~SDHCI_INT_DATA_CRC;
> +	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> +
>  	while (phase_delay <= MAX_PHASE_DELAY) {
>  		sdhci_omap_set_dll(omap_host, phase_delay);
>  
> @@ -328,6 +339,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  ret:
>  	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  	return ret;
>  }
>  
> 
