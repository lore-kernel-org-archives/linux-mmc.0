From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 3/13] mmc: sunxi: Always set signal delay to 0 for A64
Date: Wed, 25 Jan 2017 10:10:34 +0100
Message-ID: <20170125091034.2cwnq7g72fndhuqz@lukather>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <67fd7dad745b49bb8edb7391655eaddf6f35160e.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFoatUWz0AwY6e73OCguDx70B1B5OAoPUYX-JDPsru+aZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwly4umxqaau2v7z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoatUWz0AwY6e73OCguDx70B1B5OAoPUYX-JDPsru+aZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--uwly4umxqaau2v7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, Jan 24, 2017 at 09:16:12AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Experience have shown that the using the  autocalibration could severely
> > degrade the performances of the MMC bus.
> >
> > Allwinner is using in its BSP a delay set to 0 for all the modes but HS=
400.
> > Remove the calibration code for now, and add comments to document our
> > findings.
>=20
> So doesn't this break some platforms using HS400? Or are you saying
> those are already broken?

Like Andre said, HS400 isn't supported at all, so there's no
regression or brokenness involved :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--uwly4umxqaau2v7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYiGuGAAoJEBx+YmzsjxAgTSUP/3L0a4eEBq+bdw1/18luKR57
9JXbObOx0ofgsmfSacxBQQxKGACsnvaRZ8ZyKUN7jDCTKJ6ZLnuKLUXF344XiHa+
DvZt1d9nA9qjdXdas/0u3x2m5LXJeL+Jp6D1NGaNqcIqnNYHdKuqRC5l7VmjPqJa
JIeUO9Nsi+i/2lwEFQ9Fsay8Imy3rUCYNduEhKe5Ix9uqtAfm1/p9CX/nKS69IHo
OlRMIV1lF+qyyI4enPC46nI2IGA1GI8hQu0aTXfOf+5Uq5sEH0ZrUVp00D7Rb6Q9
xJK98Rh9BKv7tkeN7Cv7FUbjj43Zk75J0VCJP/kb5P/H6w+ytFjkfhj7M6EGk9xW
zrfnDr+YkLKoKWh6Vl7L/jwSlkxp8HBYe3HEE0URNtmBuWMxiGGyBjNHkq83aXNQ
IpvuXANamb1yPAiavq5ssKmAR3FZz9EaRjK0dMdDanVe1TXaCzdEBSMl148CKrZp
ODoYocxvRkd3y7klK0qfb3ekHCXJ/KAqKk7ihS91CzV3s7z4hkXUvWWwiUnGkzYl
VPeEL/8NUeQBXNCwblVpqKI2SjMfgKdI2ZEvNwdW5IEvjhmm1pCPMQxec5GQ6Iym
oNTr5m+1Ul+bu9XeG6c5AQ+G9ZJK1sWTu4EDJEKm6l17ixF9XLZlkscJyiRhj05o
BHhUg5AA/lUQs1VpKhwH
=qsRX
-----END PGP SIGNATURE-----

--uwly4umxqaau2v7z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
