From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] mmc: sdhci-esdhc-imx: Fix DAT line software reset
Date: Mon, 29 May 2017 11:02:46 +0300
Message-ID: <e50b673d-e04a-24f9-6790-95803799c1fe@intel.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
 <1493805925-3644-2-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493805925-3644-2-git-send-email-benoit@wsystem.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit@wsystem.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?Q?Eric_B=c3=a9nard?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

On 03/05/17 13:05, Benoît Thébaudeau wrote:
> On i.MX25, the eSDHC DAT line software reset (SYSCTL.RSTD) unexpectedly
> clears at least the data transfer width (PROCTL.DTW), which then results
> in data CRC errors. This behavior is not documented, but it has actually
> been observed. Consequently, the DAT line software resets triggered by
> sdhci.c in case of errors caused unrecoverable errors.
> 
> Fix this by making sure that the DAT line software reset does not alter
> the Host Control register. This behavior being undocumented, it may also
> be present on other i.MX SoCs, so apply this fix for the whole i.MX
> family.
> 
> Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>

I would expect to see Acks from other sdhci-esdhc-imx users.  Nevertheless,
for sdhci:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 59 ++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 23d8b8a..4ee82e1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -579,7 +579,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -	u32 new_val;
> +	u32 new_val = 0;
>  	u32 mask;
>  
>  	switch (reg) {
> @@ -610,29 +610,46 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  
>  		esdhc_clrset_le(host, mask, new_val, reg);
>  		return;
> +	case SDHCI_SOFTWARE_RESET:
> +		if (val & SDHCI_RESET_DATA)
> +			new_val = readl(host->ioaddr + SDHCI_HOST_CONTROL);
> +		break;
>  	}
>  	esdhc_clrset_le(host, 0xff, val, reg);
>  
> -	/*
> -	 * The esdhc has a design violation to SDHC spec which tells
> -	 * that software reset should not affect card detection circuit.
> -	 * But esdhc clears its SYSCTL register bits [0..2] during the
> -	 * software reset.  This will stop those clocks that card detection
> -	 * circuit relies on.  To work around it, we turn the clocks on back
> -	 * to keep card detection circuit functional.
> -	 */
> -	if ((reg == SDHCI_SOFTWARE_RESET) && (val & 1)) {
> -		esdhc_clrset_le(host, 0x7, 0x7, ESDHC_SYSTEM_CONTROL);
> -		/*
> -		 * The reset on usdhc fails to clear MIX_CTRL register.
> -		 * Do it manually here.
> -		 */
> -		if (esdhc_is_usdhc(imx_data)) {
> -			/* the tuning bits should be kept during reset */
> -			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -			writel(new_val & ESDHC_MIX_CTRL_TUNING_MASK,
> -					host->ioaddr + ESDHC_MIX_CTRL);
> -			imx_data->is_ddr = 0;
> +	if (reg == SDHCI_SOFTWARE_RESET) {
> +		if (val & SDHCI_RESET_ALL) {
> +			/*
> +			 * The esdhc has a design violation to SDHC spec which
> +			 * tells that software reset should not affect card
> +			 * detection circuit. But esdhc clears its SYSCTL
> +			 * register bits [0..2] during the software reset. This
> +			 * will stop those clocks that card detection circuit
> +			 * relies on. To work around it, we turn the clocks on
> +			 * back to keep card detection circuit functional.
> +			 */
> +			esdhc_clrset_le(host, 0x7, 0x7, ESDHC_SYSTEM_CONTROL);
> +			/*
> +			 * The reset on usdhc fails to clear MIX_CTRL register.
> +			 * Do it manually here.
> +			 */
> +			if (esdhc_is_usdhc(imx_data)) {
> +				/*
> +				 * the tuning bits should be kept during reset
> +				 */
> +				new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +				writel(new_val & ESDHC_MIX_CTRL_TUNING_MASK,
> +						host->ioaddr + ESDHC_MIX_CTRL);
> +				imx_data->is_ddr = 0;
> +			}
> +		} else if (val & SDHCI_RESET_DATA) {
> +			/*
> +			 * The eSDHC DAT line software reset clears at least the
> +			 * data transfer width on i.MX25, so make sure that the
> +			 * Host Control register is unaffected.
> +			 */
> +			esdhc_clrset_le(host, 0xff, new_val,
> +					SDHCI_HOST_CONTROL);
>  		}
>  	}
>  }
> 
