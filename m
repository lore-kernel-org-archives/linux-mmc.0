From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl interaction
Date: Tue, 21 Feb 2012 13:40:05 +0100
Message-ID: <CACRpkdYzRu4VPKPgxuttuvSDCpfHjvBGGq1rFEDExv1PsoLG=w@mail.gmail.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
	<20120220073941.GC22562@n2100.arm.linux.org.uk>
	<CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
	<20120221110618.GJ22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120221110618.GJ22562-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 21, 2012 at 12:06 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

>> It's a bit kludgy but works and makes sure the pins are only used
>> for one thing at a time.
>
> No. =A0The case which I'm thinking of is for the Assabet audio, where
> we have the following situation.

OK... (thanks for the explanation!)

> The solution is to wait for SSP to finish, and while SSP is still ena=
bled,
> switch the pins from the SSP block to the GPIO block and toggle the S=
=46RM
> signal to flip the WS output before removing power. =A0When starting =
up,
> with the pins under control of GPIO, power up and them toggle hte SFR=
M
> signal to restore the WS state before giving it back to the SSP block=
=2E
>
> However, here's the thing: SSP must be enabled at the point in time w=
hen
> the pins are given or taken away from it, otherwise SFRM is indetermi=
nant.
> We can't allow gpio_request() to fail at the points where we toggle t=
his
> pin - failure is not really an option where causing hardware stress i=
s
> involved.  We can't allow the GPIO block to have the state of these p=
ins
> change state while the pins are given back to the GPIO block before t=
he
> GPIOs have been requested (glitches on the SFRM line will cause the s=
tate
> of the FIFO to change.)

This can probably be done, mainly I'd say that control over the pins
need not mean that they are decoupled from some specific hardware, or
that the hardware is disabled or so, the semantics of doing say
pinctrl_get/enable/disable/put aren't set in stone, it's just callbacks=
 into
the device driver so it could avoid doing anything in this case, keep
the pins muxed for the SSP if the transition goes from SSP->GPIO
and back.

However I guess it would be conceptually closer if say the pins could
be used for a device and GPIO at the *same time*.

I had this similar example where a pin on U300 could be in GPIO mode
and "spy" on the peripheral using that pin, by just sampling the value
or triggering on edge transitions.

Since each pin has a pin descriptor, we could solve this by marking
pins as "gpio dualmode", i.e. add some bool dualmode to the
descriptor and augment the core to allow pins with this property to be =
in
GPIO and "for device X" mode at the same time. So in
pin_request() in pinmux.c we check for this property and allow
dual-mode on a case-by-case basis (assuming this will be pretty rare,
so the default is not to use it).

Of course it assumes the SA1100 being converted to use pin control,
I looked at it a bit and it seems simple enough since the GAFR
register is a single "GPIO or something else"-switch for the GPIOs.
(It'd probably need the SA1100 to be a bit more strict in using
gpiolib in place for the direct assignments though, else the
abstractions get a bit pointless anyway.)

> Another case where this kind of run-time switching needs to occur is =
the
> PXA IrDA driver, where the pins need to be switched between their FIR=
 and
> SIR modes.

This sounds more mutually exclusive and should be possible to support
with a get/enable/disable/put sequence AFAICT.

Yours,
Linus Walleij
