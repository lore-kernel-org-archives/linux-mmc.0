From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2 1/7] mmc: sdhci: make sdhci-pltfm device drivers
 self registered
Date: Thu, 5 May 2011 18:24:31 +0400
Message-ID: <20110505142431.GA12444@oksana.dev.rtsoft.ru>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51457 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab1EEOYg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 10:24:36 -0400
Received: by eyx24 with SMTP id 24so688922eyx.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 May 2011 07:24:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304601778-13837-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

On Thu, May 05, 2011 at 09:22:52PM +0800, Shawn Guo wrote:
[...]
> +static int __devinit sdhci_cns3xxx_probe(struct platform_device *pdev)
> +{
> +	return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata);
> +}
> +
> +static int __devexit sdhci_cns3xxx_remove(struct platform_device *pdev)
> +{
> +	return sdhci_pltfm_unregister(pdev);
> +}
> +
> +static struct platform_driver sdhci_cns3xxx_driver = {
> +	.driver		= {
> +		.name	= "sdhci-cns3xxx",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= sdhci_cns3xxx_probe,
> +	.remove		= __devexit_p(sdhci_cns3xxx_remove),
> +#ifdef CONFIG_PM
> +	.suspend	= sdhci_pltfm_suspend,
> +	.resume		= sdhci_pltfm_resume,
> +#endif
> +};
> +
> +static int __init sdhci_cns3xxx_init(void)
> +{
> +	return platform_driver_register(&sdhci_cns3xxx_driver);
> +}
> +module_init(sdhci_cns3xxx_init);
> +
> +static void __exit sdhci_cns3xxx_exit(void)
> +{
> +	platform_driver_unregister(&sdhci_cns3xxx_driver);
> +}
> +module_exit(sdhci_cns3xxx_exit);

I don't think I like this duplicate code for each platform sub-
driver. It's repetitive and annoying. :-/

But considering that ARM will be multiplatform soon, we don't
want to have every mach-* stuff in the single sdhci-pltfm.

So... OK. If that compiles, I'm fine with it. :-D

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
