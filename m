From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 03/12] clk: Add a function to retrieve phase
Date: Tue, 2 Sep 2014 11:34:28 +0200
Message-ID: <20140902093428.GS15297@lukather>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140901190054.5251.56409@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zVHGwpeVr3D20HrI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36541 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752643AbaIBJfS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 05:35:18 -0400
Content-Disposition: inline
In-Reply-To: <20140901190054.5251.56409@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org


--zVHGwpeVr3D20HrI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 01, 2014 at 12:00:54PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-08-30 13:03:02)
> > The current phase API doesn't look into the actual hardware to get the =
phase
> > value, but will rather get it from a variable only set by the set_phase
> > function.
> >=20
> > This will cause issue when the client driver will never call the set_ph=
ase
> > function, where we can end up having a reported phase that will not mat=
ch what
> > the hardware has been programmed to by the bootloader or what phase is
> > programmed out of reset.
> >=20
> > Add a new get_phase function for the drivers to implement so that we ca=
n get
> > this value.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/clk.c            | 17 ++++++++++++++---
> >  include/linux/clk-provider.h |  5 +++++
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index d87661af0c72..7dbceca694f1 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1797,8 +1797,8 @@ out:
> >   * clk_get_phase - return the phase shift of a clock signal
> >   * @clk: clock signal source
> >   *
> > - * Returns the phase shift of a clock node in degrees, otherwise retur=
ns
> > - * -EERROR.
> > + * Returns the phase shift of a clock node in degrees. Any negative
> > + * values are errors.
> >   */
> >  int clk_get_phase(struct clk *clk)
> >  {
> > @@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
> >                 goto out;
> > =20
> >         clk_prepare_lock();
> > -       ret =3D clk->phase;
> > +
> > +       if (clk->phase) {
>=20
> So if a phase is zero, then we fall through and query the hardware?
> Seems like this case might be hit a lot for clocks that implement
> .get_phase but never have their phase shifted, and accesses to the
> registers may be much slower than to memory.

Yep, which is exactly why I'm not that proud of it :)

> Do you expect the phase to be changed behind our backs? E.g. firmware
> changes it, or coming in and out of idle state, etc. If not then we can
> store the phase at clock registration time and use a cached value.

This is exactly what happens in our case. Since in order to use the
MMC, you have to change the phase of the output and sample clocks,
every time the firmware will have to use the MMC, it will change these
clocks phase. Which happens pretty much all the time.

> See how the CLK_GET_RATE_NOCACHE and CLK_GET_ACCURACY_NOCACHE flags are
> used for details on how we can handle the case where the phase might
> change behind our back.

Ah, yes, of course. Thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--zVHGwpeVr3D20HrI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBY8kAAoJEBx+YmzsjxAgFvAP/iBy2TuOu89Ml4jQV1gshfAW
NkGGtzAkrAzdfsmLVLPQphHU74fQvUxRcD1mK+/XkfIDUTy3bCd+K+gSmZpg9u3y
SmyBvVrebxu/HVh0KDN3lU+8tP7ZyB3/bggNyeuAeCLQ4BrqVmrbPZdpcqKj3saj
/h+g1ovzjVovOEVBoRjXn6G0yn8x7ByR1AMtfyckLQ8ZYm8eWraakpkPDS44JlFR
gu5U97nUIUdGiWSvm/xFp4vJJTvLJkKTXpSnuKI4etT2J9I0sdJQmNY0wM4wlHZA
JXPfYB0H9pyDRKUjNRcTdyTk7EYA6KBSPQ+h8G+ljJcS3fzr1m0hlnyR+7ja+JJW
tffqebg7xLGRFZWMzLAKoJ8kOrGoseoFsurWmvDu55d8XwBJypUs5C9lGF/KCXSW
K2k4MjU+oJEBprjjEf37LQEd0OFL6rIyURfXzpe6+uU05Ne70+9q9gjJG4NqAwhR
K7McBgLu+jEjKOezaShvrBOMin2XcR3z3c5xlN9VtEM+z8oa96jMe4UHRFgPQlGJ
Zq/zm9IJhwY9Lr+NKx8+pm/+4JW57z2UI9VE8L/InOqR1tVYa/9TuaObSH470iLA
4cdJscFKg5ok8L5qQDf0PS3QdWV5nJHSB9g13suqxCN93fN8+jmK2Nxv0xTy+RuR
s6IuFw9tbHjFIm5ywTvs
=Nltr
-----END PGP SIGNATURE-----

--zVHGwpeVr3D20HrI--
