From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
Date: Wed, 18 Dec 2013 12:10:35 -0800
Message-ID: <20131218201035.23538.60602@quantum>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <20131215045116.23538.4@quantum> <52AF68DB.7090105@elopez.com.ar>
 <2899559.jbTzDM2qtE@dizzy-6.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:40033 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3LRUKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 15:10:41 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so72235yhz.36
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2013 12:10:40 -0800 (PST)
In-Reply-To: <2899559.jbTzDM2qtE@dizzy-6.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, =?utf-8?q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>
Cc: zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com, mark.rutland@arm.com, devicetree@vger.kernel.org, dinh.linux@gmail.com, heiko@sntech.de, pawel.moll@arm.com, bzhao@marvell.com, tgih.jun@samsung.com, Peter De Schrijver <pdeschrijver@nvidia.com>, linux-mmc@vger.kernel.org, dianders@chromium.org, rob.herring@calxeda.com, jh80.chung@samsung.com, alim.akhtar@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ian.campbell@citrix.com, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>

Quoting David Lanzend=C3=B6rfer (2013-12-16 13:54:21)
> Hi
> > that takes the MMC clock (and only the MMC clock) and does the setu=
p
> > (it's basically configuring two values, "sample" and "output", into=
 the
> > clock register). I really don't know what does this do/why is it
> > required/when is it used; I'm cc'ing Hans and David who can hopeful=
ly
> > explain that part.
> Since the read/write operations have to happen asynchronously and in =
a manner
> so that the data provided by the SD-Card can be fetched on time, a sp=
ecific
> clock phase shift is required as you can see in the linked picture[1]=
=2E
> That's what the function is doing: It accesses the special registers =
of the
> MMC clock device and configures this phase offset.

Yeah, clock phase is a fairly common thing to tune but there are two
things to consider when crafting a new api like clk_set_phase(...):

1) are we adjusting the phase of the clock signal or the phase of
something else related to the clock rate? This is just something to
think about. Sometimes it would be better to have
video_signal_set_phase() instead of clk_set_phase().

2) what is the input parameter to clk_set_phase? I guess the two best
options are degrees (zero to 359), or a fraction of the clock period
(1/4, 1/2, etc).

Any thoughts?

Regards,
Mike

>=20
> > I also saw a similar requirement from the gmac people (on cc too), =
who
> > needed to set the phy type (or something like that) on one of the c=
lock
> > registers; so I'm thinking maybe a generic "tune something" approac=
h
> > that lets users configure some clock-dependent, arbitrary aspect of=
 the
> > clock is the way forward. Otherwise, we're going to end up bloating=
 the
> > clock framework with a lot of callback pointers that are going to b=
e
> > used in one or two clocks out of potentially hundreds on the whole =
system.
> It totally makes sense, since GMAC will be doing asynchrous
> operations as well.
>=20
> -David
>=20
> [1] http://www.chipestimate.com/techtalk/images/11022010_fig2_3.JPG
