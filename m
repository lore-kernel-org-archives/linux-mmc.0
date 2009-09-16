From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 8/8] s3c6410: sdhci: Updating sdhci_s3c_remove module exit function
Date: Wed, 16 Sep 2009 01:52:01 +0100
Message-ID: <20090916005201.GT13508@trinity.fluff.org>
References: <1252393355-31920-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:47355 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbZIPAv6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 20:51:58 -0400
Content-Disposition: inline
In-Reply-To: <1252393355-31920-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 04:02:35PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch populates the sdhci_s3c_remove function in the
> s3c sdhci driver. This will allow s3c sdhci driver to be
> used as a module.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 7f5b64e..80e8c38 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -380,9 +380,35 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  
>  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  {
> +	struct sdhci_host *host =  platform_get_drvdata(pdev);
> +	struct sdhci_s3c *sc = sdhci_priv(host);
> +	int ptr, dead = 0;
> +	u32 scratch;
> +
> +	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
> +	if (scratch == (u32)-1)
> +		dead = 1;
> +
> +	sdhci_remove_host(host, dead);
> +
> +	for (ptr = 0; ptr < 3; ptr++) {

ptr < ARRRAY_SIZE(sc->clk_bus)

you probably also need to check for the validity of the clock
and skip it if it is not in used.

> +		clk_disable(sc->clk_bus[ptr]);
> +		clk_put(sc->clk_bus[ptr]);
> +	}
> +	clk_disable(sc->clk_io);
> +	clk_put(sc->clk_io);
> +
> +	iounmap(host->ioaddr);
> +	release_resource(sc->ioarea);
> +	kfree(sc->ioarea);
> +
> +	sdhci_free_host(host);
> +	platform_set_drvdata(pdev, NULL);
> +
>  	return 0;
>  }
>  
> +
>  #ifdef CONFIG_PM
>  
>  static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
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

