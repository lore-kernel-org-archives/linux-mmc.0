From: Daniel Drake <dsd@laptop.org>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Sun, 18 Nov 2012 11:42:10 -0600
Message-ID: <CAMLZHHRAq7NHrDeA6d3JLsALGgVgfBxL8Y=DMNCLSDvFOFVw2Q@mail.gmail.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
	<CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56500 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab2KRRmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 12:42:11 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2875112pad.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 09:42:10 -0800 (PST)
In-Reply-To: <CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Nov 2, 2012 at 8:35 AM, Johan Rudholm <jrudholm@gmail.com> wrot=
e:
> Good question. I=92d guess that mmc_power_off/up does not work as
> expected here, that the card is not at all power cycled.

Before going further on the "find a way to quirk it" route, there is
something else we could look into.

According to our hardware engineers, the external SD card power has
been "always-on" until now. It is actually controlled by our embedded
controller, separate from the CPU.

In a test firmware, I can now control the SD card power via our "OLPC
EC" interface, I call into that from mmc_power_up and mmc_power_down.
And, with your hacky patch to make the voltage switch failure
detection work, this fixes it: it tries 10 times at 1.8v then falls
back to 3.3 successfully. No more problems with the power cycle.

So we have the option of fixing it that way: if we can fix the voltage
switch failure detection, we could implement a custom vmmc regulator
driver that uses our EC interface to enable and disable the SD power
appropriately, solving our ability to power cycle.

On the other hand, we may have a good basis to add a quirk, triggered
by the device tree, for when the hardware physically does not have
1.8v capabilities.

I'm also curious if there is a 3rd option. It seems like in the case
of our SoC, the SoC design mandates that the SD card power is separate
from the SDHCI interface - requiring either a GPIO or some other
mechanism (e.g. OLPC EC) to be able to control it.

I'm wondering if this is the same for all sdhci-pxa devices. And the
same for all sdhci devices? Maybe the SDHCI specs would help here, but
I guess they aren't public.

If this is the case, the driver could have another heuristic: if there
is no vmmc regulator, there is no way of cutting the card power,
therefore we could avoid even trying 1.8v on the basis that we know we
can't recover if things go wrong.

Similarly, for our next product we are looking at adding 1.8v
capabilities. However, it seems that again, the SoC design (or
something more fundamental?) requires that this power is controlled
via some external mechanism - we're planning to use a GPIO to switch
between 1.8v and 3.3v, which can be exposed as a regulator. So again,
would it be fair for sdhci-pxa or sdhci to drop the UHS-I support when
no regulator is present? Or am I over-generalizing?

Thanks,
Daniel
