From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Sun, 4 Oct 2009 14:05:08 +0900
Message-ID: <aec7e5c30910032205j1f9cefa6r7639164904b3ae8c@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	 <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	 <aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	 <c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
	 <aec7e5c30910012246r1c452606w149f18d9fe825737@mail.gmail.com>
	 <c09aa50a0910020031x1c6f1fceo4740a3edc9592cbe@mail.gmail.com>
	 <aec7e5c30910020057w38e72894p9ffed291f3fc1d1@mail.gmail.com>
	 <c09aa50a0910021114h1a84703dt4f168b9fee1b723a@mail.gmail.com>
	 <aec7e5c30910030611k1f468271x51654aab7d9197ac@mail.gmail.com>
	 <c09aa50a0910031700l390b6185o3a6b6376aead4e1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:58893 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZJDFFp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Oct 2009 01:05:45 -0400
Received: by ywh6 with SMTP id 6so1656335ywh.4
        for <linux-mmc@vger.kernel.org>; Sat, 03 Oct 2009 22:05:09 -0700 (PDT)
In-Reply-To: <c09aa50a0910031700l390b6185o3a6b6376aead4e1e@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

Hi Ian,

On Sun, Oct 4, 2009 at 9:00 AM, Ian Molton <ian@mnementh.co.uk> wrote:
> 2009/10/3 Magnus Damm <magnus.damm@gmail.com>:
>> On Sat, Oct 3, 2009 at 3:14 AM, Ian Molton <ian@mnementh.co.uk> wrot=
e:
>
>> 512kHz?
>
> That was an example. I suppose if your HCLK (the input or host clock,
> as named in the TMIO specs) never falls below double the maximum
> MMC/SD bus speed, then you will be ok.

That should be the case. Thanks for explaining.

> Do _any_ SH platforms actually share HCLK with other peripherals?

_All_ the SuperH Mobile SoCs that I've seen so far share the clock.
The clock for the SDHI block(s) can usually be stopped individually,
but the clock rate is shared with a bunch of other blocks. Just in the
sh7724 case there are 13 hardware blocks that share the same clock.
The clock that goes by HCLK in TMIO lingo. Most of these blocks
interface external hardware so changing the frequency will affect
other drivers.

>> So the shared SDHI input clock is usually set to around 100 MHz. If
>> I'm right then this clock is divided by the value in the
>> CTL_SD_CARD_CLK_CTL register which allows us to divide by a maximum =
of
>> 512.
>
> And in your case, a minimum of 2, IIRC.
>
>> Which would be enough to give us a wide range of valid MMC
>> frequencies.
>
> If nothing else shares the HCLK line, I'd recommend you set it such
> that one of the lower clock speeds is exactly 400kHz. I'd also leave
> 200 and 100kHz as options below that - some cards really do need to
> init that slowly.

I would if I could. =3D)

>> But yes, neither the tmio-mmc driver nor the mmc framework supports
>> updating the frequency while running. At least last time I checked.
>> That's usually the case when the frequency range is set once at
>> register time. =3D) It would be nice to add support for updating the
>> range though. I did just that for clockevents a few months ago.
>
> I doubt it'd be =A0much use, the TMIO MMC core doesnt use much power =
to
> preserve its state. on my platforms, the chip containing it is simply
> put to sleep and can remain so for days without draining the battery,
> and when it wakes up again the registers are as expected.

Well you measure days but I want to measure weeks. The SDHI block can
most likely be found in SoCs aimed for portable handsets, and for such
devices "days" are just not good enough.

The TMIO block itself may not use much power, but it's pretty common
to have power domains that cover a range of hardware blocks. So there
are complex dependencies. As an example, if we want to power off the
USB controller hardware block then we may have to power off the SDHI
block as well. That's just an example, but it shows how we may need
SDHI runtime pm to save and restore state even though the SDHI block
itself may not consume much power. The exact partitioning of the power
domains vary with processor model, but the concept is pretty much the
same for all SoCs. Regardless of vendor. Most vendors probably have
out-of-tree/private code for this already - the feature is most likely
just missing from the upstream driver.

> Thus far only one TMIO block has register save / restore and thats
> because its in a braindamaged hardware design that shuts off power to
> the ASIC when it sleeps.

Or maybe they have very coarse grained power domains. =3D) Some deeper
sleep modes on certain embedded SoCs turn off the power domains which
will give the same result as you are describing.

>> Well, _we_ can control the power domain where the SDHI block(s) is/a=
re
>> located.
>
> Its probably not worth it, unless the SH design is merely a copy of
> the tmio design rather than a reimplementation. it barely uses any
> power when the clock is off anyway.

It's worth it, believe me.

>> And I suspect SoCs from other embedded processor vendors can
>> do the same. But to do that we need to have support for saving and
>> restoring the state in the driver.
>
> Given how low power the TMIO hardware is, and how fast it resumes,
> that seems counterproductive to me.

Well, ask anyone technically competent doing runtime power management
for embedded systems and they'll probably say the same thing. I can
introduce you to some ARM hackers fairly high in the food chain that
most likely will agree with me.

>> As you can see, quite a few of my drivers save and restore state
>> already. I'd be happy doing the technical work for the tmio-mmc
>> driver. Unless you want to. =3D)
>
> I'd like to see that this would result in significant power saving
> first. simply halting the block on my boards drops it to damn near
> zero consumption, and its still ready to go then.

Right, stopping the clock is great as a first step. This is the very
first step of power managment. As for the SDHI block - we're not even
fully there yet because we don't control what you call HCLK
dynamically. The next step after mucking around with more fine grained
clock stopping would be to implement save and restore.

