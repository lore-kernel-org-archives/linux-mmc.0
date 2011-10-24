From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 13:49:28 +0200
Message-ID: <CACRpkdZdrB0Q8Wy2kgD_zAD1Dn3qZcJPQoM8vvU8JO-AH0utJg@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<20111024093632.GH9893@n2100.arm.linux.org.uk>
	<CACRpkdY6rzYsYQW+GACL6Ux8o=Eo-3wn62O0YZxJZ=F2WbE4DQ@mail.gmail.com>
	<20111024095638.GJ9893@n2100.arm.linux.org.uk>
	<4EA53B1D.9090208@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46510 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab1JXLt3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 07:49:29 -0400
Received: by iaby12 with SMTP id y12so1246331iab.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2011 04:49:28 -0700 (PDT)
In-Reply-To: <4EA53B1D.9090208@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

On Mon, Oct 24, 2011 at 12:17 PM, Ulf Hansson
<ulf.hansson@stericsson.com> wrote:
> Russell King - ARM Linux wrote:
>> On Mon, Oct 24, 2011 at 11:54:00AM +0200, Linus Walleij wrote:
>>>
>>> It's 8 cycles on MCLK required.
>>
>> _Plus_ keeping the clock running while the card is signalling busy.
>>
>> If you don't clock the card while its signalling busy, it will never
>> go non-busy (the data line becomes frozen.)
>>
>
> (...)
> Is the aggressive clk gating feature in the mmc framework taking this into
> account as well?

Nope.

That is why frequency 0 is not handled like some special case in the
MMCI driver, which means you can turn it on but nothing spectacularly
power saving will happen. (i.e. clock gating does not gate the clock
on the mmci driver) I did a rough patch to cut the clock
but Russell pointed out the problem here (same as discussed above):
http://marc.info/?l=linux-mmc&m=129146545916794&w=2

I *was* meaning to fix it. However now I feel that since we're
anyway ironing out the painful details of runtime PM, we can
probably use that framework to handle also aggressive clock
gating.

> Potentially the framework could do a get_sync/put (in claim/release host) to
> prevent hosts from being runtime disabled. Similar how the enable/disable
> mechanism is working.

Yep. We just need to make sure the hysteresis/delay value covers
the bus activity with some margin.

Yours,
Linus Walleij
