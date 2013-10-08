From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: Remove custom properties
Date: Tue, 8 Oct 2013 14:45:43 +0800
Message-ID: <20131008064537.GE7480@S2101-09.ap.freescale.net>
References: <1381167144-18098-1-git-send-email-fabio.estevam@freescale.com>
 <1381167144-18098-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:38885 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753696Ab3JHGpc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2013 02:45:32 -0400
Content-Disposition: inline
In-Reply-To: <1381167144-18098-2-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Mon, Oct 07, 2013 at 02:32:24PM -0300, Fabio Estevam wrote:
> According to Documentation/devicetree/bindings/mmc/mmc.txt:
> 
> "Card detection:
> If no property below is supplied, host native card detect is used.
> Only one of the properties in this section should be supplied:
>   - broken-cd: There is no card detection available; polling must be used.
>   - cd-gpios: Specify GPIOs for card detection, see gpio binding
>   - non-removable: non-removable slot (like eMMC); assume always present. "
> 
> So remove the custom fsl,cd-controller and fsl,wp-controller properties, as the
> mmc core can take care of it.
> 
> Tested on mx51babbage, mx53qsb boards and mx6qsabresd boards.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 6 ------
>  drivers/mmc/host/sdhci-esdhc-imx.c                      | 6 ------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 1dd6225..5da8ab0 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -9,18 +9,12 @@ by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
>  Required properties:
>  - compatible : Should be "fsl,<chip>-esdhc"
>  
> -Optional properties:
> -- fsl,cd-controller : Indicate to use controller internal card detection
> -- fsl,wp-controller : Indicate to use controller internal write protection
> -
>  Examples:
>  
>  esdhc@70004000 {
>  	compatible = "fsl,imx51-esdhc";
>  	reg = <0x70004000 0x4000>;
>  	interrupts = <1>;
> -	fsl,cd-controller;
> -	fsl,wp-controller;
>  };
>  
>  esdhc@70008000 {
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b9899e9..07662d1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -796,12 +796,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	if (of_get_property(np, "non-removable", NULL))
>  		boarddata->cd_type = ESDHC_CD_PERMANENT;
>  
> -	if (of_get_property(np, "fsl,cd-controller", NULL))
> -		boarddata->cd_type = ESDHC_CD_CONTROLLER;

Without this removed, flag SDHCI_QUIRK_BROKEN_CARD_DETECTION will be
kept for the host controller.  Consequently, MMC_CAP_NEEDS_POLL is set,
and we will use polling for card-detection.

Shawn

> -
> -	if (of_get_property(np, "fsl,wp-controller", NULL))
> -		boarddata->wp_type = ESDHC_WP_CONTROLLER;
> -
>  	boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
>  	if (gpio_is_valid(boarddata->cd_gpio))
>  		boarddata->cd_type = ESDHC_CD_GPIO;
> -- 
> 1.8.1.2
> 
> 

