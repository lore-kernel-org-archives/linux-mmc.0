From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 1/4] mmc: Add quirk to disable SDR50 mode
Date: Mon, 9 Nov 2015 10:15:57 -0800
Message-ID: <5640E2DD.7080505@broadcom.com>
References: <1446763200-10234-1-git-send-email-alcooperx@gmail.com>
 <CAPDyKFrhtoDwe82Zg4YP4eU=xO6zE1pZTcRSnzSeHGRCzgu+5w@mail.gmail.com>
 <563D3E0F.70906@broadcom.com>
 <CAPDyKFqpFu3aEs5vLc9dhpj4YmCAXKdhj4k2qKgd2Zaw8OACow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:37272 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbKISQM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 13:16:12 -0500
In-Reply-To: <CAPDyKFqpFu3aEs5vLc9dhpj4YmCAXKdhj4k2qKgd2Zaw8OACow@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Al Cooper <alcooperx@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On 15-11-09 02:45 AM, Ulf Hansson wrote:
> On 7 November 2015 at 00:55, Scott Branden <sbranden@broadcom.com> wrote:
>> Hi Ulf,
>>
>> On 15-11-06 12:14 AM, Ulf Hansson wrote:
>>>
>>> On 5 November 2015 at 23:39, Al Cooper <alcooperx@gmail.com> wrote:
>>>>
>>>> Add quirk to disable SDR50 mode for controllers/boards that have
>>>> problems with this mode.
>>>
>>>
>>> No thanks! No more quirks please!
>>>
>>
>> I'm fine with not having this quirk added (I don't need this one but use
>> multiple of the other quirks in the driver)  But, what if I also needed it
>> in my driver?  When do we determine when a quirk should be added to sdhci.c
>> or not.  What about existing quirks - should the current ones be moved to
>> multiple existing drivers?
>
> The sdhci driver should turn into a library providing generic helper
> functions. Each host can then pick which functions to use and also
> deal with its own "quirks", instead of managing those in generic code.
>
> I guess we might end up getting a bit more code in total, but on the
> other hand the code would be better optimized and also maintainable.
>

OK, if I need to add any new quirks I will look into this a bit more and 
see if it can be done.  I don't have a need to do this right now so if 
anyone else wants to have a look feel free to.

>>>
>>> Kind regards
>>> Uffe
>>>
>>>>
>>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>>> ---
>>>>    drivers/mmc/host/sdhci.c | 3 +++
>>>>    drivers/mmc/host/sdhci.h | 2 ++
>>>>    2 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index b48565e..71067c7 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -3176,6 +3176,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>           } else if (caps[1] & SDHCI_SUPPORT_SDR50)
>>>>                   mmc->caps |= MMC_CAP_UHS_SDR50;
>>>>
>>>> +       if (host->quirks2 & SDHCI_QUIRK2_BROKEN_SDR50)
>>>> +               mmc->caps &= ~MMC_CAP_UHS_SDR50;
>>>> +
>>
>> Perhaps a lot of these quirks can be solved by having a generic mechanism to
>> override any of the values in the caps registers rather than adding all
>> these quirks?
>
> Sure, it makes sense if it can decreases the number of quirks!
>
I think it can in some cases.  In fact - the hardware designers do not 
even set the correct settings in the caps register on some of the SoCs. 
  The caps register does not appear to be used in the hardware other 
than for "info" purposes to read by the driver - and when the info is 
wrong this may lead to many of the quirks that have been added by others 
over the years.
>>
>>>>           if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
>>>>               (caps[1] & SDHCI_SUPPORT_HS400))
>>>>                   mmc->caps2 |= MMC_CAP2_HS400;
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index 9d4aa31..0941c94 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -412,6 +412,8 @@ struct sdhci_host {
>>>>    #define SDHCI_QUIRK2_ACMD23_BROKEN                     (1<<14)
>>>>    /* Broken Clock divider zero in controller */
>>>>    #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN             (1<<15)
>>>> +/* Controller does not support SDR50 */
>>>> +#define SDHCI_QUIRK2_BROKEN_SDR50                      (1<<16)
>>>>    /*
>>>>     * When internal clock is disabled, a delay is needed before modifying
>>>> the
>>>>     * SD clock frequency or enabling back the internal clock.
>>>> --
>>>> 1.9.0.138.g2de3478
>>>>
>>
>> Regards,
>>   Scott
>
> Kind regards
> Uffe
>
Thanks,
  Scott
