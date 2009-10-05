From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Mon, 5 Oct 2009 15:49:21 +0900
Message-ID: <aec7e5c30910042349p1d1c96fbk2e40beb8ee0fcecf@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	 <c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
	 <aec7e5c30910012246r1c452606w149f18d9fe825737@mail.gmail.com>
	 <c09aa50a0910020031x1c6f1fceo4740a3edc9592cbe@mail.gmail.com>
	 <aec7e5c30910020057w38e72894p9ffed291f3fc1d1@mail.gmail.com>
	 <c09aa50a0910021114h1a84703dt4f168b9fee1b723a@mail.gmail.com>
	 <aec7e5c30910030611k1f468271x51654aab7d9197ac@mail.gmail.com>
	 <c09aa50a0910031700l390b6185o3a6b6376aead4e1e@mail.gmail.com>
	 <aec7e5c30910032205j1f9cefa6r7639164904b3ae8c@mail.gmail.com>
	 <c09aa50a0910040851g51640678r5d1f79a50b01164a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:48950 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbZJEGt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2009 02:49:59 -0400
Received: by ywh3 with SMTP id 3so2682015ywh.22
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2009 23:49:22 -0700 (PDT)
In-Reply-To: <c09aa50a0910040851g51640678r5d1f79a50b01164a@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

Hi Ian,

On Mon, Oct 5, 2009 at 12:51 AM, Ian Molton <ian@mnementh.co.uk> wrote:
> 2009/10/4 Magnus Damm <magnus.damm@gmail.com>:
>> The TMIO block itself may not use much power, but it's pretty common
>> to have power domains that cover a range of hardware blocks.
>
> Hm, that could get ugly. the MFD concept would tend to consider an MF=
D
> to control the power to its blocks. You want to use an MFD subdriver
> outside the power domain of the 'MFD' that contains it.

=46or SuperH SoCs most on-chip devices are registered as platform
devices, and for those devices architecture specific platform bus
extensions handle the runtime pm management. So the architecture code
gets to do whatever it needs to make sure the right low power states
can be entered during runtime. So it's all done without MFD today. Not
sure which way is best to deal with the MFD stuff at this point.

>>> Thus far only one TMIO block has register save / restore and thats
>>> because its in a braindamaged hardware design that shuts off power =
to
>>> the ASIC when it sleeps.
>>
>> Or maybe they have very coarse grained power domains. =3D) Some deep=
er
>> sleep modes on certain embedded SoCs turn off the power domains whic=
h
>> will give the same result as you are describing.
>
> No, its because that particular device is braindamaged. Normally, the
> tc6393xb MFD maintainns the state of all its blocks (even if the bloc=
k
> itself is disabled in the MFD system config register) so you can
> suspend and resume the MFD without powering it off. One of sharps
> devices kills power to the ship too, which needed working around in
> the video driver.

So it's a matter of just stopping the clock or stopping clock + power o=
ff?

>>> Its probably not worth it, unless the SH design is merely a copy of
>>> the tmio design rather than a reimplementation. it barely uses any
>>> power when the clock is off anyway.
>>
>> It's worth it, believe me.
>
> Do you =A0have any figures (measure current draw) to back that up?

I've calculated the numbers below using values from the sh7722 data she=
et:

Typical Processor Power Consumption [SH7722 @ 266/66/133 MHz]:
    No Power Management: ~0.6W
    "Sleep Mode": ~0.2W
    "Software Standby Mode": ~0.01W
    "U-Standby Mode": ~0.0001W

As for SDHI and tmio-mmc:
- To enter "Software Standby Mode" properly we need to have more fine
grained clock control.
- To enter "U-Standby Mode" we need runtime pm save/restore state suppo=
rt.

With the current MMC code the clock to the SDHI block will be enabled
as long as the driver is loaded. This blocks transition to deeper
sleep states. The best we can do with MMC enabled is basically "Sleep
Mode" which is far from good. I want to be able to enter the deepest
sleep state even though there's a SD Card plugged in and the driver is
loaded.

There are some real world numbers to back up some of the above in my
Runtime PM presentation from ELC2009:
http://www.celinuxforum.org/CelfPubWiki/ELC2009Presentations

> Seriously, on e750 the power draw of the tc6393 in standby is so low
> my meter cant measure it.