>> But before I even think of extending the tmio-mmc driver _we_ _reall=
y_
>> need to work on improving the patch throughput a bit. I guess it's a
>> question of trust. From my point of view it is risky and frustrating
>> to do the work if we can't agree on things.
>
> Thats easily solved - agree on what needs to be done first.

Good. But I think we both knew what was needed earlier. From my
perspective, I needed to use the tmio-mmc driver on hardware that
wasn't supported yet. I sent a bunch of patches. Some got in, some
didn't which left my hardware unsupported.

Then there was this clock framework discussion. I can understand your
pain with the lack of arch-independent clock framework support. But on
my hardware the clock framework is working perfectly fine.

>> From your side I suspect
>> that you just don't want any breakage. I think you should trust me o=
n
>> not wanting to break your driver and in the rare case I would then I
>> have time to spend on fixing it up.
>
> Well, if I had done that this time, we'd have a driver with two
> clocking methods in it now...

I appreciate your work, but seriously, who cares if you have two
clocking methods? This is just one driver of an entire system. I'm
sure there are more important matters in the world. That zoomed out
perspective aside, I do think your patch removing the second area is
much nicer.

So again, I really appreciate your help. But from my point of view you
could have just accepted my "make the second io area optional" patch
earlier and done this cleanup at any time later without stress. That
would have disconnected the two activities and we would have had
SuperH support half a year ago.

The stress you feel now is because the task is made more complicated
than it had to be IMO.

> I don't think my review has been overly slow, especially in the light
> of the fact that _I_ had to write the code you're now using, despite
> having no platforms that benefit from it at all. Perhaps if you'd don=
e
> that the first time I suggetsed it, you wouldnt have had to wait for
> me to do it for you?

I didn't force you to write the code. I came to you with a rather
light weight implementation that you rejected.

You are right that you asked me to rewrite things. But you also asked
me to make the clock framework arch independent. Adding that
dependency didn't make any sense to me. This through the eyes of a guy
who had worked on implementing SuperH PM for half a year at that
point. So I do understand the internals of the clock framework,
believe me. And making it arch independent is not an easy task. It
involves changing code for a whole bunch of architectures. That's much
much much more complicated than any of this work so far.

=46rom my point of view you kept on insisting on adding this clock
framework dependency, adding a virtual dependency and keeping the code
hostage. So I put the tmio-mmc driver on the list of drivers that I
need to deal with. Not technically - just communication wise I
suppose. I suppose meeting face to face would improve things. What do
you think?

> Yes, the above paragraph is meant to sound irritated. I've put quite
> some time into updating the driver _just for you_. =A0Time I could ha=
ve
> spent doing other things, and time I'm sure Philipp could be better
> using rather than updating ASIC3 _just for you_. =A0 If you wanted it
> doing faster, you could have done it, but I still would have reviewed
> it and still would have wanted it done this way. I was *quite* clear
> about that since some time ago. If you'd simply done that rather than
> keep pushing patches I'd already said I wasnt taking, it'd have taken
> no time at all. =A0 Yes, you'd have had to update the other 4 MFD
> drivers using tmio-mmc yourself, and yes, thats a ball-ache. But sinc=
e
> _you_ want the change, you should do the work. Quite honestly, if
> someone else does it for you, you should be grateful and not complain
> about =A0how long it took.

I _am_ really grateful, believe me. Thank you very much to both you and=
 Philipp.

But from my point of view I didn't force you to do this work. You do
seem to think so. My original patch didn't require any MFD driver
changes. I understand and agree that breaking out the code for the
second io window results in cleaner code. I would have been happy to
do that work myself if I felt that the chance for a simple ACK would
have been higher. My memories is from last time just wild NAKing and
random clock framework rework requirements.

I'm not here to break your driver, you know. And I don't invent
requirements just for fun. I wanted to use the tmio-mmc driver because
I discovered that there is a lot of hardware out there that can make
use of it. The same thing with real requirements goes for Runtime PM -
I'm not pulling these requirements out of the dark - state save and
restore is really needed for proper power managment.

>> I can see a cell->enable() call in probe(), but I can't see any
>> cell->disable() calls in the tmio-mmc driver. I sort of expected the
>> remove() function in tmio-mmc and the probe() error handling code to
>> do cell->disable(), but maybe I'm misunderstanding the way the MFD
>> drivers work?
>
> If the disable hook is not called then that may be a bug. Patches wel=
come.

Cool. Where should it be called then? Both in the error case of
probe() and in remove()? I plan on doing nothing at this point, but if
I make a patch I'd like to avoidto break all the other MFD drivers.

> My point still stands that the facility to power the block on / off a=
s
> and when the module is loaded is quite clearly available in the MFD
> API.

Yes, I agree it's available _when_the_module_is_loaded. But that's not
what I want. I'd like to see a more fine grained control. When the
system is idle it should have the option of being powered off.
Transparently.

This feature will require some serious rework of both the driver and
the MMC framework. And I suspect that you feel far from motivated by
such a change since it doesn't benefit any of your platforms.

>>> Great - as soon as Philipp gets back to us with the ASIC3 update I'=
ll
>>> re-do my patchset to include ASIC3 - if the changes to tmio-mmc and
>>> submitted seperately, it will break ASIC3 so that needs to go in th=
e
>>> same patchset. Philipp will be ready this weekend, not long to wait=
=2E
>>
>> Great, thanks a lot guys!
>
> Hope the work is appreciated. Tracking down the init failure on my
> (slow) netbook took the best part of 24 hours.

Ouch. Don't get me started on netbooks. =3D)

Your help is greatly appreciated.

Cheers,

/ magnus
