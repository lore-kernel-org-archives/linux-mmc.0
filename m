From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/3] mmc: pwrseq: convert to proper platform device
Date: Wed, 2 Mar 2016 14:22:38 +0000
Message-ID: <56D6F72E.4040005@linaro.org>
References: <1453975315-13424-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1453975435-13564-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAPDyKFo1esuXiR7jaO+U8+8RbZVAF_rW6+z_Zn8shRdt8DBrdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37267 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbcCBOWl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2016 09:22:41 -0500
Received: by mail-wm0-f49.google.com with SMTP id p65so80081111wmp.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2016 06:22:40 -0800 (PST)
In-Reply-To: <CAPDyKFo1esuXiR7jaO+U8+8RbZVAF_rW6+z_Zn8shRdt8DBrdg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 01/03/16 10:55, Ulf Hansson wrote:
> On 28 January 2016 at 11:03, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> simple-pwrseq and emmc-pwrseq drivers rely on platform_device
>> structure from of_find_device_by_node(), this works mostly. But, as there
>> is no driver associated with this devices, cases like default/init pinctrl
>> setup would never be performed by pwrseq. This becomes problem when the
>> gpios used in pwrseq require pinctrl setup.
>>
>> Currently most of the common pinctrl setup is done in
>> drivers/base/pinctrl.c by pinctrl_bind_pins().
>>
>> There are two ways to solve this issue on either convert pwrseq drivers
>> to a proper platform drivers or copy the exact code from
>> pcintrl_bind_pins(). I prefer converting pwrseq to proper drivers so that
>> other cases like setting up clks/parents from dt would also be possible.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Full review this time. :-)
>
> And sorry for the delay in reviewing.
>
>> ---
>>   drivers/mmc/Kconfig              |   2 +
>>   drivers/mmc/core/Kconfig         |   7 +++
>>   drivers/mmc/core/Makefile        |   4 +-
>>   drivers/mmc/core/pwrseq.c        | 115 +++++++++++++++++++++------------------
>>   drivers/mmc/core/pwrseq.h        |  19 +++++--
>>   drivers/mmc/core/pwrseq_emmc.c   |  81 +++++++++++++++++++--------
>>   drivers/mmc/core/pwrseq_simple.c |  85 ++++++++++++++++++++---------
>>   7 files changed, 207 insertions(+), 106 deletions(-)
>>
>> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
>> index f2eeb38..7b2412a 100644
>> --- a/drivers/mmc/Kconfig
>> +++ b/drivers/mmc/Kconfig
>> @@ -5,6 +5,8 @@
>>   menuconfig MMC
>>          tristate "MMC/SD/SDIO card support"
>>          depends on HAS_IOMEM
>> +       select PWRSEQ_SIMPLE if OF
>> +       select PWRSEQ_EMMC if OF
>
> In general I don't like "select" and for this case I think there is a
> better way. See below.
>
>>          help
>>            This selects MultiMediaCard, Secure Digital and Secure
>>            Digital I/O support.
>> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
>> index 4c33d76..b26f756 100644
>> --- a/drivers/mmc/core/Kconfig
>> +++ b/drivers/mmc/core/Kconfig
>> @@ -1,3 +1,10 @@
>>   #
>>   # MMC core configuration
>>   #
>> +config PWRSEQ_EMMC
>> +       tristate "PwrSeq EMMC"
>
> I suggest change this to:
> bool "HW reset support for eMMC"
>
>> +       depends on OF
>
> Add:
> default y
>
> Also I think some brief "help" text, describing the feature would be nice.
Am ok with that, will change it in next version.
>
>> +
>> +config PWRSEQ_SIMPLE
>> +       tristate "PwrSeq Simple"
>> +       depends on OF
>
> Similar comments as above for PWRSEQ_EMMC.

sure

