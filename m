From: Arnd Hannemann <hannemann@nets.rwth-aachen.de>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Tue, 16 Nov 2010 18:17:09 +0100
Message-ID: <4CE2BC95.5030605@nets.rwth-aachen.de>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com> <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com> <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com> <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com> <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com> <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com> <AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com> <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com> <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com> <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com> <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com> <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com> <AANLkTi=EaZbdnJzJWGH2fUadvNkUhd
 QgTU1rAoS5wMAs@mail.gmail.com> <AANLkTinzvte389GNHtD2N0wO9mYsysCG9+Z1AFVZRn0E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:49874 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752978Ab0KPRRL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Nov 2010 12:17:11 -0500
In-Reply-To: <AANLkTinzvte389GNHtD2N0wO9mYsysCG9+Z1AFVZRn0E@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Am 16.11.2010 14:22, schrieb Ohad Ben-Cohen:
> On Mon, Nov 1, 2010 at 10:27 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>   
>> On Sun, Oct 31, 2010 at 9:06 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> ...
>>     
>>> we need to support boards with controllers/cards
>>> which we can't power off in runtime.
>>>
>>> On such boards, the right thing to do would be to disable runtime PM altogether.
>>>       
>> The patch below (/attached) should trivially fix the problem - can you
>> please check it out ?
>>
>> It's very simple: it just requires hosts to explicitly indicate they
>> support runtime powering off/on their cards (by means of
>> MMC_CAP_RUNTIME_PM).
>>
>> There is no way around this I'm afraid: it is legitimate for a
>> board/host/card configuration not to support powering off the card
>> after boot, and we must allow it.
>>
>> In addition having an explicit MMC_CAP_RUNTIME_PM will also allow us
>> smoother transition to runtime PM behavior. Developers will have to
>> explicitly turn it on, and will not be surprised if things won't
>> immediately work.
>>
>> Please note that this cap is not interchangeable, and can't be replace
>> with CONFIG_PM_RUNTIME.
>>
>> Having said that, I still think we need to understand why CMD3 timed
>> out on the XO-1.5.
>>     
> Just to update the list, the problem with the XO-1.5 was because the
> sd8686 has an external reset gpio line which is currently being
> manipulated manually by an out-of-tree kernel patch:
>
> http://dev.laptop.org/git/olpc-2.6/commit/?h=olpc-2.6.35&id=e9bee721fb0cc303286d1fe5df4930ce79b0b1e0
>
> ... which makes me wonder whether we really want to take that
> MMC_CAP_RUNTIME_PM road. I'm not sure anymore.
>
> We need a demonstrated hardware limitation before we take that
> approach (or a setup which worked using vanilla kernels and now
> doesn't), because frankly this MMC_CAP_RUNTIME_PM approach is
> cumbersome and involving. I would not like to introduce it just to fix
> out-of-tree software issues, and it seems that at least the XO-1.5
> case can be cleanly solved by software (e.g. by letting the regulator
> handle that sd8686 quirk).
>
> I'm looping in Arnd, who reported similar problems with b43-sdio on
> AP4EVB (arm) with tmio_mmc.
>
> Arnd,
>
> We're trying to exactly understand the reasons behind the reported
> SDIO runtime pm failures (we had two, yours, and OLPC). So far it
> seems that the OLPC had a software issue, and I'm wondering about
> yours.
>
> Can you please supply additional information about your board ? where
> does your wifi card gets its power from ? is there an external gpio
> involved ? Were you able to work with vanilla kernels (prior to
> 2.6.37) or do you carry some out-of-tree patches ?
>   
Its an AP4 (SH7372) evaluation board from renesas. It has an SD-Slot,
where you plug the SDIO card into it. No special wiring or something
like this. So I doubt some external GPIOs are involved.
I have no idea how the wifi card gets its power, but I hope its over
some well defined pins within the SD slot...
I was able to work with 2.6.35 and .36 plus some out-of-tree patches
for the sh_mobile_sdhi mfd, which are now in mainline:
mmc: Allow 2 byte requests in 4-bit mode for tmio_mmc
tmio_mmc: don't clear unhandled pending interrupts
tmio_mmc: don't clear unhandled pending interrupts

>> From 6b5691bdd8184cc0876d209c69d38844ea10f678 Mon Sep 17 00:00:00 2001
>> From: Ohad Ben-Cohen <ohad@wizery.com>
>> Date: Mon, 1 Nov 2010 09:41:44 +0200
>> Subject: [PATCH] mmc: add MMC_CAP_RUNTIME_PM
>>
>> Some board/card/host configurations are not capable of powering off/on
>> on the card during runtime.
>>
>> To support such configurations, and to allow smoother transition to
>> runtime PM behavior, MMC_CAP_RUNTIME_PM is added, so hosts need to
>> explicitly indicate that it's OK to power off their cards after boot.
>>
>> This will prevent sdio_bus_probe() from failing to power on the card
>> when the driver is loaded on such setups.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>>  drivers/mmc/core/sdio.c     |   37 +++++++++++++++++++++++--------------
>>  drivers/mmc/core/sdio_bus.c |   33 ++++++++++++++++++++++-----------
>>  include/linux/mmc/host.h    |    1 +
>>  3 files changed, 46 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index 6a9ad40..373d56d 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -547,9 +547,11 @@ static void mmc_sdio_detect(struct mmc_host *host)
>>        BUG_ON(!host->card);
>>
>>        /* Make sure card is powered before detecting it */
>> -       err = pm_runtime_get_sync(&host->card->dev);
>> -       if (err < 0)
>> -               goto out;
>> +       if (host->caps & MMC_CAP_RUNTIME_PM) {
>> +               err = pm_runtime_get_sync(&host->card->dev);
>> +               if (err < 0)
>> +                       goto out;
>> +       }
>>
>>        mmc_claim_host(host);
>>
>> @@ -570,7 +572,8 @@ out:
>>        }
>>
>>        /* Tell PM core that we're done */
>> -       pm_runtime_put(&host->card->dev);
>> +       if (host->caps & MMC_CAP_RUNTIME_PM)
>> +               pm_runtime_put(&host->card->dev);
>>  }
>>
>>  /*
>> @@ -720,16 +723,21 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>>        card = host->card;
>>
>>        /*
>> -        * Let runtime PM core know our card is active
>> +        * Enable runtime PM only if supported by host+card+board
>>         */
>> -       err = pm_runtime_set_active(&card->dev);
>> -       if (err)
>> -               goto remove;
>> +       if (host->caps & MMC_CAP_RUNTIME_PM) {
>> +               /*
>> +                * Let runtime PM core know our card is active
>> +                */
>> +               err = pm_runtime_set_active(&card->dev);
>> +               if (err)
>> +                       goto remove;
>>
>> -       /*
>> -        * Enable runtime PM for this card
>> -        */
>> -       pm_runtime_enable(&card->dev);
>> +               /*
>> +                * Enable runtime PM for this card
>> +                */
>> +               pm_runtime_enable(&card->dev);
>> +       }
>>
>>        /*
>>         * The number of functions on the card is encoded inside
>> @@ -747,9 +755,10 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>>                        goto remove;
>>
>>                /*
>> -                * Enable Runtime PM for this func
>> +                * Enable Runtime PM for this func (if supported)
>>                 */
>> -               pm_runtime_enable(&card->sdio_func[i]->dev);
>> +               if (host->caps & MMC_CAP_RUNTIME_PM)
>> +                       pm_runtime_enable(&card->sdio_func[i]->dev);
>>        }
>>
>>        mmc_release_host(host);
>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
>> index 2716c7a..f3ce21b 100644
>> --- a/drivers/mmc/core/sdio_bus.c
>> +++ b/drivers/mmc/core/sdio_bus.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/pm_runtime.h>
>>
>>  #include <linux/mmc/card.h>
>> +#include <linux/mmc/host.h>
>>  #include <linux/mmc/sdio_func.h>
>>
>>  #include "sdio_cis.h"
>> @@ -132,9 +133,11 @@ static int sdio_bus_probe(struct device *dev)
>>         * it should call pm_runtime_put_noidle() in its probe routine and
>>         * pm_runtime_get_noresume() in its remove routine.
>>         */
>> -       ret = pm_runtime_get_sync(dev);
>> -       if (ret < 0)
>> -               goto out;
>> +       if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
>> +               ret = pm_runtime_get_sync(dev);
>> +               if (ret < 0)
>> +                       goto out;
>> +       }
>>
>>        /* Set the default block size so the driver is sure it's something
>>         * sensible. */
>> @@ -151,7 +154,8 @@ static int sdio_bus_probe(struct device *dev)
>>        return 0;
>>
>>  disable_runtimepm:
>> -       pm_runtime_put_noidle(dev);
>> +       if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>> +               pm_runtime_put_noidle(dev);
>>  out:
>>        return ret;
>>  }
>> @@ -160,12 +164,14 @@ static int sdio_bus_remove(struct device *dev)
>>  {
>>        struct sdio_driver *drv = to_sdio_driver(dev->driver);
>>        struct sdio_func *func = dev_to_sdio_func(dev);
>> -       int ret;
>> +       int ret = 0;
>>
>>        /* Make sure card is powered before invoking ->remove() */
>> -       ret = pm_runtime_get_sync(dev);
>> -       if (ret < 0)
>> -               goto out;
>> +       if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
>> +               ret = pm_runtime_get_sync(dev);
>> +               if (ret < 0)
>> +                       goto out;
>> +       }
>>
>>        drv->remove(func);
>>
>> @@ -178,10 +184,12 @@ static int sdio_bus_remove(struct device *dev)
>>        }
>>
>>        /* First, undo the increment made directly above */
>> -       pm_runtime_put_noidle(dev);
>> +       if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>> +               pm_runtime_put_noidle(dev);
>>
>>        /* Then undo the runtime PM settings in sdio_bus_probe() */
>> -       pm_runtime_put_noidle(dev);
>> +       if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>> +               pm_runtime_put_noidle(dev);
>>
>>  out:
>>        return ret;
>> @@ -191,6 +199,8 @@ out:
>>
>>  static int sdio_bus_pm_prepare(struct device *dev)
>>  {
>> +       struct sdio_func *func = dev_to_sdio_func(dev);
>> +
>>        /*
>>         * Resume an SDIO device which was suspended at run time at this
>>         * point, in order to allow standard SDIO suspend/resume paths
>> @@ -212,7 +222,8 @@ static int sdio_bus_pm_prepare(struct device *dev)
>>         * since there is little point in failing system suspend if a
>>         * device can't be resumed.
>>         */
>> -       pm_runtime_resume(dev);
>> +       if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>> +               pm_runtime_resume(dev);
>>
>>        return 0;
>>  }
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index c3ffad8..e5eee0e 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -167,6 +167,7 @@ struct mmc_host {
>>                                                /* DDR mode at 1.8V */
>>  #define MMC_CAP_1_2V_DDR       (1 << 12)       /* can support */
>>                                                /* DDR mode at 1.2V */
>> +#define MMC_CAP_RUNTIME_PM     (1 << 13)       /* Can power off/on in runtime */
>>
>>        mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>
>> --
>> 1.7.0.4
>>
>>     

