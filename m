From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 3/5] sdhci-s3c: increase the timeout value
Date: Thu, 10 Jun 2010 19:46:13 +0900
Message-ID: <019301cb088a$29134970$7b39dc50$%kim@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
 <1276076383-24825-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1276076383-24825-4-git-send-email-m.szyprowski@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Marek Szyprowski wrote:
> 
> This patch increases the timeout value on sdhci-s3c controller by using
> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL quirk. Without it most transfers from
> external mmc cards fails on Samsung s5pv210 SoCs based systems. Tested
> on Samsung Aquila board.
> 

Hi,

Seems to use max timeout value, 0xE.
However, should be use SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK.
Because basically, Samsung MMC used sdclock as timeout clock.

Please refer to below URL:
http://article.gmane.org/gmane.linux.kernel.mmc/304

And new patch with SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK will be submitted.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index ad30f07..2b6cb44 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -331,6 +331,7 @@ static int __devinit sdhci_s3c_probe(struct
platform_device
> *pdev)
>  	 * transfers, not sure if this is a problem with this specific
>  	 * SDHCI block, or a missing configuration that needs to be set. */
>  	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
> +	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> 
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
