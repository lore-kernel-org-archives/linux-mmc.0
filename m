From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Tue, 13 Jan 2015 15:22:59 +0100
Message-ID: <CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>
	<54B51C55.9060500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:63096 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbAMOXA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 09:23:00 -0500
Received: by mail-qc0-f178.google.com with SMTP id p6so2358113qcv.9
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 06:23:00 -0800 (PST)
In-Reply-To: <54B51C55.9060500@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 13 January 2015 at 14:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 13/01/15 13:25, Ulf Hansson wrote:
>> Hi Adrian,
>>
>> Thanks for working on this and apologize for my late reply!
>>
>> On 5 December 2014 at 18:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Currently, there is core support for tuning during
>>> initialization. There can also be a need to re-tune
>>> periodically (e.g. sdhci) or to re-tune after the
>>> host controller is powered off (e.g. after PM
>>> runtime suspend / resume) or to re-tune in response
>>> to CRC errors.
>>>
>>> The main requirements for re-tuning are:
>>>   - ability to enable /disable re-tuning
>>>   - ability to flag that re-tuning is needed
>>>   - ability to re-tune before any request
>>>   - ability to hold off re-tuning if the card is busy
>>>   - ability to hold off re-tuning if re-tuning is in
>>>   progress
>>>   - ability to run a re-tuning timer
>>
>> I suggest we skip the support for the re-tuning timer in this initial
>> step and thus remove the related functionality from this patchset. It
>> adds complexity, but more important it's not obvious that it actually
>> will help. I am more concerned that it randomly will cause a request
>> latency and thus decrease performance.
>>
>> The re-tuning period can't be selected "perfectly", so in this initial
>> step let's instead just rely on re-tune from the request retry path.
>>
>> If we do see a need for a doing re-tuning periodically, how about
>> using the runtime PM suspend path (of the mmc card device). In that
>> way, we should be able to minimize the impact on performance.
>
> Thank you for looking at the patches.
>
> I am not sure I know what you mean. sdhci already has a re-tuning timer, so
> this is just moving it into core, where it won't be used by other drivers
> unless they enable it.

I am kind of questioning the re-tuning timer in sdhci. What is it good for?

Can sdhci rely on that the mmc core performs a re-tune from the
request retry mechanism instead?

>
> I am not sure what you want to leave in sdhci.c and what you want in core,
> if anything.

We need all the infrastructure code in the core. Much like what your
patchset does. Except that I would like you to remove the option of
having a timer and the corresponding complexity it adds.

>
> At a minimum I need sdhci to be able to switch from hs400 to hs200, re-tune,
> and switch back.

As stated, I am only questioning the timer, nothing else.

Kind regards
Uffe
