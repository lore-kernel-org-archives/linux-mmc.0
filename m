From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Fri, 17 Aug 2012 10:06:24 +0200
Message-ID: <201208171006.25051.heiko@sntech.de>
References: <1345132169-21066-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1345132169-21066-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

Am Donnerstag, 16. August 2012, 17:49:29 schrieb Thomas Abraham:
> Add device tree based discovery support for Samsung's sdhci controller
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |  146
> ++++++++++++++++++++++++++++++++++++++++-- 1 files changed, 140
> insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index a50c205..7fcc642 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c

[...]

> @@ -737,6 +860,16 @@ static struct platform_device_id
> sdhci_s3c_driver_ids[] = { };
>  MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id sdhci_s3c_dt_match[] = {
> +	{ .compatible = "samsung,s3c6410-sdhci", },
> +	{ .compatible = "samsung,exynos4210-sdhci",
> +		.data = &exynos4_sdhci_drv_data },

Please use the EXYNOS4_SDHCI_DRV_DATA constant here. Otherwise other Samsung 
platforms experimenting with dt will break.


Thanks
Heiko
