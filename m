From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 4/4] mmc: core: Support aggressive power management for (e)MMC/SD
Date: Thu, 2 May 2013 13:35:16 +0200
Message-ID: <CAPDyKFp3NGC13qOT=y=MxiANO9ecU3y3vMFTYHfiM-56AT_6-g@mail.gmail.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
	<1366106437-18004-5-git-send-email-ulf.hansson@stericsson.com>
	<5182422C.6000902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:51085 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920Ab3EBLfS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 May 2013 07:35:18 -0400
Received: by mail-vc0-f173.google.com with SMTP id ht11so358679vcb.4
        for <linux-mmc@vger.kernel.org>; Thu, 02 May 2013 04:35:17 -0700 (PDT)
In-Reply-To: <5182422C.6000902@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

On 2 May 2013 12:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/04/13 13:00, Ulf Hansson wrote:
>> Aggressive power management is suitable when saving power is
>> essential. At request inactivity timeout, aka pm runtime
>> autosuspend timeout, the card will be suspended.
>>
>> Once a new request arrives, the card will be re-initalized and
>> thus the first request will suffer from a latency. This latency
>> is card-specific, experiments has shown in general that SD-cards
>> has quite poor initialization time, around 300ms-1100ms. eMMC is
>> not surprisingly far better but still a couple of hundreds of ms
>> has been observed.
>>
>> Except for the request latency, it is important to know that
>> suspending the card will also prevent the card from executing
>> internal house-keeping operations in idle mode. This could mean
>> degradation in performance.
>>
>> To use this feature make sure the request inactivity timeout is
>> chosen carefully. This has not been done as a part of this patch.
>>
>> Enable this feature by using host cap MMC_CAP_AGGRESSIVE_PM and
>> by setting CONFIG_MMC_UNSAFE_RESUME.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Maya Erez <merez@codeaurora.org>
>> Cc: Subhash Jadavani <subhashj@codeaurora.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Kevin Liu <kliu5@marvell.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Daniel Drake <dsd@laptop.org>
>> Cc: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>>  drivers/mmc/core/mmc.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/core/sd.c    |   42 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mmc/host.h |    2 +-
>>  3 files changed, 86 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index bf19058..8dfbc84 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1454,6 +1454,47 @@ static int mmc_resume(struct mmc_host *host)
>>       return err;
>>  }
>>
>> +
>> +/*
>> + * Callback for runtime_suspend.
>> + */
>> +static int mmc_runtime_suspend(struct mmc_host *host)
>> +{
>> +     int err;
>> +
>> +     if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>> +             return 0;
>> +
>
> mmc_power_off() needs to be within mmc_claim_host() / mmc_release_host().
>
> Claiming is nested, so you can out put mmc_claim_host() here:
>
>         mmc_claim_host(host);

OK

>
>
>> +     err = mmc_suspend(host);
>> +     if (err) {
>> +             pr_err("%s: error %d doing aggessive suspend\n",
>> +                     mmc_hostname(host), err);
>> +             return err;
>
>                 goto out;
>
>> +     }
>> +
>> +     mmc_power_off(host);
>
> out:
>         mmc_release_host(host);
>

OK

>> +     return err;
>> +}
>> +
>> +/*
>> + * Callback for runtime_resume.
>> + */
>> +static int mmc_runtime_resume(struct mmc_host *host)
>> +{
>> +     int err;
>> +
>> +     if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>> +             return 0;
>> +
>> +     mmc_power_up(host);
>
> As above
>

OK

>> +     err = mmc_resume(host);
>> +     if (err)
>> +             pr_err("%s: error %d doing aggessive resume\n",
>> +                     mmc_hostname(host), err);
>> +
>> +     return err;
>
> The power is on - leaving the device in a RPM_SUSPENDED state does not seem
> useful so better to return zero here.

OK

>
>> +}
>> +
>>  static int mmc_power_restore(struct mmc_host *host)
>>  {
>>       int ret;
>> @@ -1514,6 +1555,8 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
>>       .detect = mmc_detect,
>>       .suspend = mmc_suspend,
>>       .resume = mmc_resume,
>> +     .runtime_suspend = mmc_runtime_suspend,
>> +     .runtime_resume = mmc_runtime_resume,
>>       .power_restore = mmc_power_restore,
>>       .alive = mmc_alive,
>>  };
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 30387d6..e0458f9 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -1095,6 +1095,46 @@ static int mmc_sd_resume(struct mmc_host *host)
>>       return err;
>>  }
>>
>> +/*
>> + * Callback for runtime_suspend.
>> + */
>> +static int mmc_sd_runtime_suspend(struct mmc_host *host)
>> +{
>> +     int err;
>> +
>> +     if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>> +             return 0;
>> +
>> +     err = mmc_sd_suspend(host);
>> +     if (err) {
>> +             pr_err("%s: error %d doing aggessive suspend\n",
>> +                     mmc_hostname(host), err);
>> +             return err;
>> +     }
>> +
>> +     mmc_power_off(host);
>
> As above

OK

>
>> +     return err;
>> +}
>> +
>> +/*
>> + * Callback for runtime_resume.
>> + */
>> +static int mmc_sd_runtime_resume(struct mmc_host *host)
>> +{
>> +     int err;
>> +
>> +     if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>> +             return 0;
>> +
>> +     mmc_power_up(host);
>
> As above

OK

>
>> +     err = mmc_sd_resume(host);
>> +     if (err)
>> +             pr_err("%s: error %d doing aggessive resume\n",
>> +                     mmc_hostname(host), err);
>> +
>> +     return err;
>
> As above

OK

>
>         return 0
>
>> +}
>> +
>>  static int mmc_sd_power_restore(struct mmc_host *host)
>>  {
>>       int ret;
>> @@ -1119,6 +1159,8 @@ static const struct mmc_bus_ops mmc_sd_ops = {
>>  static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
>>       .remove = mmc_sd_remove,
>>       .detect = mmc_sd_detect,
>> +     .runtime_suspend = mmc_sd_runtime_suspend,
>> +     .runtime_resume = mmc_sd_runtime_resume,
>>       .suspend = mmc_sd_suspend,
>>       .resume = mmc_sd_resume,
>>       .power_restore = mmc_sd_power_restore,
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 17d7148..cec6684 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -239,7 +239,7 @@ struct mmc_host {
>>  #define MMC_CAP_SPI          (1 << 4)        /* Talks only SPI protocols */
>>  #define MMC_CAP_NEEDS_POLL   (1 << 5)        /* Needs polling for card-detection */
>>  #define MMC_CAP_8_BIT_DATA   (1 << 6)        /* Can the host do 8 bit transfers */
>> -
>> +#define MMC_CAP_AGGRESSIVE_PM        (1 << 7)        /* Suspend (e)MMC/SD at idle  */
>
> Using a "cap" is not ideal here - it should really be under the control of
> user space.

Several other caps could be debated whether these should exist here as
well, but let's leave that to a separate discussion.
Until there are a solution for how to add new mmc features per host,
which should be runtime configurable, I believe this is the only way
we can do it.

Do note, that runtime pm can be disabled from user space, which
indirectly will prevent this feature from being used.

>
>>  #define MMC_CAP_NONREMOVABLE (1 << 8)        /* Nonremovable e.g. eMMC */
>>  #define MMC_CAP_WAIT_WHILE_BUSY      (1 << 9)        /* Waits while card is busy */
>>  #define MMC_CAP_ERASE                (1 << 10)       /* Allow erase/trim commands */
>>
>
