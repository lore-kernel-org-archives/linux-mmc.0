From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/8] mmc: sdhci: Remove redundant runtime PM calls
Date: Tue, 5 Apr 2016 16:38:42 +0200
Message-ID: <CAPDyKFp4L9sSMcURVeNO9DKRrYTAp32iEmgJmGEXn_ydESV7AQ@mail.gmail.com>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
	<1459236673-5639-7-git-send-email-ulf.hansson@linaro.org>
	<56FE2739.2030100@intel.com>
	<CAPDyKFpOdS2C9_NjqMxtWRK4-qGc1gjL6TtKVAyBqVEot=u3gg@mail.gmail.com>
	<5703A414.8070005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33431 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758280AbcDEOio (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 10:38:44 -0400
Received: by mail-wm0-f53.google.com with SMTP id f198so35086950wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2016 07:38:43 -0700 (PDT)
In-Reply-To: <5703A414.8070005@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

[...]

>>
>>>>
>>>>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>>>> @@ -1668,7 +1646,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>>>       struct sdhci_host *host = mmc_priv(mmc);
>>>>       unsigned long flags;
>>>>
>>>> -     sdhci_runtime_pm_get(host);
>>>> +     pm_runtime_get_sync(mmc_dev(mmc));
>>>
>>> Why can't this be moved into the core as well?  At the least, there should
>>> be a comment here and explanation in the commit message.
>>
>> That's indeed a very good question! :-)
>>
>> SDHCI is a special case for how a host driver deals with SDIO IRQs as
>> it's the only user of MMC_CAP2_SDIO_IRQ_NOTHREAD.
>>
>> It means it has its own SDIO IRQ thread (threaded IRQ) which will
>> invoke sdio_run_irqs() to consume a received SDIO IRQ. Other host
>> drivers are using the mmc_signal_sdio_irq() API to deal with this,
>> which behaves a bit different.
>>
>> The sdio_run_irqs() API claims the host (mmc_claim|release_host())
>> before it starts to consume the SDIO IRQ. This triggers the host to be
>> runtime resumed before the host ops ->enable_sdio_irq() gets called.
>> So, actually it means it *should* be safe to remove
>> pm_runtime_get|put() in it's current form from within
>> sdhci_enable_sdio_irq()...
>
> Sorry for slow reply.
>
> Yes it looks safe.  Please remove it.

Okay, v2 is on its way. Thanks!

>
>>
>> Although, I wonder how SDHCI can allow to have SDIO IRQs enabled
>> without *keeping* the host runtime resumed, because I fail to see that
>> any wakeups are being configured when the host becomes runtime
>> suspended. I may be missing something, but what do you think?
>
> As you probably know, it was done by Russell King, for the sdhci_esdhc-imx
> driver by the look of it.  The clocks are left on during runtime suspend iff
> the SDIO IRQ is enabled, and IIRC it says the registers are accessible.  I
> would not expect any wakeups would need to be configured because the system
> is not asleep.  I don't know exactly what Russell was aiming for, but one
> advantage is that the host controller will go to a lower power state (clocks
> off) when the SDIO IRQ is not enabled.

My interpretation of how runtime PM should be deployed, it's s that a
device shall not process data in the runtime suspend state. To do
that, it first needs to be runtime resumed. I think this conforms to
what the runtime PM documentation also recommends in section 2, Device
Runtime PM Callbacks.

Moreover I think it's an SoC specific detail whether a driver *can*
access a device's registers in the runtime suspend state (thus it
shouldn't do it). Especially, devices may reside in a PM domain, which
could enter a retention state, because all its devices are runtime
suspended. Typically for an ARM SoC is that devices looses their
register's context in such retention state.

Regarding remote wake-ups, if the device supports it, this could be
configured to trigger the device to be runtime resumed to allow it to
start process data again. Typically it means the wake-up IRQ handler
should call pm_runtime_resume() (or similar) to wake up the device
(and its potential PM domain).

In the MMC/SD/SDIO case, the relevant wake-ups settings concerns card
detect IRQ and the SDIO IRQ.

For runtime PM deployment; if SDIO IRQ is enabled but no remote
wake-up is supported, I think runtime PM suspend must be prevented.
Either via returning -EBUSY from the ->runtime_suspend() callback or
by increasing the runtime PM usage count.

The similar applies to card detect IRQ regarding runtime PM deployment.

For system PM, there is a few additional parameters to consider. In
some cases we might not care about wake-ups but in some other we do,
MMC_PM_WAKE_SDIO_IRQ is one of these cases.

I guess I should spend some time documenting this for MMC. :-)

Kind regards
Uffe
