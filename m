From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: name esdhc specific definitions
 with ESDHC_ prefix
Date: Fri, 25 Jan 2013 07:46:49 +0100
Message-ID: <51022A59.8010309@de.bosch.com>
References: <1358264213-3611-1-git-send-email-shawn.guo@linaro.org> <1358264213-3611-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:56196 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab3AYHAt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Jan 2013 02:00:49 -0500
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id B7FBE8405FF
	for <linux-mmc@vger.kernel.org>; Fri, 25 Jan 2013 07:50:38 +0100 (CET)
In-Reply-To: <1358264213-3611-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 15.01.2013 16:36, Shawn Guo wrote:
> Rename esdhc local definitions with ESDHC_ rather than SDHCI_ prefix,
> so that we can distinguish them from SDHCI core definitions from name.
> 
> A couple of bit fields are also changed use shift for consistency and
> better readability.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Tested on i.MX6.

Thanks

Dirk

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   40 ++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 322eabf..6ffd15e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -30,12 +30,12 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>  
> -#define	SDHCI_CTRL_D3CD			0x08
> +#define	ESDHC_CTRL_D3CD			0x08
>  /* VENDOR SPEC register */
> -#define SDHCI_VENDOR_SPEC		0xC0
> -#define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
> -#define SDHCI_WTMK_LVL			0x44
> -#define SDHCI_MIX_CTRL			0x48
> +#define ESDHC_VENDOR_SPEC		0xc0
> +#define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
> +#define ESDHC_WTMK_LVL			0x44
> +#define ESDHC_MIX_CTRL			0x48
>  
>  /*
>   * There is an INT DMA ERR mis-match between eSDHC and STD SDHC SPEC:
> @@ -43,7 +43,7 @@
>   * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
>   * Define this macro DMA error INT for fsl eSDHC
>   */
> -#define SDHCI_INT_VENDOR_SPEC_DMA_ERR	0x10000000
> +#define ESDHC_INT_VENDOR_SPEC_DMA_ERR	(1 << 28)
>  
>  /*
>   * The CMDTYPE of the CMD register (offset 0xE) should be set to
> @@ -165,8 +165,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  	}
>  
>  	if (unlikely(reg == SDHCI_INT_STATUS)) {
> -		if (val & SDHCI_INT_VENDOR_SPEC_DMA_ERR) {
> -			val &= ~SDHCI_INT_VENDOR_SPEC_DMA_ERR;
> +		if (val & ESDHC_INT_VENDOR_SPEC_DMA_ERR) {
> +			val &= ~ESDHC_INT_VENDOR_SPEC_DMA_ERR;
>  			val |= SDHCI_INT_ADMA_ERROR;
>  		}
>  	}
> @@ -192,9 +192,9 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  			 * re-sample it by the following steps.
>  			 */
>  			data = readl(host->ioaddr + SDHCI_HOST_CONTROL);
> -			data &= ~SDHCI_CTRL_D3CD;
> +			data &= ~ESDHC_CTRL_D3CD;
>  			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> -			data |= SDHCI_CTRL_D3CD;
> +			data |= ESDHC_CTRL_D3CD;
>  			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
>  		}
>  	}
> @@ -203,15 +203,15 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  				&& (reg == SDHCI_INT_STATUS)
>  				&& (val & SDHCI_INT_DATA_END))) {
>  			u32 v;
> -			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> -			v &= ~SDHCI_VENDOR_SPEC_SDIO_QUIRK;
> -			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> +			v = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +			v &= ~ESDHC_VENDOR_SPEC_SDIO_QUIRK;
> +			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
>  	}
>  
>  	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
>  		if (val & SDHCI_INT_ADMA_ERROR) {
>  			val &= ~SDHCI_INT_ADMA_ERROR;
> -			val |= SDHCI_INT_VENDOR_SPEC_DMA_ERR;
> +			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
>  		}
>  	}
>  
> @@ -253,9 +253,9 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  				&& (host->cmd->data->blocks > 1)
>  				&& (host->cmd->data->flags & MMC_DATA_READ)) {
>  			u32 v;
> -			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> -			v |= SDHCI_VENDOR_SPEC_SDIO_QUIRK;
> -			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> +			v = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +			v |= ESDHC_VENDOR_SPEC_SDIO_QUIRK;
> +			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
>  		}
>  		imx_data->scratchpad = val;
>  		return;
> @@ -266,9 +266,9 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  			val |= SDHCI_CMD_ABORTCMD;
>  
>  		if (is_imx6q_usdhc(imx_data)) {
> -			u32 m = readl(host->ioaddr + SDHCI_MIX_CTRL);
> +			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
>  			m = imx_data->scratchpad | (m & 0xffff0000);
> -			writel(m, host->ioaddr + SDHCI_MIX_CTRL);
> +			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>  			writel(val << 16,
>  			       host->ioaddr + SDHCI_TRANSFER_MODE);
>  		} else {
> @@ -487,7 +487,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	 * to something insane.  Change it back here.
>  	 */
>  	if (is_imx6q_usdhc(imx_data))
> -		writel(0x08100810, host->ioaddr + SDHCI_WTMK_LVL);
> +		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
>  
>  	boarddata = &imx_data->boarddata;
>  	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {

