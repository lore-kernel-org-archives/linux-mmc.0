From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH V2]mmc: remove MMC bus legacy suspend/resume method
Date: Tue, 10 Apr 2012 14:02:48 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A90FDAD25A@SHSMSX102.ccr.corp.intel.com>
References: <20120405075118.GA29395@intel.com>
 <4F84336A.8070903@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:22592 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab2DJOC6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Apr 2012 10:02:58 -0400
In-Reply-To: <4F84336A.8070903@stericsson.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "rjw@sisk.pl" <rjw@sisk.pl>



> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@stericsson.com]
> Sent: Tuesday, April 10, 2012 9:20 PM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; linux-pm@lists.linux-foundation.org; rjw@sisk.pl
> Subject: Re: [PATCH V2]mmc: remove MMC bus legacy suspend/resume method
> 
> 
> On 04/05/2012 09:51 AM, Chuanxiao Dong wrote:
> > MMC bus is using legacy suspend/resume method, which is not compatible
> > if runtime pm callbacks are used. In this scenario, MMC bus
> > suspend/resume callbacks cannot be called when system entering S3. So
> > change to use the new defined dev_pm_ops for system sleeping mode
> >
> > Signed-off-by: Chuanxiao Dong<chuanxiao.dong@intel.com>
> > ---
> > Changes in v2:
> > 	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
> > 	suggested
> >
> >   drivers/mmc/card/block.c |    2 +-
> >   drivers/mmc/core/bus.c   |   26 ++++++++++++--------------
> >   include/linux/mmc/card.h |    2 +-
> >   3 files changed, 14 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index
> > f2020d3..3582c03 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -1826,7 +1826,7 @@ static void mmc_blk_remove(struct mmc_card *card)
> >   }
> >
> >   #ifdef CONFIG_PM
> > -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
> > +static int mmc_blk_suspend(struct mmc_card *card)
> >   {
> >   	struct mmc_blk_data *part_md;
> >   	struct mmc_blk_data *md = mmc_get_drvdata(card); diff --git
> > a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> > 5d011a3..d44f0d9 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -122,14 +122,14 @@ static int mmc_bus_remove(struct device *dev)
> >   	return 0;
> >   }
> >
> > -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
> > +static int mmc_bus_suspend(struct device *dev)
> >   {
> >   	struct mmc_driver *drv = to_mmc_driver(dev->driver);
> >   	struct mmc_card *card = mmc_dev_to_card(dev);
> >   	int ret = 0;
> >
> >   	if (dev->driver&&  drv->suspend)
> > -		ret = drv->suspend(card, state);
> > +		ret = drv->suspend(card);
> >   	return ret;
> >   }
> >
> > @@ -165,20 +165,20 @@ static int mmc_runtime_idle(struct device *dev)
> >   	return pm_runtime_suspend(dev);
> >   }
> >
> > -static const struct dev_pm_ops mmc_bus_pm_ops = {
> > -	.runtime_suspend	= mmc_runtime_suspend,
> > -	.runtime_resume		= mmc_runtime_resume,
> > -	.runtime_idle		= mmc_runtime_idle,
> > -};
> > -
> > -#define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
> > -
> >   #else /* !CONFIG_PM_RUNTIME */
> >
> > -#define MMC_PM_OPS_PTR	NULL
> > +#define mmc_runtime_suspend	NULL
> > +#define mmc_runtime_resume	NULL
> > +#define mmc_runtime_idle	NULL
> 
> You do not have to set these functions to NULL, the use of SET_RUNTIME_PM_OPS
> will fix that when !CONFIG_PM_RUNTIME
Okay, will remove this in v3.

Thanks
Chuanxiao

> 
> >
> >   #endif /* !CONFIG_PM_RUNTIME */
> >
> > +static const struct dev_pm_ops mmc_bus_pm_ops = {
> > +	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume,
> > +			mmc_runtime_idle)
> > +	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume) };
> > +
> >   static struct bus_type mmc_bus_type = {
> >   	.name		= "mmc",
> >   	.dev_attrs	= mmc_dev_attrs,
> > @@ -186,9 +186,7 @@ static struct bus_type mmc_bus_type = {
> >   	.uevent		= mmc_bus_uevent,
> >   	.probe		= mmc_bus_probe,
> >   	.remove		= mmc_bus_remove,
> > -	.suspend	= mmc_bus_suspend,
> > -	.resume		= mmc_bus_resume,
> > -	.pm		= MMC_PM_OPS_PTR,
> > +	.pm		=&mmc_bus_pm_ops,
> >   };
> >
> >   int mmc_register_bus(void)
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> > 1a1ca71..c984c9a 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -480,7 +480,7 @@ struct mmc_driver {
> >   	struct device_driver drv;
> >   	int (*probe)(struct mmc_card *);
> >   	void (*remove)(struct mmc_card *);
> > -	int (*suspend)(struct mmc_card *, pm_message_t);
> > +	int (*suspend)(struct mmc_card *);
> >   	int (*resume)(struct mmc_card *);
> >   };
> >
> 
> Otherwise looks good!
> 
> Kind regards
> Ulf Hansson
