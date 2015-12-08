From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 2/5] mmc: sdhci-of-esdhc: get SVR from global utilities
 registers
Date: Tue, 8 Dec 2015 11:45:32 -0600
Message-ID: <1449596732.15946.125.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-3-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0119.outbound.protection.outlook.com ([157.56.110.119]:20112
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751112AbbLHSAH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Dec 2015 13:00:07 -0500
In-Reply-To: <1448594417-22515-3-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com

On Fri, 2015-11-27 at 11:20 +0800, Yangbo Lu wrote:
> Most of silicon errata about the eSDHC need to be identified through
> the SoC version/revision. This patch makes the driver get these
> information from SVR(system version register) of global utilities
> registers.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
> 	- Got SVR through iomap instead of dts
> Changes for v3:
> 	- Managed GUTS through syscon instead of iomap in eSDHC driver
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of
> -esdhc.c
> index 83b1226..fce24b7 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -19,6 +19,9 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/fsl-svr.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>  
> @@ -28,6 +31,8 @@
>  struct sdhci_esdhc {
>  	u8 vendor_ver;
>  	u8 spec_ver;
> +	u32 soc_ver;
> +	u8 soc_rev;
>  };
>  
>  /**
> @@ -566,18 +571,28 @@ static void esdhc_init(struct platform_device *pdev,
> struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_esdhc *esdhc;
> +	struct regmap *guts_regmap;
> +	u32 svr;
>  	u16 host_ver;
>  
>  	pltfm_host = sdhci_priv(host);
>  	esdhc = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_esdhc),
>  			     GFP_KERNEL);
> +	pltfm_host->priv = esdhc;
> +
> +	guts_regmap = syscon_regmap_lookup_by_compatible("syscon");
> +	if (IS_ERR(guts_regmap)) {
> +		dev_err(&pdev->dev, "unable to find global utilities
> registers\n");
> +	} else {
> +		regmap_read(guts_regmap, SVR_OFFSET, &svr);
> +		esdhc->soc_ver = SVR_SOC_VER(svr);
> +		esdhc->soc_rev = SVR_REV(svr);
> +	}

As this patchset stands you're going to be spitting out that error message on
everything that isn't t4240...

-Scott

