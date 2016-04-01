From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/8] mmc: sdhci: Remove redundant runtime PM calls
Date: Fri, 1 Apr 2016 11:46:27 +0200
Message-ID: <CAPDyKFpOdS2C9_NjqMxtWRK4-qGc1gjL6TtKVAyBqVEot=u3gg@mail.gmail.com>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
	<1459236673-5639-7-git-send-email-ulf.hansson@linaro.org>
	<56FE2739.2030100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38827 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbcDAJq3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2016 05:46:29 -0400
Received: by mail-wm0-f44.google.com with SMTP id 20so15921027wmh.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2016 02:46:28 -0700 (PDT)
In-Reply-To: <56FE2739.2030100@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 1 April 2016 at 09:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 29/03/16 10:31, Ulf Hansson wrote:
>> Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
>> devices"), made some calls to the runtime PM API from the driver
>> redundant. Especially those which deals with runtime PM reference
>> counting, so let's remove them.
>>
>> Moreover as SDHCI have its own wrapper functions for runtime PM these
>> becomes superfluous, so let's remove them as well.
>>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Looks good, but I have one comment below.
>

[...]

>>
>>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>> @@ -1668,7 +1646,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>       struct sdhci_host *host = mmc_priv(mmc);
>>       unsigned long flags;
>>
>> -     sdhci_runtime_pm_get(host);
>> +     pm_runtime_get_sync(mmc_dev(mmc));
>
> Why can't this be moved into the core as well?  At the least, there should
> be a comment here and explanation in the commit message.

That's indeed a very good question! :-)

SDHCI is a special case for how a host driver deals with SDIO IRQs as
it's the only user of MMC_CAP2_SDIO_IRQ_NOTHREAD.

It means it has its own SDIO IRQ thread (threaded IRQ) which will
invoke sdio_run_irqs() to consume a received SDIO IRQ. Other host
drivers are using the mmc_signal_sdio_irq() API to deal with this,
which behaves a bit different.

The sdio_run_irqs() API claims the host (mmc_claim|release_host())
before it starts to consume the SDIO IRQ. This triggers the host to be
runtime resumed before the host ops ->enable_sdio_irq() gets called.
So, actually it means it *should* be safe to remove
pm_runtime_get|put() in it's current form from within
sdhci_enable_sdio_irq()...

Although, I wonder how SDHCI can allow to have SDIO IRQs enabled
without *keeping* the host runtime resumed, because I fail to see that
any wakeups are being configured when the host becomes runtime
suspended. I may be missing something, but what do you think?

[...]

Kind regards
Uffe
