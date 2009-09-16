From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 3/8] s3c6410: sdhci: Set parent clock, source clock and sdhci module speed.
Date: Wed, 16 Sep 2009 01:46:56 +0100
Message-ID: <20090916004656.GQ13508@trinity.fluff.org>
References: <1252392686-31135-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:42435 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbZIPAqx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 20:46:53 -0400
Content-Disposition: inline
In-Reply-To: <1252392686-31135-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 03:51:26PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch sets the parent clock, source clock and sdhci module
> clock speed for 6410 sdhci controller.

The driver should really be presented with a correct list of sources
for mmc_bus in the platform data (ok, the last post was incorrect as
I forgot the mux on mmc_bus as well as the mux in the driver block).

Any static setup of mmc_bus can be done in the machine setup code,
otherwise please look at how the choices for the SDHCI mux is presented.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 50997d2..db1bb93 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -22,6 +22,8 @@
>  
>  #include <plat/sdhci.h>
>  #include <plat/regs-sdhci.h>
> +#include <plat/clock.h>
> +#include <plat/cpu.h>
>  
>  #include "sdhci.h"
>  
> @@ -221,6 +223,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct sdhci_s3c *sc;
>  	struct resource *res;
> +	struct clk *clk_mmc, *clk_parent;
>  	int ret, irq, ptr, clks;
>  
>  	if (!pdata) {
> @@ -240,6 +243,16 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> +	/* Set the SDHCI controller clock rate */
> +	clk_mmc = clk_get(dev, pdata->clk_source_name);
> +	clk_parent = clk_get(dev, pdata->clk_parent_name);
> +        if (!clk_mmc || !clk_parent) {
> +                dev_err(dev, "could not obtain clock information");
> +                return -ENXIO;
> +        }
> +	clk_set_parent(clk_mmc, clk_parent);
> +	clk_set_rate(clk_mmc, pdata->clk_speed);
> +
>  	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
>  	if (IS_ERR(host)) {
>  		dev_err(dev, "sdhci_alloc_host() failed\n");
> -- 
> 1.5.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

