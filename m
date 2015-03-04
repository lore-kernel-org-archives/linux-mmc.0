From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 3/4] mmc: sdio: support switching to 1-bit before
 turning off clocks
Date: Wed, 4 Mar 2015 16:28:48 +1100
Message-ID: <20150304162848.2d33914d@notabene.brown>
References: <20150224024023.22719.32436.stgit@notabene.brown>
	<20150224024223.22719.91536.stgit@notabene.brown>
	<20150303225355.GE3756@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/WYiWpQUCu08iIOm07gIIA4B"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37511 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758302AbbCDF3D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Mar 2015 00:29:03 -0500
In-Reply-To: <20150303225355.GE3756@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Ash Charles <ash@gumstix.com>

--Sig_/WYiWpQUCu08iIOm07gIIA4B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Mar 2015 14:53:55 -0800 Tony Lindgren <tony@atomide.com> wrote:

> * NeilBrown <neilb@suse.de> [150223 18:47]:
> > According to section 7.1.2 of
> >=20
> > http://www.sandisk.com/media/File/OEM/Manuals/SD_SDIO_specsv1.pdf
> >=20
> >     In the case where the interrupt mechanism is used to wake the host =
while
> >     the card is in a low power state (i.e. no clocks), Both the card an=
d the
> >     host shall be placed into the 1-bit SD mode prior to stopping the c=
lock.
> >=20
> > This is particularly important for the Marvell "libertas" wifi chip
> > in the GTA04.  While in 4-bit mode it will only signal an interrupt
> > when the clock is running (which is why setting CLKEXTFREE is
> > important).
> > In 1-bit mode, the interrupt is asynchronous (explained in OMAP3
> > TRM description of the CIRQ flag to MMCHS_STAT:
> >=20
> >   In 1-bit mode, interrupt source is asynchronous (can be a source of
> >   asynchronous wakeup).
> >   In 4-bit mode, interrupt source is sampled during the interrupt
> >   cycle.
> >=20
> > )
> >=20
> > It is awkward to simply set 1-bit mode in ->runtime_suspend
> > as that will call mmc_set_ios which calls ops->set_ios(),
> > which will likely call pm_runtime_get_sync(), on the device that
> > is currently suspending.  This deadlocks.
> >=20
> > So:
> >  - create a work_struct to schedule setting of 1-bit mode
> >  - introduce an 'sdio_narrowed' state flag which transitions:
> >      0 (normal) -> 1 (convert to 1-bit pending) ->
> >          2 (have switch to 1-bit mode) -> 0 (normal)
> >  - create a function mmc_sdio_want_no_clocks() which can be called
> >    when the driver wants to turn off clocks (presumably after an
> >    idle timeout).  This either succeeds (in 1-bit mode) or fails
> >    and schedules the work to switch to 1-bit mode.
> >  - when the host is claimed, if sdio_narrowed is 2, restore the
> >    4-bit bus
> >  - When the host is released, if sdio_narrowed is 1, then some
> >    caller other  than our worker claimed the host first, so
> >    clear sdio_narrowed.
> >=20
> > This all allows a graceful and race-free switch to 1-bit mode
> > before switching off the clocks, if SDIO interrupts are enabled.
> >=20
> > A host should call mmc_sdio_want_no_clocks() when about to turn off
> > clocks if sdio interrupts are enabled, and the ->disable() function
> > should not use a timeout (pm_runtime_put_autosuspend) if
> > ->sdio_narrowed is 2.
>=20
> Wow! A mystery finally solved for why libertas_sdio using devices
> like overo won't work for the wakeirqs.. The interface has to be
> in 1-bit mode for libertas to produce any SDIO interrupts..
>=20
> Below is a patch enabling some more SDIO wakeirqs. Seems to work
> on overo now too :) So tor the whole series, please feel free to
> add:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks a lot!


>=20
> 8< -------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 26 Feb 2015 16:16:03 -0800
> Subject: [PATCH] ARM: dts: Fix omap3 SDIO wakeirqs for devices using sdio=
_libertas
>=20
> Turns out the the MMC interface needs to be in 1-bit mode for the
> libertas card to send any SDIO interrupts as pointed out by
> NeilBrown <neilb@suse.de>. Now that the MMC framework is getting
> fixed for setting 1-bit mode for idle, we can enable SDIO wakeirqs
> for libertas using devices too.
>=20
> Cc: Andreas Fenkart <afenkart@gmail.com>
> Cc: Ash Charles <ash@gumstix.com>
> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
> Cc: NeilBrown <neil@brown.name>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -367,6 +367,7 @@
>  };
> =20
>  &mmc2 {
> +	interrupts-extended =3D <&intc 86 &omap3_pmx_core 0x12e>;
>  	vmmc-supply =3D <&vaux4>;
>  	bus-width =3D <4>;
>  	ti,non-removable;

I had=20

+       interrupts-extended =3D <&intc 86 &gpio5 5 0>; /* GPIO_133 */
+       pinctrl-names =3D "default", "idle";
+       pinctrl-0 =3D <&mmc2_pins>;
+       pinctrl-1 =3D <&mmc2_cirq_pin>;

together with

+       mmc2_cirq_pin: pinmux_cirq_pin {
+               pinctrl-single,pins =3D <
+                       OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MO=
DE4)=20
+               >;
+       };
+


and a longer definition for mmc2_pins.

Is that one line reconfigure the pin on demand?  How does that work?


Thanks,
NeilBrown

--Sig_/WYiWpQUCu08iIOm07gIIA4B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPaYEDnsnt1WYoG5AQI/2A/+Id5QeI9puU7XrLLNaWj86QXtOU/mfPuI
0lF1rTIhqiXABqP0SI65McGAOuEWaU8bqsjcTnFL5aZ8gNop7kjbm8ElQxFw+zjx
8wKJNmrwxHamG5jhaS3hw69N/2aHC5p6g2jSn5MthqLogMhBnXNp7q8vgFCgDsmG
iVMlS5ks2K7Olu5W4yWXj/Bv+Vmc1DoD0E02FN3ek089mU7S5zjgEoWvERACn3WG
6Gss4cMLY0CfDLhQlEIVJmBTLbQG2wTQhMy0GG/BPwl2UhqjAp8avquSwK/1yIFy
1XlpULp2/4t3TYU6und883k2KgItknpwLAxA3K+9P1U2SSDADj3H0G/9n7YHXOQM
R4gouuMQH3UmVquhSLlVHFNbh+DPeYEhrPtKXz+kqazbPWjA7TiN8j7wrgE41byx
chEhxxQMI4OOusCniKsPEtmWMLxVGaZUNd3XklZQkBCpVQOQ3NPY8hbk9NoQ793D
e6DU8O7kRZPXHDSL8cZoBxvPB3qFcLF8/HmXcns1ErHmhiWHKCEaRzvO9JjcKBD2
FVZ6itRgAG0OZPz+46bBTn9quZzAhkR6VAP9M5b2T+j4DCfZmJgpeCpdz1t4hY8G
LrMEwgXYRcYnQf4B43Q0ukV6R57etwMZD+7zJPTXrD7LeMkU32kG/8tqQhij/YWC
VyoksgyYomc=
=Id+Q
-----END PGP SIGNATURE-----

--Sig_/WYiWpQUCu08iIOm07gIIA4B--
