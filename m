From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC/PATCH] mmc: core: Signal wakeup event at card insert/removal
Date: Mon, 23 Sep 2013 21:46:05 +0900
Message-ID: <5240380D.6010003@samsung.com>
References: <1379670523-13229-1-git-send-email-ulf.hansson@linaro.org>
 <52401E32.1080304@samsung.com>
 <CAPDyKFoZf6xFmft5KwMjM4PAxA=-TXW4_5YVQbSrPusLC5f-Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42858 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab3IWMpb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 08:45:31 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTK00BUDWRO7RF0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Sep 2013 21:45:29 +0900 (KST)
In-reply-to: <CAPDyKFoZf6xFmft5KwMjM4PAxA=-TXW4_5YVQbSrPusLC5f-Sw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>, John Stultz <john.stultz@linaro.org>, Zoran Markovic <zoran.markovic@linaro.org>, cpgs@samsung.com

On 09/23/2013 09:11 PM, Ulf Hansson wrote:
> On 23 September 2013 12:55, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Ulf,
>>
>> On 09/20/2013 06:48 PM, Ulf Hansson wrote:
>>> We want to give user space provision to fully consume a card
>>> insert/remove event, when the event was caused by a wakeup irq.
>>>
>>> By signaling the wakeup event for a time of 5 s for devices configured
>>> as wakeup capable, we likely will be prevent a sleep long enough to let
>>> user space consume the event.
>>>
>>> To enable this feature, host drivers must thus configure their devices
>>> as wakeup capable.
>>>
>>> This is a reworked implementation of the old wakelocks for the mmc
>>> subsystem, originally authored by Colin Cross and San Mehat for the
>>> Android kernel. Zoran Markovic shall also be given cred for recently
>>> re-trying to upstream this feature.
>>>
>>> Cc: San Mehat <san@google.com>
>>> Cc: Colin Cross <ccross@android.com>
>>> Cc: John Stultz <john.stultz@linaro.org>
>>> Cc: Zoran Markovic <zoran.markovic@linaro.org>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>
>>> This patch has just been compile tested, since I at very moment did not
>>> have a good board to test it on. I am working on that.
>>>
>>> Any help in testing this patch is thus greatly appreciated. While
>>> testing also don't forget to enable the host device as wakeup capable.
>>> Use "device_init_wakeup" from the host probe function.
>>
> 
> Hi Jaehoon,
> 
> Thanks for helping out testing this patch!
> 
>> I used the device_init_wakeup(&pdev->dev, 1) into host controller. (Also enabled the irq for wakeup)
>> It didn't work when device is suspended.
>> Well, i might missed something.
> 
> Not sure what you mean by didn't work here. Did the card detect irq
> wake up the platform and thus triggered a resume? Or you mean that
> even that did not work?
> 
>> As my understanding, it's helpful that wakeup-event is used when device is suspended.
> 
> This feature is typically used for devices using "autosuspend", like
> Android devices. Otherwise you likely do not want to wakeup the
> platform when inserting/removing a card, but that is another story.
> :-)
Hi Ulf,

Then, my case should be another story. I will re-test with using "autosuspend".
I didn't use the autosuspend.
> 
>> How do you call mmc_detect_change() during suspended?

In my case,
1, entered suspended.
2. card is inserted..then didn't get the triggered irq.
If get the triggered irq, need to set irq_set_irq_wake(cd_irq, 1).

So i have asked to you how called mmc_detect_change().
In my-case, didn't call mmc_detect_change().

I will re-test and share the result.

