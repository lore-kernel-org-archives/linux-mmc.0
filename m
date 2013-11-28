From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: don't limit discard timeout by data line
 timeout
Date: Thu, 28 Nov 2013 09:12:45 +0200
Message-ID: <5296ECED.9060106@intel.com>
References: <1385046445-29711-1-git-send-email-vladimir_zapolskiy@mentor.com> <528F4242.8040408@intel.com> <528F4D06.3080400@mentor.com> <528F5663.2050800@intel.com> <528F6113.2070009@mentor.com> <528F728D.3040004@intel.com> <528F7670.9040101@mentor.com> <52946412.6060001@intel.com> <5294CD6A.9000106@mentor.com> <5295AB97.4040907@intel.com> <52960860.8090807@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35481 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab3K1HFJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Nov 2013 02:05:09 -0500
In-Reply-To: <52960860.8090807@mleia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, linux-mmc@vger.kernel.org, Ed Sutter <ed.sutter@alcatel-lucent.com>, Chris Ball <cjb@laptop.org>

On 27/11/13 16:57, Vladimir Zapolskiy wrote:
> On 11/27/13 10:21, Adrian Hunter wrote:
>> On 26/11/13 18:33, Vladimir Zapolskiy wrote:
>>> On 11/26/13 11:04, Adrian Hunter wrote:
>>>> On 22/11/13 17:21, Vladimir Zapolskiy wrote:
>>>>> On 22.11.2013 16:04, Adrian Hunter wrote:
>>>>>> On 22/11/13 15:50, Vladimir Zapolskiy wrote:
>>>>>>> On 22.11.2013 14:04, Adrian Hunter wrote:
>>>>>>>> On 22/11/13 14:24, Vladimir Zapolskiy wrote:
>>>>>>>>> On 22.11.2013 12:38, Adrian Hunter wrote:
>>>>>>>>>> On 21/11/13 17:07, Vladimir Zapolskiy wrote:
>>>>>>>>>>> JEDEC specification defines quite high erase timeout value for 300ms
>>>>>>>>>>> multiplied by erase group number, and SD Host Controller
>>>>>>>>>>> specification
>>>>>>>>>>> data line timeout may be much less, e.g. 2^13 / 52MHz ~ 160us.
>>>>>>>>>>>
>>>>>>>>>>>>        From block layer and MMC perfromance perspective it is
>>>>>>>>>>>> desirable
>>>>>>>>>>>> that
>>>>>>>>>>> millions of erase groups are discarded at once, so there is no much
>>>>>>>>>>> sense to limit maximum erase timeout by data line timeout, if a
>>>>>>>>>>> controller handles correctly erase operation without indication of
>>>>>>>>>>> data line timeout.
>>>>>>>>>>
>>>>>>>>>> Would you explain that some more.  Do you mean that:
>>>>>>>>>>         a) it does not have a timeout
>>>>>>>>>
>>>>>>>>> JEDEC defines a timeout on erase/trim operations, also in
>>>>>>>>> drivers/mmc/core/core.c
>>>>>>>>> there is a reasonable enough 10 minutes limitation for discard
>>>>>>>>> operations.
>>>>>>>>>
>>>>>>>>>>         b) it has a timeout which is less than the timeout specified
>>>>>>>>>> by the
>>>>>>>>>> standard but the operation nevertheless completes
>>>>>>>>>
>>>>>>>>> SDHC data line timeout is enormously less than erase group timeout,
>>>>>>>>> and
>>>>>>>>> trivial testing shows that those two timeouts are independent,
>>>>>>>>> probably
>>>>>>>>> except some particular cases of controllers not known before commits
>>>>>>>>> 58d1246db3 and e056a1b5b.
>>>>>>>>>
>>>>>>>>> According to the currently implemented logic, mmc_do_erase()
>>>>>>>>> commonly is
>>>>>>>>> instructed to discard 1-2 erase groups at maximum, however it tends
>>>>>>>>> to be
>>>>>>>>> capable to successfully discard millions of erase groups at once
>>>>>>>>> ignoring
>>>>>>>>> that SDHC data line timeout limitation.
>>>>>>>>>
>>>>>>>>
>>>>>>>> You seem to be trying to say that the SDHCI spec. says that the host
>>>>>>>> controller does not timeout erase operations or uses a different
>>>>>>>> timeout
>>>>>>>> than the one programmed in the "Timeout Control Register".  Where is
>>>>>>>> that is
>>>>>>>> the SDHCI spec?
>>>>>>>
>>>>>>> According to the spec a host controller timeouts erase operations
>>>>>>> like any
>>>>>>> other R1B command.
>>>>>>>
>>>>>>> So in your opinion, should there be SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>>>>>>> instead
>>>>>>> of the new quirk?
>>>>>>
>>>>>> I don't understand how SDHCI_QUIRK_BROKEN_TIMEOUT_VAL would help.  It
>>>>>> just
>>>>>> sets the timeout to maximum but max_discard_to is the maximum timeout.
>>>>>
>>>>> Here I meant to do something like:
>>>>>
>>>>>       if (host->quirks&   SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>>>>>           mmc->max_discard_to = 0;
>>>>>
>>>>> Again I'm not sure that this applies well to all
>>>>> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>>>>> controllers, therefore a new quirk might be better.
>>>>>
>>>>>> As I understand it you don't want to limit the discard size, either
>>>>>> because
>>>>>> your controller does not timeout, or because you are happy that the
>>>>>> maximum
>>>>>> timeout is enough for your users and their use-cases.
>>>>>>
>>>>>> If that is the case then the original patch just needs the quirk the
>>>>>> other
>>>>>> way around. i.e.
>>>>>>
>>>>>>        if (host->quirks2&    SDHCI_QUIRK2_NO_DISCARD_LIMIT)
>>>>>>            mmc->max_discard_to = 0;
>>>>>>        else
>>>>>>            mmc->max_discard_to = (1<<    27) / host->timeout_clk;
>>>>>
>>>>> This suits me fine, thanks for review, and I'll resend a change based on
>>>>> this.
>>>>>
>>>>> Also I'd like to pay your attention to (1<<   27) / host->timeout_clk
>>>>> part of
>>>>> calculation, following the spec it might be better to account the actual
>>>>> value of Data Timeout Counter, otherwise a controller may get
>>>>> unintentional
>>>>> Data Timeout Error pretty soon. Please correct me, if I'm mistaken here.
>>>>
>>>> Not sure what you mean.  max_discard_to is the maximum timeout (in
>>>> milliseconds) that the host controller supports.  The intent is to limit
>>>> erase operations to ones that have a timeout that is less than or equal to
>>>> that.
>>>
>>> That's clear. But it's not obvious why do you prefer (1<<  27) numerator
>>> instead
>>> of secure (1<<  13) or (1<<  (13 + sdhci_readl(host,
>>> SDHCI_TIMEOUT_CONTROL))).
>>
>> The maximum value of "Data Timeout Counter Value" in "Timeout Control
>> Register" is 14 and the maximum timeout is therefore (1<<  27).
> 
> So, from this perspective I assume this is a potential theoretical maximum
> timeout for a controller, which may be 16384 times more than the maximum
> guaranteed timeout before getting a DAT timeout. Why is the theoretical maximum

Where do you get the notion of "maximum guaranteed timeout"?  The timeout is
what is programmed in "Data Timeout Counter Value".

> supposed to be used in calculations of a guaranteed discard operation timeout
> instead of promised DAT timeout by a controller?

What is "promised DAT timeout"?

> 
>>>
>>>> Currently, the limit gets applied by the block layer before the mmc
>>>> layer is
>>>> involved so there is no possibility to take the actual timeout into
>>>> account.
>>>>    However if you have erase_group_def set, then it won't make any
>>>> difference
>>>> i.e. the limit will be the same.
>>>>
>>>>>
>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Potentially the change may break some of the SDHCs on discard of
>>>>>>>>>>> mmc,
>>>>>>>>>>> and for backward compatibility a new quirk is introduced, which
>>>>>>>>>>> is NOT
>>>>>>>>>>> set by default.
>>>>>>>>>>
>>>>>>>>>> It sounds to me that what you want to do is not standard so the quirk
>>>>>>>>>> should
>>>>>>>>>> be the other way around.
>>>>>>>>>
>>>>>>>>> Please take a look at commits 58d1246db3 and e056a1b5b, I'd be
>>>>>>>>> glad, if
>>>>>>>>> you
>>>>>>>>> could elaborate to which "some host controllers" the quirk in my
>>>>>>>>> definition
>>>>>>>>> applies, I believe all other host controllers present at that time in
>>>>>>>>> drivers/mmc/host/* are capable to discard without introduced
>>>>>>>>> limitation.
>>>>>>>>
>>>>>>>> "some host controllers" == SDHCI i.e. to all of the ones you are
>>>>>>>> applying
>>>>>>>> the change.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Vladimir Zapolskiy<vladimir_zapolskiy@mentor.com>
>>>>>>>>>>> Reported-by: Ed Sutter<ed.sutter@alcatel-lucent.com>
>>>>>>>>>>> Cc: Chris Ball<cjb@laptop.org>
>>>>>>>>>>> Cc: Adrian Hunter<adrian.hunter@intel.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       drivers/mmc/host/sdhci.c  |    5 ++++-
>>>>>>>>>>>       include/linux/mmc/sdhci.h |    1 +
>>>>>>>>>>>       2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>>>>>>> index bd8a098..b1fdddb 100644
>>>>>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>>>>>> @@ -2930,7 +2930,10 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>>>>>>>>           if (host->quirks&     
>>>>>>>>>>> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>>>>>>>>>>>               host->timeout_clk = mmc->f_max / 1000;
>>>>>>>>>>>
>>>>>>>>>>> -    mmc->max_discard_to = (1<<      27) / host->timeout_clk;
>>>>>>>>>>> +    if (host->quirks2&      SDHCI_QUIRK2_DATA_TIMEOUT_ON_DISCARD)
>>>>>>>>>>> +        mmc->max_discard_to = (1<<      27) / host->timeout_clk;
>>>>>>>>>>> +    else
>>>>>>>>>>> +        mmc->max_discard_to = 0;
>>>>>>>>>>>
>>>>>>>>>>>           mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE |
>>>>>>>>>>> MMC_CAP_CMD23;
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>>>>>>>>>>> index 3e781b8..e7f6bd2 100644
>>>>>>>>>>> --- a/include/linux/mmc/sdhci.h
>>>>>>>>>>> +++ b/include/linux/mmc/sdhci.h
>>>>>>>>>>> @@ -98,6 +98,7 @@ struct sdhci_host {
>>>>>>>>>>>       #define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON        (1<<4)
>>>>>>>>>>>       /* Controller has a non-standard host control register */
>>>>>>>>>>>       #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL        (1<<5)
>>>>>>>>>>> +#define SDHCI_QUIRK2_DATA_TIMEOUT_ON_DISCARD        (1<<6)
>>>>>>>>>>>
>>>>>>>>>>>           int irq;        /* Device IRQ */
>>>>>>>>>>>           void __iomem *ioaddr;    /* Mapped address */
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>
>>>>>
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

