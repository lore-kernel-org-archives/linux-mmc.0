From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/PATCH] mmc: core: Signal wakeup event at card insert/removal
Date: Mon, 23 Sep 2013 14:11:52 +0200
Message-ID: <CAPDyKFoZf6xFmft5KwMjM4PAxA=-TXW4_5YVQbSrPusLC5f-Sw@mail.gmail.com>
References: <1379670523-13229-1-git-send-email-ulf.hansson@linaro.org>
	<52401E32.1080304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:33766 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab3IWMLx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 08:11:53 -0400
Received: by mail-ve0-f182.google.com with SMTP id oy12so2152084veb.41
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2013 05:11:52 -0700 (PDT)
In-Reply-To: <52401E32.1080304@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>, John Stultz <john.stultz@linaro.org>, Zoran Markovic <zoran.markovic@linaro.org>, cpgs@samsung.com

On 23 September 2013 12:55, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Ulf,
>
> On 09/20/2013 06:48 PM, Ulf Hansson wrote:
>> We want to give user space provision to fully consume a card
>> insert/remove event, when the event was caused by a wakeup irq.
>>
>> By signaling the wakeup event for a time of 5 s for devices configured
>> as wakeup capable, we likely will be prevent a sleep long enough to let
>> user space consume the event.
>>
>> To enable this feature, host drivers must thus configure their devices
>> as wakeup capable.
>>
>> This is a reworked implementation of the old wakelocks for the mmc
>> subsystem, originally authored by Colin Cross and San Mehat for the
>> Android kernel. Zoran Markovic shall also be given cred for recently
>> re-trying to upstream this feature.
>>
>> Cc: San Mehat <san@google.com>
>> Cc: Colin Cross <ccross@android.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Zoran Markovic <zoran.markovic@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> This patch has just been compile tested, since I at very moment did not
>> have a good board to test it on. I am working on that.
>>
>> Any help in testing this patch is thus greatly appreciated. While
>> testing also don't forget to enable the host device as wakeup capable.
>> Use "device_init_wakeup" from the host probe function.
>

Hi Jaehoon,

Thanks for helping out testing this patch!

> I used the device_init_wakeup(&pdev->dev, 1) into host controller. (Also enabled the irq for wakeup)
> It didn't work when device is suspended.
> Well, i might missed something.

Not sure what you mean by didn't work here. Did the card detect irq
wake up the platform and thus triggered a resume? Or you mean that
even that did not work?

> As my understanding, it's helpful that wakeup-event is used when device is suspended.

This feature is typically used for devices using "autosuspend", like
Android devices. Otherwise you likely do not want to wakeup the
platform when inserting/removing a card, but that is another story.
:-)

> How do you call mmc_detect_change() during suspended?

To try to clarify things a bit, the sequence is typically like this:

1. We enter suspend.
2. A card is inserted and a card detect irq is triggered. The
corresponding irq handler gets called which then issue
mmc_detect_change.
3. mmc_detect_change recognize the device as a wakeup capable device
and thus issue a pm_wakeup_event(5s) to prevent a new trigger of
suspend.
4. A rescan work is scheduled.
5. System continues resuming.
6. After PM_POST_SUSPEND notification (mmc_pm_notify), rescan is
enabled and a new work re-scheduled.
7. The rescan work detects the new card and user space soon gets
notified about it.
8. User space gets the notification and can act on it.
9. The timeout of the pm_wakeup_event has elapsed, allowing a new
suspend to be triggered.


Kind regards
Ulf Hansson

>
> Best Regards,
> Jaehoon Chung
>>
>> ---
>>  drivers/mmc/core/core.c |   39 +++++++++++++++++++++++++++------------
>>  1 file changed, 27 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index bf18b6b..3e8229e 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/log2.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/pm_wakeup.h>
>>  #include <linux/suspend.h>
>>  #include <linux/fault-inject.h>
>>  #include <linux/random.h>
>> @@ -1723,6 +1724,28 @@ void mmc_detach_bus(struct mmc_host *host)
>>       mmc_bus_put(host);
>>  }
>>
>> +static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>> +                             bool cd_irq)
>> +{
>> +#ifdef CONFIG_MMC_DEBUG
>> +     unsigned long flags;
>> +     spin_lock_irqsave(&host->lock, flags);
>> +     WARN_ON(host->removed);
>> +     spin_unlock_irqrestore(&host->lock, flags);
>> +#endif
>> +
>> +     /*
>> +      * If the device is configured as wakeup, we prevent a new sleep for
>> +      * 5 s to give provision for user space to consume the event.
>> +      */
>> +     if (cd_irq && !(host->caps & MMC_CAP_NEEDS_POLL) &&
>> +             device_can_wakeup(mmc_dev(host)))
>> +             pm_wakeup_event(mmc_dev(host), 5000);
>> +
>> +     host->detect_change = 1;
>> +     mmc_schedule_delayed_work(&host->detect, delay);
>> +}
>> +
>>  /**
>>   *   mmc_detect_change - process change of state on a MMC socket
>>   *   @host: host which changed state.
>> @@ -1735,16 +1758,8 @@ void mmc_detach_bus(struct mmc_host *host)
>>   */
>>  void mmc_detect_change(struct mmc_host *host, unsigned long delay)
>>  {
>> -#ifdef CONFIG_MMC_DEBUG
>> -     unsigned long flags;
>> -     spin_lock_irqsave(&host->lock, flags);
>> -     WARN_ON(host->removed);
>> -     spin_unlock_irqrestore(&host->lock, flags);
>> -#endif
>> -     host->detect_change = 1;
>> -     mmc_schedule_delayed_work(&host->detect, delay);
>> +     _mmc_detect_change(host, delay, true);
>>  }
>> -
>>  EXPORT_SYMBOL(mmc_detect_change);
>>
>>  void mmc_init_erase(struct mmc_card *card)
>> @@ -2423,7 +2438,7 @@ int mmc_detect_card_removed(struct mmc_host *host)
>>                        * rescan handle the card removal.
>>                        */
>>                       cancel_delayed_work(&host->detect);
>> -                     mmc_detect_change(host, 0);
>> +                     _mmc_detect_change(host, 0, false);
>>               }
>>       }
>>
>> @@ -2505,7 +2520,7 @@ void mmc_start_host(struct mmc_host *host)
>>               mmc_power_off(host);
>>       else
>>               mmc_power_up(host);
>> -     mmc_detect_change(host, 0);
>> +     _mmc_detect_change(host, 0, false);
>>  }
>>
>>  void mmc_stop_host(struct mmc_host *host)
>> @@ -2724,7 +2739,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>>               spin_lock_irqsave(&host->lock, flags);
>>               host->rescan_disable = 0;
>>               spin_unlock_irqrestore(&host->lock, flags);
>> -             mmc_detect_change(host, 0);
>> +             _mmc_detect_change(host, 0, false);
>>
>>       }
>>
>>
>
