From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Tue, 13 Jan 2015 16:11:14 +0100
Message-ID: <54B53592.9070303@broadcom.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>	<54B51C55.9060500@intel.com>	<CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>	<54B52D53.8080106@intel.com> <CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:8950 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbAMPLS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 10:11:18 -0500
In-Reply-To: <CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>

On 01/13/15 15:56, Ulf Hansson wrote:
> [...]
>
>>>> Thank you for looking at the patches.
>>>>
>>>> I am not sure I know what you mean. sdhci already has a re-tuning timer, so
>>>> this is just moving it into core, where it won't be used by other drivers
>>>> unless they enable it.
>>>
>>> I am kind of questioning the re-tuning timer in sdhci. What is it good for?
>>
>> It is part of the SD Host Controller Standard Specification. The timer
>> ensures that re-tuning is done before temperature changes could affect the
>> "sampling point". It is needed for re-tuning mode 1 for UHS-I modes like SDR104.
>
> Does the spec say what value the timer should have?

It is read from the Capabilities register in the SD host controller, ie. 
in field "Timer Count for Re-Tuning" (see below).

Regards,
Arend

Timer Count for Re-Tuning
This field indicates an initial value of the Re-Tuning Timer for 
Re-Tuning Mode 1 to 3. Setting to 0 disables Re-Tuning Timer.
0h	Re-Tuning Timer disabled
1h	1 seconds
2h	2 seconds
3h	4 seconds
4h	8 seconds
.....	......................
n	2(n-1) seconds
.....	......................
Bh	1024 seconds
Eh - Ch	Reserved
Fh	Get information from other source

>>
>>>
>>> Can sdhci rely on that the mmc core performs a re-tune from the
>>> request retry mechanism instead?
>>
>> Not according to the standard.
>
> We don't have to implement everything that comes with the standard. We
> can leave things out.
>
>>
>>>
>>>>
>>>> I am not sure what you want to leave in sdhci.c and what you want in core,
>>>> if anything.
>>>
>>> We need all the infrastructure code in the core. Much like what your
>>> patchset does. Except that I would like you to remove the option of
>>> having a timer and the corresponding complexity it adds.
>>
>> If we are going to follow the standard then that doesn't seem to be an option.
>
> I am not suggestion us to violating the spec. I am suggesting to
> currently not support all of it.
>
>>
>>>
>>>>
>>>> At a minimum I need sdhci to be able to switch from hs400 to hs200, re-tune,
>>>> and switch back.
>>>
>>> As stated, I am only questioning the timer, nothing else.
>>
>> Ok so how should I proceed?
>>
>
> As I stated, let's try without the timer first.
>
> If we find it's not enough to recover at the request retry path, since
> it happens too often - lets deal with that then.
>
> Okay?
>
> Kind regards
> Uffe

