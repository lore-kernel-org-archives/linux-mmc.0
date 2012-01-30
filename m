From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Mon, 30 Jan 2012 10:51:11 +0100
Message-ID: <201201301051.22396.heiko@sntech.de>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org> <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:43210 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2A3Jvo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2012 04:51:44 -0500
In-Reply-To: <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org

Am Mittwoch, 2. November 2011, 21:36:03 schrieb Thomas Abraham:

Hi Thomas,

in patch 1/6:
> +static struct platform_device_id sdhci_s3c_driver_ids[] = {
> +       {
> +               .name           = "s3c-sdhci",
> +               .driver_data    = (kernel_ulong_t)NULL,
> +       },
> +       {
> +               .name           = "exynos4-sdhci",
> +               .driver_data    = EXYNOS4_SDHCI_DRV_DATA,
> +       },
> +};
> +MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);


and in patch 6/6:
> +#ifdef CONFIG_OF
> +static const struct of_device_id sdhci_s3c_dt_match[] = {
> +	{ .compatible = "samsung,s3c6410-sdhci", },
> +	{ .compatible = "samsung,exynos4210-sdhci",
> +		.data = &exynos4_sdhci_drv_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);

wouldn't it be better to keep the naming consistent between of and non-of?
I.e. s3c-sdhci vs. s3c6410-sdhci. Since the driver is used for all S3C SoCs 
containing hsmmc controllers I think s3c-sdhci would be preferable here.

Heiko
