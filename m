From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: slot-gpio: Add support to enable irq wake on cd_irq
Date: Fri, 28 Apr 2017 12:27:29 +0200
Message-ID: <CAPDyKFqACm+Q9xNVro=T+KkUL4-3JB2bkCMhc-Z6ynK+qr2v8A@mail.gmail.com>
References: <1492607363-5346-1-git-send-email-adrian.hunter@intel.com>
 <1492607363-5346-2-git-send-email-adrian.hunter@intel.com>
 <c33cc643-0f35-f92f-37b2-62e7ccba0209@intel.com> <CAPDyKFpmvk93qn_B-o7+UW7t4JSTm9w=2T=1Mov-iKxfCADz=Q@mail.gmail.com>
 <a0a8df6c-cda6-f291-705a-f25f9c995813@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34624 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968856AbdD1K1b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Apr 2017 06:27:31 -0400
Received: by mail-qk0-f169.google.com with SMTP id y63so48949660qkd.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Apr 2017 03:27:30 -0700 (PDT)
In-Reply-To: <a0a8df6c-cda6-f291-705a-f25f9c995813@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 28 April 2017 at 09:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 25/04/17 23:02, Ulf Hansson wrote:
>> On 25 April 2017 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 19/04/17 16:09, Adrian Hunter wrote:
>>>> Add mmc_gpio_cd_enable_wake() to allow drivers to enable irq wake on the
>>>> card detect irq.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>
>>> Any comments on this?
>>
>> Not yet. I need some more thinking about this.
>
> How is the thinking going ;-)

To many things at the moment. Anyway, to me this is material for 4.13.
I will get back to it as soon as I can.

Kind regards
Uffe

>
>>
>> However, at first glance it seems very reasonable to make the core to
>> help with cd wakeup irqs.
>>
>> Related topic: I have a plan of avoiding the mmc_pm_notify() to punt a
>> work at resume, in case the host has enabled cd wakeup irqs. The
>> reason is that we are sometimes resuming removable cards, just to find
>> out that those are still there. I would be interesting to know how
>> $subject change can help with this as well. I intend to keep this in
>> mind while I review this, just so you know. :-)
>>
>> Kind regards
>> Uffe
>>
>>>
>>>> ---
>>>>  drivers/mmc/core/core.c       |  5 ++++-
>>>>  drivers/mmc/core/slot-gpio.c  | 12 ++++++++++++
>>>>  include/linux/mmc/host.h      |  1 +
>>>>  include/linux/mmc/slot-gpio.h |  1 +
>>>>  4 files changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 0bb39795d484..6987976252ad 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -2828,8 +2828,11 @@ void mmc_stop_host(struct mmc_host *host)
>>>>       host->removed = 1;
>>>>       spin_unlock_irqrestore(&host->lock, flags);
>>>>  #endif
>>>> -     if (host->slot.cd_irq >= 0)
>>>> +     if (host->slot.cd_irq >= 0) {
>>>> +             if (host->slot.cd_wake_enabled)
>>>> +                     disable_irq_wake(host->slot.cd_irq);
>>>>               disable_irq(host->slot.cd_irq);
>>>> +     }
>>>>
>>>>       host->rescan_disable = 1;
>>>>       cancel_delayed_work_sync(&host->detect);
>>>> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
>>>> index a8450a8701e4..56e4edb9e63a 100644
>>>> --- a/drivers/mmc/core/slot-gpio.c
>>>> +++ b/drivers/mmc/core/slot-gpio.c
>>>> @@ -25,6 +25,7 @@ struct mmc_gpio {
>>>>       struct gpio_desc *cd_gpio;
>>>>       bool override_ro_active_level;
>>>>       bool override_cd_active_level;
>>>> +     bool cd_wake;
>>>>       irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>>>>       char *ro_label;
>>>>       char cd_label[0];
>>>> @@ -118,6 +119,15 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
>>>>  }
>>>>  EXPORT_SYMBOL(mmc_gpio_request_ro);
>>>>
>>>> +void mmc_gpio_cd_enable_wake(struct mmc_host *host)
>>>> +{
>>>> +     struct mmc_gpio *ctx = host->slot.handler_priv;
>>>> +
>>>> +     if (ctx && ctx->cd_gpio)
>>>> +             ctx->cd_wake = true;
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_gpio_cd_enable_wake);
>>>> +
>>>>  void mmc_gpiod_request_cd_irq(struct mmc_host *host)
>>>>  {
>>>>       struct mmc_gpio *ctx = host->slot.handler_priv;
>>>> @@ -151,6 +161,8 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
>>>>
>>>>       if (irq < 0)
>>>>               host->caps |= MMC_CAP_NEEDS_POLL;
>>>> +     else if (ctx->cd_wake && !enable_irq_wake(irq))
>>>> +             host->slot.cd_wake_enabled = true;
>>>>  }
>>>>  EXPORT_SYMBOL(mmc_gpiod_request_cd_irq);
>>>>
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index 21385ac0c9b1..78c544e296cd 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -184,6 +184,7 @@ struct mmc_async_req {
>>>>   */
>>>>  struct mmc_slot {
>>>>       int cd_irq;
>>>> +     bool cd_wake_enabled;
>>>>       void *handler_priv;
>>>>  };
>>>>
>>>> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
>>>> index 82f0d289f110..6af681d33a53 100644
>>>> --- a/include/linux/mmc/slot-gpio.h
>>>> +++ b/include/linux/mmc/slot-gpio.h
>>>> @@ -33,5 +33,6 @@ void mmc_gpio_set_cd_isr(struct mmc_host *host,
>>>>                        irqreturn_t (*isr)(int irq, void *dev_id));
>>>>  void mmc_gpiod_request_cd_irq(struct mmc_host *host);
>>>>  bool mmc_can_gpio_cd(struct mmc_host *host);
>>>> +void mmc_gpio_cd_enable_wake(struct mmc_host *host);
>>>>
>>>>  #endif
>>>>
>>>
>>
>
