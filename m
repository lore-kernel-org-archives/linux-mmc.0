From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/8] mmc: tegra: Implement HS400 enhanced strobe
Date: Thu, 9 Aug 2018 15:47:54 +0200
Message-ID: <20180809134754.GE21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
 <20180809114345.GL21639@ulmo>
 <20180809152254.03b97af0@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SqEuGDw53xMPnx3c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809152254.03b97af0@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--SqEuGDw53xMPnx3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:22:54PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 13:43:45 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Aug 07, 2018 at 04:59:59PM +0300, Aapo Vienamo wrote:
> > > Implement HS400 enhanced strobe. =20
> >=20
> > Can you provide a little more information about what the impact is of
> > this? Does this increase throughput? How much?
>=20
> The eMMC enhanced strobe is a mechanism that can be used instead of the
> HS400 tuning procedure. Note that the delay line calibration implemented
> later on in this series is Tegra specific and has to be performed
> regardless of which type of HS400 tuning mechanism is used.

Sounds like a variation of that would be good material for the commit
message.

Thierry

--SqEuGDw53xMPnx3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRgoACgkQ3SOs138+
s6Ek9g/8CIOFqwrTD09B0L2yVYz5rSYuD+fJvJACIETWJSNe4V/jUUsvRnGbCkhm
92ZLz6diFCrz5/uX/cJAdnbVcSyOjqidVkpJzPlZLeyx0V2q8Gobee0+AuSMHVub
5WZOms5ZPZhx38G+x7TTwA8p8gtVtoQtAHnDTZU0EhxXyD75YGrUk22bYvXRKSbC
UumCFuJDmghSAfbahN6bRO/6zbCU1iWCzah4GktlUC88jmtdpLBtue93rGNYthGp
Dl81TPu43QvOw7/GSGGNWY4cDdjoVon1RUH7dwgA8OY3OnLv33oOLNY9nr5E38PN
xvJiwMko3YWyIW3/sFmfG91Q0rKQj7b5rCe8kgVdD1wVu8ISMt/uxTos3cwu/j6y
1c58NWO19sVDPil0TovPqiSb5GBfRZAVSVAhAHYx2aqmEiKvx2/plkvO7fy/J/B3
OVyHepxiBUURyxNIjPUvUXlhDQ2/0FnoENyZ/SWW/bvWmXzScIq4DODwuF2kOvEO
lLTNPwVkm9oAhmgY4o396ZhomYI9xMUXb63ozdPdVzKXl3EcinQL0W9B1ysF6ixs
HvpZN/kp4tEx7/zQ153vPW+4/B4SfwnqvJX6fHP8KcdZAtDVD2/3FTW6aDdAi+vE
2DL+KGaenRGQ6WAmhFS9CQomXMvP2ELO/dF9ph/H+5sof76udWo=
=Q54M
-----END PGP SIGNATURE-----

--SqEuGDw53xMPnx3c--
