From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus clock
Date: Tue, 27 Mar 2012 13:02:38 +0900
Message-ID: <CANqRtoQ7z3YVujA0hmiZoubpD-3vK4kemXWWtVq6DH9Fe82tyA@mail.gmail.com>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
	<1332320549-28584-3-git-send-email-horms@verge.net.au>
	<Pine.LNX.4.64.1203241904150.19427@axis700.grange>
	<20120325223033.GA6860@verge.net.au>
	<4F70027A.9020203@renesas.com>
	<20120326055256.GE2347@verge.net.au>
	<CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
	<20120327014343.GA28782@verge.net.au>
	<CANqRtoTtXSess2UQAj1K80xmSuubrK5gw+YkWnBiyNyiY5mQfQ@mail.gmail.com>
	<87limmybjo.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60862 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2C0ECk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 00:02:40 -0400
Received: by vcqp1 with SMTP id p1so4881946vcq.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 Mar 2012 21:02:39 -0700 (PDT)
In-Reply-To: <87limmybjo.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Simon Horman <horms@verge.net.au>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

Hi Chris,

On Tue, Mar 27, 2012 at 12:20 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Mar 26 2012, Magnus Damm wrote:
>>> Do you have a feeling of if it it worth trying to start with a valu=
e close
>>> to 400kHz or if it would be better to simplify the code? I can try =
and
>>> measure the difference in start up time for particular hardware
>>> combinations, but I'm not sure how far that will get us.
>>
>> I believe the correct way is to program the hardware to be as close =
to
>> 400 kHz as possible. I may be wrong, but I guess that slower than 40=
0
>> kHz is also acceptable during the initial phase, but faster may mean
>> out of spec. For optimal performance the code may need to be reworke=
d
>> to support both correct and slow 400 kHz as well as whatever high
>> frequencies needed for fast transfers.
>
> Hm, I think I'm missing something -- you shouldn't need to optimize f=
_min
> in the driver at all, because the core handles retrying at lower freq=
uencies
> in the init phase (before switching to the higher frequency that come=
s from
> the CSD) and it always begins at 400KHz if that's above f_min. =A0In =
core.c:
>
> void mmc_rescan(struct work_struct *work)
> {
> =A0 =A0 =A0 =A0static const unsigned freqs[] =3D { 400000, 300000, 20=
0000, 100000 };
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(freqs); i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mmc_rescan_try_freq(host, max(fre=
qs[i], host->f_min)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
>
> So, why would you want f_min to be near 400KHz?

=46irst of all, sorry to cause confusion. It is most likely me missing
something. =3D)

The reason we want f_min to be near 400 kHz is that this moves our
window of allowed frequencies as high as possible. We could go lower
than 400 kHz but due to hardware limitations that may also lower
f_max.

So thanks to your pointer I can see that a range of frequencies are
being tried in mmc_rescan(). I can see how f_init is being set in
mmc_rescan_try_freq() and the value is being passed down in
mmc_power_up() which in turn sets ios.clock to f_init and calls
mmc_set_ios(). This regardless of f_min in this case - perhaps worth
comparing to the WARN_ON() comparison with f_min in __mmc_set_clock().
I know too little about the MMC subsystem to say anything about that.

Anyway, I was mainly wondering about the setup of the clocks in the
driver for the MMC host hardware. I got the impression that f_min and
f_max are supposed to be used to point out the minimum and maximum
allowed frequencies that the hardware supports. On our SoCs this
depends on the rate of the parent clock and the number of bits used
for the MMC host hardware divider.

So the parent clock rate may be rather high, and if it happens to be
set too high on a board level then the MMC hardware block won't be
able to program the frequencies as low as 400 kHz. So my point is only
that we need to make sure that the parent clock rate is set in such a
way that we can have some at least half-high clock frequency for
decent general purpose throughput but if we try to increase the clock
rate too much then we may force the lowest clock rate to go above 400
kHz and then I suspect we may be out of spec. All this is based on
that the parent clock is set statically to some frequency during boot
by the SoC or board code.

Some device drivers may set the parent clock rate in ->set_ios() but
we do not at this point. We keep the parent rate fixed and just adjust
the frequency in the range that the on-MMC-controller divider allows
us to do without affecting the rest of the system. The code could be
extended to also set the parent clock but due to clock dependencies
related to the SoC clock topology we may not be able to change those
frequencies during runtime.

Anyway, I hope this clarifies how I see things!

Thanks,

/ magnus