The Linux PM mini-summit notes from earlier this year contains a list
of recommended power meters:
http://lwn.net/Articles/345007/

>>> I'd like to see that this would result in significant power saving
>>> first. simply halting the block on my boards drops it to damn near
>>> zero consumption, and its still ready to go then.
>>
>> Right, stopping the clock is great as a first step. This is the very
>> first step of power managment. As for the SDHI block - we're not eve=
n
>> fully there yet because we don't control what you call HCLK
>> dynamically. The next step after mucking around with more fine grain=
ed
>> clock stopping would be to implement save and restore.
>
> We dont control HCLK because the documentation for the tmio-mmc block
> says one should use the clock gating that is provided by it. Also
> stopping HCLK on platforms with tc63**xb would probably hang the
> system as soon as any of the other peripherals in the MFD got
> accessed. the SDHI block has the same clock gating available, so I
> expect its best to use it. Further, there is nothing in the docs
> detailing how one should start / stop HCLK for tmio-mmc - it is
> assumed that the MFD containing it always has HCLK enabled prior to
> starting the MMC block, and stopped after disabling it (or on suspend
> / resume)

Right, but it would be nice with more fine grained control for
hardware that supports stopping the HCLK without affecting other
hardware blocks. I believe that such code can easily coexist with the
existing clock gating stragegy that you mention.

>>> Thats easily solved - agree on what needs to be done first.
>>
>> Good. But I think we both knew what was needed earlier. From my
>> perspective, I needed to use the tmio-mmc driver on hardware that
>> wasn't supported yet. I sent a bunch of patches. Some got in, some
>> didn't which left my hardware unsupported.
>
> Thats pretty normal patch submission procedure. Somee make it, some
> get asked for a rework.

Right, I agree with you.

>> Then there was this clock framework discussion. I can understand you=
r
>> pain with the lack of arch-independent clock framework support. But =
on
>> my hardware the clock framework is working perfectly fine.
>
> Your hardware is one of (currently) 5 users of the driver (with
> another one being developed, although I havent heard from the guy
> recently).
>
> I conceeded that expecting the clock API to be reworked wasnt
> realistic at the time, so I rewrote the clock/power handling for
> tmio-mmc.

That was a wise decision IMO.

> I dont intend to modify the clock / power handling further at this
> point because it works well enough now.

And my numbers above? =3D)

> Fully dynamic clocking / power control will require some sort =A0of A=
PI
> to manage clocks and power. The dev pm stuff might do for power, but
> there is nothing suitable for use with clocks yet. Until there is, it=
s
> going to be messy.

We use runtime pm to both control clocks and save/restore state. For
SuperH Mobile the power is controlled on a more global scale and can
only be turned off if clocks are off and state is saved.

> Might I suggest that it should be now, now that you can use the
> in-kernel tmio-mmc driver, that you, I, we, and anyone else
> interested, should look into actually making the clk API useful?

Good suggestion. Maybe I can fit that with some other tasks that I
have lined up.

> So you agree that the code is better for the extra time it took - the=
n
> there should be no problem. Throwing code into the kernel in a big
> heap isnt the way to go. its fine for private trees etc. but it
> rapidly gets out of control if stuff just getsb accepted without bein=
g
> thought out properly. I spent a night removing and coalescing in one
> place, about 20 cookie-cutter functions from the ASoC code a while
> back, which, if people had done things properly to begin with, would
> never have existed in the first place. Its all wasted time. That code
> should have been spotted in someones personal tree long ago and been
> fixed before it ever got to mainline.

I agree that the code looks better than before. But I don't agree on
the idea of upstream always containing the correct long term solution.
You don't want things out of control, but the code also moves in some
direction all the time. Your words above "I dont intend to modify the
clock / power handling further at this point because it works well
enough now." makes me think that you believe that there is no need to
improve the driver. But from my point there is a whole lot to do with
the driver.

>> So again, I really appreciate your help. But from my point of view y=
ou
>> could have just accepted my "make the second io area optional" patch
>> earlier and done this cleanup at any time later without stress.
>
> IOW, you want your code rushed into the kernel and me to 'just fix
> things later' for you.
>
> Since you want the feature in question, why should not _you_ be the
> one tasked with doing it properly?

