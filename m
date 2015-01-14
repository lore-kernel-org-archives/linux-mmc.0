From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Wed, 14 Jan 2015 11:57:40 +0200
Message-ID: <54B63D94.2050602@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>	<54B51C55.9060500@intel.com>	<CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>	<54B52D53.8080106@intel.com>	<CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>	<54B53592.9070303@broadcom.com>	<CAPDyKFrs9SVt+8OSTHbkCFiY5ujdfXsqjg7E837CVZjEqz4EvA@mail.gmail.com>	<54B54187.7080008@broadcom.com> <CAPDyKFqwQ+GPLv9T3fW3Y74hKhagKSOiXydvL9WoK8y3k0O6hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50589 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbbANJ72 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 Jan 2015 04:59:28 -0500
In-Reply-To: <CAPDyKFqwQ+GPLv9T3fW3Y74hKhagKSOiXydvL9WoK8y3k0O6hQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arend van Spriel <arend@broadcom.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>

On 14/01/15 11:47, Ulf Hansson wrote:
> On 13 January 2015 at 17:02, Arend van Spriel <arend@broadcom.com> wrote:
>> On 01/13/15 16:41, Ulf Hansson wrote:
>>>
>>> On 13 January 2015 at 16:11, Arend van Spriel<arend@broadcom.com>  wrote:
>>>>
>>>> On 01/13/15 15:56, Ulf Hansson wrote:
>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>>>> Thank you for looking at the patches.
>>>>>>>>
>>>>>>>> I am not sure I know what you mean. sdhci already has a re-tuning
>>>>>>>> timer, so
>>>>>>>> this is just moving it into core, where it won't be used by other
>>>>>>>> drivers
>>>>>>>> unless they enable it.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I am kind of questioning the re-tuning timer in sdhci. What is it good
>>>>>>> for?
>>>>>>
>>>>>>
>>>>>>
>>>>>> It is part of the SD Host Controller Standard Specification. The timer
>>>>>> ensures that re-tuning is done before temperature changes could affect
>>>>>> the
>>>>>> "sampling point". It is needed for re-tuning mode 1 for UHS-I modes
>>>>>> like
>>>>>> SDR104.
>>>>>
>>>>>
>>>>>
>>>>> Does the spec say what value the timer should have?
>>>>
>>>>
>>>>
>>>> It is read from the Capabilities register in the SD host controller, ie.
>>>> in
>>>> field "Timer Count for Re-Tuning" (see below).
>>>>
>>>> Regards,
>>>> Arend
>>>>
>>>> Timer Count for Re-Tuning
>>>> This field indicates an initial value of the Re-Tuning Timer for
>>>> Re-Tuning
>>>> Mode 1 to 3. Setting to 0 disables Re-Tuning Timer.
>>>> 0h      Re-Tuning Timer disabled
>>>> 1h      1 seconds
>>>> 2h      2 seconds
>>>> 3h      4 seconds
>>>> 4h      8 seconds
>>>> .....   ......................
>>>> n       2(n-1) seconds
>>>> .....   ......................
>>>> Bh      1024 seconds
>>>> Eh - Ch Reserved
>>>> Fh      Get information from other source
>>>
>>>
>>> Thanks for sharing this information, but unfortunate I don't
>>> understand much from it.
>>>
>>> Is the host driver intended to read/poll this register to find a good
>>> value?
>>
>>
>> You can download the spec (and others) here [1]. sdhci currently implements
>> retuning mode 1, which is decribed in the spec:
>>
>> Re-Tuning Timer Control Example for Re-Tuning Mode 1
>> The initial value of re-tuning timer is provided by Timer Count for
>> Re-Tuning field in this register. The timer starts counting by loading the
>> initial value. When the timer expires, the Host Driver marks an expiration
>> flag. On receiving a command request, the Host driver checks the expiration
>> flag. If the expiration flag is set, then the Host Driver should perform the
>> re-tuning procedure before issuing a command. If the expiration flag is not
>> set, then the Host Driver issues a command without performing the re-tuning
>> procedure. Every time the re-tuning procedure is performed, the timer loads
>> the new initial value and the expiration flag is cleared.
>>
>> So the host controller could indeed update this register for subsequent
>> retuning.
> 
> Arend, thanks for the link and information. So, I decided to go for a
> look in there.
> 
>>From the same section you quoted above:
> ------
> (1) Re-Tuning Mode 1
> The host controller does not have any internal logic to detect when
> the re-tuning needs to be performed. In this case, the Host Driver
> should maintain all re-tuning timings by using a Re-Tuning Timer. To
> enable inserting the re-tuning procedure during data transfers, the
> data length per read/write command shall be limited up to 4MB.
> ------
> 
> That means, we can't get _any_ help from the controller HW (in mode 1)
> to find a good value for the timer.

In fact the timer value *is* defined in the Capabilities Register (Offset
040h) bits 43-40 Timer Count for Re-Tuning

It has been supported since 2011, see:

	commit cf2b5eea1ea0ff9b3184bc6771bcb93a9fdcd1d9
	"mmc: sdhci: add support for retuning mode 1"

