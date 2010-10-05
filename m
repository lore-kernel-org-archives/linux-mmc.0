From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH V2 1/1]MMC: add support of sdhci-pxa driver
Date: Tue, 5 Oct 2010 10:03:14 +0100
Message-ID: <20101005090314.GD22830@console-pimps.org>
References: <AANLkTikK0oEwLEXaf_Q5XWi3nxoq8WKCzKiF87E_Z3k+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:55811 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429Ab0JEJDP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2010 05:03:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikK0oEwLEXaf_Q5XWi3nxoq8WKCzKiF87E_Z3k+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, kmpark@infradead.org, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc@vger.kernel.org

On Tue, Sep 28, 2010 at 11:23:35PM -0400, zhangfei gao wrote:
> +
> +	pxa->clk = clk_get(dev, "PXA-SDHCLK");
> +	if (IS_ERR(pxa->clk)) {
> +		dev_err(dev, "failed to get io clock\n");
> +		ret = PTR_ERR(pxa->clk);
> +		goto out;
> +	}
> +
> +	pxa->res = request_mem_region(iomem->start, resource_size(iomem),
> +		mmc_hostname(host->mmc));
> +	if (!pxa->res) {
> +		dev_err(&pdev->dev, "cannot request region\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
> +	if (!host->ioaddr) {
> +		dev_err(&pdev->dev, "failed to remap registers\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	host->hw_name = "MMC";
> +	host->ops = &sdhci_pxa_ops;
> +	host->irq = irq;
> +	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +
> +	if (pdata->pxa_quirk & PXA_QUIRK_BROKEN_CARD_DETECTION)
> +		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;

I don't think there's a good reason to define
PXA_QUIRK_BROKEN_CARD_DETECTION because its only use is to turn on
SDHCI_QUIRK_BROKEN_CARD_DETECTION. As Eric pointed out, you should
just use SDHCI_QUIRK_BROKEN_CARD_DETECTION directly. While adding new
sdhci quirks should be avoided, using the existing ones is fine :-)

> +
> +	ret = sdhci_add_host(host);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add host\n");
> +		goto out;
> +	}
> +
> +	if (pxa->pdata->max_speed)
> +		host->mmc->f_max = pxa->pdata->max_speed;
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	return 0;
> +out:
> +	if (host) {
> +		if (host->ioaddr)
> +			iounmap(host->ioaddr);
> +		if (pxa->res)
> +			release_mem_region(pxa->res->start,
> +					resource_size(pxa->res));
> +		sdhci_free_host(host);
> +	}

Aren't you missing a clk_put() here?
