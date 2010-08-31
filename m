From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 3/3] MMC/SD: add callback function to detect card
Date: Tue, 31 Aug 2010 22:57:25 +0300
Message-ID: <4C7D5EA5.2060701@nokia.com>
References: <1259913309-27146-1-git-send-email-r66093@freescale.com> <20100827190513.GC20407@void.printf.net> <20100831191040.GB7847@console-pimps.org> <4C7D56AB.1060307@nokia.com> <4C7D5AB1.3020306@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45287 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab0HaT5h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2010 15:57:37 -0400
In-Reply-To: <4C7D5AB1.3020306@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Chris Ball <cjb@laptop.org>, "r66093@freescale.com" <r66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>

Adrian Hunter wrote:
> Adrian Hunter wrote:
>> Matt Fleming wrote:
>>> On Fri, Aug 27, 2010 at 08:05:13PM +0100, Chris Ball wrote:
>>>> Hi,
>>>>
>>>> On Fri, Dec 04, 2009 at 03:55:09PM +0800, r66093@freescale.com wrote:
>>>>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>>>
>>>>> Add callback function to check if the card has been removed.
>>>>>
>>>>> in order to check if the card has been removed, the function mmc_send_status will send commad CMD13 to card and ask the card to send its status register to driver, which will generate interrupt repeatly and make the system bad.
>>>>> Therefore, get_cd callback is used to detect the card if the driver has.
>>>>>
>>>>> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>>> ---
>>>>>  drivers/mmc/core/mmc.c |    5 ++++-
>>>>>  drivers/mmc/core/sd.c  |    5 ++++-
>>>>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 06084db..c5c676d 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -494,7 +494,10 @@ static void mmc_detect(struct mmc_host *host)
>>>>>  	/*
>>>>>  	 * Just check if our card has been removed.
>>>>>  	 */
>>>>> -	err = mmc_send_status(host->card, NULL);
>>>>> +	if (host->ops->get_cd)
>>>>> +		err = !host->ops->get_cd(host);
>>>>> +	else
>>>>> +		err = mmc_send_status(host->card, NULL);
>>>>>  
>>>>>  	mmc_release_host(host);
>>>>>  
>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>>> index cd81c39..3cf1f38 100644
>>>>> --- a/drivers/mmc/core/sd.c
>>>>> +++ b/drivers/mmc/core/sd.c
>>>>> @@ -548,7 +548,10 @@ static void mmc_sd_detect(struct mmc_host *host)
>>>>>  	/*
>>>>>  	 * Just check if our card has been removed.
>>>>>  	 */
>>>>> -	err = mmc_send_status(host->card, NULL);
>>>>> +	if (host->ops->get_cd)
>>>>> +		err = !host->ops->get_cd(host);
>>>>> +	else
>>>>> +		err = mmc_send_status(host->card, NULL);
>>>>>  
>>>>>  	mmc_release_host(host);
>>>>>  
>>>>> -- 
>>>>> 1.6.4
>>>> This patchset wasn't replied to -- any comments on it from the list?
>>> I think this change makes sense, although it needs to be a bit smarter
>>> with error handling because the get_cd() functions can return -ENOSYS if
>>> they are not implemented (but the function pointer is still valid).
>>>
>>> 	int err = 0;
>>>
>>> 	if (host->ops->get_cd) {
>>> 		err = host->ops->get_cd(host);
>>> 		if (err >= 0)
>>> 			err = !err;
>>> 	}
>>>
>>> 	if (!host->ops->get_cd || err < 0)
>>> 		err = mmc_send_status(host->card, NULL);
>>>
>>> Thoughts?
>> I am not sure it won't cause problems.
>>
>> If you change the card then card detect will return true because
>> there is a card but send status will fail because the card is not
>> initialised.  So the two do not seem equivalent.
> 
> But maybe the following?
> 
> 	int err = 0;
> 
> 	if (host->ops->get_cd)
> 		err = !host->ops->get_cd(host);
> 
> 	if (!err)
> 		err = mmc_send_status(host->card, NULL);

But now I think it should be in the mmc_rescan() function
because that is where the main other use of .get_cd()
is, and also the only call of .detect().


>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> 
> 

