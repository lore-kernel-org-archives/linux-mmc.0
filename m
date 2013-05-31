From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: core: Remove unnecessary check for the remove callback
Date: Fri, 31 May 2013 17:05:43 +0200
Message-ID: <CAPDyKFp8RB-pbgqmOrxQHaHrYHqbf1WNihJ6sq_a-iU_rjJaPw@mail.gmail.com>
References: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
	<1369918391-15277-2-git-send-email-ulf.hansson@stericsson.com>
	<51A854B8.3020605@samsung.com>
	<CAPDyKFrgytOSuhTCUxC+aS0YV+6CvC0bpXofc4qHWFohK-jxnw@mail.gmail.com>
	<51A85DCA.8040701@samsung.com>
	<CAPDyKFqYrLWYJ31WE69n9w4gX6Qu79+FiFrh5pZ0BfkgchFg1Q@mail.gmail.com>
	<51A88074.6090006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:37750 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab3EaPFo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 May 2013 11:05:44 -0400
Received: by mail-vb0-f48.google.com with SMTP id w8so1099484vbf.21
        for <linux-mmc@vger.kernel.org>; Fri, 31 May 2013 08:05:44 -0700 (PDT)
In-Reply-To: <51A88074.6090006@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 31 May 2013 12:50, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Ulf,
>
> Sorry..:-) I understood clear. it's my mis-understanding.

Hi Jaehoon,

OK, cool! :-)

Would be very nice if you had some time to check the other patches in
this series as well.

Thanks!

Ulf Hansson

>
> Best Regards,
> Jaehoon Chung
>
> On 05/31/2013 06:33 PM, Ulf Hansson wrote:
>> On 31 May 2013 10:22, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> On 05/31/2013 05:11 PM, Ulf Hansson wrote:
>>>> On 31 May 2013 09:43, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi Ulf,
>>>>>
>>>>> According to your commit message, host->bus_ops is also always existed, isn't?
>>>>
>>>> I am saying that the .remove callback always exist. Maybe I should
>>>> clarify it further somehow?
>>> Sorry if you are confused. My meaning is that according to your commit message,
>>> it didn't need also to check whether host->bus_ops is existed or not.
>>> For example,
>>> if (host->bus_ops && !host->bus_dead) {
>>
>> I really can't see this information in the commit msg, I guess we are
>> reading it differently :-)
>>
>> Anyway, I will rephrase it so it gets clear.
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>>
>>>> Kind regards
>>>> Ulf Hansson
>>>>
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>>
>>>>> On 05/30/2013 09:53 PM, Ulf Hansson wrote:
>>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>
>>>>>> For every bus_ops type the .remove callback always exist, thus there
>>>>>> are no need to check the existence of it, before we decide to call it.
>>>>>>
>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>> ---
>>>>>>  drivers/mmc/core/core.c |   11 +++--------
>>>>>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>> index e9a104b..d2ee282 100644
>>>>>> --- a/drivers/mmc/core/core.c
>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>> @@ -2483,9 +2483,7 @@ void mmc_stop_host(struct mmc_host *host)
>>>>>>       mmc_bus_get(host);
>>>>>>       if (host->bus_ops && !host->bus_dead) {
>>>>>>               /* Calling bus_ops->remove() with a claimed host can deadlock */
>>>>>> -             if (host->bus_ops->remove)
>>>>>> -                     host->bus_ops->remove(host);
>>>>>> -
>>>>>> +             host->bus_ops->remove(host);
>>>>>>               mmc_claim_host(host);
>>>>>>               mmc_detach_bus(host);
>>>>>>               mmc_power_off(host);
>>>>>> @@ -2638,8 +2636,7 @@ int mmc_suspend_host(struct mmc_host *host)
>>>>>>                        * bus_ops->remove() with a claimed host can
>>>>>>                        * deadlock.)
>>>>>>                        */
>>>>>> -                     if (host->bus_ops->remove)
>>>>>> -                             host->bus_ops->remove(host);
>>>>>> +                     host->bus_ops->remove(host);
>>>>>>                       mmc_claim_host(host);
>>>>>>                       mmc_detach_bus(host);
>>>>>>                       mmc_power_off(host);
>>>>>> @@ -2722,9 +2719,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>>>>>>                       break;
>>>>>>
>>>>>>               /* Calling bus_ops->remove() with a claimed host can deadlock */
>>>>>> -             if (host->bus_ops->remove)
>>>>>> -                     host->bus_ops->remove(host);
>>>>>> -
>>>>>> +             host->bus_ops->remove(host);
>>>>>>               mmc_claim_host(host);
>>>>>>               mmc_detach_bus(host);
>>>>>>               mmc_power_off(host);
>>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
