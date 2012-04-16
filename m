From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH V4]mmc: remove MMC bus legacy suspend/resume method
Date: Mon, 16 Apr 2012 05:46:32 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33E9D0E0F@DBDE01.ent.ti.com>
References: <20120411115438.GA303@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59414 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab2DPFqz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Apr 2012 01:46:55 -0400
In-Reply-To: <20120411115438.GA303@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "ulf.hansson@stericsson.com" <ulf.hansson@stericsson.com>

On Wed, Apr 11, 2012 at 17:24:38, Chuanxiao Dong wrote:
> MMC bus is using legacy suspend/resume method, which is not compatible if
> runtime pm callbacks are used. In this scenario, MMC bus suspend/resume
> callbacks cannot be called when system entering S3. So change to use the new
> defined dev_pm_ops for system sleeping mode
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> Changes in v2:
> 	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
> 	suggested
> 
> Changes in v3:
> 	remove NULL pointer define for runtime callbacks when PM_RUNTIME is not
> 	selected, as Ulf Hansson suggested
> 
> Changes in v4:
> 	fix the warning when disable CONFIG_PM_RUNTIME


Tested on AM335x Platform. Solves major issue/crash reported at 
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg65425.html

Tested-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>

> 
>  drivers/mmc/card/block.c |    2 +-
>  drivers/mmc/core/bus.c   |   24 ++++++++----------------
>  include/linux/mmc/card.h |    2 +-
>  3 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index f2020d3..3582c03 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1826,7 +1826,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>  }
>  
>  #ifdef CONFIG_PM
> -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
> +static int mmc_blk_suspend(struct mmc_card *card)
>  {
>  	struct mmc_blk_data *part_md;
>  	struct mmc_blk_data *md = mmc_get_drvdata(card);
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 5d011a3..aad8516 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -122,14 +122,14 @@ static int mmc_bus_remove(struct device *dev)
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
> @@ -165,20 +165,14 @@ static int mmc_runtime_idle(struct device *dev)
>  	return pm_runtime_suspend(dev);
>  }
>  
> +#endif /* !CONFIG_PM_RUNTIME */
> +
>  static const struct dev_pm_ops mmc_bus_pm_ops = {
> -	.runtime_suspend	= mmc_runtime_suspend,
> -	.runtime_resume		= mmc_runtime_resume,
> -	.runtime_idle		= mmc_runtime_idle,
> +	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume,
> +			mmc_runtime_idle)
> +	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
>  };
>  
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
> @@ -186,9 +180,7 @@ static struct bus_type mmc_bus_type = {
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
> index 1a1ca71..c984c9a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -480,7 +480,7 @@ struct mmc_driver {
>  	struct device_driver drv;
>  	int (*probe)(struct mmc_card *);
>  	void (*remove)(struct mmc_card *);
> -	int (*suspend)(struct mmc_card *, pm_message_t);
> +	int (*suspend)(struct mmc_card *);
>  	int (*resume)(struct mmc_card *);
>  };
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Regards, 
Gururaja
