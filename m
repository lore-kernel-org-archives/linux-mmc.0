From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-s3c: add default controller configuration
Date: Mon, 05 Sep 2011 10:31:09 +0900
Message-ID: <4E64265D.9090206@samsung.com>
References: <1314976702-19284-1-git-send-email-thomas.abraham@linaro.org>
 <1314976702-19284-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13010 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1IEBar (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Sep 2011 21:30:47 -0400
In-reply-to: <1314976702-19284-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

Hi Thomas.

I have some question. This patch looks good.
Some names are used S3C_SDHCI_xxxx. but some names are used S3C64XX_SDHCI_xxxx.
Do you know what differ them?

Thanks,
Jaehoon Chung

Thomas Abraham wrote:

> The default controller configuration which was previously setup by
> platform helper functions is moved into the driver.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   28 +++++++++++++++++-----------
>  1 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 2bd7bf4..d891682 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -203,17 +203,23 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>  		writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
>  	}
>  
> -	/* reconfigure the hardware for new clock rate */
> -
> -	{
> -		struct mmc_ios ios;
> -
> -		ios.clock = clock;
> -
> -		if (ourhost->pdata->cfg_card)
> -			(ourhost->pdata->cfg_card)(ourhost->pdev, host->ioaddr,
> -						   &ios, NULL);
> -	}
> +	/* reprogram default hardware configuration */
> +	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA,
> +		host->ioaddr + S3C64XX_SDHCI_CONTROL4);
> +
> +	ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
> +	ctrl |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> +		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> +		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> +		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> +		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> +	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
> +
> +	/* reconfigure the controller for new clock rate */
> +	ctrl = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
> +	if (clock < 25 * 1000000)
> +		ctrl |= (S3C_SDHCI_CTRL3_FCSEL3 | S3C_SDHCI_CTRL3_FCSEL2);
> +	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL3);
>  }
>  
>  /**


