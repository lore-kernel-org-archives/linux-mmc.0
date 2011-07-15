From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: Add support for device tree based
 probe
Date: Fri, 15 Jul 2011 12:51:45 -0600
Message-ID: <20110715185145.GE2833@ponder.secretlab.ca>
References: <1310730128-4243-1-git-send-email-thomas.abraham@linaro.org>
 <1310730128-4243-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59781 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab1GOSvs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2011 14:51:48 -0400
Received: by pvg12 with SMTP id 12so1295272pvg.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2011 11:51:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310730128-4243-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org

On Fri, Jul 15, 2011 at 05:12:06PM +0530, Thomas Abraham wrote:
> Add of_match_table to enable sdhci-s3c driver to be probed when a compatible
> sdhci device node is found in device tree.
> 
> CC: linux-mmc@vger.kernel.org
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  .../devicetree/bindings/mmc/samsung-s3c-sdhci.txt  |   10 ++++++++++
>  drivers/mmc/host/sdhci-s3c.c                       |   11 +++++++++++
>  2 files changed, 21 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung-s3c-sdhci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/samsung-s3c-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-s3c-sdhci.txt
> new file mode 100644
> index 0000000..c2298f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/samsung-s3c-sdhci.txt
> @@ -0,0 +1,10 @@
> +* Samsung's SDHCI controller
> +
> +The Samsung's SDHCI controller is used for interfacing with SD/MMC cards.
> +
> +Required properties:
> +- compatible : should be "samsung,s3c-sdhci"
> +- reg : base physical address of the controller and length of memory mapped
> +	region.
> +- interrupts : interrupt number to the cpu.
> +
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 69e3ee3..5ccbee0 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -629,6 +629,16 @@ static int sdhci_s3c_resume(struct platform_device *dev)
>  #define sdhci_s3c_resume NULL
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id s3c_sdhci_match[] = {
> +	{ .compatible = "samsung,s3c-sdhci" },

Be specific.  samsung,exynos4210-sdhci.  Newer chips can claim
compatibility with the older one.

Otherwise,

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, s3c_sdhci_match);
> +#else
> +#define s3c_sdhci_match NULL
> +#endif
> +
>  static struct platform_driver sdhci_s3c_driver = {
>  	.probe		= sdhci_s3c_probe,
>  	.remove		= __devexit_p(sdhci_s3c_remove),
> @@ -637,6 +647,7 @@ static struct platform_driver sdhci_s3c_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "s3c-sdhci",
> +		.of_match_table	= s3c_sdhci_match,
>  	},
>  };
>  
> -- 
> 1.7.1
> 
