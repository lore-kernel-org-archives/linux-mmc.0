From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 8/8] mmc: core: use the broken-cd for non-removable card
Date: Tue, 28 Jan 2014 12:21:50 +0100
Message-ID: <CAPDyKFp-Q1u_YLwc7ELLCaf44umF1bE2jd0X5e3bf0+yEPyB5Q@mail.gmail.com>
References: <52E7695B.2050504@samsung.com>
	<CAPDyKFoXS5BMzHem3ahOVkdgC8YBrQXcQGyavSeLhn9zVvfNag@mail.gmail.com>
	<52E78BC9.9010209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50026 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbaA1LVv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 06:21:51 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so258898qab.40
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2014 03:21:50 -0800 (PST)
In-Reply-To: <52E78BC9.9010209@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Arnd Bergmann <arnd@arndb.de>, Seungwon Jeon <tgih.jun@samsung.com>

On 28 January 2014 11:51, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf.
>
> On 01/28/2014 07:32 PM, Ulf Hansson wrote:
>> On 28 January 2014 09:24, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Some SoC is used the broken card-detection.
>>> And it should be also used the "non-removable".
>>> Even if card is "non-removable", it didn't always use the cd-gpio.
>>>
>>> If it's used only broken-cd, then card-detect interrupt is polling.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>>  drivers/mmc/core/core.c |    4 ++--
>>>  drivers/mmc/core/host.c |    6 +++---
>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 098374b..df732aa 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -2460,8 +2460,8 @@ void mmc_rescan(struct work_struct *work)
>>>          */
>>>         mmc_bus_put(host);
>>>
>>> -       if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
>>> -                       host->ops->get_cd(host) == 0) {
>>> +       if (host->ops->get_cd && host->ops->get_cd(host) == 0 &&
>>> +                       !(host->caps & MMC_CAP_NONREMOVABLE)) {
>>
>> What's the difference here?
>
> eMMC is non-removable card. So i added the "non-removable" property at dt file.
> Then first checking !(host->caps & MMC_CAP_NONREMOVABLE), and didn't call get_cd().
> In case of dw-mmc.c, after calling get_cd(), CARD_PRESENT bit is set at dw_mci_get_cd().
> I didn't check other driver how it work.
> If you didn't this change, i will change the dw-mmc controller.

Thanks for the clarification.

I would then suggest you to change in dw-mmc instead, since I think
using the MMC_CAP_NONREMOVABLE flag, indicates that the .get_cd
callback is not needed.

Kind regards
Ulf Hansson

>
>>
>>>                 mmc_claim_host(host);
>>>                 mmc_power_off(host);
>>>                 mmc_release_host(host);
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index 4b81c93..52a64fe 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -356,6 +356,9 @@ int mmc_of_parse(struct mmc_host *host)
>>>          * configuration is performed.
>>>          */
>>>
>>> +       if (of_find_property(np, "broken-cd", &len))
>>> +               host->caps |= MMC_CAP_NEEDS_POLL;
>>> +
>>
>> No. There are no meaning in using MMC_CAP_NEEDS_POLL in conjunction
>> with MMC_CAP_NONREMOVABLE.
>>
>> Using MMC_CAP_NONREMOVABLE, will allow mmc_rescan to detect a card  -
>> only for one iteration. Thus MMC_CAP_NEEDS_POLL will have no effect.
>
> Sorry. You're right. It's no meaning. I will maintain the original code.
>
> Best Regards,
> Jaehoon Chung
>>
>> Kind regards
>> Uffe
>>
>>
>>>         /* Parse Card Detection */
>>>         if (of_find_property(np, "non-removable", &len)) {
>>>                 host->caps |= MMC_CAP_NONREMOVABLE;
>>> @@ -364,9 +367,6 @@ int mmc_of_parse(struct mmc_host *host)
>>>
>>>                 explicit_inv_cd = of_property_read_bool(np, "cd-inverted");
>>>
>>> -               if (of_find_property(np, "broken-cd", &len))
>>> -                       host->caps |= MMC_CAP_NEEDS_POLL;
>>> -
>>>                 gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
>>>                 if (gpio == -EPROBE_DEFER)
>>>                         return gpio;
>>> --
>>> 1.7.9.5
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
