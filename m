From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Wed, 14 Jan 2015 13:52:52 +0100
Message-ID: <CAPDyKFrVDcW8VxRO00-c=VHWMgjXV1VpnoaWtc7JtLpGoVqyCQ@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>
	<54B51C55.9060500@intel.com>
	<CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>
	<54B52D53.8080106@intel.com>
	<CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>
	<54B53592.9070303@broadcom.com>
	<CAPDyKFrs9SVt+8OSTHbkCFiY5ujdfXsqjg7E837CVZjEqz4EvA@mail.gmail.com>
	<54B54187.7080008@broadcom.com>
	<CAPDyKFqwQ+GPLv9T3fW3Y74hKhagKSOiXydvL9WoK8y3k0O6hQ@mail.gmail.com>
	<54B63D94.2050602@intel.com>
	<CAPDyKFosO9D6sQagk1nPRZ5aTMDhYu2P7Y5jzFUdA8gAcTNJog@mail.gmail.com>
	<54B66346.2090101@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:57132 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbANMwx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jan 2015 07:52:53 -0500
Received: by mail-qg0-f46.google.com with SMTP id q107so6679882qgd.5
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2015 04:52:52 -0800 (PST)
In-Reply-To: <54B66346.2090101@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>

[...]

>
> Hi Ulf,
>
> After sending my email I read that part as well and figured my response was
> incorrect.
>
>>>> That means, we can't get _any_ help from the controller HW (in mode 1)
>>>> to find a good value for the timer.
>>>
>>>
>>> In fact the timer value *is* defined in the Capabilities Register (Offset
>>> 040h) bits 43-40 Timer Count for Re-Tuning
>>>
>>> It has been supported since 2011, see:
>>>
>>>          commit cf2b5eea1ea0ff9b3184bc6771bcb93a9fdcd1d9
>>>          "mmc: sdhci: add support for retuning mode 1"
>>>
>>
>> The value from the register is also just randomly selected, only
>> difference is that it's the HW that has randomly set it.
>
>
> I think you can not say it like that. The value from the register is set by
> the manufacturer of the host controller. I would not say they would set that
> randomly. It is just hard-coded in their IP design. Now whether the value
> comes from actual hardware validation is hard to say.

How can they pre-validate use-cases? They don't have any clue of how
the card is going to be exercised on a real SOC. It can't be more than
just a guess.

>
>> Even if the above commit was merged, I don't think it was the correct
>> way of dealing with re-tuning.
>
>
> It seems a reasonable choice to follow the specification.
>
>> First of all, re-tuning this is a mmc protocol specific thing should
>> be managed from the mmc core, like the approach you have taken in your
>> $subject patchset. Second I question whether the timer is useful at
>> all.
>
>
> Not sure I understand what the alternative approach is here. You mentioned
> earlier something about "the request retry path". Does that mean you
> proposal is to only do a re-tuning procedure when a request fails.

Correct. It actually already implemented as part of $subject patchset.

> That does
> not seem like "the correct way of dealing with re-tuning" either as it
> introduces additional delay of the failed request. I would rather see some
> algorithm to adapt the timer value and thus keep a re-tuning timer. If you
> are concerned about doing unnecessary re-tuning cycles retuning could be
> limited to ADTC request as from what I understand about retuning is that it
> is only needed for requests that involve using the DAT lines.

It will introduce a delay/latency, but only when it's actually needed
to do a re-tune.

With the timer, it will add a latency at a random point in time,
depending on the selected value for it.
More importantly, user the timer means we will potentially insert
latencies, when in fact the re-tune wasn't needed.

Kind regards
Uffe
