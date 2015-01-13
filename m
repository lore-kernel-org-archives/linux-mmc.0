From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Tue, 13 Jan 2015 16:41:57 +0100
Message-ID: <CAPDyKFrs9SVt+8OSTHbkCFiY5ujdfXsqjg7E837CVZjEqz4EvA@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>
	<54B51C55.9060500@intel.com>
	<CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>
	<54B52D53.8080106@intel.com>
	<CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>
	<54B53592.9070303@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:41745 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbAMPl6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 10:41:58 -0500
Received: by mail-qg0-f41.google.com with SMTP id e89so2687785qgf.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 07:41:57 -0800 (PST)
In-Reply-To: <54B53592.9070303@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>

On 13 January 2015 at 16:11, Arend van Spriel <arend@broadcom.com> wrote:
> On 01/13/15 15:56, Ulf Hansson wrote:
>>
>> [...]
>>
>>>>> Thank you for looking at the patches.
>>>>>
>>>>> I am not sure I know what you mean. sdhci already has a re-tuning
>>>>> timer, so
>>>>> this is just moving it into core, where it won't be used by other
>>>>> drivers
>>>>> unless they enable it.
>>>>
>>>>
>>>> I am kind of questioning the re-tuning timer in sdhci. What is it good
>>>> for?
>>>
>>>
>>> It is part of the SD Host Controller Standard Specification. The timer
>>> ensures that re-tuning is done before temperature changes could affect
>>> the
>>> "sampling point". It is needed for re-tuning mode 1 for UHS-I modes like
>>> SDR104.
>>
>>
>> Does the spec say what value the timer should have?
>
>
> It is read from the Capabilities register in the SD host controller, ie. in
> field "Timer Count for Re-Tuning" (see below).
>
> Regards,
> Arend
>
> Timer Count for Re-Tuning
> This field indicates an initial value of the Re-Tuning Timer for Re-Tuning
> Mode 1 to 3. Setting to 0 disables Re-Tuning Timer.
> 0h      Re-Tuning Timer disabled
> 1h      1 seconds
> 2h      2 seconds
> 3h      4 seconds
> 4h      8 seconds
> .....   ......................
> n       2(n-1) seconds
> .....   ......................
> Bh      1024 seconds
> Eh - Ch Reserved
> Fh      Get information from other source

Thanks for sharing this information, but unfortunate I don't
understand much from it.

Is the host driver intended to read/poll this register to find a good value?

Isn't heat one of the most important factor that could effect the need
for a re-tune? Does then the controller internally dynamically update
this register (since it keep track of heat or similar)?


Kind regards
Uffe
