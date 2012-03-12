From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] drivers: mmc: sdhci-s3c: fix broken compilation for
 non-Exynos SoCs
Date: Mon, 12 Mar 2012 09:12:05 +0900
Message-ID: <4F5D3F55.10102@samsung.com>
References: <1331300667-22566-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27310 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2CLAMT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Mar 2012 20:12:19 -0400
In-reply-to: <1331300667-22566-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>

Looks fine to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 03/09/2012 10:44 PM, Marek Szyprowski wrote:

> exynos4_sdhci_drv_data structure is not available on non-Exynos builds,
> that's why EXYNOS4_SDHCI_DRV_DATA macro has been introduced. This patch
> fixes commit 67819656 'mmc: sdhci-s3c: Add device tree support' to use
> that macro. This fixes broken build for pre-Exynos SoCs.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index ea0767e..984601e 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -859,7 +859,7 @@ MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
>  static const struct of_device_id sdhci_s3c_dt_match[] = {
>  	{ .compatible = "samsung,s3c6410-sdhci", },
>  	{ .compatible = "samsung,exynos4210-sdhci",
> -		.data = &exynos4_sdhci_drv_data },
> +		.data = EXYNOS4_SDHCI_DRV_DATA },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);


