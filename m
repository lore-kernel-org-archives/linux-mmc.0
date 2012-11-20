From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Tue, 20 Nov 2012 09:53:35 +0100
Message-ID: <CA+20K0Cfmpe46S8pS2QOn4ac0x=Uab0MsDHX_=SSraaqyA1c3A@mail.gmail.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
	<CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
	<CAMLZHHRAq7NHrDeA6d3JLsALGgVgfBxL8Y=DMNCLSDvFOFVw2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:59820 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2KTIxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Nov 2012 03:53:36 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4063315iay.19
        for <linux-mmc@vger.kernel.org>; Tue, 20 Nov 2012 00:53:35 -0800 (PST)
In-Reply-To: <CAMLZHHRAq7NHrDeA6d3JLsALGgVgfBxL8Y=DMNCLSDvFOFVw2Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi!

2012/11/18 Daniel Drake <dsd@laptop.org>:
> On Fri, Nov 2, 2012 at 8:35 AM, Johan Rudholm <jrudholm@gmail.com> wr=
ote:
>> Good question. I=92d guess that mmc_power_off/up does not work as
>> expected here, that the card is not at all power cycled.
>
> Before going further on the "find a way to quirk it" route, there is
> something else we could look into.
>
> According to our hardware engineers, the external SD card power has
> been "always-on" until now. It is actually controlled by our embedded
> controller, separate from the CPU.
>
> In a test firmware, I can now control the SD card power via our "OLPC
> EC" interface, I call into that from mmc_power_up and mmc_power_down.
> And, with your hacky patch to make the voltage switch failure
> detection work, this fixes it: it tries 10 times at 1.8v then falls
> back to 3.3 successfully. No more problems with the power cycle.

Ah, great! Then we know what the issue was at least. Then I guess that
this code did not work with your driver:

			host->ios.clock =3D 0;
			mmc_set_ios(host);

so with my original patch ([RFC/PATCH,v2] mmc: core: Fixup signal
voltage switch), the clock was actually never stopped during the
signal voltage switch? I guess this will need some further
investigation also.

> So we have the option of fixing it that way: if we can fix the voltag=
e
> switch failure detection, we could implement a custom vmmc regulator
> driver that uses our EC interface to enable and disable the SD power
> appropriately, solving our ability to power cycle.

Being able to power cycle the SD-card might also come in handy in
other situations, perhaps if a poor SD-card misbehaves in some way?
SD-cards have no "reset cord" like eMMCs, so being able to power cycle
the card feels like a good thing.

> On the other hand, we may have a good basis to add a quirk, triggered
> by the device tree, for when the hardware physically does not have
> 1.8v capabilities.

This also seems proper, if we know we can't get 1.8V, then we
shouldn't even try for it. In this way the detection will also be
faster (no 10 retries).

> I'm also curious if there is a 3rd option. It seems like in the case
> of our SoC, the SoC design mandates that the SD card power is separat=
e
> from the SDHCI interface - requiring either a GPIO or some other
> mechanism (e.g. OLPC EC) to be able to control it.
>
> I'm wondering if this is the same for all sdhci-pxa devices. And the
> same for all sdhci devices? Maybe the SDHCI specs would help here, bu=
t
> I guess they aren't public.
>
> If this is the case, the driver could have another heuristic: if ther=
e
> is no vmmc regulator, there is no way of cutting the card power,
> therefore we could avoid even trying 1.8v on the basis that we know w=
e
> can't recover if things go wrong.

So the driver could for instance drop the MMC_CAP_UHS_DDR50 cap if
there is no way to power cycle the card? I think that sounds
reasonable and according to spec, although also a little bit hard
since there probably are cards out there that never require a power
cycle to perform a proper voltage switch?

Kind regards, Johan
