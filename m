From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] driver core: detach device's pm_domain after
 devres_release_all
Date: Tue, 29 Aug 2017 08:42:31 +0200
Message-ID: <20170829064231.GE12198@kroah.com>
References: <1502786217-212887-1-git-send-email-shawn.lin@rock-chips.com>
 <1502786217-212887-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdH2Gm0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2017 02:42:26 -0400
Content-Disposition: inline
In-Reply-To: <1502786217-212887-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 15, 2017 at 04:36:56PM +0800, Shawn Lin wrote:
> Move dev_pm_domain_detach after devres_release_all to avoid
> accessing device's registers with genpd been powered off.

So, what is this going to break that is working already today?  :)

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/base/dd.c       | 35 ++++++++++++++++++++++++++++++-----
>  drivers/base/platform.c | 18 ++----------------
>  2 files changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index ad44b40..13dc0ad 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -25,7 +25,9 @@
>  #include <linux/kthread.h>
>  #include <linux/wait.h>
>  #include <linux/async.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pinctrl/devinfo.h>
>  
>  #include "base.h"
> @@ -356,6 +358,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	int local_trigger_count = atomic_read(&deferred_trigger_count);
>  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>  			   !drv->suppress_bind_attrs;
> +	struct platform_driver *pdrv;
> +	bool do_pm_domain = false;
>  
>  	if (defer_all_probes) {
>  		/*
> @@ -414,6 +418,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		if (ret)
>  			goto probe_failed;
>  	} else if (drv->probe) {
> +		ret = dev_pm_domain_attach(dev, true);
> +		pdrv = to_platform_driver(dev->driver);
> +		/* don't fail if just dev_pm_domain_attach failed */
> +		if (pdrv->prevent_deferred_probe &&
> +		    ret == -EPROBE_DEFER) {
> +			dev_warn(dev, "probe deferral not supported\n");
> +			ret = -ENXIO;
> +			goto probe_failed;
> +		}
> +		do_pm_domain = true;
>  		ret = drv->probe(dev);
>  		if (ret)
>  			goto probe_failed;
> @@ -421,13 +435,17 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  
>  	if (test_remove) {
>  		test_remove = false;
> +		do_pm_domain = false;
>  
> -		if (dev->bus->remove)
> +		if (dev->bus->remove) {
>  			dev->bus->remove(dev);
> -		else if (drv->remove)
> +		} else if (drv->remove) {
>  			drv->remove(dev);
> -
> +			do_pm_domain = true;

Why is this set to true if you have a driver remove function, but not if
you only have a bus remove function?  Why the difference?


> +		}
>  		devres_release_all(dev);
> +		if (do_pm_domain)
> +			dev_pm_domain_detach(dev, true);
>  		driver_sysfs_remove(dev);
>  		dev->driver = NULL;
>  		dev_set_drvdata(dev, NULL);
> @@ -458,6 +476,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  pinctrl_bind_failed:
>  	device_links_no_driver(dev);
>  	devres_release_all(dev);
> +	if (do_pm_domain)
> +		dev_pm_domain_detach(dev, true);

Can't you just always call this on the error path?

>  	driver_sysfs_remove(dev);
>  	dev->driver = NULL;
>  	dev_set_drvdata(dev, NULL);
> @@ -818,6 +838,7 @@ int driver_attach(struct device_driver *drv)
>  static void __device_release_driver(struct device *dev, struct device *parent)
>  {
>  	struct device_driver *drv;
> +	bool do_pm_domain = false;
>  
>  	drv = dev->driver;
>  	if (drv) {
> @@ -855,15 +876,19 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  
>  		pm_runtime_put_sync(dev);
>  
> -		if (dev->bus && dev->bus->remove)
> +		if (dev->bus && dev->bus->remove) {
>  			dev->bus->remove(dev);
> -		else if (drv->remove)
> +		} else if (drv->remove) {
> +			do_pm_domain = true;

Same question here about drivers and bus default functions.

thanks,

greg k-h
