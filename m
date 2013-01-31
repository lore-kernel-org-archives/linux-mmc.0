From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unused variables
Date: Thu, 31 Jan 2013 08:31:20 +0800
Message-ID: <20130131003118.GC2765@S2101-09.ap.freescale.net>
References: <1359576681-14797-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.181.184] ([216.32.181.184]:19661 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755313Ab3AaAck (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 19:32:40 -0500
Content-Disposition: inline
In-Reply-To: <1359576681-14797-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 30, 2013 at 09:11:21PM +0100, Thierry Reding wrote:
> Commit 3f175a6 (mmc: sdhci-esdhc-imx: remove ESDHC_CD_GPIO handling from
> IO accessory) removed all the code that was using these variables, so it
> is safe to drop them.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Thanks for the fixing, Thierry.  But Chris has already queued a fix [1]
from Fabio.

Shawn

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/18724

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ae68bc9..509be3a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -144,10 +144,6 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
>  
>  static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  {
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> -	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
> -
>  	u32 val = readl(host->ioaddr + reg);
>  
>  	if (unlikely(reg == SDHCI_CAPABILITIES)) {
> @@ -178,7 +174,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> -	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  	u32 data;
>  
>  	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
> -- 
> 1.8.1.2
> 

