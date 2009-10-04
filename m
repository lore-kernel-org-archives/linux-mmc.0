From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: TMIO MMC: full patchset.
Date: Sun, 4 Oct 2009 01:00:00 +0100
Message-ID: <c09aa50a0910031700l390b6185o3a6b6376aead4e1e@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	<aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	<c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	<aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	<c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
	<aec7e5c30910012246r1c452606w149f18d9fe825737@mail.gmail.com>
	<c09aa50a0910020031x1c6f1fceo4740a3edc9592cbe@mail.gmail.com>
	<aec7e5c30910020057w38e72894p9ffed291f3fc1d1@mail.gmail.com>
	<c09aa50a0910021114h1a84703dt4f168b9fee1b723a@mail.gmail.com>
	<aec7e5c30910030611k1f468271x51654aab7d9197ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:52512 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbZJDAA6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Oct 2009 20:00:58 -0400
Received: by bwz6 with SMTP id 6so1791353bwz.37
        for <linux-mmc@vger.kernel.org>; Sat, 03 Oct 2009 17:00:20 -0700 (PDT)
In-Reply-To: <aec7e5c30910030611k1f468271x51654aab7d9197ac@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

2009/10/3 Magnus Damm <magnus.damm@gmail.com>:
> On Sat, Oct 3, 2009 at 3:14 AM, Ian Molton <ian@mnementh.co.uk> wrote:

> 512kHz?

That was an example. I suppose if your HCLK (the input or host clock,
as named in the TMIO specs) never falls below double the maximum
MMC/SD bus speed, then you will be ok.

Do _any_ SH platforms actually share HCLK with other peripherals?

> So the shared SDHI input clock is usually set to around 100 MHz. If
> I'm right then this clock is divided by the value in the
> CTL_SD_CARD_CLK_CTL register which allows us to divide by a maximum of
> 512.

And in your case, a minimum of 2, IIRC.

> Which would be enough to give us a wide range of valid MMC
> frequencies.

If nothing else shares the HCLK line, I'd recommend you set it such
that one of the lower clock speeds is exactly 400kHz. I'd also leave
200 and 100kHz as options below that - some cards really do need to
init that slowly.

> But yes, neither the tmio-mmc driver nor the mmc framework supports
> updating the frequency while running. At least last time I checked.
> That's usually the case when the frequency range is set once at
> register time. =) It would be nice to add support for updating the
> range though. I did just that for clockevents a few months ago.

I doubt it'd be  much use, the TMIO MMC core doesnt use much power to
preserve its state. on my platforms, the chip containing it is simply
put to sleep and can remain so for days without draining the battery,
and when it wakes up again the registers are as expected.

Thus far only one TMIO block has register save / restore and thats
because its in a braindamaged hardware design that shuts off power to
the ASIC when it sleeps.

> Well, _we_ can control the power domain where the SDHI block(s) is/are
> located.

Its probably not worth it, unless the SH design is merely a copy of
the tmio design rather than a reimplementation. it barely uses any
power when the clock is off anyway.

> And I suspect SoCs from other embedded processor vendors can
> do the same. But to do that we need to have support for saving and
> restoring the state in the driver.

Given how low power the TMIO hardware is, and how fast it resumes,
that seems counterproductive to me.

> As you can see, quite a few of my drivers save and restore state
> already. I'd be happy doing the technical work for the tmio-mmc
> driver. Unless you want to. =)

I'd like to see that this would result in significant power saving
first. simply halting the block on my boards drops it to damn near
zero consumption, and its still ready to go then.

> But before I even think of extending the tmio-mmc driver _we_ _really_
> need to work on improving the patch throughput a bit. I guess it's a
> question of trust. From my point of view it is risky and frustrating
> to do the work if we can't agree on things.

Thats easily solved - agree on what needs to be done first.

> From your side I suspect
> that you just don't want any breakage. I think you should trust me on
> not wanting to break your driver and in the rare case I would then I
> have time to spend on fixing it up.

Well, if I had done that this time, we'd have a driver with two
clocking methods in it now...

I don't think my review has been overly slow, especially in the light
of the fact that _I_ had to write the code you're now using, despite
having no platforms that benefit from it at all. Perhaps if you'd done
that the first time I suggetsed it, you wouldnt have had to wait for
me to do it for you?

Yes, the above paragraph is meant to sound irritated. I've put quite
some time into updating the driver _just for you_.  Time I could have
spent doing other things, and time I'm sure Philipp could be better
using rather than updating ASIC3 _just for you_.   If you wanted it
doing faster, you could have done it, but I still would have reviewed
it and still would have wanted it done this way. I was *quite* clear
about that since some time ago. If you'd simply done that rather than
keep pushing patches I'd already said I wasnt taking, it'd have taken
no time at all.   Yes, you'd have had to update the other 4 MFD
drivers using tmio-mmc yourself, and yes, thats a ball-ache. But since
_you_ want the change, you should do the work. Quite honestly, if
someone else does it for you, you should be grateful and not complain
about  how long it took.

>>> I don't think your MFD drivers do that,
>>
>> Actually they do provide provision for that by means of the enable /
>> disable hooks.
>>
>> if you unload the driver, the disable hook will get called and you can
>> power it off there.
>
> I can see a cell->enable() call in probe(), but I can't see any
> cell->disable() calls in the tmio-mmc driver. I sort of expected the
> remove() function in tmio-mmc and the probe() error handling code to
> do cell->disable(), but maybe I'm misunderstanding the way the MFD
> drivers work?

If the disable hook is not called then that may be a bug. Patches welcome.

My point still stands that the facility to power the block on / off as
and when the module is loaded is quite clearly available in the MFD
API.

>> Great - as soon as Philipp gets back to us with the ASIC3 update I'll
>> re-do my patchset to include ASIC3 - if the changes to tmio-mmc and
>> submitted seperately, it will break ASIC3 so that needs to go in the
>> same patchset. Philipp will be ready this weekend, not long to wait.
>
> Great, thanks a lot guys!

Hope the work is appreciated. Tracking down the init failure on my
(slow) netbook took the best part of 24 hours.

-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
