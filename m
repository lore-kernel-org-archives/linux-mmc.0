From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: fix multiblock reads on i.MX53
Date: Tue, 16 Apr 2013 08:45:12 +0200
Message-ID: <1366094712.4636.8.camel@weser.hi.pengutronix.de>
References: <1363272225-1304-1-git-send-email-l.stach@pengutronix.de>
	 <1363337366-8532-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45307 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3DPGqH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Apr 2013 02:46:07 -0400
In-Reply-To: <1363337366-8532-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

Ping.

Am Freitag, den 15.03.2013, 09:49 +0100 schrieb Lucas Stach:
> The eSDHC controller on the i.MX53 needs an additional, non spec
> compliant CMD12 after a multiblock read with a predefined number of
> blocks. Otherwise the internal state machine won't go back to the
> idle state.
> 
> This commit effectively reverts 5b6b0ad6 (mmc: sdhci-esdhc-imx:
> fix for mmc cards on i.MX5), which fixed part of the problem by
> making multiblock reads work, however this fix was not sufficient
> when multi- and singleblock reads got intermixed.
> 
> This implements the recommended workaround (Freescale i.MX Reference
> Manual, section 29.6.8 "Multi-block Read") by manually sending a
> CMD12 with the RSPTYP bits cleared.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2:
> - clarified and fixed commit msg
> - converted multiblock state to an enum
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   37 +++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 78ac002..4bc0dd4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -85,6 +85,12 @@ struct pltfm_imx_data {
>  	struct clk *clk_ipg;
>  	struct clk *clk_ahb;
>  	struct clk *clk_per;
> +	enum {
> +		NO_CMD_PENDING,      /* no multiblock command pending*/
> +		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
> +		WAIT_FOR_INT,        /* sent CMD12, waiting for response INT */
> +	} multiblock_status;
> +
>  };
>  
>  static struct platform_device_id imx_esdhc_devtype[] = {
> @@ -154,6 +160,8 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
>  
>  static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
>  	u32 val = readl(host->ioaddr + reg);
>  
>  	if (unlikely(reg == SDHCI_CAPABILITIES)) {
> @@ -175,6 +183,18 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  			val &= ~ESDHC_INT_VENDOR_SPEC_DMA_ERR;
>  			val |= SDHCI_INT_ADMA_ERROR;
>  		}
> +
> +		/*
> +		 * mask off the interrupt we get in response to the manually
> +		 * sent CMD12
> +		 */
> +		if ((imx_data->multiblock_status == WAIT_FOR_INT) &&
> +		    ((val & SDHCI_INT_RESPONSE) == SDHCI_INT_RESPONSE)) {
> +			val &= ~SDHCI_INT_RESPONSE;
> +			writel(SDHCI_INT_RESPONSE, host->ioaddr +
> +						   SDHCI_INT_STATUS);
> +			imx_data->multiblock_status = NO_CMD_PENDING;
> +		}
>  	}
>  
>  	return val;
> @@ -211,6 +231,15 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  			v = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>  			v &= ~ESDHC_VENDOR_SPEC_SDIO_QUIRK;
>  			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
> +
> +			if (imx_data->multiblock_status == MULTIBLK_IN_PROCESS)
> +			{
> +				/* send a manual CMD12 with RESPTYP=none */
> +				data = MMC_STOP_TRANSMISSION << 24 |
> +				       SDHCI_CMD_ABORTCMD << 16;
> +				writel(data, host->ioaddr + SDHCI_TRANSFER_MODE);
> +				imx_data->multiblock_status = WAIT_FOR_INT;
> +			}
>  	}
>  
>  	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
> @@ -277,11 +306,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		}
>  		return;
>  	case SDHCI_COMMAND:
> -		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION ||
> -		     host->cmd->opcode == MMC_SET_BLOCK_COUNT) &&
> -	            (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
> +		if (host->cmd->opcode == MMC_STOP_TRANSMISSION)
>  			val |= SDHCI_CMD_ABORTCMD;
>  
> +		if ((host->cmd->opcode == MMC_SET_BLOCK_COUNT) &&
> +		    (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
> +			imx_data->multiblock_status = MULTIBLK_IN_PROCESS;
> +
>  		if (is_imx6q_usdhc(imx_data))
>  			writel(val << 16,
>  			       host->ioaddr + SDHCI_TRANSFER_MODE);

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

