From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Revert "mmc: core: Convert mmc_driver to device_driver"
Date: Fri, 17 Apr 2015 07:44:47 +0900
Message-ID: <55303B5F.3070801@samsung.com>
References: <1429012456-29648-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35346 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbDPWou (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 18:44:50 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NMX00KUS8IO3E60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Apr 2015 07:44:48 +0900 (KST)
In-reply-to: <1429012456-29648-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Hi, Ulf.

This revert can be removed the warning message that is displayed at probe time.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 04/14/2015 08:54 PM, Ulf Hansson wrote:
> This reverts commit 6685ac62b2f0 ("mmc: core: Convert mmc_driver to
> device_driver")
> 
> The reverted commit went too far in simplifing the device driver parts
> for mmc.
> 
> Let's restore the old mmc_driver to enable driver core to sooner
> or later to remove the ->probe(), ->remove() and ->shutdown() callbacks
> from the struct device_driver.
> 
> Note that, the old ->suspend|resume() callbacks in the struct
> mmc_driver don't need to be restored, since the mmc block layer has
> converted to the modern system PM ops.
> 
> Fixes: 6685ac62b2f0 ("mmc: core: Convert mmc_driver to device_driver")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/card/block.c    | 34 +++++++++++++++++-----------------
>  drivers/mmc/card/mmc_test.c | 18 +++++++-----------
>  drivers/mmc/core/bus.c      | 41 +++++++++++++++++++++++++++++++++--------
>  include/linux/mmc/card.h    | 14 ++++++++++++--
>  4 files changed, 69 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c69afb5..e192bf1 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2418,9 +2418,8 @@ static const struct mmc_fixup blk_fixups[] =
>  	END_FIXUP
>  };
>  
> -static int mmc_blk_probe(struct device *dev)
> +static int mmc_blk_probe(struct mmc_card *card)
>  {
> -	struct mmc_card *card = mmc_dev_to_card(dev);
>  	struct mmc_blk_data *md, *part_md;
>  	char cap_str[10];
>  
> @@ -2445,7 +2444,7 @@ static int mmc_blk_probe(struct device *dev)
>  	if (mmc_blk_alloc_parts(card, md))
>  		goto out;
>  
> -	dev_set_drvdata(dev, md);
> +	dev_set_drvdata(&card->dev, md);
>  
>  	if (mmc_add_disk(md))
>  		goto out;
> @@ -2475,10 +2474,9 @@ static int mmc_blk_probe(struct device *dev)
>  	return 0;
>  }
>  
> -static int mmc_blk_remove(struct device *dev)
> +static void mmc_blk_remove(struct mmc_card *card)
>  {
> -	struct mmc_card *card = mmc_dev_to_card(dev);
> -	struct mmc_blk_data *md = dev_get_drvdata(dev);
> +	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
>  
>  	mmc_blk_remove_parts(card, md);
>  	pm_runtime_get_sync(&card->dev);
> @@ -2489,15 +2487,13 @@ static int mmc_blk_remove(struct device *dev)
>  		pm_runtime_disable(&card->dev);
>  	pm_runtime_put_noidle(&card->dev);
>  	mmc_blk_remove_req(md);
> -	dev_set_drvdata(dev, NULL);
> -
> -	return 0;
> +	dev_set_drvdata(&card->dev, NULL);
>  }
>  
> -static int _mmc_blk_suspend(struct device *dev)
> +static int _mmc_blk_suspend(struct mmc_card *card)
>  {
>  	struct mmc_blk_data *part_md;
> -	struct mmc_blk_data *md = dev_get_drvdata(dev);
> +	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
>  
>  	if (md) {
>  		mmc_queue_suspend(&md->queue);
> @@ -2508,15 +2504,17 @@ static int _mmc_blk_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static void mmc_blk_shutdown(struct device *dev)
> +static void mmc_blk_shutdown(struct mmc_card *card)
>  {
> -	_mmc_blk_suspend(dev);
> +	_mmc_blk_suspend(card);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int mmc_blk_suspend(struct device *dev)
>  {
> -	return _mmc_blk_suspend(dev);
> +	struct mmc_card *card = mmc_dev_to_card(dev);
> +
> +	return _mmc_blk_suspend(card);
>  }
>  
>  static int mmc_blk_resume(struct device *dev)
> @@ -2541,9 +2539,11 @@ static int mmc_blk_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(mmc_blk_pm_ops, mmc_blk_suspend, mmc_blk_resume);
>  
> -static struct device_driver mmc_driver = {
> -	.name		= "mmcblk",
> -	.pm		= &mmc_blk_pm_ops,
> +static struct mmc_driver mmc_driver = {
> +	.drv		= {
> +		.name	= "mmcblk",
> +		.pm	= &mmc_blk_pm_ops,
> +	},
>  	.probe		= mmc_blk_probe,
>  	.remove		= mmc_blk_remove,
>  	.shutdown	= mmc_blk_shutdown,
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 7dac469..53b7413 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -14,7 +14,6 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/slab.h>
> -#include <linux/device.h>
>  
>  #include <linux/scatterlist.h>
>  #include <linux/swap.h>		/* For nr_free_buffer_pages() */
> @@ -2996,9 +2995,8 @@ err:
>  	return ret;
>  }
>  
> -static int mmc_test_probe(struct device *dev)
> +static int mmc_test_probe(struct mmc_card *card)
>  {
> -	struct mmc_card *card = mmc_dev_to_card(dev);
>  	int ret;
>  
>  	if (!mmc_card_mmc(card) && !mmc_card_sd(card))
> @@ -3013,22 +3011,20 @@ static int mmc_test_probe(struct device *dev)
>  	return 0;
>  }
>  
> -static int mmc_test_remove(struct device *dev)
> +static void mmc_test_remove(struct mmc_card *card)
>  {
> -	struct mmc_card *card = mmc_dev_to_card(dev);
> -
>  	mmc_test_free_result(card);
>  	mmc_test_free_dbgfs_file(card);
> -
> -	return 0;
>  }
>  
> -static void mmc_test_shutdown(struct device *dev)
> +static void mmc_test_shutdown(struct mmc_card *card)
>  {
>  }
>  
> -static struct device_driver mmc_driver = {
> -	.name	= "mmc_test",
> +static struct mmc_driver mmc_driver = {
> +	.drv		= {
> +		.name	= "mmc_test",
> +	},
>  	.probe		= mmc_test_probe,
>  	.remove		= mmc_test_remove,
>  	.shutdown	= mmc_test_shutdown,
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index c5ef100..972ff84 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -26,6 +26,8 @@
>  #include "sdio_cis.h"
>  #include "bus.h"
>  
> +#define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
> +
>  static ssize_t type_show(struct device *dev,
>  	struct device_attribute *attr, char *buf)
>  {
> @@ -105,14 +107,33 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return retval;
>  }
>  
> +static int mmc_bus_probe(struct device *dev)
> +{
> +	struct mmc_driver *drv = to_mmc_driver(dev->driver);
> +	struct mmc_card *card = mmc_dev_to_card(dev);
> +
> +	return drv->probe(card);
> +}
> +
> +static int mmc_bus_remove(struct device *dev)
> +{
> +	struct mmc_driver *drv = to_mmc_driver(dev->driver);
> +	struct mmc_card *card = mmc_dev_to_card(dev);
> +
> +	drv->remove(card);
> +
> +	return 0;
> +}
> +
>  static void mmc_bus_shutdown(struct device *dev)
>  {
> +	struct mmc_driver *drv = to_mmc_driver(dev->driver);
>  	struct mmc_card *card = mmc_dev_to_card(dev);
>  	struct mmc_host *host = card->host;
>  	int ret;
>  
> -	if (dev->driver && dev->driver->shutdown)
> -		dev->driver->shutdown(dev);
> +	if (dev->driver && drv->shutdown)
> +		drv->shutdown(card);
>  
>  	if (host->bus_ops->shutdown) {
>  		ret = host->bus_ops->shutdown(host);
> @@ -181,6 +202,8 @@ static struct bus_type mmc_bus_type = {
>  	.dev_groups	= mmc_dev_groups,
>  	.match		= mmc_bus_match,
>  	.uevent		= mmc_bus_uevent,
> +	.probe		= mmc_bus_probe,
> +	.remove		= mmc_bus_remove,
>  	.shutdown	= mmc_bus_shutdown,
>  	.pm		= &mmc_bus_pm_ops,
>  };
> @@ -199,22 +222,24 @@ void mmc_unregister_bus(void)
>   *	mmc_register_driver - register a media driver
>   *	@drv: MMC media driver
>   */
> -int mmc_register_driver(struct device_driver *drv)
> +int mmc_register_driver(struct mmc_driver *drv)
>  {
> -	drv->bus = &mmc_bus_type;
> -	return driver_register(drv);
> +	drv->drv.bus = &mmc_bus_type;
> +	return driver_register(&drv->drv);
>  }
> +
>  EXPORT_SYMBOL(mmc_register_driver);
>  
>  /**
>   *	mmc_unregister_driver - unregister a media driver
>   *	@drv: MMC media driver
>   */
> -void mmc_unregister_driver(struct device_driver *drv)
> +void mmc_unregister_driver(struct mmc_driver *drv)
>  {
> -	drv->bus = &mmc_bus_type;
> -	driver_unregister(drv);
> +	drv->drv.bus = &mmc_bus_type;
> +	driver_unregister(&drv->drv);
>  }
> +
>  EXPORT_SYMBOL(mmc_unregister_driver);
>  
>  static void mmc_release_card(struct device *dev)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index a6cf4c0..19f0175 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -512,8 +512,18 @@ static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
>  
>  #define mmc_dev_to_card(d)	container_of(d, struct mmc_card, dev)
>  
> -extern int mmc_register_driver(struct device_driver *);
> -extern void mmc_unregister_driver(struct device_driver *);
> +/*
> + * MMC device driver (e.g., Flash card, I/O card...)
> + */
> +struct mmc_driver {
> +	struct device_driver drv;
> +	int (*probe)(struct mmc_card *);
> +	void (*remove)(struct mmc_card *);
> +	void (*shutdown)(struct mmc_card *);
> +};
> +
> +extern int mmc_register_driver(struct mmc_driver *);
> +extern void mmc_unregister_driver(struct mmc_driver *);
>  
>  extern void mmc_fixup_device(struct mmc_card *card,
>  			     const struct mmc_fixup *table);
> 

