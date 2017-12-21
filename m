From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 11/12] mmc: sdhci-omap: Add support for MMC/SD controller
 in k2g SoC
Date: Thu, 21 Dec 2017 11:15:03 +0200
Message-ID: <4d04e881-2756-184b-1909-49f9d4a68efd@intel.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-12-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14257 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbdLUJPb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Dec 2017 04:15:31 -0500
In-Reply-To: <20171214130941.26666-12-kishon@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com

On 14/12/17 15:09, Kishon Vijay Abraham I wrote:
> Add support for the new compatible added specifically to support
> k2g's MMC/SD controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index cddc3ad1331f..5e81e29383d9 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -767,6 +767,10 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
>  	.ops = &sdhci_omap_ops,
>  };
>  
> +static const struct sdhci_omap_data k2g_data = {
> +	.offset = 0x200,
> +};
> +
>  static const struct sdhci_omap_data dra7_data = {
>  	.offset = 0x200,
>  	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
> @@ -774,6 +778,7 @@ static const struct sdhci_omap_data dra7_data = {
>  
>  static const struct of_device_id omap_sdhci_match[] = {
>  	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
> +	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, omap_sdhci_match);
> @@ -882,6 +887,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	int ret;
>  	u32 offset;
>  	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_omap_host *omap_host;
> @@ -908,6 +914,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  		return PTR_ERR(host);
>  	}
>  
> +	if (of_device_is_compatible(node, "ti,k2g-sdhci"))
> +		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +
>  	pltfm_host = sdhci_priv(host);
>  	omap_host = sdhci_pltfm_priv(pltfm_host);
>  	omap_host->host = host;
> 

