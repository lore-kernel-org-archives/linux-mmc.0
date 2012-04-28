From: NeilBrown <neilb@suse.de>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Sat, 28 Apr 2012 19:51:03 +1000
Message-ID: <20120428195103.72b9f170@notabene.brown>
References: <WC20111118085327.010279@terrafix.co.uk>
	<CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
	<WC20111118100011.2902A2@terrafix.co.uk>
	<CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
	<WC20111129111750.470087@terrafix.co.uk>
	<CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
	<CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
	<CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
	<CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
	<CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
	<CAK=WgbaKFhknaDVEbPjmcWGL-F_DiYG0t1t-cB-sGWHPCOBErA@mail.gmail.com>
	<CAGDS+n=bYK4_RZMd9TeKTGafi6k9JQmu1u2ELuUQecTKxJ_gfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/GQgije3B0oAxioHnxWBKuqB"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44951 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab2D1JvO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 28 Apr 2012 05:51:14 -0400
In-Reply-To: <CAGDS+n=bYK4_RZMd9TeKTGafi6k9JQmu1u2ELuUQecTKxJ_gfg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Chris Ball <cjb@laptop.org>, Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Bing Zhao <bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>

--Sig_/GQgije3B0oAxioHnxWBKuqB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Apr 2012 16:51:10 -0700 Steve Sakoman <sakoman@gmail.com> wrote:

> On Mon, Dec 19, 2011 at 1:10 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>=20
> > We're slowly progressing towards understanding the issues we have with
> > the 8686 (it seems there are a few different hw revisions of it, some
> > of which do require toggling the reset pin before sending another init
> > sequence), but it might take some more time until a solution fully
> > materializes.
> >
> > Since 3.2 is just around the corner, I suggest we should now proceed
> > with the revert (see patch below), and later revisit this once we have
> > a complete solution in hand.
>=20
> Has any progress been made on this issue?
>=20
> I too have been trying to power down/up the wifi module on the Overo.
> I'm seeing the same issue described in this thread.
>=20
> Some additional data:
>=20
> I rebuilt my kernel (3.2) with a CD GPIO enabled for the mmc port the mod=
ule
> is connected to and in turn connected that GPIO to another one that I
> can toggle from user space.
>=20
> Toggling the CD GPIO after powering back up the module does indeed
> work properly -- the module is detected, the driver loaded, and proper fu=
nction
> restored.
>=20
> So basically the procedure I've used is:
>=20
> - decide wifi can be powered down
> - unload the libertas modules
> - put the wifi hw in reset with gpio16
> - wait till wifi is needed again
> - take the chip out of reset
> - toggle the CD gpio
> - libertas modules are autoloaded, as is the firmware
> - wifi is up and functioning
>=20
> So the next step is to get rid of the silly two GPIO external hardware
> hack.  Is it possible to trigger a card insertion/removal event via
> some standard API?
>=20
> Or does the above information provide a clue as to why normal code
> paths don't work?
>=20
> Any other ideas?

I thought I had a nicely working solution, but I recently discovered that it
doesn't work as well as I thought it did.  I now think we need some help fr=
om
the mmc layer to get it really working.

My understanding of the underlying problem is that the wifi chip can get
into a state where it really needs a hardware reset, but it isn't given one.
Applying the reset at the right time is needed.

When the mmc layer wants to power-up the device, it tells the configured
regulator to turn on, then sends some standard command sequence.
If the regulator was actually off, this works (I think - it is a while since
I experimented).  However if the regulator wasn't actually off, it doesn't
work - the wifi chip gets confused by getting the init sequence when it is
already inited, and fails to continue.
So pulsing the resent line low after turning on the power is necessary and
sufficient.
In my case, the regulator is shared by the bluetooth and the wifi so if
bluetooth is on while the wifi is off the regulator never gets turned off,
and so bad things happen when we try to turn the wifi back on.

I had worked around this by defining a separate 'fixed' regulator to power
the wifi chip.  It declared the real regulator as the 'supply' regulator so
that when the mmc driver turns on this pseudo regulator, the real one gets
turned on too.  The 'fixed' regulator can drive a gpio and I configured it =
to
drive the wifi reset line.  So when the regulator was turned off, the wifi
was held in reset.  When the regulator was turned back on, the reset was
release, the power was on, and it all worked beautifully.

But there are two problems with this:
 1/ the reset line is also shared with the bluetooth :-( so I cannot hold it
    down.  It is safe to pulse it down, but the 'fixed' regulator won't do
    that (without a bit of hacking)
 2/ When the voltage is set for the 'fixed' regulator, it is not propagated
    back to the real regulator, so the real regulator's voltage doesn't get
    set properly to make the requirements of the wifi chip.

I can work around the first problem by hacking the 'fixed' regulator, but I
wouldn't expect that hack to go upstream.

I can work around the second by observing the hsmmc enables 2 regulators if
they are defined: vmmc and vmmc_aux
So I configure the real regulator as vmmc, which gets the voltage setting,
and configure the pseudo regulator as vmmc_aux.  This gets powered on after
vmmc, so the reset happens at the right time.

But I think all this is really just hacking around the problem.
I think we need for omap_hsmmc.c to be able to accept a 'reset_gpio' config,
and to toggle that after power-on.
It is unfortunate to have to include functionality for one particular device
in common code like this, but I really cannot see any other way.

BTW I explicitly set MMC_CAP_POWER_OFF so I don't need any card detect
enabled and there is no need to rmmod the device.  A simple "ifconfig wlan0
down" will power off the wifi chip, and "ifconfig wlan0 up" will power it on
again.

NeilBrown


--Sig_/GQgije3B0oAxioHnxWBKuqB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT5u9hznsnt1WYoG5AQKZ8RAAlopAU1BYfZ4NXeC7Ti8W48jCNTmeNz0U
slaiLwidvSp8wj/zr87F1pemOi4JMrY4pvRnfhm49hjvVLJA5TozjjA3H0kciaY3
eIc5QyaDtioKWuC4nw1stSYG1/X5xJJUBiHJC7T0ciiM63AaDefa6cCQpYytizmo
MwdsnsYueoHBTop41+UlEboc4rdxPRkEZVW1A77AfrxWW6JEfFhLOVQZOOTESElI
wYwo0LgzXZstqnknJxtb2LSEPVLn/Xzow/2wJ5vuoVrI3CGERX+k2nSRES7jhsjs
1raMoH1EXD1OmRoeLTPVIfQOgPV7PuN2Tdo47jaACeup9KMhe2PP89xOs6BRQg5H
3ZX/MEnG3q5Avbc6LvPIq7xglHoHJsetnKhcgSfOrEVMqnWpwRlfXPQA4l/VL0H1
38cTFMuBz60awnp1seE/40Qc6zVGz8VIBVpOO447bKwDQFho3+gwy3Kth3sSL9QT
8c77myUa5Y4SPlCj0ZnImbG+P9EtT/Dx209/Z3nGvU1+4MNFndHwfaY5TtNaRkEw
KzgO3Gbm9Rk0aXyPNhst0sFEgWHXCpPjCz3pwLtMy4/d2ZRuDaKhYrHLaN1oKMDb
M4c49WtADI7oavKpIS8YU2BjToahp0floX8KGhRWMncVlIHjG+sKNjyX56CuDy5l
4ilt+2c7XBo=
=URLQ
-----END PGP SIGNATURE-----

--Sig_/GQgije3B0oAxioHnxWBKuqB--
