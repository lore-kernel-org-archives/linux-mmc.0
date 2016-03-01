From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/3] mmc: pwrseq: convert to proper platform device
Date: Tue, 1 Mar 2016 10:54:18 +0100
Message-ID: <CAPDyKFrDN3spHog4=icyAfySc2GsvfbarJNns4S=i3PSEy54Nw@mail.gmail.com>
References: <1453975315-13424-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1453975435-13564-1-git-send-email-srinivas.kandagatla@linaro.org>
	<CAPDyKFp+LhGfGF5vW85Tk7WCvPU6ovktsunE+8fN+NkUYbGn8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp+LhGfGF5vW85Tk7WCvPU6ovktsunE+8fN+NkUYbGn8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 1 March 2016 at 10:51, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
>> ---
>>  drivers/mmc/Kconfig              |   2 +
>>  drivers/mmc/core/Kconfig         |   7 +++
>>  drivers/mmc/core/Makefile        |   4 +-
>>  drivers/mmc/core/pwrseq.c        | 115 +++++++++++++++++++++------------------
>>  drivers/mmc/core/pwrseq.h        |  19 +++++--
>>  drivers/mmc/core/pwrseq_emmc.c   |  81 +++++++++++++++++++--------
>>  drivers/mmc/core/pwrseq_simple.c |  85 ++++++++++++++++++++---------
>>  7 files changed, 207 insertions(+), 106 deletions(-)
>>
>> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
>> index f2eeb38..7b2412a 100644
>> --- a/drivers/mmc/Kconfig
>> +++ b/drivers/mmc/Kconfig
>> @@ -5,6 +5,8 @@
>>  menuconfig MMC
>>         tristate "MMC/SD/SDIO card support"
>>         depends on HAS_IOMEM
>> +       select PWRSEQ_SIMPLE if OF
>> +       select PWRSEQ_EMMC if OF
>
> In general I don't like "select" and for this case I think there is a
> better way. See below.
>
>>         help
>>           This selects MultiMediaCard, Secure Digital and Secure
>>           Digital I/O support.
>> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
>> index 4c33d76..b26f756 100644
>> --- a/drivers/mmc/core/Kconfig
>> +++ b/drivers/mmc/core/Kconfig
>> @@ -1,3 +1,10 @@
>>  #
>>  # MMC core configuration
>>  #
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
>
>> +
>> +config PWRSEQ_SIMPLE
>> +       tristate "PwrSeq Simple"
>> +       depends on OF
>
> Similar comments as above for PWRSEQ_EMMC.
>
>> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
>> index 2c25138..f007151 100644
>> --- a/drivers/mmc/core/Makefile
>> +++ b/drivers/mmc/core/Makefile
>> @@ -8,5 +8,7 @@ mmc_core-y                      := core.o bus.o host.o \
>>                                    sdio.o sdio_ops.o sdio_bus.o \
>>                                    sdio_cis.o sdio_io.o sdio_irq.o \
>>                                    quirks.o slot-gpio.o
>> -mmc_core-$(CONFIG_OF)          += pwrseq.o pwrseq_simple.o pwrseq_emmc.o
>> +mmc_core-$(CONFIG_OF)          += pwrseq.o
>> +obj-$(CONFIG_PWRSEQ_SIMPLE)    += pwrseq_simple.o
>> +obj-$(CONFIG_PWRSEQ_EMMC)      += pwrseq_emmc.o
>>  mmc_core-$(CONFIG_DEBUG_FS)    += debugfs.o
>> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
>> index 4c1d175..64c7c79 100644
>> --- a/drivers/mmc/core/pwrseq.c
>> +++ b/drivers/mmc/core/pwrseq.c
>> @@ -8,80 +8,64 @@
>>   *  MMC power sequence management
>>   */
>>  #include <linux/kernel.h>
>> -#include <linux/platform_device.h>
>>  #include <linux/err.h>
>> +#include <linux/module.h>
>>  #include <linux/of.h>
>> -#include <linux/of_platform.h>
>>
>>  #include <linux/mmc/host.h>
>>
>>  #include "pwrseq.h"
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
>>  {
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
>>                         break;
>>                 }
>>         }
>>
>> -       return match;
>> +       of_node_put(np);
>> +       mutex_unlock(&pwrseq_list_mutex);
>> +
>> +       return pwrseq ? : ERR_PTR(-EPROBE_DEFER);
>>  }
>>
>>  int mmc_pwrseq_alloc(struct mmc_host *host)
>>  {
>> -       struct platform_device *pdev;
>> -       struct device_node *np;
>> -       struct mmc_pwrseq_match *match;
>>         struct mmc_pwrseq *pwrseq;
>>         int ret = 0;
>>
>> -       np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
>> -       if (!np)
>> -               return 0;
>> +       pwrseq = of_find_mmc_pwrseq(host);
>>
>
> I think you can remove another empty line here.
>
>> -       pdev = of_find_device_by_node(np);
>> -       if (!pdev) {
>> -               ret = -ENODEV;
>> -               goto err;
>> -       }
>> +       if (IS_ERR_OR_NULL(pwrseq))
>> +               return PTR_ERR(pwrseq);
>
> You need "return PTR_ERR_OR_ZERO(pwrseq)", as pwrse is what you want here.
>

Argh, slipped with my fingers in the middle of review and manage to
send on half the review. Please ignore it, I will send a new one with
a full review.

Sorry for noise.

Kind regards
Uffe
