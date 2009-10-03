From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Sat, 3 Oct 2009 22:11:08 +0900
Message-ID: <aec7e5c30910030611k1f468271x51654aab7d9197ac@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	 <aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	 <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	 <aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	 <c09aa50a0910010319w5c613063j699a02d3a786c34f@mail.gmail.com>
	 <aec7e5c30910012246r1c452606w149f18d9fe825737@mail.gmail.com>
	 <c09aa50a0910020031x1c6f1fceo4740a3edc9592cbe@mail.gmail.com>
	 <aec7e5c30910020057w38e72894p9ffed291f3fc1d1@mail.gmail.com>
	 <c09aa50a0910021114h1a84703dt4f168b9fee1b723a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:33973 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZJCNLE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Oct 2009 09:11:04 -0400
Received: by gxk4 with SMTP id 4so2377053gxk.8
        for <linux-mmc@vger.kernel.org>; Sat, 03 Oct 2009 06:11:08 -0700 (PDT)
In-Reply-To: <c09aa50a0910021114h1a84703dt4f168b9fee1b723a@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

On Sat, Oct 3, 2009 at 3:14 AM, Ian Molton <ian@mnementh.co.uk> wrote:
> 2009/10/2 Magnus Damm <magnus.damm@gmail.com>:
>
>>> I asked if the clock freq. changes - you said 'Well, the goal is
>>> dynamic clocks, but at this point it's dynamic until the clock is
>>> enabled'.
>>>
>>> Since your code doesnt set the clock frequency, that means the MMC
>>> drivers f_max will be set to whatever the clock was running at when
>>> you grab it.
>>
>> Yes?
>
> Well if its set to 512kHz prior to being claimed, that means the MMC
> clock will run between 1kHz and 512kHz
>
> tmio_mmc will work like that but it seems kinda daft...

512kHz?

Exactly how the SDHI is hooked up varies from processor to processor,
and since the clock generator is configurable by software the rate may
vary depending on embedded application. The numbers I've seen so far
seem to be around 100 _MHz_ which should be more than enough. Don't
worry.

>> You can call it whatever you want. On SuperH we can do clock scaling
>> which seems very dynamic to me. But before changing the clock we nee=
d
>> to make sure that all drivers and =A0hardware blocks support changin=
g
>> the frequency. Changing the clock frequency while the driver or
>> hardware needs it fixed is of course a programming error.
>
> exactly - which is one reason why I said your clk based implementatio=
n
> is broken - tmio_mmc has no logic for coping with a clock that change=
d
> frequency. Since all tmio-based devices appear to have the
> frequency-divider =A0built in, I suspect that all tmio units expect t=
o
> have a host (input) clock in the 20-30MHz range. Since the superH tmi=
o
> blocks clock divider is missing the unity divisor, varying the imput
> clock speed to change the MMC bus frequency seems like a bad idea. If
> you could do unity-divisor then you might be able to save a little
> power disabling the TMIO divisor and adjusting the input clock
> frequency

So the shared SDHI input clock is usually set to around 100 MHz. If
I'm right then this clock is divided by the value in the
CTL_SD_CARD_CLK_CTL register which allows us to divide by a maximum of
512. Which would be enough to give us a wide range of valid MMC
frequencies.

In my opinion the code is not broken since we're _not_ changing the
frequency while running today. After the clock is enabled with
clk_enable(), the rate is fixed. The frequency may change again after
the clock is disabled with clk_disable(), so if we ever extend the
code to disable and enable on a more fine grained basis we need to
read out the frequency again after redoing clk_enable(). The
i2c-sh_mobile.c driver is a good example of a driver with more fine
grained clock control - it keeps the clock off while idle and enables
and reads out the frequency when it is requested to do any i2c
activity and then disables the clock again when done.

Right now we keep the clock constantly enabled while the tmio-mmc
driver instance is running so there is no problem. And if someone
would change the frequency while we are running then it's a bug. But
that's a system configuration issue which will affect a whole bunch of
drivers so I wouldn't worry about it if I were you. And it's far from
a unique problem to the tmio-mmc driver. Think about it - on-chip we
have serial ports, USB controllers, sound interfaces, RAM controllers,
ethernet controllers, LCD panel hardware interface blocks, camera
interfaces and a whole bunch of other more specialized hardware
blocks. Most of these have drivers that use the clock framework
already and if someone would change the frequency "behind the back"
without notifying and updating the drivers then the clocks for the
hardware interfaces may go out of range and things will just stop
working. So we're not doing that. That would be silly.

But yes, neither the tmio-mmc driver nor the mmc framework supports
updating the frequency while running. At least last time I checked.
That's usually the case when the frequency range is set once at
register time. =3D) It would be nice to add support for updating the
range though. I did just that for clockevents a few months ago.

>>> Well the tmio MFD drivers do just that, if you take a look. The hoo=
ks
>>> are already there.
>>
>> Do you mean powering off the SD-Card?
>
> Well the CNF area controls card clocking and power.
> but the MFD code provides enable and disable hooks. Cutting the clock
> and sleeping the chip is the best the toshiba hardware can do, but
> theres no reason not to turn off the chip when its not in use (as
> opposed to suspended / idle - or the registers will lose state)

Well, _we_ can control the power domain where the SDHI block(s) is/are
located. And I suspect SoCs from other embedded processor vendors can
do the same. But to do that we need to have support for saving and
restoring the state in the driver.

Try this:
damm@rxone ~/git/linux-2.6 $ find drivers/ | xargs grep pm_runtime

As you can see, quite a few of my drivers save and restore state
already. I'd be happy doing the technical work for the tmio-mmc
driver. Unless you want to. =3D)

But before I even think of extending the tmio-mmc driver _we_ _really_
need to work on improving the patch throughput a bit. I guess it's a
question of trust. From my point of view it is risky and frustrating
to do the work if we can't agree on things. From your side I suspect
that you just don't want any breakage. I think you should trust me on
not wanting to break your driver and in the rare case I would then I
have time to spend on fixing it up.

>> I don't think your MFD drivers do that,
>
> Actually they do provide provision for that by means of the enable /
> disable hooks.
>
> if you unload the driver, the disable hook will get called and you ca=
n
> power it off there.

I can see a cell->enable() call in probe(), but I can't see any
cell->disable() calls in the tmio-mmc driver. I sort of expected the
remove() function in tmio-mmc and the probe() error handling code to
do cell->disable(), but maybe I'm misunderstanding the way the MFD
drivers work?

>> especially since the Runtime
>> PM framework was merged quite recently and I doubt that there are an=
y
>> ARM implementations available upstream at this point.
>
> Thats something for the future - right now tmio-mmc wont take power
> being interrupted whilst it runs.

Yeah, indeed something for the future.

>> I've already tested the first patch with my series that that I poste=
d
>> earlier today. So from the SuperH side things are ok.
>
> Great - as soon as Philipp gets back to us with the ASIC3 update I'll
> re-do my patchset to include ASIC3 - if the changes to tmio-mmc and
> submitted seperately, it will break ASIC3 so that needs to go in the
> same patchset. Philipp will be ready this weekend, not long to wait.

Great, thanks a lot guys!

/ magnus
