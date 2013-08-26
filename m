From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc:tmio_mmc change driver to use dev_pm_ops infrastructure
Date: Mon, 26 Aug 2013 10:48:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1308261043010.1767@axis700.grange>
References: <1376148055-2539-1-git-send-email-shuah.kh@samsung.com>
 <1376148055-2539-10-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376148055-2539-10-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: ian@mnementh.co.uk, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hi Shuah Khan,

On Sat, 10 Aug 2013, Shuah Khan wrote:

> Change tmio_mmc platform driver to register pm ops using dev_pm_ops instead of
> legacy pm_ops infrastructure.
> 
> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>

This looks good to me, although I don't have access to any MFD-based TMIO 
MMC systems, so, cannot test. In fact that code hasn't been touched for a 
while now, so, I don't even know if anyone is still using it. With that in 
mind

Acked-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks
Guennadi

> ---
>  drivers/mmc/host/tmio_mmc.c |   24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 8860d4d..3e3c730 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -24,31 +24,33 @@
>  #include "tmio_mmc.h"
>  
>  #ifdef CONFIG_PM
> -static int tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
> +static int tmio_mmc_suspend(struct device *dev)
>  {
> -	const struct mfd_cell *cell = mfd_get_cell(dev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);
>  	int ret;
>  
> -	ret = tmio_mmc_host_suspend(&dev->dev);
> +	ret = tmio_mmc_host_suspend(dev);
>  
>  	/* Tell MFD core it can disable us now.*/
>  	if (!ret && cell->disable)
> -		cell->disable(dev);
> +		cell->disable(pdev);
>  
>  	return ret;
>  }
>  
> -static int tmio_mmc_resume(struct platform_device *dev)
> +static int tmio_mmc_resume(struct device *dev)
>  {
> -	const struct mfd_cell *cell = mfd_get_cell(dev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);
>  	int ret = 0;
>  
>  	/* Tell the MFD core we are ready to be enabled */
>  	if (cell->resume)
> -		ret = cell->resume(dev);
> +		ret = cell->resume(pdev);
>  
>  	if (!ret)
> -		ret = tmio_mmc_host_resume(&dev->dev);
> +		ret = tmio_mmc_host_resume(dev);
>  
>  	return ret;
>  }
> @@ -123,17 +125,19 @@ static int tmio_mmc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static SIMPLE_DEV_PM_OPS(tmio_mmc_dev_pm_ops, tmio_mmc_suspend,
> +			  tmio_mmc_resume);
> +
>  /* ------------------- device registration ----------------------- */
>  
>  static struct platform_driver tmio_mmc_driver = {
>  	.driver = {
>  		.name = "tmio-mmc",
>  		.owner = THIS_MODULE,
> +		.pm = &tmio_mmc_dev_pm_ops,
>  	},
>  	.probe = tmio_mmc_probe,
>  	.remove = tmio_mmc_remove,
> -	.suspend = tmio_mmc_suspend,
> -	.resume = tmio_mmc_resume,
>  };
>  
>  module_platform_driver(tmio_mmc_driver);
> -- 
> 1.7.10.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