>
>> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
>> index 2c25138..f007151 100644
>> --- a/drivers/mmc/core/Makefile
>> +++ b/drivers/mmc/core/Makefile
>> @@ -8,5 +8,7 @@ mmc_core-y                      := core.o bus.o host.o \
>>                                     sdio.o sdio_ops.o sdio_bus.o \
>>                                     sdio_cis.o sdio_io.o sdio_irq.o \
>>                                     quirks.o slot-gpio.o
>> -mmc_core-$(CONFIG_OF)          += pwrseq.o pwrseq_simple.o pwrseq_emmc.o
>> +mmc_core-$(CONFIG_OF)          += pwrseq.o
>> +obj-$(CONFIG_PWRSEQ_SIMPLE)    += pwrseq_simple.o
>> +obj-$(CONFIG_PWRSEQ_EMMC)      += pwrseq_emmc.o
>>   mmc_core-$(CONFIG_DEBUG_FS)    += debugfs.o
>> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
>> index 4c1d175..64c7c79 100644
>> --- a/drivers/mmc/core/pwrseq.c
>> +++ b/drivers/mmc/core/pwrseq.c
>> @@ -8,80 +8,64 @@
>>    *  MMC power sequence management
>>    */
>>   #include <linux/kernel.h>
>> -#include <linux/platform_device.h>
>>   #include <linux/err.h>
>> +#include <linux/module.h>
>>   #include <linux/of.h>
>> -#include <linux/of_platform.h>
>>
>>   #include <linux/mmc/host.h>
>>
>>   #include "pwrseq.h"
>>
>> -struct mmc_pwrseq_match {
>> -       const char *compatible;
>> -       struct mmc_pwrseq *(*alloc)(struct mmc_host *host, struct device *dev);
>> -};
>> -
>> -static struct mmc_pwrseq_match pwrseq_match[] = {
>> -       {
>> -               .compatible = "mmc-pwrseq-simple",
>> -               .alloc = mmc_pwrseq_simple_alloc,
>> -       }, {
>> -               .compatible = "mmc-pwrseq-emmc",
>> -               .alloc = mmc_pwrseq_emmc_alloc,
>> -       },
>> -};
>> -
>> -static struct mmc_pwrseq_match *mmc_pwrseq_find(struct device_node *np)
>> +static DEFINE_MUTEX(pwrseq_list_mutex);
>> +static LIST_HEAD(pwrseq_list);
>> +
>> +static struct mmc_pwrseq *of_find_mmc_pwrseq(struct mmc_host *host)
>>   {
>> -       struct mmc_pwrseq_match *match = ERR_PTR(-ENODEV);
>> -       int i;
>> +       struct device_node *np;
>> +       struct mmc_pwrseq *p, *pwrseq = NULL;
>>
>> -       for (i = 0; i < ARRAY_SIZE(pwrseq_match); i++) {
>> -               if (of_device_is_compatible(np, pwrseq_match[i].compatible)) {
>> -                       match = &pwrseq_match[i];
>> +       np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
>> +       if (!np)
>> +               return NULL;
>> +
>> +       mutex_lock(&pwrseq_list_mutex);
>> +       list_for_each_entry(p, &pwrseq_list, list) {
>> +               if (p->dev->of_node == np) {
>> +                       pwrseq = p;
>>                          break;
>>                  }
>>          }
>>
>> -       return match;
>> +       of_node_put(np);
>> +       mutex_unlock(&pwrseq_list_mutex);
>> +
>> +       return pwrseq ? : ERR_PTR(-EPROBE_DEFER);
>>   }
>>
>>   int mmc_pwrseq_alloc(struct mmc_host *host)
>>   {
>> -       struct platform_device *pdev;
>> -       struct device_node *np;
>> -       struct mmc_pwrseq_match *match;
>>          struct mmc_pwrseq *pwrseq;
>>          int ret = 0;
>>
>> -       np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
>> -       if (!np)
>> -               return 0;
>> +       pwrseq = of_find_mmc_pwrseq(host);
>>
>
> I think you can remove another empty line here.

Ok.
>
>> -       pdev = of_find_device_by_node(np);
>> -       if (!pdev) {
>> -               ret = -ENODEV;
>> -               goto err;
>> -       }
>> +       if (IS_ERR_OR_NULL(pwrseq))
>> +               return PTR_ERR(pwrseq);
>
> You need "return PTR_ERR_OR_ZERO(pwrseq);", as pwrseq can be NULL here.

Good spot, Will change this.
>
>>
>> -       match = mmc_pwrseq_find(np);
>> -       if (IS_ERR(match)) {
>> -               ret = PTR_ERR(match);
>> -               goto err;
>> -       }
>> +       if (pwrseq->ops && pwrseq->ops->alloc) {
>
> 1)
> I think we need to decide whether the pwrseq->ops pointer should be
> optional or not.
>
> Currently from the mmc_pwrseq_register() API, you prevent a pwrseq
> from being registered unless the ops is provided. That means the above
> validation of the ops pointer is redundant.
>
> Although, I am thinking that we should allow the ops to be NULL to
> provide some more flexibility. Thus the above check could remain as
> is.
>
> 2)
> As a matter of fact, I don't think the ops->alloc|free() functions are
> needed any more. The corresponding platform driver will now be able
> alloc its resourses during ->probe() and drop them at ->remove() (or
> even use devm_*() APIs).

Yes, that can cleanup some code.
>
>> +               host->pwrseq = pwrseq;
>> +               ret = pwrseq->ops->alloc(host);
>>
>> -       pwrseq = match->alloc(host, &pdev->dev);
>> -       if (IS_ERR(pwrseq)) {
>> -               ret = PTR_ERR(pwrseq);
>> -               goto err;
>> +               if (IS_ERR_VALUE(ret)) {
>> +                       host->pwrseq = NULL;
>> +                       goto err;
>> +               }
>> +               try_module_get(pwrseq->owner);
>
> I don't think this fragile.
>
may be you meant its fragile  :-)


> For example, what happens if the pwrseq platform driver module becomes
> removed and thus called mmc_pwrseq_unregister() before invoking
> try_module_get()?
>
Yes I agree, there is a slight window of opportunity for this to happen.
> Perhaps extending the region for where pwrseq_list_mutex is held can
> help and in combination of checking the return value from
> try_module_get()?
>
Yep that will help, I will fix this in next version.
> Finally, pwrseq->owner may be NULL as you don't validate that in
> mmc_pwrseq_register().
>
Ah, will add a check for that too.

>>          }
>>
>> -       host->pwrseq = pwrseq;
>>          dev_info(host->parent, "allocated mmc-pwrseq\n");
>>
>>   err:
>> -       of_node_put(np);
>>          return ret;
>>   }
>>
>> @@ -89,7 +73,7 @@ void mmc_pwrseq_pre_power_on(struct mmc_host *host)
>>   {
>>          struct mmc_pwrseq *pwrseq = host->pwrseq;
>>
>> -       if (pwrseq && pwrseq->ops && pwrseq->ops->pre_power_on)
>
> See upper comment, whether we should allow ops to be NULL.
>
>> +       if (pwrseq && pwrseq->ops->pre_power_on)
>>                  pwrseq->ops->pre_power_on(host);
>>   }
>>
>> @@ -97,7 +81,7 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host)
>>   {
>>          struct mmc_pwrseq *pwrseq = host->pwrseq;
>>
>> -       if (pwrseq && pwrseq->ops && pwrseq->ops->post_power_on)
>> +       if (pwrseq && pwrseq->ops->post_power_on)
>
> Ditto.
>
>>                  pwrseq->ops->post_power_on(host);
>>   }
>>
>> @@ -105,7 +89,7 @@ void mmc_pwrseq_power_off(struct mmc_host *host)
>>   {
>>          struct mmc_pwrseq *pwrseq = host->pwrseq;
>>
>> -       if (pwrseq && pwrseq->ops && pwrseq->ops->power_off)
>> +       if (pwrseq && pwrseq->ops->power_off)
>
> Ditto.
>
>>                  pwrseq->ops->power_off(host);
>>   }
>>
>> @@ -113,8 +97,35 @@ void mmc_pwrseq_free(struct mmc_host *host)
>>   {
>>          struct mmc_pwrseq *pwrseq = host->pwrseq;
>>
>> -       if (pwrseq && pwrseq->ops && pwrseq->ops->free)
>> -               pwrseq->ops->free(host);
>> +       if (pwrseq) {
>> +               if (pwrseq->ops->free)
>
> See upper comment. I think the callback ops->free can be removed.
Ok,
>
>> +                       pwrseq->ops->free(host);
>> +               module_put(pwrseq->owner);
>> +
>> +               host->pwrseq = NULL;
>> +       }
>> +
>> +}
>> +
>> +int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
>> +{
>> +       if (!pwrseq || !pwrseq->ops || !pwrseq->dev)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&pwrseq_list_mutex);
>> +       list_add(&pwrseq->list, &pwrseq_list);
>> +       mutex_unlock(&pwrseq_list_mutex);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(mmc_pwrseq_register);
>>
>> -       host->pwrseq = NULL;
>> +void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq)
>> +{
>> +       if (pwrseq) {
>> +               mutex_lock(&pwrseq_list_mutex);
>> +               list_del(&pwrseq->list);
>> +               mutex_unlock(&pwrseq_list_mutex);
>> +       }
>>   }
>> +EXPORT_SYMBOL_GPL(mmc_pwrseq_unregister);
>> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
>> index 133de04..913587c 100644
>> --- a/drivers/mmc/core/pwrseq.h
>> +++ b/drivers/mmc/core/pwrseq.h
>> @@ -8,7 +8,10 @@
>>   #ifndef _MMC_CORE_PWRSEQ_H
>>   #define _MMC_CORE_PWRSEQ_H
>>
>> +#include <linux/mmc/host.h>
>> +
>>   struct mmc_pwrseq_ops {
>> +       int (*alloc)(struct mmc_host *host);
>>          void (*pre_power_on)(struct mmc_host *host);
>>          void (*post_power_on)(struct mmc_host *host);
>>          void (*power_off)(struct mmc_host *host);
>> @@ -17,23 +20,29 @@ struct mmc_pwrseq_ops {
>>
>>   struct mmc_pwrseq {
>>          const struct mmc_pwrseq_ops *ops;
>> +       struct device *dev;
>> +       struct list_head list;
>
> I would prefer to rename "list" to "pwrseq_node", to reflect that it's
> node in the pwrseq_list.
>
>> +       struct module *owner;
>>   };
>>
>>   #ifdef CONFIG_OF
>>
>> +int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq);
>> +void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq);
>> +
>>   int mmc_pwrseq_alloc(struct mmc_host *host);
>>   void mmc_pwrseq_pre_power_on(struct mmc_host *host);
>>   void mmc_pwrseq_post_power_on(struct mmc_host *host);
>>   void mmc_pwrseq_power_off(struct mmc_host *host);
>>   void mmc_pwrseq_free(struct mmc_host *host);
>>
>> -struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>> -                                          struct device *dev);
>> -struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
>> -                                        struct device *dev);
>> -
>>   #else
>>
>> +static inline int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
>> +{
>> +       return -ENOSYS;
>> +}
>> +static inline void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq) {}
>>   static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
>>   static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
>>   static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
>> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
>> index c2d732a..1b14e32 100644
>> --- a/drivers/mmc/core/pwrseq_emmc.c
>> +++ b/drivers/mmc/core/pwrseq_emmc.c
>> @@ -9,6 +9,9 @@
>>    */
>>   #include <linux/delay.h>
>>   #include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>> @@ -48,14 +51,8 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *host)
>
> According to upper comments, this entire code should go into a
> ->remove() function.

