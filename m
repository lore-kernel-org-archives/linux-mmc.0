From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Wed, 07 Dec 2011 12:28:51 +0000
Message-ID: <WC20111207122851.07076E@terrafix.co.uk>
References: <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com> <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com> <WC20111130150051.910209@terrafix.co.uk> <CAK=WgbbBF1=YJyc2MF2fgNtPbbqF=-9L53=LKoEmkgA43PjSdw@mail.gmail.com> <WC20111201112805.3502EA@terrafix.co.uk> <CAMLZHHSGL20vr7E1rMO47RsxOmO-UPRyOdnqq=DUie3FVzNcaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:43869 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755763Ab1LGM3H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2011 07:29:07 -0500
In-Reply-To: <CAMLZHHSGL20vr7E1rMO47RsxOmO-UPRyOdnqq=DUie3FVzNcaQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Right, a bit more information.

=46irst I tried just adding delays as suggested:

# Delays in core.c:mmc_power_up() increased to 1000.
# Delay in core.c:mmc_power_off() increased to 1000.
# sdio.c:mmc_sdio_power_restore() modified to add delays.
=2E..
	msleep(500);
	sdio_reset(host);
	msleep(500);
	mmc_go_idle(host);
	msleep(500);
	mmc_send_if_cond(host, host->ocr_avail);
	msleep(500);

	ret =3D mmc_send_io_op_cond(host, 0, &ocr);
=2E..

And there was no improvement (it slowed down the probe a lot!), so I tr=
ied again with much longer delays (3 seconds rather than 500ms) and sti=
ll no change.

So I added control of the nRESET line in sdio.c:mmc_sdio_power_restore(=
).
=2E..
	gpio_set_value(16, 0);  /* GPIO16 is the nRESET line */
	msleep(10);
	gpio_set_value(16, 1);
	msleep(100);

	msleep(3000);
	sdio_reset(host);
	msleep(3000);
	mmc_go_idle(host);
	msleep(3000);
	mmc_send_if_cond(host, host->ocr_avail);
	msleep(3000);
=2E..

and things sprung in to life, well sometimes! Sadly this only worked in=
termittently, and only with longer delays.

I guess this may not be a suprise, as I'm force resetting the card but =
not doing a full "probe".

I'm afraid I can't probe the nRESET line as the SD8686 is hidden under =
a shielding can, and I don't have the schematics for the GUMSTIX Overo =
to be able to=20
look for the signal anywhere else.

With the SD8686 only working every now and again with the nRESET contro=
l it's difficult to make progress as I'm stabbing around in the dark - =
I never really=20
know if I'm improving things or not when adding/removing timeouts etc..=
=2E

Previous kernel's never had runtime PM enabled, so I'm not sure what yo=
u mean to compare there?

Whatever procedure is first applied to the SD8686 with runtime PM disab=
led works 100% of the time.

Does anyone know if OLPC keep any out-of-tree patches to make runtime P=
M work for them on the SD8686 (maybe fudging GPIOs or similar)?

Cheers,
Joe



-----Original Message-----
=46rom: Daniel Drake <dsd@laptop.org>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Chris =
Ball <cjb@laptop.org>
Date: Sat, 3 Dec 2011 10:44:18 -0600
Subject: Re: mmc: sdio: runtime PM and 8686 problems

> On Thu, Dec 1, 2011 at 5:28 AM, Joe Woodward <jw@terrafix.co.uk> wrot=
e:
> > I've had a play with the nRESET line (as far as I can tell it is th=
e
> only pin I have access to), and no joy.
> >
> > Also tried playing about a bit with the CMD sequence, again no joy.
> >
> > I'm not entirely sure of the CMD sequence. It seems we get:
> > =A0- CMD52 (x2)
> > =A0- CMD0
> > =A0- CMD8 (fails)
> > =A0- CMD5 (fails)
> >
> > In the "SDIO Simplified Specification Version 2.00"
> (https://www.sdcard.org/developers/overview/sdio/sdio_spec/Simplified=
_S
> DIO_Card_Spec.pdf) page 6 it
> > seems only a CMD52 should be required to "Re-init IO". Previous
> thread posts state CMD5 (x2) are required by the 8686, but why
> CMD0/CMD8?
> >
> > Incidentally errors only occur after the CMD0, but before the first
> error we get (i.e. a change of cs from 1 to 0):
> > "mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0
> timing 0".
>=20
> Can you see how this compares with older working kernels?
>=20
> Some more things to try:
> there are some delays in mmc_power_off - try increasing them to 1000.
>=20
>=20
> mmc_sdio_power_restore does:
> sdio_reset (cmd52)
> mmc_go_idle (cmd0)
> mmc_send_if_cond (cmd8)
> mmc_send_io_op_cond (cmd52)
>=20
> These are the commands you have been looking at from the angle of the
> logs.
>=20
> Try sprinkling in a load of msleep(500) delays before and inbetween
> those commands. And if you suspect some of them are not necessary
> trying removing them, etc.
>=20
> Non-scientific but this is how we have got things working so far :)
>=20
> Thanks,
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


