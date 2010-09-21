From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Tue, 21 Sep 2010 16:59:43 +0400
Message-ID: <20100921125943.GA31945@oksana.dev.rtsoft.ru>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
 <1285072210-10207-5-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43486 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab0IUM7s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 08:59:48 -0400
Received: by ewy23 with SMTP id 23so1889614ewy.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2010 05:59:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285072210-10207-5-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

On Tue, Sep 21, 2010 at 02:30:10PM +0200, Wolfram Sang wrote:
> This driver adds basic support for the esdhc-core found on e.g.
> imx35/51. It adds up to the pltfm-core.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/mmc/host/Kconfig       |    9 +++
>  drivers/mmc/host/Makefile      |    1 +
>  drivers/mmc/host/sdhci-esdhc.c |  141 ++++++++++++++++++++++++++++++++++++++++

I'd reserve that file for esdhc common code, and move IMX
specific bits to sdhci-esdhc-imx.c.

>  drivers/mmc/host/sdhci-pltfm.c |    3 +
>  drivers/mmc/host/sdhci-pltfm.h |    1 +
>  5 files changed, 155 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-esdhc.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6f12d5d..20d03f5 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -143,6 +143,15 @@ config MMC_SDHCI_MV
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_ESDHC
> +	bool "SDHCI platform support for the Freescale eSDHC controller"

Maybe Freescale IMX eSDHC? Let's keep MPC and IMX eSDHC
separate as it's quite possible that they may have different
bugs and limitations.

[...]
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sdhci-pltfm.h>
> +#include "sdhci.h"
> +#include "sdhci-esdhc.h"
> +#include "sdhci-pltfm.h"
> +
> +static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
> +{
> +	void __iomem *base = host->ioaddr + (reg & ~0x3);

#include <linux/compiler.h> is needed for __iomem.

[...]
> +static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);

Please put an empty line here.

> +	return clk_get_rate(pltfm_host->clk);
> +}
> +
> +static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);

Ditto.

> +	return clk_get_rate(pltfm_host->clk) / 256 / 16;
> +}

[...]
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -164,6 +164,9 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
>  #ifdef CONFIG_MMC_SDHCI_CNS3XXX
>  	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
>  #endif
> +#ifdef CONFIG_MMC_SDHCI_ESDHC
> +	{ "sdhci-esdhc", (kernel_ulong_t)&sdhci_esdhc_pdata },

sdhci-esdhc-imx, sdhci_esdhc_imx_pdata.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
