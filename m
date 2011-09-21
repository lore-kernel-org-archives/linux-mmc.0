From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v2 1/2] mmc: sdhci-s3c: add default controller configuration
Date: Wed, 21 Sep 2011 19:56:16 +0900
Message-ID: <002501cc784d$1618f110$424ad330$%kim@samsung.com>
References: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
 <1315984158-29651-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1315984158-29651-2-git-send-email-thomas.abraham@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Thomas Abraham wrote:
> 
> The default controller configuration which was previously setup by
> platform helper functions is moved into the driver.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Hi Chris,

This is ok to me. Could you please pick this up in your tree so that I can
pick 2nd patch up in my tree.

As you know, this patch has no dependency with patch2/2 so that you can
handle without any conflicts.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/mmc/host/sdhci-s3c.c |   28 +++++++++++++++++-----------
>  1 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 2bd7bf4..d891682 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -203,17 +203,23 @@ static void sdhci_s3c_set_clock(struct sdhci_host
*host,
> unsigned int clock)
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
> -			(ourhost->pdata->cfg_card)(ourhost->pdev, host-
> >ioaddr,
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
> +		ctrl |= (S3C_SDHCI_CTRL3_FCSEL3 |
> S3C_SDHCI_CTRL3_FCSEL2);
> +	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL3);
>  }
> 
>  /**
> --
> 1.6.6.rc2
