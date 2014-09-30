From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 5/6] mmc: block: Fix SD card stop cmd response type
Date: Tue, 30 Sep 2014 15:41:53 +0300
Message-ID: <542AA511.5010904@intel.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>	<1411502430-25535-6-git-send-email-adrian.hunter@intel.com>	<CAPDyKFr4YuCyW9DhbQRyFDTkMdm1meK96z7x7-gUvRCvy0U+qg@mail.gmail.com>	<542A9247.3050302@intel.com> <CAPDyKFrMPW_MhPpKnviZnBXoVtJkMWEBC5K3GotyVhktue+9_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55901 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbaI3MnY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Sep 2014 08:43:24 -0400
In-Reply-To: <CAPDyKFrMPW_MhPpKnviZnBXoVtJkMWEBC5K3GotyVhktue+9_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 30/09/14 15:09, Ulf Hansson wrote:
> On 30 September 2014 13:21, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 25/09/14 12:20, Ulf Hansson wrote:
>>> On 23 September 2014 22:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> Nowhere in the SD Association Specifications does
>>>> it state that the stop command has an R1 response
>>>> type.  It is always R1B.  Change accordingly.
>>>
>>> It depends on how detailed you read the spec. :-)
>>>
>>> First, R1B is the same as R1, but with optional busy signalling on DAT0.
>>
>> Not exactly:
>>
>> "R1b is identical to R1 with an optional busy signal
>> transmitted on the data line. The card may become
>> busy after receiving these commands based on its
>> state prior to the command reception. The Host shall
>> check for busy at the response. Refer to Section 4.12.3
>> for a detailed description and timing diagrams."
>>
>> Note it says "The Host shall check for busy at the response."
>> It does not say "The Host is not affected"
> 
> Sorry, I was a bit unclear. I was referring to the format of the response.
> 
>>
>>>
>>> Just reading the table listing CMDS their related response types,
>>> confirms what you are saying. CMD12 has an R1B.
>>
>> Which is explicit and definitive.
>>
>>> Though, going into the details of the "Timing" section where this is
>>> clearly visualized in diagrams, you realize there are no busy
>>> signalling associated with a DATA READ, only for DATA WRITE. It is
>>> also indicated in earlier sections of the spec when "DATA READ/WRITE
>>> sequences are described", but I think the "Timing" section describes
>>> this the best.
>>
>> You are looking at it only from the point of view of the card. The host
>> controller can expect that CMD12/R1b is the only valid combination
>> because that is what the specification defines.  You can't know what
>> the host controller will do if you tell it to do CMD12/R1 because that
>> is outside the spec.
>>
> 
> It doesn't matter from what point of view we look at it. It's all
> about the details of the spec, which tells us there are no busy
> signalling involved with a READ. HW designers of MMC controllers
> should know this as well.

HW designers may well choose to follow the spec.

> 
> Unless you really are fixing a regression here, I can't see the need
> for your patch.

No, I have a host controller that wants to give a TC interrupt on CMD12
which is correct if the response type is R1b but incorrect if the
response type is R1.  However I am anyway fixing that with a quirk because
theoretically MMC is affected too - although not in practice because it uses
CMD23 instead of CMD12.

That got me thinking that we really ought to follow the spec and use R1b.

