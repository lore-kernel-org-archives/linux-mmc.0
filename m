From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] mmc: core: allow a reset gpio to be configured.
Date: Fri, 28 Nov 2014 14:45:58 +0000
Message-ID: <20141128144558.GN7712@sirena.org.uk>
References: <20141108000919.5629.55381.stgit@notabene.brown>
 <20141108001411.5629.25179.stgit@notabene.brown>
 <CAPDyKFrx98NspRU1nV3uJ6XwTuA4tZQkrYTfDoeXGR+f5htODQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h73OigHGubxJv9Jx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrx98NspRU1nV3uJ6XwTuA4tZQkrYTfDoeXGR+f5htODQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: NeilBrown <neilb@suse.de>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org


--h73OigHGubxJv9Jx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 28, 2014 at 12:56:33PM +0100, Ulf Hansson wrote:
> On 8 November 2014 at 01:14, NeilBrown <neilb@suse.de> wrote:

> > If the regulator supplying an SDIO device is shared
> > with another device, the turning the regulator 'on' and 'off'
> > will not actually cycle power and so will not reset
> > the device.

> > This is particularly a problem for some wi2si wireless modules which
> > have a BT module on chip and can share power lines.
> > Without the power-cycle, subsequent reset commands fail.

> > So allow a 'reset' gpio to be specified.  If provided, the
> > line is asserted during power-up.

> There have been several attempts to fix similar issues as this patch
> does. The latest one I posted a few month ago, which wasn't accepted.
> http://comments.gmane.org/gmane.linux.power-management.general/46635

Note also that if the issue is about needing to take different actions
depending on if the power actually got pulled you can request
notification from the regulator API when things actually happen.

--h73OigHGubxJv9Jx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUeIqlAAoJECTWi3JdVIfQPKcH/1dJqUWpSHTA5HKz0w05Y7GY
WAlWW21PWs6zAQUY1NC3Aoa/z5R5KA1QB/FS0LKAxmnWOncn5N0+9Pp7tpllhNSt
Nl8/kgFvx37OrWzfHoQy5J+zY87man/mwc8FKZAjLo7+yuQwMibZIO8JYpA/w5Aa
iEE+JakEuU8Q1EQjji/jspzkxNuBXbPgE+mleh225zIaWDS/jjeVRoYyXtMizgwU
U4qZ6gd2e2SOEeQVPaipDM1r3+4tnZtC2OX7oRqxphNUxDrbBa1tkKP1xdpA+urV
YhL6DaNsm9S0dTDSGZZTld0dP8V3T4UWtpMnNo6sdVmrtfe4PrIJ0hGmt4jJFwY=
=2Zhc
-----END PGP SIGNATURE-----

--h73OigHGubxJv9Jx--
