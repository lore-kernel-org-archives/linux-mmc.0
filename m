From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: fix warning during module
 remove function
Date: Mon, 23 Dec 2013 22:06:15 +0800
Message-ID: <20131223140613.GL26070@S2101-09.ap.freescale.net>
References: <1387796544-18209-1-git-send-email-b29396@freescale.com>
 <1387796544-18209-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:32069
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757357Ab3LWOEo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Dec 2013 09:04:44 -0500
Content-Disposition: inline
In-Reply-To: <1387796544-18209-2-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, fabio.estevam@freescale.com

On Mon, Dec 23, 2013 at 07:02:24PM +0800, Dong Aisheng wrote:
> @@ -1160,8 +1160,6 @@ free_sdhci:
>  static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = pltfm_host->priv;
>  	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
>  
>  	sdhci_remove_host(host, dead);
> @@ -1169,10 +1167,6 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> -	clk_disable_unprepare(imx_data->clk_per);
> -	clk_disable_unprepare(imx_data->clk_ipg);
> -	clk_disable_unprepare(imx_data->clk_ahb);

It's obviously a bad change to me.  We should definitely have these
clk_disable_unprepare() calls in sdhci_esdhc_imx_remove() to match the
clk_prepare_enable() calls in sdhci_esdhc_imx_probe().  Otherwise, at
least for !CONFIG_PM_RUNTIME build, it's broken.

I'm looking at sdhci-pxav3 driver.  Why can it call
clk_disable_unprepare(pltfm_host->clk) in .remove() with runtime PM
support in there?  Is there anything about runtime PM not being done
correctly for our driver?

Shawn

> -
>  	sdhci_pltfm_free(pdev);
>  
>  	return 0;
> -- 
> 1.7.2.rc3
> 
> 

