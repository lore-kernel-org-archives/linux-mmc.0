From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl interaction
Date: Tue, 21 Feb 2012 14:08:23 +0100
Message-ID: <CACRpkda3ZYptmExYbMuQv1LJqf=hD8g8jcPSP8Lij5-xaYd2GQ@mail.gmail.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
	<20120220073941.GC22562@n2100.arm.linux.org.uk>
	<CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
	<20120221110618.GJ22562@n2100.arm.linux.org.uk>
	<CACRpkdYzRu4VPKPgxuttuvSDCpfHjvBGGq1rFEDExv1PsoLG=w@mail.gmail.com>
	<20120221124409.GL22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120221124409.GL22562-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 21, 2012 at 1:44 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

>> (It'd probably need the SA1100 to be a bit more strict in using
>> gpiolib in place for the direct assignments though, else the
>> abstractions get a bit pointless anyway.)
>
> That's mostly happened through my recent set of 100 or so patches.
> There's a few areas where that's not quite as easy as it should be,
> but on the whole, it's mostly complete.

Excellent!

> The other thing I forgot to mention, and I suspect it's particular to
> SA11x0, is that the GPDR must be set correctly according to the speci=
al
> function as well as GAFR. =A0So, if a special function involves drivi=
ng
> a pin, the pin must be set as an output in GPDR. =A0Conversely, if th=
e
> special function involves input only, the pin must be set as an input
> in GPDR.
>
> So, on SA11x0, gpio and pin configuration are intimately linked.

It's quite common I think, many platforms have an intimate
relation between GPIO and muxes/altfunctions. For example
it is common that the hardware engineer doesn't helpfully
enable on-die pull-ups on the I2C bus even though the I2C
block is muxed in, you have to go in and set the pull-up bits
separately from muxing the I2C in...

Basically it's expected from a generic pad I/O cell being
arrayed into a GPIO block to expose these things in the same
set of registers.

I made some presentation last week partly describing how
some hardware engineers I know go about creating GPIO
controllers from simpler I/O pad cells:
http://www.df.lth.se/~triad/papers/pincontrol.pdf

Yours,
Linus Walleij
