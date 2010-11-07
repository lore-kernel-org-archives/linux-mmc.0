From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Sun, 7 Nov 2010 11:32:32 +0200
Message-ID: <AANLkTimWg_EE+hg__b0NW792szvY+4Rc_4XsjbHN_tJv@mail.gmail.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com> <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44906 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab0KGJcw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 04:32:52 -0500
Received: by mail-iw0-f174.google.com with SMTP id 41so2721067iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 07 Nov 2010 01:32:52 -0800 (PST)
In-Reply-To: <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linus.Walleij@stericsson.com" <linus.Walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>

On Sat, Nov 6, 2010 at 7:38 PM, Philip Rakity <prakity@marvell.com> wro=
te:
> When clock gating is enabled with SDIO cards we have seen
> a) Missed Interrupts
> b) Transactions not completed

As David suggested, these issues are probably card-specific.

The 128x wlan card, e.g., supports both synchronous and asynchronous
SDIO interrupts (and also external non-SDIO interrupts).

So the decision whether to enable clock gating for SDIO should not be
static (eventually. I'm not saying this is something Linus should take
care of in his patch, it's up to us to make this work). By default,
SDIO clock gating should be disabled, but we need to allow drivers to
explicitly enable it if supported.

I'm tempted to suggest that drivers should control this too using
runtime PM API, but for that we need PM core to support several
different levels of runtime suspended states (and not just
active/suspended). It might be a good use case to push runtime PM core
for that.

We would then have three power states:

* Active (powered on; clocks ungated)
* Gated (powered on; clocks gated)
* Suspended (powered off)

>
> We think this is because some SDIO cards need n clocks after the xfer=
 completes from the host point of view to be in a state to handle clock=
s off. =A0n clocks should be 8 for SD 3.0 but in sometimes the cards ne=
ed more. =A0We have seen SDIO cards work with no clocks needed and some=
 needing more then 12 clocks. =A0This is completely understandable cons=
idering that clock gating is a new feature.
>
>
> b) hardware doing clock gating with SDIO is BAD -- we see the same is=
sues that s/w clock gating patch see's .. =A0The sdio cards do not work=
 correctly.
>
> c) The quirk is needed to tell the core/ layer that h/w support is av=
ailable.
>
> On Nov 6, 2010, at 10:24 AM, Ohad Ben-Cohen wrote:
>
>> Hi Phillip,
>>
>> On Sat, Nov 6, 2010 at 1:38 AM, Philip Rakity <prakity@marvell.com> =
wrote:
>>> d) keep sdio clock gating OFF -- need this from our experience.
>>
>> I'm really interested to hear more about that one - what issues did =
you see ?
>> Can you please elaborate ?
>>
>> Thanks,
>> Ohad.
>
>
