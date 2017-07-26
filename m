From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 00/10] ARM: sun8i: a83t: Add support for MMC
 controllers
Date: Wed, 26 Jul 2017 21:45:22 +0200
Message-ID: <20170726194522.7d64f7c2danrknfi@flea>
References: <20170724135905.28855-1-wens@csie.org>
 <CAGb2v66DQ3H2Mta7h+t1P+UzSRLnMABRebeYcopaPkN0gOiwxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t4p4sc5v3likqkxq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66DQ3H2Mta7h+t1P+UzSRLnMABRebeYcopaPkN0gOiwxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--t4p4sc5v3likqkxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 10:09:41PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 24, 2017 at 9:58 PM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> > Hi everyone,
> >
> > This is v3 of my MMC controller support series.
> >
>=20
> [...]
>=20
> > Chen-Yu Tsai (10):
> >   clk: sunxi-ng: Add interface to query or configure MMC timing modes.
> >   clk: sunxi-ng: Add MP_MMC clocks that support MMC timing modes
> >     switching
> >   clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
> >   mmc: sunxi: Support controllers that can use both old and new timings
> >   mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
> >   mmc: sunxi: Add support for A83T eMMC (MMC2)
>=20
> So this series seems to be ready for inclusion, unless Ulf has further
> concerns about the clk usage.
>=20
> The first mmc patch have build time dependencies on the first clk patch.
> Shall we put the clk patch on a separate immutable branch for both trees
> to pull? Or we could just merge everything through the mmc tree? I don't
> think we'll touch this part of the sunxi-ng clk driver for the remainder
> of this cycle.

I guess the easiest would be for it to go through Ulf tree, unless he
says otherwise of course :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--t4p4sc5v3likqkxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZePFSAAoJEBx+YmzsjxAgJJEQAMAPkqxIgWt5zhdvRBodODdm
r8UKPzetUTraLKvZ1U8hzOQ5jMlEAC8hjWO+RNcwE6xp9/uQaqBXrMLiZFEAe8HQ
6+rwxwtEjO9y9DrYC7EWS1pv7NoewULPIjhXBMHcb7EhpSo+Yy9UHF4iy2/EzJcl
AWAP1nVPGlyzcCUbG1Ace2WH+1PWjpkz9HXJHxVcRqJtOx7TkQrhZFKwXCMDmyYJ
K8P+wexUpDF7eAlZ5ZMkwmzmIA6qYRSTl5kM3y0iHIv1QI2ypMXAPupw9UondAE+
KAJzWR0fzq9hh+bf63onGA4z5xc1h8ULDAPaOUsEIvhlUsWNcNP8FP3ZRyP/HflC
MvRjUgFUmtCaREjXHUzSivkPoATm4tWp4nxX8tKzhANJFBwfRf0MsneMaOgKuHgl
de7CTGPEDmqumyZU8n7d/lyrmpESFFadF1E4BSDnMgxnLAWsjQvt9C2KYcRi8Mbv
wLT5c7ezeaoyE0ubsLJrqHTx/Z3VbrCK4U2aXKLLk2OjKbmJyr9xAoTmOl+rPCQx
eDLxzk03P84VqXpprSDtaPlEowyhEncdpKzSIiA7lFEedT0No0pJ90hOXWQBW2zC
udU5tzD9yDlTD/jnF+X67T8ixNYv0jWWId/7UfeRuEqYzVVy9b4p1PpAdnKBbepj
C6VA8IuvJreF7bkpdIO9
=VcM4
-----END PGP SIGNATURE-----

--t4p4sc5v3likqkxq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
