From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 03/12] clk: Add a function to retrieve phase
Date: Mon, 29 Sep 2014 10:24:21 +0200
Message-ID: <20140929082421.GA4388@lukather>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140928001732.19023.2496@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44556 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751352AbaI2IZF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 04:25:05 -0400
Content-Disposition: inline
In-Reply-To: <20140928001732.19023.2496@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Sat, Sep 27, 2014 at 05:17:32PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-09-11 13:18:17)
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
> >  drivers/clk/clk.c            | 10 ++++++++++
> >  include/linux/clk-provider.h |  5 +++++
> >  2 files changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index d87661af0c72..113d75db371d 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1934,6 +1934,16 @@ int __clk_init(struct device *dev, struct clk *c=
lk)
> >                 clk->accuracy =3D 0;
> > =20
> >         /*
> > +        * Set clk's phase.
> > +        * Since a phase is by definition relative to its parent, just
> > +        * query the current clock phase, or just assume it's in phase.
> > +        */
> > +       if (clk->ops->get_phase)
> > +               clk->phase =3D clk->ops->get_phase(clk->hw);
> > +       else
> > +               clk->phase =3D 0;
>=20
> I probably wasn't paying enough attention to this. Based on the
> coverletter I thought that v3 would introduce something like
> CLK_GET_PHASE_NOCACHE and stuff that logic into a __clk_get_phase
> function? Looks like this version of the series doesn't handle phases
> that can be changed by hardware (e.g. coming out of idle).
>=20
> Correct me if I am wrong, but it looks like we retrieve the phase only
> once at init and then never again? The rest of the time we rely on
> clk->phase to always be accurate...

Yeah, I didn't have any use for it at the moment, and thought that if
someone ever needed it, it would be trivial to add, so I left it out.

If you want me to still do it, I can send an additional patch.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKRc0AAoJEBx+YmzsjxAgFjMP/3W5ySXsZdvc15BwNwW4RnBL
ZjEkQnwT3LckyxBDv/p1D5Yy4c9bp7mhhPecX7UzUbfDSS9UEEGctX8G/VBaJpBX
vtTKDAb/bxt5TYcCR1hCs39kHUCfATWs9bM3fMrQWCxvlZRmR/ybNLGgHe3GNNWo
LIZNzEwpi6ILafMlxmnzrFviTEO32jSTBec3agIBFTip2y7AeLgELQbbFxYNm+oi
cCvt8hTDhLr6uPVm7S4zN+4wFxNSQnNNayk1UQBtP8J1WjeKLkSNWWcKSKOQaCjk
taUfM0sp+OQdaGxhA+4VrXOXIgGvELEj1nDi0IZUuh7JDw05nzLfCMzohkgKe81u
JWTNJI/+I6ccvcvXmICjDSmhNFDJDiIXTAekLMsMljpUm9BJS97RVpYYPOGmq3DJ
E7xQnIpRBw7HD77GUqOQoprbeid4q7Sk6WMkxt1C49pmWoS8IUhXDDOd5T/tuemk
9B8GA7/DB3A1njizphherUd/IjUaZcj26qDQD1h6zO8M97cbED2a6LnglaU3UAvO
jGnwKEeycqU3KFJVZN1CyEZOs8yO61qvMKRbwDyx7gpJ0kL2N3/NVleIVoKBcqeO
0FYTrKYMCSAiIZDIW2AhHFobAW9Fp3V0a9ysuWweSrqBBQ1pE0trtH0Qc1VGo2Rc
dQThU2sL8e2tFa6uIhYh
=iMF7
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
