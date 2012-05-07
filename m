From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 03/10] mmc: mxs-mmc: get rid of the use of cpu_is_xxx
Date: Tue, 8 May 2012 01:46:44 +0200
Message-ID: <201205080146.45090.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org> <1336401793-13753-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:42422 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806Ab2EGX6c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 19:58:32 -0400
In-Reply-To: <1336401793-13753-4-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

Dear Shawn Guo,

> The register HW_SSP_VERSION is broken for ssp version detection,
> as the address of the register is different between imx23 and imx28.
> Let's use platform_device_id to detect the device, so that the use
> of cpu_is_xxx can be removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

[...]

> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 13907e4..54bbb8b 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -42,7 +42,6 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/stmp_device.h>
> 
> -#include <mach/mxs.h>
>  #include <mach/mmc.h>
> 
>  #define DRIVER_NAME	"mxs-mmc"
> @@ -50,8 +49,7 @@
>  /* card detect polling timeout */
>  #define MXS_MMC_DETECT_TIMEOUT			(HZ/2)
> 
> -#define SSP_VERSION_LATEST	4
> -#define ssp_is_old(host)	(host->version < SSP_VERSION_LATEST)
> +#define ssp_is_old(host)	(host->devid == IMX23_MMC)

(host)->devid ...

> 
>  /* SSP registers */
>  #define HW_SSP_CTRL0				0x000
> @@ -123,8 +121,6 @@
>  #define HW_SSP_STATUS(h)			(ssp_is_old(h) ? 0x0c0 : 0x100)
>  #define  BM_SSP_STATUS_CARD_DETECT		(1 << 28)
>  #define  BM_SSP_STATUS_SDIO_IRQ			(1 << 17)
> -#define HW_SSP_VERSION				(cpu_is_mx23() ? 0x110 : 
0x130)
> -#define  BP_SSP_VERSION_MAJOR			(24)
> 
>  #define BF_SSP(value, field)	(((value) << BP_SSP_##field) &
> BM_SSP_##field)
> 
> @@ -139,6 +135,11 @@
> 
>  #define SSP_PIO_NUM	3
> 
> +enum mxs_mmc_id {
> +	IMX23_MMC,
> +	IMX28_MMC,
> +};
> +
>  struct mxs_mmc_host {
>  	struct mmc_host			*mmc;
>  	struct mmc_request		*mrq;
> @@ -158,7 +159,7 @@ struct mxs_mmc_host {
>  	enum dma_transfer_direction	slave_dirn;
>  	u32				ssp_pio_words[SSP_PIO_NUM];
> 
> -	unsigned int			version;
> +	enum mxs_mmc_id			devid;
>  	unsigned char			bus_width;
>  	spinlock_t			lock;
>  	int				sdio_irq_en;
> @@ -678,6 +679,19 @@ static bool mxs_mmc_dma_filter(struct dma_chan *chan,
> void *param) return true;
>  }
> 
> +static struct platform_device_id mxs_mmc_ids[] = {
> +	{
> +		.name = "imx23-mmc",
> +		.driver_data = IMX23_MMC,
> +	}, {
> +		.name = "imx28-mmc",
> +		.driver_data = IMX28_MMC,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, mxs_mmc_ids);
> +
>  static int mxs_mmc_probe(struct platform_device *pdev)
>  {
>  	struct mxs_mmc_host *host;
> @@ -712,10 +726,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  		goto out_mmc_free;
>  	}
> 
> -	/* only major verion does matter */
> -	host->version = readl(host->base + HW_SSP_VERSION) >>
> -			BP_SSP_VERSION_MAJOR;
> -
> +	host->devid = pdev->id_entry->driver_data;
>  	host->mmc = mmc;
>  	host->res = r;
>  	host->dma_res = dmares;
> @@ -866,6 +877,7 @@ static const struct dev_pm_ops mxs_mmc_pm_ops = {
>  static struct platform_driver mxs_mmc_driver = {
>  	.probe		= mxs_mmc_probe,
>  	.remove		= mxs_mmc_remove,
> +	.id_table	= mxs_mmc_ids,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
>  		.owner	= THIS_MODULE,
