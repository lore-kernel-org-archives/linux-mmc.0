From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/40] soc/tegra: pmc: Implement pad configuration via
 pinctrl
Date: Thu, 9 Aug 2018 15:12:11 +0200
Message-ID: <20180809131211.GA21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
 <20180809122706.GT21639@ulmo>
 <20180809154412.4e7fe9b3@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ELawpaRm0uGyL1wg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809154412.4e7fe9b3@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--ELawpaRm0uGyL1wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:44:12PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 14:27:06 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Aug 01, 2018 at 07:32:00PM +0300, Aapo Vienamo wrote:
> > > Register a pinctrl device and implement get and set functions for
> > > PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  drivers/soc/tegra/pmc.c | 187 ++++++++++++++++++++++++++++++++++++++=
+++++++++-
> > >  1 file changed, 185 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c =20
> > [...]
> > > @@ -1704,6 +1863,12 @@ static const u8 tegra124_cpu_powergates[] =3D {
> > >  		.name	=3D (_name),			\
> > >  	})
> > > =20
> > > +#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> > > +	((struct pinctrl_pin_desc) {			\
> > > +		.number =3D (_id),			\
> > > +		.name	=3D (_name)			\
> > > +	})
> > > + =20
> >=20
> > Do we really need the explicit cast to struct pinctrl_pin_desc here?
> >=20
>=20
> No, but I prefer to have it as it makes the type of the value the macro
> expands to explicit. In a way it hints at how and where the macro should
> be used and arguably improves readability.

It's a rather uncommon pattern in the kernel, and most issues are easily
caught by the compiler.

But it's fine with me if you want to keep it.

Thierry

--ELawpaRm0uGyL1wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsPasACgkQ3SOs138+
s6Ft+Q//ZlGl3OuUBrz8aBjmgApj4optY/PujiMt8F0ObC/Br+s2gQVJPYmrhI4q
dR2ARZaVA9Br9Fkq5z5zRkD6YDle07p9kj7RjSrVdXnMbCM4dNspfD04XBmveqsT
6wtaJinLd9FVF55UkLGApwL0dlMq06fyu1947GOMmFTAVlrKkS7LT5AtQICgX9Yr
FJVVYmVF8ZKtJphokEhdtlbu6ZV/jiqVDyWKWEY2bPaJx/4rUcGbZNKar4BYOuXu
6fNSPJ6umDXNsUJwwheGd0r+1na75zGm/Zd6cCvtI0BjVh/xpKzfF8A5FzOYKjfM
M5Rr0lDilDqI1tcr5vIiZiI+WLV+Bkr/ZfC96+usHibkESiC+Ow5J1v8kbjPOmiT
16xHCwAHDUwvkmYCrolw/sf1m0RsWweIC+y0BOl4meBbhMkLQDUhBG6TxPTU32+/
0U9jw9d9iIDOWsqMKzjGhB9WmvPJO2w720wQtRCn2nX6lR+ROmlT/BGZWujXN730
CBHnx+LbL7pw4GrhYf1EfY8E+YgVZA6Ql3Uyb6Z7/I7UNyH9MMjyPH1HnuET1nst
wBUtAQSNLXqgVdtZ4p3ryfMfu0PhNmgbjrnBgbSGDOmOcQJHquRWqiWn1uPPe7od
c8VLH5COAFJuZmthAtG/RW/vQxsH1vkqqnkxlVxKZE/ei8bqLl4=
=lAWZ
-----END PGP SIGNATURE-----

--ELawpaRm0uGyL1wg--
