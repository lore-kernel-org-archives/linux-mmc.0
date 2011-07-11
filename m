From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH]mmc: remove MMC bus legacy suspend/resume method
Date: Mon, 11 Jul 2011 10:45:43 +0200
Message-ID: <201107111045.43634.rjw@sisk.pl>
References: <20110711061726.GA19185@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44603 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414Ab1GKIpA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jul 2011 04:45:00 -0400
In-Reply-To: <20110711061726.GA19185@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Monday, July 11, 2011, Chuanxiao Dong wrote:
> MMC bus suspend/resume was using legacy method. In system entering
> S3 patch, the suspend/resume function cannot be called since MMC
> bus also implemented the new suspend/resume method (dev_pm_ops struct).
> So if dev_pm_ops is defined but .suspend/.resume callbacks not implemented,
> mmc_queue will not be suspended/resumed.
> 
> This patch will remove the legacy suspend/resume method and change to
> use the new method totally.
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/card/block.c |    2 +-
>  drivers/mmc/core/bus.c   |   24 +++++++++++-------------
>  include/linux/mmc/card.h |    2 +-
>  3 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 38d0149..224f1bb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1549,7 +1549,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>  }
>  
>  #ifdef CONFIG_PM
> -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
> +static int mmc_blk_suspend(struct mmc_card *card)
>  {
>  	struct mmc_blk_data *part_md;
>  	struct mmc_blk_data *md = mmc_get_drvdata(card);
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 393d817..03be6d0 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -120,14 +120,14 @@ static int mmc_bus_remove(struct device *dev)
>  	return 0;
>  }
>  
> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
> +static int mmc_bus_suspend(struct device *dev)
>  {
>  	struct mmc_driver *drv = to_mmc_driver(dev->driver);
>  	struct mmc_card *card = mmc_dev_to_card(dev);
>  	int ret = 0;
>  
>  	if (dev->driver && drv->suspend)
> -		ret = drv->suspend(card, state);
> +		ret = drv->suspend(card);
>  	return ret;
>  }
>  
> @@ -163,20 +163,20 @@ static int mmc_runtime_idle(struct device *dev)
>  	return pm_runtime_suspend(dev);
>  }
>  
> +#else /* !CONFIG_PM_RUNTIME */
> +#define mmc_runtime_suspend	NULL
> +#define mmc_runtime_resume	NULL
> +#define mmc_runtime_idle	NULL
> +#endif /* !CONFIG_PM_RUNTIME */
> +
>  static const struct dev_pm_ops mmc_bus_pm_ops = {
>  	.runtime_suspend	= mmc_runtime_suspend,
>  	.runtime_resume		= mmc_runtime_resume,
>  	.runtime_idle		= mmc_runtime_idle,
> +	.suspend		= mmc_bus_suspend,
> +	.resume			= mmc_bus_resume,
>  };

Please define hibernate callbacks too, for example by using the
SIMPLE_DEV_PM_OPS() convenience macro, defined in include/linux/pm.h.

Thanks,
Rafael


> -#define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
> -
> -#else /* !CONFIG_PM_RUNTIME */
> -
> -#define MMC_PM_OPS_PTR	NULL
> -
> -#endif /* !CONFIG_PM_RUNTIME */
> -
>  static struct bus_type mmc_bus_type = {
>  	.name		= "mmc",
>  	.dev_attrs	= mmc_dev_attrs,
> @@ -184,9 +184,7 @@ static struct bus_type mmc_bus_type = {
>  	.uevent		= mmc_bus_uevent,
>  	.probe		= mmc_bus_probe,
>  	.remove		= mmc_bus_remove,
> -	.suspend	= mmc_bus_suspend,
> -	.resume		= mmc_bus_resume,
> -	.pm		= MMC_PM_OPS_PTR,
> +	.pm		= &mmc_bus_pm_ops,
>  };
>  
>  int mmc_register_bus(void)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b460fc2..978f395 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -393,7 +393,7 @@ struct mmc_driver {
>  	struct device_driver drv;
>  	int (*probe)(struct mmc_card *);
>  	void (*remove)(struct mmc_card *);
> -	int (*suspend)(struct mmc_card *, pm_message_t);
> +	int (*suspend)(struct mmc_card *);
>  	int (*resume)(struct mmc_card *);
>  };
>  
> 