Yep.

>
>>
>>          unregister_restart_handler(&pwrseq->reset_nb);
>>          gpiod_put(pwrseq->reset_gpio);
>> -       kfree(pwrseq);
>>   }
>>
>> -static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
>> -       .post_power_on = mmc_pwrseq_emmc_reset,
>> -       .free = mmc_pwrseq_emmc_free,
>> -};
>> -
>>   static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
>>                                      unsigned long mode, void *cmd)
>>   {
>> @@ -66,21 +63,14 @@ static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
>>          return NOTIFY_DONE;
>>   }
>>
>> -struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
>> -                                        struct device *dev)
>> +static int mmc_pwrseq_emmc_alloc(struct mmc_host *host)
>
> According to upper comments, this entire code should go into a
> ->probe() function.

That makes more sense.
>
>>   {
>> -       struct mmc_pwrseq_emmc *pwrseq;
>> -       int ret = 0;
>> -
>> -       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_emmc), GFP_KERNEL);
>> -       if (!pwrseq)
>> -               return ERR_PTR(-ENOMEM);
>> +       struct mmc_pwrseq_emmc *pwrseq =  to_pwrseq_emmc(host->pwrseq);
>>
>> -       pwrseq->reset_gpio = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> -       if (IS_ERR(pwrseq->reset_gpio)) {
>> -               ret = PTR_ERR(pwrseq->reset_gpio);
>> -               goto free;
>> -       }
>> +       pwrseq->reset_gpio = gpiod_get(host->pwrseq->dev,
>> +                                       "reset", GPIOD_OUT_LOW);
>> +       if (IS_ERR(pwrseq->reset_gpio))
>> +               return PTR_ERR(pwrseq->reset_gpio);
>>
>>          /*
>>           * register reset handler to ensure emmc reset also from
>> @@ -91,10 +81,55 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
>>          pwrseq->reset_nb.priority = 255;
>>          register_restart_handler(&pwrseq->reset_nb);
>>
>> +       return 0;
>> +}
>> +
>> +static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
>> +       .alloc = mmc_pwrseq_emmc_alloc,
>> +       .post_power_on = mmc_pwrseq_emmc_reset,
>> +       .free = mmc_pwrseq_emmc_free,
>> +};
>> +
>> +static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
>> +{
>> +       struct mmc_pwrseq_emmc *pwrseq;
>> +       struct device *dev = &pdev->dev;
>> +
>> +       pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
>> +       if (!pwrseq)
>> +               return -ENOMEM;
>> +
>>          pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
>> +       pwrseq->pwrseq.dev = dev;
>> +       pwrseq->pwrseq.owner = THIS_MODULE;
>> +
>> +       return mmc_pwrseq_register(&pwrseq->pwrseq);
>> +}
>> +
>> +static int mmc_pwrseq_emmc_remove(struct platform_device *pdev)
>> +{
>> +       struct mmc_pwrseq_emmc *spwrseq = platform_get_drvdata(pdev);
>
> I think you need to call platform_set_drvdata() in ->probe() to allow
> this to work.

Opps, Will fix it.

>
>> +
>> +       mmc_pwrseq_unregister(&spwrseq->pwrseq);
>>
>> -       return &pwrseq->pwrseq;
>> -free:
>> -       kfree(pwrseq);
>> -       return ERR_PTR(ret);
>> +       return 0;
>>   }
>> +
>> +static const struct of_device_id mmc_pwrseq_emmc_of_match[] = {
>> +       { .compatible = "mmc-pwrseq-emmc",},
>> +       {/* sentinel */},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, mmc_pwrseq_emmc_of_match);
>> +
>> +static struct platform_driver mmc_pwrseq_emmc_driver = {
>> +       .probe = mmc_pwrseq_emmc_probe,
>> +       .remove = mmc_pwrseq_emmc_remove,
>> +       .driver = {
>> +               .name = "pwrseq_emmc",
>> +               .of_match_table = mmc_pwrseq_emmc_of_match,
>> +       },
>> +};
>> +
>> +module_platform_driver(mmc_pwrseq_emmc_driver);
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
>
> Similar comment to changes in this file as for pwrseq_emmc.c.
>
Ok, Will take care of this in next version.

