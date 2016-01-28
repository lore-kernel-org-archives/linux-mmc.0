From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
 quirk
Date: Thu, 28 Jan 2016 10:17:11 +0800
Message-ID: <56A97A27.4000501@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <56A8BF22.8010509@intel.com> <20160127132348.GY10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:53916 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934254AbcA1CRm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 21:17:42 -0500
In-Reply-To: <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Adrian Hunter <adrian.hunter@intel.com>
Cc: shawn.lin@rock-chips.com, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2016/1/27 23:07, Ulf Hansson wrote:
> On 27 January 2016 at 14:23, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Jan 27, 2016 at 02:59:14PM +0200, Adrian Hunter wrote:
>>> In my view Ulf needs to explain how the SDHCI library is going to work,
>>> particularly in the absence of new callbacks.
>>
>> We need to add new callbacks as part of the conversion to a library,
>> otherwise we're very much into a total rewrite from scratch (which
>> I think is far too much work, and prone to errors) or a big flag day
>> to switch everything over (which will require a moritorium on sdhci
>> patches while the effort to switch everything is ongoing.)
>>

Totally agreed. Maybe that is the reason that frighten some volunteers
to make the conversion.

>> Both of those approaches suffer from one huge drawback: there is no
>> way to bisect between them to locate the cause of a regression.
>>

[...]

>>
>> I think what needs to happen here is that Ulf needs to leave such
>> decisions about what is acceptable or unacceptable to those who are
>> trying to convert sdhci to a library, otherwise the conversion will
>> probably never happen... unless Ulf wants to get directly involved
>> in the conversion effort, producing patches to make it happen.
>>
>
> I don't intend to contribute much with actual patches. I am willing to
> help review and also help with expertise around the PM related parts.
>
> I do realize that some callbacks may still be needed, even in the end
> when sdhci has become a pure library. Although, those should be far
> less then those we have today.
>
> Currently I am more or less unable to properly maintain sdhci because
> of it's bad code structure. Therefore I have taken a quite simple
> approach by rejecting new callbacks and quirks, in a way to prevent it
> from being worse.

Ulf, I do understand your situation. sdhci makes you exhausted and no
one seems able to maintain it properly. But preventing it from being
worse doesn't mean making it better, right?

I'am not a experienced sdhci expert, so when I read the sdhci code
for the first time last summer, it does shock me a lot. So many
historical burden it takes with lots kinds of *quirks*, I even cannot
undertand why some quirks are need since git-blame just tell me some
useless info because somebody do some coding-style fix or moving code
here and there, which makes me hard to trace the changes. Another fact,
how to test these changes for diff hardwares?? Without the help of
variant drivers folks, it cannot go a step. If we split our "library
direction" movement, do you think all the variant drivers are willing
to test all the patchsets for it? I don't think so.

Here, I come up with a bold and tentative proposal:
If someone is willing to be the maintainer of sdhci, he/she can create
a separate files and rewrite it to be a library. Then we reject to
accept any new variant drivers to use the old sdhci struct and encourage
it to fit the library one. Then ask the variant drivers who use the old
struct to migrate its code to fit the library. Until all done, remove
the old sdhci. Does that make sense?


To me, the best way forward would be if some of you
> experienced sdhci developers stepped in as a maintainer for it. In
> that way, I can trust the development moving in the "library
> direction" so I can pull back from nacking potential interim sdhci
> callbacks/quirks.
>
> Does it make sense?
>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