Best Regards,
Jaehoon Chung
> 
> To try to clarify things a bit, the sequence is typically like this:
> 
> 1. We enter suspend.
> 2. A card is inserted and a card detect irq is triggered. The
> corresponding irq handler gets called which then issue
> mmc_detect_change.
> 3. mmc_detect_change recognize the device as a wakeup capable device
> and thus issue a pm_wakeup_event(5s) to prevent a new trigger of
> suspend.
> 4. A rescan work is scheduled.
> 5. System continues resuming.
> 6. After PM_POST_SUSPEND notification (mmc_pm_notify), rescan is
> enabled and a new work re-scheduled.
> 7. The rescan work detects the new card and user space soon gets
> notified about it.
> 8. User space gets the notification and can act on it.
> 9. The timeout of the pm_wakeup_event has elapsed, allowing a new
> suspend to be triggered.
> 
> 
> Kind regards
> Ulf Hansson
> 
>>
>> Best Regards,
>> Jaehoon Chung
>>>
>>> ---
>>>  drivers/mmc/core/core.c |   39 +++++++++++++++++++++++++++------------
>>>  1 file changed, 27 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index bf18b6b..3e8229e 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/log2.h>
>>>  #include <linux/regulator/consumer.h>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/pm_wakeup.h>
>>>  #include <linux/suspend.h>
>>>  #include <linux/fault-inject.h>
>>>  #include <linux/random.h>
>>> @@ -1723,6 +1724,28 @@ void mmc_detach_bus(struct mmc_host *host)
>>>       mmc_bus_put(host);
>>>  }
>>>
>>> +static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>>> +                             bool cd_irq)
>>> +{
>>> +#ifdef CONFIG_MMC_DEBUG
>>> +     unsigned long flags;
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     WARN_ON(host->removed);
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>> +#endif
>>> +
>>> +     /*
>>> +      * If the device is configured as wakeup, we prevent a new sleep for
>>> +      * 5 s to give provision for user space to consume the event.
>>> +      */
>>> +     if (cd_irq && !(host->caps & MMC_CAP_NEEDS_POLL) &&
>>> +             device_can_wakeup(mmc_dev(host)))
>>> +             pm_wakeup_event(mmc_dev(host), 5000);
>>> +
>>> +     host->detect_change = 1;
>>> +     mmc_schedule_delayed_work(&host->detect, delay);
>>> +}
>>> +
>>>  /**
>>>   *   mmc_detect_change - process change of state on a MMC socket
>>>   *   @host: host which changed state.
>>> @@ -1735,16 +1758,8 @@ void mmc_detach_bus(struct mmc_host *host)
>>>   */
>>>  void mmc_detect_change(struct mmc_host *host, unsigned long delay)
>>>  {
>>> -#ifdef CONFIG_MMC_DEBUG
>>> -     unsigned long flags;
>>> -     spin_lock_irqsave(&host->lock, flags);
>>> -     WARN_ON(host->removed);
>>> -     spin_unlock_irqrestore(&host->lock, flags);
>>> -#endif
>>> -     host->detect_change = 1;
>>> -     mmc_schedule_delayed_work(&host->detect, delay);
>>> +     _mmc_detect_change(host, delay, true);
>>>  }
>>> -
>>>  EXPORT_SYMBOL(mmc_detect_change);
>>>
>>>  void mmc_init_erase(struct mmc_card *card)
>>> @@ -2423,7 +2438,7 @@ int mmc_detect_card_removed(struct mmc_host *host)
>>>                        * rescan handle the card removal.
>>>                        */
>>>                       cancel_delayed_work(&host->detect);
>>> -                     mmc_detect_change(host, 0);
>>> +                     _mmc_detect_change(host, 0, false);
>>>               }
>>>       }
>>>
>>> @@ -2505,7 +2520,7 @@ void mmc_start_host(struct mmc_host *host)
>>>               mmc_power_off(host);
>>>       else
>>>               mmc_power_up(host);
>>> -     mmc_detect_change(host, 0);
>>> +     _mmc_detect_change(host, 0, false);
>>>  }
>>>
>>>  void mmc_stop_host(struct mmc_host *host)
>>> @@ -2724,7 +2739,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>>>               spin_lock_irqsave(&host->lock, flags);
>>>               host->rescan_disable = 0;
>>>               spin_unlock_irqrestore(&host->lock, flags);
>>> -             mmc_detect_change(host, 0);
>>> +             _mmc_detect_change(host, 0, false);
>>>
>>>       }
>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

