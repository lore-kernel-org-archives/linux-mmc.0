From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/6] mmc: sdhci-esdhc-imx: set the correct max timeout
 value for uSDHC
Date: Wed, 11 Dec 2013 10:17:17 +0800
Message-ID: <20131211021715.GD18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-5-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:55222
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830Ab3LKCQ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 21:16:59 -0500
Content-Disposition: inline
In-Reply-To: <1386680168-5227-5-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

On Tue, Dec 10, 2013 at 08:56:06PM +0800, Dong Aisheng wrote:
> The default sdhci driver write 0xE into timeout counter register to
> set the maximum timeout. The value is not correct for uSDHC since the
> max counter value for uSDHC is 0xF.
> Instead of using common timeout code in sdhci, we implement esdhc_set_timeout
> to handle the difference between eSDHC and uSDHC.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 97b35e1..c24cb23 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -868,6 +868,16 @@ unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
>  	return max_to / (esdhc_pltfm_get_max_clock(host) / 1000);
>  }
>  
> +void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)

static?

Shawn

> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +
> +	/* use maximum timeout counter */
> +	sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
> +			SDHCI_TIMEOUT_CONTROL);
> +}
> +
>  static struct sdhci_ops sdhci_esdhc_ops = {
>  	.read_l = esdhc_readl_le,
>  	.read_w = esdhc_readw_le,
> @@ -881,6 +891,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.platform_bus_width = esdhc_pltfm_bus_width,
>  	.set_uhs_signaling = esdhc_set_uhs_signaling,
>  	.get_max_timeout = esdhc_get_max_timeout,
> +	.set_timeout = esdhc_set_timeout,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> -- 
> 1.7.2.rc3
> 
> 

