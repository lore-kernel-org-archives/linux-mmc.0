From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/5] sdhci-s3c: depend on plat-samsung
Date: Fri, 11 Jun 2010 09:29:38 +0900
Message-ID: <000701cb08fd$2f8e15a0$8eaa40e0$%kim@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
 <1276076383-24825-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1276076383-24825-2-git-send-email-m.szyprowski@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Marek Szyprowski wrote:
> 
> Most Samsung SoC have support for SDHCI block, so make the driver
> dependent on the Samsung platform instead on listing all SoCs in the
> Kconfig (and updating it again when support for the new SoC variant is
> added).
> 
Hi, Marek

Kyungmin Park already submitted same patch.

And Andrew Morton added to the -mm tree.
http://www.spinics.net/lists/mm-commits/msg79159.html

But, I think your comment is better...

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e171e77..acf5bf6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -123,7 +123,7 @@ config MMC_SDHCI_PLTFM
> 
>  config MMC_SDHCI_S3C
>  	tristate "SDHCI support on Samsung S3C SoC"
> -	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
> +	depends on MMC_SDHCI && PLAT_SAMSUNG
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  often referrered to as the HSMMC block in some of the Samsung S3C
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