I wanted the code included so I can show people here that we have a
working upstream driver and a healthy relationship with the maintainer
so we can proceed investing time in it. So I would have done the work.

>> That
>> would have disconnected the two activities and we would have had
>> SuperH support half a year ago.
>
> Just because you gave up for several months after your first attempt
> doesnt mean the process had to take that long.

I could have pinged more frequently, yes, I agree.

>> I didn't force you to write the code. I came to you with a rather
>> light weight implementation that you rejected.
>
> Yes. Normally when that happens, you go away and rewrite the code, no=
t
> expect the maintainer to do it for you.

I'm not expecting the maintainer to rewrite the code. I just want good
and clear communication so I can rewrite the code myself - just like
the one zillion other drivers I've spent time hacking on.

>> So I do understand the internals of the clock framework,
>> believe me.
>
> When you do things like pass struct clk pointers around in violation
> of the API, that makes it a bit more tricky to believe.

You can call it a violation if that makes you happy. I call it an
ARM-centric convention.

>> And making it arch independent is not an easy task. It
>> involves changing code for a whole bunch of architectures. That's mu=
ch
>> much much more complicated than any of this work so far.
>
> Perhaps you and I should collaborate on that and actually get the job
> done, rather tham complain about it?

So what do you propose?

>> I _am_ really grateful, believe me. Thank you very much to both you =
and Philipp.
>>
>> But from my point of view I didn't force you to do this work.
>
> True. Perhaps I should have kept NAKing until you did it?

So if you NAKed and explained your goals clearly then I would have
rewritten the code. If it was a contant NAK-fest without any clear
technical reasoning I would have made sure the code got merged some
other way.

>> I wanted to use the tmio-mmc driver because
>> I discovered that there is a lot of hardware out there that can make
>> use of it. The same thing with real requirements goes for Runtime PM=
 -
>> I'm not pulling these requirements out of the dark - state save and
>> restore is really needed for proper power managment.
>
> Well, its possible it might give a fractional improvement. Prove me
> wrong with numbers...

See above! =3D)

> I think that tmio-mmc should be left alone in favour of improving the
> clk API at this point, which would mean you could use your struct clk
> directly in the driver and we could look at putting finer grained PM
> in the MFD drivers too.

Sounds like a good plan. I don't have any hardware where the clock
framework isn't working as expected though. All boards that I have
come with SDHI integrated in the SoC, and in that case it's the same
clock framework as the main processor clock framework. That's slightly
different from the outside-the-soc MFD case.

>>> If the disable hook is not called then that may be a bug. Patches w=
elcome.
>>
>> Cool. Where should it be called then? Both in the error case of
>> probe() and in remove()?
>
> I expect so (not looked at the code yet)
>
>> I plan on doing nothing at this point, but if
>> I make a patch I'd like to avoidto break all the other MFD drivers.
>
> Its the intended use of the hooks, so feel free to write a patch for =
it.

Ok, will put that on my TODO list.

>> Yes, I agree it's available _when_the_module_is_loaded. But that's n=
ot
>> what I want. I'd like to see a more fine grained control. When the
>> system is idle it should have the option of being powered off.
>> Transparently.
>
> I think it should be found out if its worth it first. Its a lot of
> code for little gain probably.

I'll let the numbers speak for themselves.

> That said the mmc block is fairly simple, it can be simply reset to
> restore state.

Nice.

> Of course there are other issues like how to suupport SD cards that
> remain poowered during suspend...

Right, suspend issues. I have to admit that I have very little
interest in suspend. My main goal is to get an idle running system as
close as possible to the power efficiency of a suspended system.

>> And I suspect that you feel far from motivated by
>> such a change since it doesn't benefit any of your platforms.
>
> Correct, however if you can back your claims with some current
> measurements with the block powered off =A0/ unclocked vs unclocked v=
s
> running, and if the gain is worthwhile, I will consider such a patch.
>
>> Ouch. Don't get me started on netbooks. =3D)
>
> I like my netbook. I just wishh it was a 4 core ARM rather than X86..=
=2E

I like the concept of small laptops, but they've been around forever
here in japan. I guess it's nice with the price drop, but the engineer
in me is not so keen on seeing old technology with poor performance
and crappy battery life being reused.

Cheers,

/ magnus
