From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: core: Remove unnecessary check for the remove callback
Date: Fri, 31 May 2013 10:11:52 +0200
Message-ID: <CAPDyKFrgytOSuhTCUxC+aS0YV+6CvC0bpXofc4qHWFohK-jxnw@mail.gmail.com>
References: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
	<1369918391-15277-2-git-send-email-ulf.hansson@stericsson.com>
	<51A854B8.3020605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:36031 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab3EaILx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 May 2013 04:11:53 -0400
Received: by mail-vb0-f52.google.com with SMTP id p12so829566vbe.39
        for <linux-mmc@vger.kernel.org>; Fri, 31 May 2013 01:11:52 -0700 (PDT)
In-Reply-To: <51A854B8.3020605@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 31 May 2013 09:43, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Ulf,
>
> According to your commit message, host->bus_ops is also always existed, isn't?

I am saying that the .remove callback always exist. Maybe I should
clarify it further somehow?

Kind regards
Ulf Hansson

>
> Best Regards,
> Jaehoon Chung
>
> On 05/30/2013 09:53 PM, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> For every bus_ops type the .remove callback always exist, thus there
>> are no need to check the existence of it, before we decide to call it.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/core.c |   11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e9a104b..d2ee282 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2483,9 +2483,7 @@ void mmc_stop_host(struct mmc_host *host)
>>       mmc_bus_get(host);
>>       if (host->bus_ops && !host->bus_dead) {
>>               /* Calling bus_ops->remove() with a claimed host can deadlock */
>> -             if (host->bus_ops->remove)
>> -                     host->bus_ops->remove(host);
>> -
>> +             host->bus_ops->remove(host);
>>               mmc_claim_host(host);
>>               mmc_detach_bus(host);
>>               mmc_power_off(host);
>> @@ -2638,8 +2636,7 @@ int mmc_suspend_host(struct mmc_host *host)
>>                        * bus_ops->remove() with a claimed host can
>>                        * deadlock.)
>>                        */
>> -                     if (host->bus_ops->remove)
>> -                             host->bus_ops->remove(host);
>> +                     host->bus_ops->remove(host);
>>                       mmc_claim_host(host);
>>                       mmc_detach_bus(host);
>>                       mmc_power_off(host);
>> @@ -2722,9 +2719,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>>                       break;
>>
>>               /* Calling bus_ops->remove() with a claimed host can deadlock */
>> -             if (host->bus_ops->remove)
>> -                     host->bus_ops->remove(host);
>> -
>> +             host->bus_ops->remove(host);
>>               mmc_claim_host(host);
>>               mmc_detach_bus(host);
>>               mmc_power_off(host);
>>
>
