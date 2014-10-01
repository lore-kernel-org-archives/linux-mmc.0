From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/6] mmc: block: Fix SD card stop cmd response type
Date: Wed, 1 Oct 2014 10:36:16 +0200
Message-ID: <CAPDyKFpzEgCJHJ2=pKCz1Ysu7h_eRF7FptRFLfTPQM1GkzGTtA@mail.gmail.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
	<1411502430-25535-6-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFr4YuCyW9DhbQRyFDTkMdm1meK96z7x7-gUvRCvy0U+qg@mail.gmail.com>
	<542A9247.3050302@intel.com>
	<CAPDyKFrMPW_MhPpKnviZnBXoVtJkMWEBC5K3GotyVhktue+9_w@mail.gmail.com>
	<542AA511.5010904@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:35092 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaJAIgR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 04:36:17 -0400
Received: by mail-qa0-f54.google.com with SMTP id i13so180687qae.27
        for <linux-mmc@vger.kernel.org>; Wed, 01 Oct 2014 01:36:16 -0700 (PDT)
In-Reply-To: <542AA511.5010904@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 30 September 2014 14:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 30/09/14 15:09, Ulf Hansson wrote:
>> On 30 September 2014 13:21, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 25/09/14 12:20, Ulf Hansson wrote:
>>>> On 23 September 2014 22:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> Nowhere in the SD Association Specifications does
>>>>> it state that the stop command has an R1 response
>>>>> type.  It is always R1B.  Change accordingly.
>>>>
>>>> It depends on how detailed you read the spec. :-)
>>>>
>>>> First, R1B is the same as R1, but with optional busy signalling on DAT0.
>>>
>>> Not exactly:
>>>
>>> "R1b is identical to R1 with an optional busy signal
>>> transmitted on the data line. The card may become
>>> busy after receiving these commands based on its
>>> state prior to the command reception. The Host shall
>>> check for busy at the response. Refer to Section 4.12.3
>>> for a detailed description and timing diagrams."
>>>
>>> Note it says "The Host shall check for busy at the response."
>>> It does not say "The Host is not affected"
>>
>> Sorry, I was a bit unclear. I was referring to the format of the response.
>>
>>>
>>>>
>>>> Just reading the table listing CMDS their related response types,
>>>> confirms what you are saying. CMD12 has an R1B.
>>>
>>> Which is explicit and definitive.
>>>
>>>> Though, going into the details of the "Timing" section where this is
>>>> clearly visualized in diagrams, you realize there are no busy
>>>> signalling associated with a DATA READ, only for DATA WRITE. It is
>>>> also indicated in earlier sections of the spec when "DATA READ/WRITE
>>>> sequences are described", but I think the "Timing" section describes
>>>> this the best.
>>>
>>> You are looking at it only from the point of view of the card. The host
>>> controller can expect that CMD12/R1b is the only valid combination
>>> because that is what the specification defines.  You can't know what
>>> the host controller will do if you tell it to do CMD12/R1 because that
>>> is outside the spec.
>>>
>>
>> It doesn't matter from what point of view we look at it. It's all
>> about the details of the spec, which tells us there are no busy
>> signalling involved with a READ. HW designers of MMC controllers
>> should know this as well.
>
> HW designers may well choose to follow the spec.
>
>>
>> Unless you really are fixing a regression here, I can't see the need
>> for your patch.
>
> No, I have a host controller that wants to give a TC interrupt on CMD12
> which is correct if the response type is R1b but incorrect if the
> response type is R1.  However I am anyway fixing that with a quirk because
> theoretically MMC is affected too - although not in practice because it uses
> CMD23 instead of CMD12.
>
> That got me thinking that we really ought to follow the spec and use R1b.

I will certainly keep this in mind. Likely a similar situation will
occur when I fixup mmc erase/discard.

In principle host drivers must pay attention to MMC_RSP_R1B and act
accordingly both if set and not set. I suppose you will add some extra
quirks around that in your driver.

Anyway, thanks for the discussion, it was useful!

Kind regards
Uffe
