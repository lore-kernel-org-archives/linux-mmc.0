From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 7/8] mmc: sdhci: Remove redundant runtime PM calls
Date: Tue, 5 Apr 2016 14:40:04 +0300
Message-ID: <5703A414.8070005@intel.com>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
 <1459236673-5639-7-git-send-email-ulf.hansson@linaro.org>
 <56FE2739.2030100@intel.com>
 <CAPDyKFpOdS2C9_NjqMxtWRK4-qGc1gjL6TtKVAyBqVEot=u3gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12096 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757827AbcDELnr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2016 07:43:47 -0400
In-Reply-To: <CAPDyKFpOdS2C9_NjqMxtWRK4-qGc1gjL6TtKVAyBqVEot=u3gg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 01/04/16 12:46, Ulf Hansson wrote:
> On 1 April 2016 at 09:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 29/03/16 10:31, Ulf Hansson wrote:
>>> Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
>>> devices"), made some calls to the runtime PM API from the driver
>>> redundant. Especially those which deals with runtime PM reference
>>> counting, so let's remove them.
>>>
>>> Moreover as SDHCI have its own wrapper functions for runtime PM these
>>> becomes superfluous, so let's remove them as well.
>>>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Looks good, but I have one comment below.
>>
> 
> [...]
> 
>>>
>>>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>>> @@ -1668,7 +1646,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>>       struct sdhci_host *host = mmc_priv(mmc);
>>>       unsigned long flags;
>>>
>>> -     sdhci_runtime_pm_get(host);
>>> +     pm_runtime_get_sync(mmc_dev(mmc));
>>
>> Why can't this be moved into the core as well?  At the least, there should
>> be a comment here and explanation in the commit message.
> 
> That's indeed a very good question! :-)
> 
> SDHCI is a special case for how a host driver deals with SDIO IRQs as
> it's the only user of MMC_CAP2_SDIO_IRQ_NOTHREAD.
> 
> It means it has its own SDIO IRQ thread (threaded IRQ) which will
> invoke sdio_run_irqs() to consume a received SDIO IRQ. Other host
> drivers are using the mmc_signal_sdio_irq() API to deal with this,
> which behaves a bit different.
> 
> The sdio_run_irqs() API claims the host (mmc_claim|release_host())
> before it starts to consume the SDIO IRQ. This triggers the host to be
> runtime resumed before the host ops ->enable_sdio_irq() gets called.
> So, actually it means it *should* be safe to remove
> pm_runtime_get|put() in it's current form from within
> sdhci_enable_sdio_irq()...

Sorry for slow reply.

Yes it looks safe.  Please remove it.

> 
> Although, I wonder how SDHCI can allow to have SDIO IRQs enabled
> without *keeping* the host runtime resumed, because I fail to see that
> any wakeups are being configured when the host becomes runtime
> suspended. I may be missing something, but what do you think?

As you probably know, it was done by Russell King, for the sdhci_esdhc-imx
driver by the look of it.  The clocks are left on during runtime suspend iff
the SDIO IRQ is enabled, and IIRC it says the registers are accessible.  I
would not expect any wakeups would need to be configured because the system
is not asleep.  I don't know exactly what Russell was aiming for, but one
advantage is that the host controller will go to a lower power state (clocks
off) when the SDIO IRQ is not enabled.

