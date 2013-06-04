From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: core: Initiate suspend|resume from mmc bus
 instead of mmc host
Date: Tue, 4 Jun 2013 10:57:35 +0200
Message-ID: <CAPDyKFpPC32NgDyq5SM87HRTRuvkkpfme126EG1iTf7AEcj94w@mail.gmail.com>
References: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
	<1369918391-15277-5-git-send-email-ulf.hansson@stericsson.com>
	<51AD7B07.6050505@samsung.com>
	<CAPDyKFr_my24oKJGRnQSrub6Nr-vUVu_u+35jrh1csksB7pPag@mail.gmail.com>
	<51ADA99E.9070606@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:58497 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab3FDI5g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2013 04:57:36 -0400
Received: by mail-ve0-f173.google.com with SMTP id jw11so3610319veb.18
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2013 01:57:36 -0700 (PDT)
In-Reply-To: <51ADA99E.9070606@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 4 June 2013 10:47, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Thanks for your explanation.
>
> I have tested your patch with sdhci and dw-mmc controller.
> (It's working fine <eMMC/SD-card/SDIO> with exynos)

Thanks a lot for your help Jaehoon. So we could add your "Tested-by"
on the hole patch set then?

Kind regards
Ulf Hansson

>
> Best Regards,
> Jaehoon Chung
>
> On 06/04/2013 05:34 PM, Ulf Hansson wrote:
>> On 4 June 2013 07:28, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi Ulf,
>>>
>>> On 05/30/2013 09:53 PM, Ulf Hansson wrote:
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>
>>>> The host should be responsible to suspend|resume the host and not the
>>>> card. This patch changes this behaviour, by moving the responsiblity
>>>> to the mmc bus instead which already holds the card device.
>>>>
>>>> The exported functions mmc_suspend|resume_host are now to be considered
>>>> as depcrecated. Once all host drivers moves away from using them, we
>>>> can remove them. As of now, a successful error code is always returned.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> ---
>>>>  drivers/mmc/core/bus.c  |   15 ++++++++++++++-
>>>>  drivers/mmc/core/core.c |   26 +++-----------------------
>>>>  2 files changed, 17 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>>>> index d9e8c2b..2842684 100644
>>>> --- a/drivers/mmc/core/bus.c
>>>> +++ b/drivers/mmc/core/bus.c
>>>> @@ -127,10 +127,16 @@ static int mmc_bus_suspend(struct device *dev)
>>>>  {
>>>>       struct mmc_driver *drv = to_mmc_driver(dev->driver);
>>>>       struct mmc_card *card = mmc_dev_to_card(dev);
>>>> +     struct mmc_host *host = card->host;
>>>>       int ret = 0;
>>>>
>>>> -     if (dev->driver && drv->suspend)
>>>> +     if (dev->driver && drv->suspend) {
>>>>               ret = drv->suspend(card);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     ret = host->bus_ops->suspend(host);
>>> Need not to check whether host->bus_ops->suspend is existed or not?
>>
>> We don't need to check it here.
>>
>> It is only for those cards that were not removed from the
>> mmc_pm_notify function (PM_SUSPEND_PREPARE) that get suspended here.
>> And the validation of the bus_ops has then already been done.
>>
>>>>       return ret;
>>>>  }
>>>>
>>>> @@ -138,10 +144,17 @@ static int mmc_bus_resume(struct device *dev)
>>>>  {
>>>>       struct mmc_driver *drv = to_mmc_driver(dev->driver);
>>>>       struct mmc_card *card = mmc_dev_to_card(dev);
>>>> +     struct mmc_host *host = card->host;
>>>>       int ret = 0;
>>>>
>>>> +     ret = host->bus_ops->resume(host);
>>> Ditto
>>
>> See comment above. Moreover, in the case were a bus_ops>suspend
>> function exist, there also exist an bus_ops->resume function.
>>
>>
>> Kind regards
>> Ulf Hansson
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>> +     if (ret)
>>>> +             pr_warn("%s: error %d during resume (card was removed?)\n",
>>>> +                     mmc_hostname(host), ret);
>>>> +
>>>>       if (dev->driver && drv->resume)
>>>>               ret = drv->resume(card);
>>>> +
>>>>       return ret;
>>>>  }
>>>>  #endif
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index da3b907..49a5bca 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -2619,16 +2619,8 @@ EXPORT_SYMBOL(mmc_cache_ctrl);
>>>>   */
>>>>  int mmc_suspend_host(struct mmc_host *host)
>>>>  {
>>>> -     int err = 0;
>>>> -
>>>> -     mmc_bus_get(host);
>>>> -     if (host->bus_ops && !host->bus_dead) {
>>>> -             if (host->bus_ops->suspend)
>>>> -                     err = host->bus_ops->suspend(host);
>>>> -     }
>>>> -     mmc_bus_put(host);
>>>> -
>>>> -     return err;
>>>> +     /* This function is deprecated */
>>>> +     return 0;
>>>>  }
>>>>  EXPORT_SYMBOL(mmc_suspend_host);
>>>>
>>>> @@ -2638,19 +2630,7 @@ EXPORT_SYMBOL(mmc_suspend_host);
>>>>   */
>>>>  int mmc_resume_host(struct mmc_host *host)
>>>>  {
>>>> -     int err;
>>>> -
>>>> -     mmc_bus_get(host);
>>>> -     if (host->bus_ops && !host->bus_dead) {
>>>> -             BUG_ON(!host->bus_ops->resume);
>>>> -             err = host->bus_ops->resume(host);
>>>> -             if (err)
>>>> -                     pr_warning("%s: error %d during resume "
>>>> -                                         "(card was removed?)\n",
>>>> -                                         mmc_hostname(host), err);
>>>> -     }
>>>> -     mmc_bus_put(host);
>>>> -
>>>> +     /* This function is deprecated */
>>>>       return 0;
>>>>  }
>>>>  EXPORT_SYMBOL(mmc_resume_host);
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
