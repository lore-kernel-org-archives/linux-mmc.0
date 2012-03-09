From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] drivers: mmc: sdhci-s3c: fix broken compilation for non-Exynos
 SoCs
Date: Fri, 09 Mar 2012 07:56:08 -0800
Message-ID: <4F5A2818.4090104@samsung.com>
References: <1331300667-22566-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1331300667-22566-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 03/09/12 05:44, Marek Szyprowski wrote:
> exynos4_sdhci_drv_data structure is not available on non-Exynos builds,
> that's why EXYNOS4_SDHCI_DRV_DATA macro has been introduced. This patch
> fixes commit 67819656 'mmc: sdhci-s3c: Add device tree support' to use
> that macro. This fixes broken build for pre-Exynos SoCs.
>
I think, it is protected by CONFIG_OF and the pre-EXYNOS SoCs is not 
support device tree yet. Could you please let me know the build error 
and build condition?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> ---
>   drivers/mmc/host/sdhci-s3c.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index ea0767e..984601e 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -859,7 +859,7 @@ MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
>   static const struct of_device_id sdhci_s3c_dt_match[] = {
>   	{ .compatible = "samsung,s3c6410-sdhci", },
>   	{ .compatible = "samsung,exynos4210-sdhci",
> -		.data =&exynos4_sdhci_drv_data },
> +		.data = EXYNOS4_SDHCI_DRV_DATA },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
