From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 1/4] mmc: sdhci-esdhc-imx: do not reference platform
 data after probe
Date: Wed, 6 Jul 2011 15:03:26 -0600
Message-ID: <20110706210326.GC5371@ponder.secretlab.ca>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
 <1309970870-13336-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57087 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab1GFVDa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 17:03:30 -0400
Received: by pzk9 with SMTP id 9so284815pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 14:03:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309970870-13336-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Troy Kisky <troy.kisky@boundarydevices.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>

On Thu, Jul 07, 2011 at 12:47:47AM +0800, Shawn Guo wrote:
> The patch copies platform data into pltfm_imx_data and reference
> the data there than platform data after probe.
> 
> This work is inspired by Grant Likely and Troy Kisky.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   22 +++++++++++++---------
>  1 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 3cc6f61..0b0e62e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -45,6 +45,7 @@
>  struct pltfm_imx_data {
>  	int flags;
>  	u32 scratchpad;
> +	struct esdhc_platform_data boarddata;
>  };
>  
>  static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host *host)
> @@ -69,8 +70,9 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
>  
>  static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  {
> -	struct esdhc_platform_data *boarddata =
> -			host->mmc->parent->platform_data;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  
>  	/* fake CARD_PRESENT flag */
>  	u32 val = readl(host->ioaddr + reg);
> @@ -92,8 +94,7 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> -	struct esdhc_platform_data *boarddata =
> -			host->mmc->parent->platform_data;
> +	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  
>  	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
>  			&& (boarddata->cd_type == ESDHC_CD_GPIO)))
> @@ -210,8 +211,9 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
>  
>  static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
>  {
> -	struct esdhc_platform_data *boarddata =
> -			host->mmc->parent->platform_data;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  
>  	switch (boarddata->wp_type) {
>  	case ESDHC_WP_GPIO:
> @@ -291,12 +293,14 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()))
>  		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
>  
> -	boarddata = host->mmc->parent->platform_data;
> -	if (!boarddata) {
> +	if (!host->mmc->parent->platform_data) {
>  		dev_err(mmc_dev(host->mmc), "no board data!\n");
>  		err = -EINVAL;
>  		goto no_board_data;
>  	}
> +	imx_data->boarddata = *((struct esdhc_platform_data *)
> +				host->mmc->parent->platform_data);
> +	boarddata = &imx_data->boarddata;
>  
>  	/* write_protect */
>  	if (boarddata->wp_type == ESDHC_WP_GPIO) {
> @@ -373,8 +377,8 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
>  
>  	sdhci_remove_host(host, dead);
> -- 
> 1.7.4.1
> 
> 
