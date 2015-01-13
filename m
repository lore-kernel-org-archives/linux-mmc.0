From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Tue, 13 Jan 2015 16:36:03 +0200
Message-ID: <54B52D53.8080106@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>	<54B51C55.9060500@intel.com> <CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53211 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbbAMOhv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Jan 2015 09:37:51 -0500
In-Reply-To: <CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 13/01/15 16:22, Ulf Hansson wrote:
> On 13 January 2015 at 14:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 13/01/15 13:25, Ulf Hansson wrote:
>>> Hi Adrian,
>>>
>>> Thanks for working on this and apologize for my late reply!
>>>
>>> On 5 December 2014 at 18:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> Currently, there is core support for tuning during
>>>> initialization. There can also be a need to re-tune
>>>> periodically (e.g. sdhci) or to re-tune after the
>>>> host controller is powered off (e.g. after PM
>>>> runtime suspend / resume) or to re-tune in response
>>>> to CRC errors.
>>>>
>>>> The main requirements for re-tuning are:
>>>>   - ability to enable /disable re-tuning
>>>>   - ability to flag that re-tuning is needed
>>>>   - ability to re-tune before any request
>>>>   - ability to hold off re-tuning if the card is busy
>>>>   - ability to hold off re-tuning if re-tuning is in
>>>>   progress
>>>>   - ability to run a re-tuning timer
>>>
>>> I suggest we skip the support for the re-tuning timer in this initial
>>> step and thus remove the related functionality from this patchset. It
>>> adds complexity, but more important it's not obvious that it actually
>>> will help. I am more concerned that it randomly will cause a request
>>> latency and thus decrease performance.
>>>
>>> The re-tuning period can't be selected "perfectly", so in this initial
>>> step let's instead just rely on re-tune from the request retry path.
>>>
>>> If we do see a need for a doing re-tuning periodically, how about
>>> using the runtime PM suspend path (of the mmc card device). In that
>>> way, we should be able to minimize the impact on performance.
>>
>> Thank you for looking at the patches.
>>
>> I am not sure I know what you mean. sdhci already has a re-tuning timer, so
>> this is just moving it into core, where it won't be used by other drivers
>> unless they enable it.
> 
> I am kind of questioning the re-tuning timer in sdhci. What is it good for?

It is part of the SD Host Controller Standard Specification. The timer
ensures that re-tuning is done before temperature changes could affect the
"sampling point". It is needed for re-tuning mode 1 for UHS-I modes like SDR104.

> 
> Can sdhci rely on that the mmc core performs a re-tune from the
> request retry mechanism instead?

Not according to the standard.

> 
>>
>> I am not sure what you want to leave in sdhci.c and what you want in core,
>> if anything.
> 
> We need all the infrastructure code in the core. Much like what your
> patchset does. Except that I would like you to remove the option of
> having a timer and the corresponding complexity it adds.

If we are going to follow the standard then that doesn't seem to be an option.

> 
>>
>> At a minimum I need sdhci to be able to switch from hs400 to hs200, re-tune,
>> and switch back.
> 
> As stated, I am only questioning the timer, nothing else.

Ok so how should I proceed?

