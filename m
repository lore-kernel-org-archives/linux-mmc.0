From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V3]mmc: remove MMC bus legacy suspend/resume method
Date: Tue, 10 Apr 2012 16:32:52 +0200
Message-ID: <4F844494.9070109@stericsson.com>
References: <20120410140721.GA15362@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:58408 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754471Ab2DJOd4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Apr 2012 10:33:56 -0400
In-Reply-To: <20120410140721.GA15362@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "cjb@laptop.org" <cjb@laptop.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "rjw@sisk.pl" <rjw@sisk.pl>

On 04/10/2012 04:07 PM, Chuanxiao Dong wrote:
> MMC bus is using legacy suspend/resume method, which is not compatible if
> runtime pm callbacks are used. In this scenario, MMC bus suspend/resume
> callbacks cannot be called when system entering S3. So change to use the new
> defined dev_pm_ops for system sleeping mode
>
> Signed-off-by: Chuanxiao Dong<chuanxiao.dong@intel.com>
> ---
> Changes in v2:
> 	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
> 	suggested
>
> Changes in v3:
> 	remove NULL pointer define for runtime callbacks when PM_RUNTIME is not
> 	selected, as Ulf Hansson suggested
>
>   drivers/mmc/card/block.c |    2 +-
>   drivers/mmc/core/bus.c   |   24 ++++++------------------
>   include/linux/mmc/card.h |    2 +-
>   3 files changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index f2020d3..3582c03 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1826,7 +1826,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>   }
>
>   #ifdef CONFIG_PM
> -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
> +static int mmc_blk_suspend(struct mmc_card *card)
>   {
>   	struct mmc_blk_data *part_md;
>   	struct mmc_blk_data *md = mmc_get_drvdata(card);
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 5d011a3..1996c9b 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -122,14 +122,14 @@ static int mmc_bus_remove(struct device *dev)
>   	return 0;
>   }
>
> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
> +static int mmc_bus_suspend(struct device *dev)
>   {
>   	struct mmc_driver *drv = to_mmc_driver(dev->driver);
>   	struct mmc_card *card = mmc_dev_to_card(dev);
>   	int ret = 0;
>
>   	if (dev->driver&&  drv->suspend)
> -		ret = drv->suspend(card, state);
> +		ret = drv->suspend(card);
>   	return ret;
>   }
>
> @@ -144,8 +144,6 @@ static int mmc_bus_resume(struct device *dev)
>   	return ret;
>   }
>
> -#ifdef CONFIG_PM_RUNTIME

I don't think this "idfef" shall removed. Won't that trigger compiler 
warnings when !CONFIG_PM_RUNTIME?

Just remove these three lines from patch v2...

+#define mmc_runtime_suspend	NULL
+#define mmc_runtime_resume	NULL
+#define mmc_runtime_idle	NULL

...and thus the "else" to the CONFIG_PM_RUNTIME, as done below.

> -
>   static int mmc_runtime_suspend(struct device *dev)
>   {
>   	struct mmc_card *card = mmc_dev_to_card(dev);
> @@ -166,19 +164,11 @@ static int mmc_runtime_idle(struct device *dev)
>   }
>
>   static const struct dev_pm_ops mmc_bus_pm_ops = {
> -	.runtime_suspend	= mmc_runtime_suspend,
> -	.runtime_resume		= mmc_runtime_resume,
> -	.runtime_idle		= mmc_runtime_idle,
> +	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume,
> +			mmc_runtime_idle)
> +	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
>   };
>
> -#define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
> -
> -#else /* !CONFIG_PM_RUNTIME */
> -
> -#define MMC_PM_OPS_PTR	NULL
> -
> -#endif /* !CONFIG_PM_RUNTIME */
> -
>   static struct bus_type mmc_bus_type = {
>   	.name		= "mmc",
>   	.dev_attrs	= mmc_dev_attrs,
> @@ -186,9 +176,7 @@ static struct bus_type mmc_bus_type = {
>   	.uevent		= mmc_bus_uevent,
>   	.probe		= mmc_bus_probe,
>   	.remove		= mmc_bus_remove,
> -	.suspend	= mmc_bus_suspend,
> -	.resume		= mmc_bus_resume,
> -	.pm		= MMC_PM_OPS_PTR,
> +	.pm		=&mmc_bus_pm_ops,
>   };
>
>   int mmc_register_bus(void)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 1a1ca71..c984c9a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -480,7 +480,7 @@ struct mmc_driver {
>   	struct device_driver drv;
>   	int (*probe)(struct mmc_card *);
>   	void (*remove)(struct mmc_card *);
> -	int (*suspend)(struct mmc_card *, pm_message_t);
> +	int (*suspend)(struct mmc_card *);
>   	int (*resume)(struct mmc_card *);
>   };
>

Kind regards
Ulf Hansson
