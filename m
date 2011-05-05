From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4] mmc: add runtime and system power-management support to the MMCIF driver
Date: Thu, 5 May 2011 23:50:33 +0200
Message-ID: <201105052350.33332.rjw@sisk.pl>
References: <Pine.LNX.4.64.1105051813270.29735@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105051813270.29735@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Thursday, May 05, 2011, Guennadi Liakhovetski wrote:
> Adding support for runtime power-management to the MMCIF driver allows
> it to save power as long as no card is present. To also allow to turn
> off the power domain at that time, we release DMA channels during that
> time, since on some sh-mobile systems the DMA controller(s) and the
> MMCIF block belong to the same power domain. System-wide power
> management has been tested with experimental PM patches on AP4-based
> systems.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> This patch supersedes:
> 
> [PATCH 2/3 v3] MMC: add runtime and system power-management support to the MMCIF driver
> 
> and has been tested to work with Rafael's suspend git-tree, power-domains 
> branch.
> 
>  drivers/mmc/host/sh_mmcif.c |   78 ++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 69 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index d3871b6..14f8edb 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -29,6 +29,7 @@
>  #include <linux/mmc/sh_mmcif.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  
>  #define DRIVER_NAME	"sh_mmcif"
> @@ -173,6 +174,7 @@ struct sh_mmcif_host {
>  	struct completion intr_wait;
>  	enum mmcif_state state;
>  	spinlock_t lock;
> +	bool power;
>  
>  	/* DMA support */
>  	struct dma_chan		*chan_rx;
> @@ -877,11 +879,24 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (ios->power_mode == MMC_POWER_UP) {
>  		if (p->set_pwr)
>  			p->set_pwr(host->pd, ios->power_mode);
> +		if (!host->power) {
> +			/* See if we also get DMA */
> +			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
> +			pm_runtime_get_sync(&host->pd->dev);
> +			host->power = true;
> +		}
>  	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
>  		/* clock stop */
>  		sh_mmcif_clock_control(host, 0);
> -		if (ios->power_mode == MMC_POWER_OFF && p->down_pwr)
> -			p->down_pwr(host->pd);
> +		if (ios->power_mode == MMC_POWER_OFF) {
> +			if (host->power) {
> +				pm_runtime_put(&host->pd->dev);
> +				sh_mmcif_release_dma(host);
> +				host->power = false;
> +			}
> +			if (p->down_pwr)
> +				p->down_pwr(host->pd);
> +		}
>  		host->state = STATE_IDLE;
>  		return;
>  	}
> @@ -957,7 +972,7 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
>  		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
>  		err = 1;
>  	} else {
> -		dev_dbg(&host->pd->dev, "Not support int\n");
> +		dev_dbg(&host->pd->dev, "Unsupported interrupt: 0x%x\n", state);
>  		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
>  		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
>  		err = 1;
> @@ -1053,8 +1068,12 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>  	sh_mmcif_sync_reset(host);
>  	platform_set_drvdata(pdev, host);
>  
> -	/* See if we also get DMA */
> -	sh_mmcif_request_dma(host, pd);
> +	pm_runtime_enable(&pdev->dev);
> +	host->power = false;
> +
> +	ret = pm_runtime_resume(&pdev->dev);
> +	if (ret < 0)
> +		goto clean_up2;
>  
>  	mmc_add_host(mmc);
>  
> @@ -1063,13 +1082,13 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>  	ret = request_irq(irq[0], sh_mmcif_intr, 0, "sh_mmc:error", host);
>  	if (ret) {
>  		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
> -		goto clean_up2;
> +		goto clean_up3;
>  	}
>  	ret = request_irq(irq[1], sh_mmcif_intr, 0, "sh_mmc:int", host);
>  	if (ret) {
>  		free_irq(irq[0], host);
>  		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
> -		goto clean_up2;
> +		goto clean_up3;
>  	}
>  
>  	sh_mmcif_detect(host->mmc);
> @@ -1079,7 +1098,11 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>  		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
>  	return ret;
>  
> +clean_up3:
> +	mmc_remove_host(mmc);
> +	pm_runtime_suspend(&pdev->dev);
>  clean_up2:
> +	pm_runtime_disable(&pdev->dev);
>  	clk_disable(host->hclk);
>  clean_up1:
>  	mmc_free_host(mmc);
> @@ -1094,9 +1117,9 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
>  	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
>  	int irq[2];
>  
> -	mmc_remove_host(host->mmc);
> -	sh_mmcif_release_dma(host);
> +	pm_runtime_get_sync(&pdev->dev);
>  
> +	mmc_remove_host(host->mmc);
>  	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
>  
>  	if (host->addr)
> @@ -1112,15 +1135,52 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
>  
>  	clk_disable(host->hclk);
>  	mmc_free_host(host->mmc);
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int sh_mmcif_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
> +	int ret = mmc_suspend_host(host->mmc);
> +
> +	if (!ret) {
> +		sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
> +		clk_disable(host->hclk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sh_mmcif_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
> +
> +	clk_enable(host->hclk);
> +
> +	return mmc_resume_host(host->mmc);
> +}
> +#else
> +#define sh_mmcif_suspend	NULL
> +#define sh_mmcif_resume		NULL
> +#endif	/* CONFIG_PM */
> +
> +static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
> +	.suspend = sh_mmcif_suspend,
> +	.resume = sh_mmcif_resume,
> +};

So this means the driver only has system-wide suspend/resume callbacks.
I guess hibernation is not supported by the target platform(s) yet, so
the freeze/thaw etc. callbacks are not necessary at the moment, but in case
they are supposed to be the same as the suspend/resume ones, it wouldn't
hurt to use SET_SYSTEM_SLEEP_PM_OPS (as defined in include/linux/pm.h).

Also, runtime PM callbacks are not present.  Is it intentional?  I thought
they would be necessary to save/restore the device state over the power
domain power down/power up, wouldn't they?

> +
>  static struct platform_driver sh_mmcif_driver = {
>  	.probe		= sh_mmcif_probe,
>  	.remove		= sh_mmcif_remove,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
> +		.pm	= &sh_mmcif_dev_pm_ops,
>  	},
>  };

Thanks,
Rafael
