From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 07/10] mmc: sdhci-esdhc-imx: add delay line setting
 support
Date: Tue, 15 Oct 2013 15:37:06 +0800
Message-ID: <20131015073704.GB14908@S2101-09.ap.freescale.net>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
 <1381317616-1229-8-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:52725
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752087Ab3JOHgR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2013 03:36:17 -0400
Content-Disposition: inline
In-Reply-To: <1381317616-1229-8-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, john.tobias.ph@gmail.com

On Wed, Oct 09, 2013 at 07:20:13PM +0800, Dong Aisheng wrote:
> The DLL(Delay Line) is newly added to assist in sampling read data.
> The DLL provides the ability to programmatically select a quantized
> delay (in fractions of the clock period) regardless of on-chip variations
> such as process, voltage and temperature (PVT).
> 
> This patch adds a user interface to set slave delay line via device tree.
> It's usually used in high speed mode like mmc DDR mode when the signal
> quality is not good caused by board design, e.g. the signal path is too long.
> User can manual set delay line to find a suitable data sampling window
> for card to work properly.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    1 +
>  drivers/mmc/host/sdhci-esdhc-imx.c                 |   18 ++++++++++++++++++
>  include/linux/platform_data/mmc-esdhc-imx.h        |    1 +
>  3 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 1dd6225..ebd3ff5 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -12,6 +12,7 @@ Required properties:
>  Optional properties:
>  - fsl,cd-controller : Indicate to use controller internal card detection
>  - fsl,wp-controller : Indicate to use controller internal write protection
> +- fsl,delay-line : Specify delay line value of manual override for slave delay.

It needs more documentation and should refer to the register bits in RM.
Otherwise, I hardly think people will understand what it is.

>  
>  Examples:
>  
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b6ae5c1..91b2d85 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -46,6 +46,11 @@
>  /* Bits 3 and 6 are not SDHCI standard definitions */
>  #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
>  
> +/* dll control register */
> +#define ESDHC_DLL_CTRL			0x60
> +#define ESDHC_DLL_OVERRIDE_VAL_SHIFT	9
> +#define ESDHC_DLL_OVERRIDE_EN_SHIFT	8
> +
>  /* tune control register */
>  #define ESDHC_TUNE_CTRL_STATUS		0x68
>  #define  ESDHC_TUNE_CTRL_STEP		1
> @@ -803,6 +808,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  
>  	switch (uhs) {
>  	case MMC_TIMING_UHS_SDR12:
> @@ -823,6 +829,15 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  				ESDHC_MIX_CTRL_DDREN,
>  				host->ioaddr + ESDHC_MIX_CTRL);
>  		imx_data->is_ddr = 1;
> +		if (boarddata->delay_line) {
> +			u32 v;
> +			v = boarddata->delay_line <<
> +				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
> +				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
> +			if (is_imx53_esdhc(imx_data))
> +				v <<= 1;

Is the patch (series) tested on imx53?  Or is it just a note that imx53
has different bit position? 

> +			writel(v, host->ioaddr + ESDHC_DLL_CTRL);

Is it safe to always write other bits as zero?

Shawn

> +		}
>  		break;
>  	}
>  
> @@ -887,6 +902,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	else
>  		boarddata->support_vsel = true;
>  
> +	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
> +		boarddata->delay_line = 0;
> +
>  	return 0;
>  }
>  #else
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index a0f5a8f..75f70f6 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -45,5 +45,6 @@ struct esdhc_platform_data {
>  	int max_bus_width;
>  	unsigned int f_max;
>  	bool support_vsel;
> +	unsigned int delay_line;
>  };
>  #endif /* __ASM_ARCH_IMX_ESDHC_H */
> -- 
> 1.7.2.rc3
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

