From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/2] mmc: sdhci-s3c: Add pm_caps into SD/MMC host
Date: Thu, 01 Dec 2011 16:30:28 +0900
Message-ID: <046001ccaffb$1988f580$4c9ae080$%kim@samsung.com>
References: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
 <1320685522-17481-3-git-send-email-sangwook.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1320685522-17481-3-git-send-email-sangwook.lee@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sangwook Lee' <sangwook.lee@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, ben-linux@fluff.org, linaro-dev@lists.linaro.org, patches@linaro.org, 'Sangwook Lee' <sangwook.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Sangwook Lee wrote:
> 
> sdhci-s3c updates pm_caps from platform data for SDIO PM.
> 
> Signed-off-by: Sangwook Lee <sangwook.lee@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Hi Chris,

Could you please pick this up in your tree for v3.3?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/mmc/host/sdhci-s3c.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index fe886d6..f10dd52 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -518,6 +518,9 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
>  	if (pdata->host_caps)
>  		host->mmc->caps |= pdata->host_caps;
> 
> +	if (pdata->pm_caps)
> +		host->mmc->pm_caps |= pdata->pm_caps;
> +
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
> 
> --
> 1.7.4.1