>> index 03573e1..2f509ca 100644
>> --- a/drivers/mmc/core/pwrseq_simple.c
>> +++ b/drivers/mmc/core/pwrseq_simple.c
>> @@ -8,7 +8,10 @@
>>    *  Simple MMC power sequence management
>>    */
>>   #include <linux/clk.h>
>> +#include <linux/init.h>
>>   #include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>> @@ -86,31 +89,19 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>>          if (!IS_ERR(pwrseq->ext_clk))
>>                  clk_put(pwrseq->ext_clk);
>>
>> -       kfree(pwrseq);
>>   }
>>
>> -static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>> -       .pre_power_on = mmc_pwrseq_simple_pre_power_on,
>> -       .post_power_on = mmc_pwrseq_simple_post_power_on,
>> -       .power_off = mmc_pwrseq_simple_power_off,
>> -       .free = mmc_pwrseq_simple_free,
>> -};
>> -
>> -struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>> -                                          struct device *dev)
>> +int mmc_pwrseq_simple_alloc(struct mmc_host *host)
>>   {
>> -       struct mmc_pwrseq_simple *pwrseq;
>> +       struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
>> +       struct device *dev = host->pwrseq->dev;
>>          int ret = 0;
>>
>> -       pwrseq = kzalloc(sizeof(*pwrseq), GFP_KERNEL);
>> -       if (!pwrseq)
>> -               return ERR_PTR(-ENOMEM);
>> -
>>          pwrseq->ext_clk = clk_get(dev, "ext_clock");
>>          if (IS_ERR(pwrseq->ext_clk) &&
>>              PTR_ERR(pwrseq->ext_clk) != -ENOENT) {
>> -               ret = PTR_ERR(pwrseq->ext_clk);
>> -               goto free;
>> +               return PTR_ERR(pwrseq->ext_clk);
>> +
>>          }
>>
>>          pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
>> @@ -118,16 +109,60 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>>              PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
>>              PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
>>                  ret = PTR_ERR(pwrseq->reset_gpios);
>> -               goto clk_put;
>> +               clk_put(pwrseq->ext_clk);
>> +               return ret;
>>          }
>>
>> +       return 0;
>> +}
>> +
>> +static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>> +       .alloc = mmc_pwrseq_simple_alloc,
>> +       .pre_power_on = mmc_pwrseq_simple_pre_power_on,
>> +       .post_power_on = mmc_pwrseq_simple_post_power_on,
>> +       .power_off = mmc_pwrseq_simple_power_off,
>> +       .free = mmc_pwrseq_simple_free,
>> +};
>> +
>> +static const struct of_device_id mmc_pwrseq_simple_of_match[] = {
>> +       { .compatible = "mmc-pwrseq-simple",},
>> +       {/* sentinel */},
>> +};
>> +MODULE_DEVICE_TABLE(of, mmc_pwrseq_simple_of_match);
>> +
>> +static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>> +{
>> +       struct mmc_pwrseq_simple *pwrseq;
>> +       struct device *dev = &pdev->dev;
>> +
>> +       pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
>> +       if (!pwrseq)
>> +               return -ENOMEM;
>> +
>> +       pwrseq->pwrseq.dev = dev;
>>          pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>> +       pwrseq->pwrseq.owner = THIS_MODULE;
>>
>> -       return &pwrseq->pwrseq;
>> -clk_put:
>> -       if (!IS_ERR(pwrseq->ext_clk))
>> -               clk_put(pwrseq->ext_clk);
>> -free:
>> -       kfree(pwrseq);
>> -       return ERR_PTR(ret);
>> +       return mmc_pwrseq_register(&pwrseq->pwrseq);
>>   }
>> +
>> +static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
>> +{
>> +       struct mmc_pwrseq_simple *spwrseq = platform_get_drvdata(pdev);
>> +
>> +       mmc_pwrseq_unregister(&spwrseq->pwrseq);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver mmc_pwrseq_simple_driver = {
>> +       .probe = mmc_pwrseq_simple_probe,
>> +       .remove = mmc_pwrseq_simple_remove,
>> +       .driver = {
>> +               .name = "pwrseq_simple",
>> +               .of_match_table = mmc_pwrseq_simple_of_match,
>> +       },
>> +};
>> +
>> +module_platform_driver(mmc_pwrseq_simple_driver);
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.9.1
>>
>
> Overall I like where this is going, so please keep up the good work. I
> am looking forward to review a new version.

Thanks, I will send v3 once I test all the proposed changes.
thanks,
srini
>
> Kind regards
> Uffe
>
