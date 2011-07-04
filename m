From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] mmc: sdhci-pltfm: dt device does not pass parent to
 sdhci_alloc_host
Date: Mon, 4 Jul 2011 00:22:30 -0600
Message-ID: <20110704062230.GH15152@ponder.secretlab.ca>
References: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
 <1309681851-23052-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48344 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab1GDGWd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 02:22:33 -0400
Received: by pzk9 with SMTP id 9so1413441pzk.19
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2011 23:22:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309681851-23052-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Chris Ball <cjb@laptop.org>

On Sun, Jul 03, 2011 at 04:30:50PM +0800, Shawn Guo wrote:
> Neither platform based nor dt based device needs to pass the parent
> to sdhci_alloc_host.  There is no difference between platform and dt
> on this point.
> 
> The patch makes the change to pass device itself than its parent to
> sdhci_alloc_host for dt case too.  Otherwise the probe function of
> sdhci based drivers which is shared between platform and dt will
> fail on dt case.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/mmc/host/sdhci-pltfm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 71c0ce1..6414efe 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -85,6 +85,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  {
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct resource *iomem;
>  	int ret;
>  
> @@ -98,7 +99,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  		dev_err(&pdev->dev, "Invalid iomem size!\n");
>  
>  	/* Some PCI-based MFD need the parent here */
> -	if (pdev->dev.parent != &platform_bus)
> +	if (pdev->dev.parent != &platform_bus && !np)
>  		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));
>  	else
>  		host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
> -- 
> 1.7.4.1
> 
