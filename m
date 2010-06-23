From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] MMC: add support for the Marvell platform SDHCI controller
Date: Wed, 23 Jun 2010 12:52:07 +0100
Message-ID: <87631a6k60.fsf@linux-g6p1.site>
References: <1277215742-25994-1-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:35824 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750967Ab0FWLwJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2010 07:52:09 -0400
In-Reply-To: <1277215742-25994-1-git-send-email-saeed@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: saeed.bishara@gmail.com, linux-mmc@vger.kernel.org

On Tue, 22 Jun 2010 17:09:02 +0300, Saeed Bishara <saeed@marvell.com> wrote:
> This patch implements the driver for the platfrom SDHCI controllers that found on some of Marvell's SoC's.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>

That's a nice, small driver ;-)

[...]

> +
> +	if (!devm_request_mem_region(&pdev->dev, iomem->start,
> +				     resource_size(iomem),
> +				     mmc_hostname(host->mmc))) {
> +		dev_err(&pdev->dev, "cannot request region\n");
> +		ret = -EBUSY;
> +		goto err_request;
> +	}
> +
> +	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
> +				    resource_size(iomem));
> +	if (!host->ioaddr) {
> +		dev_err(&pdev->dev, "failed to remap registers\n");
> +		ret = -ENOMEM;
> +		goto err_request;
> +	}

If you fail to remap the registers shouldn't you release the mem_region
you've allocated above?

> +
> +#if defined(CONFIG_HAVE_CLK)
> +	mv_host->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(mv_host->clk))
> +		dev_notice(&pdev->dev, "cannot get clkdev\n");
> +	else
> +		clk_enable(mv_host->clk);
> +#endif
> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err_request;

Likewise here, I think you should be iounmap()'ing the registers if this
fails. Otherwise this looks good.
