From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
 interaction
Date: Tue, 21 Feb 2012 11:14:13 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC3A1@HQMAIL01.nvidia.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
	<20120220073941.GC22562@n2100.arm.linux.org.uk>
	<CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
	<20120221110618.GJ22562@n2100.arm.linux.org.uk>
 <CACRpkdYzRu4VPKPgxuttuvSDCpfHjvBGGq1rFEDExv1PsoLG=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdYzRu4VPKPgxuttuvSDCpfHjvBGGq1rFEDExv1PsoLG=w@mail.gmail.com>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Linus Walleij wrote at Tuesday, February 21, 2012 5:40 AM:
> On Tue, Feb 21, 2012 at 12:06 PM, Russell King - ARM Linux
> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>=20
> >> It's a bit kludgy but works and makes sure the pins are only used
> >> for one thing at a time.
> >
> > No. =A0The case which I'm thinking of is for the Assabet audio, whe=
re
> > we have the following situation.
>=20
> OK... (thanks for the explanation!)
>=20
> > The solution is to wait for SSP to finish, and while SSP is still e=
nabled,
> > switch the pins from the SSP block to the GPIO block and toggle the=
 SFRM
> > signal to flip the WS output before removing power. =A0When startin=
g up,
> > with the pins under control of GPIO, power up and them toggle hte S=
=46RM
> > signal to restore the WS state before giving it back to the SSP blo=
ck.
> >
> > However, here's the thing: SSP must be enabled at the point in time=
 when
> > the pins are given or taken away from it, otherwise SFRM is indeter=
minant.
> > We can't allow gpio_request() to fail at the points where we toggle=
 this
> > pin - failure is not really an option where causing hardware stress=
 is
> > involved.  We can't allow the GPIO block to have the state of these=
 pins
> > change state while the pins are given back to the GPIO block before=
 the
> > GPIOs have been requested (glitches on the SFRM line will cause the=
 state
> > of the FIFO to change.)
>=20
> This can probably be done, mainly I'd say that control over the pins
> need not mean that they are decoupled from some specific hardware, or
> that the hardware is disabled or so, the semantics of doing say
> pinctrl_get/enable/disable/put aren't set in stone, it's just callbac=
ks into
> the device driver so it could avoid doing anything in this case, keep
> the pins muxed for the SSP if the transition goes from SSP->GPIO
> and back.
>=20
> However I guess it would be conceptually closer if say the pins could
> be used for a device and GPIO at the *same time*.

If we allowed that, it would also solve the following comment in patch
2 in this series, in the Tegra GPIO driver:

int tegra_gpio_request(struct gpio_chip *chip, unsigned offset)
{
	/*
	 * We should call pinctrl_request_gpio() here. However, we can't. Tegr=
a
	 * muxes pins in groups not individually, and real boards exist where
	 * most of a pin group needs to be used for some function, yet some of
	 * the pins aren't actually used by that function in the mode the
	 * controller operates on the board, and so those pins can be used as
	 * GPIOs.
	 *
	 * This is true in practice on Seaboard/Springbank, where pin group AT=
C
	 * is used by the NAND controller, but pin GMI_IORDY_PI5 is used as a
	 * GPIO for the SD card slot's CD signal.
	 *
	 * On Tegra30, pins are muxed in groups and hence we could call
	 * pinctrl here, but we don't for now.
	 */
	tegra_gpio_mask_write(GPIO_MSK_CNF(offset), offset, 1);

	return 0;
}

i.e. we actually /could/ call pinctrl_request_gpio() here.

And in turn, the I2C driver (in your example) and SPI driver (in Russel=
l's)
would never have to call pinctrl_disable() and hence the issue I raised
in my previous email would not occur.

The one downside here:

Ignoring WARs like we're discussing, it's typically true that a given p=
in
should either be a special function or a GPIO for any given board. If
we do allow a pin to be owned/used by both, then how do we indicate, on
a per-board rather than per-SoC basis, which pins we should allow both
gpio_request() and pinmux usage? The following considerations exist:

a) On Tegra, a pin group might include 10 pins that are mux'd as a grou=
p,
hence all owned e.g. by a NAND driver. If a few of those aren't used on=
 a
particular board due to the way the NAND is hooked up and the driver
configured, do we only allow gpio_request() only on those pins we know =
the
NAND driver isn't actually using, to prevent someone using unexpected
pins as GPIO? We'd need a per-GPIO per-board way to represent this if
we care about this level of error-checking.

b) In Linus's snooping example, how do we know the SoC can physically
implement enabling a pin as both a GPIO and a special function, such
that the gpio_request() for the snooping won't interfere with the mux'd
function? On Tegra, any GPIO usage is mutually exclusive with mux usage=
;
enabling GPIO even for input, disconnects the input side of the pin fro=
m
any HW module other than GPIO irrespective of mux function. IIRC,
somewhere some per-pin data was mentioned for this.

We could either:

1) Just ignore these issues, and allow both mux and GPIO ownership at
once of any pin, and leave it up to platform data or device tree author=
s
to give the correct GPIO IDs to drivers. This is possibly reasonable, b=
ut
I just want us to make this a conscious decision.

2) Extend the pinctrl mapping table to explicitly represent GPIO usage.

This is required anyway for HW where there isn't a 1:1 mapping between
GPIO ID and pin ID, e.g. 1 pin could be used for two different GPIO
signals, e.g. 1 from each of 2 different GPIO HW modules, with differen=
t
capabilities, or where 1 GPIO could be routed to one of 2 or more pins.

In other words, make "gpio" an explicit mux function, thus allowing
pinctrl_select_state() to directly transition between special function
and GPIO usage, rather than having separate pinctrl and GPIO APIs for
this. This way would entail dropping my Documentation/gpio.txt patch
completely, I think.

If we do this though, I think we'd want to extend pinctrl to allow muxi=
ng
on pins too, so that we don't need to create a pin group for every pin =
to
support per-pin GPIO ownership. This would also help out all the HW tha=
t
already muxes everything per-pin, since they need to create these singl=
e-
pin groups right now... I somewhat anticpated this in my naming of the
mapping table convenience macros in the most recent pinctrl patch I pos=
ted
to add pin config mapping table entries.

Thoughts?

--=20
nvpublic
