From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v5 0/13] arm64: allwinner: a64: Enable MMC support
Date: Mon, 30 Jan 2017 11:42:18 +0100
Message-ID: <20170130104218.34zftrdyr3m6422w@lukather>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67stC=EaFMpTSrOirSqQL6r_jPDKsKQNishb=8g=278Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bnkpovf32onb7nkm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v67stC=EaFMpTSrOirSqQL6r_jPDKsKQNishb=8g=278Gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org


--bnkpovf32onb7nkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 28, 2017 at 08:44:02PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jan 28, 2017 at 5:38 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > Here is a new attempt at getting the MMC controllers running, following=
 the
> > work done by Andre.
> >
> > This has been tested on a board with one SDIO device (a Marvell WiFi ch=
ip)
> > and a Kingston eMMC with 1.8V IOs.
> >
> > For SDIO, the HS DDR mode works just fine. That serie also enables the
> > SDR104 mode to work on the devices that are capable of this.
> >
> > For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> > moment, but since it's significantly more complex, and at the same time
> > Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> > any benefits. If there's any at some point, this can be added later.
>=20
> Whole series is
>=20
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>=20
> Seems that we don't need to increase the signal drive strength for eMMC
> on the A64? This is probably a good thing.

=46rom what I've seen, Allwinner still recommends using a 30mA drive
strength, so that doesn't seem needed.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bnkpovf32onb7nkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYjxiGAAoJEBx+YmzsjxAgTuAP/jjm2VHtkP/VYLVgP/Vu2TvF
fx1dxsUId1CNVOrzPEkYY2g/DJZNkj8HTEU7wKm5z7u6cEaBDhhtyFwyZvX51IbU
FK0ECrJsaZbL0dCkhjxUnU4W0fqrXmVk302iTaxzIt68L13/P9ddWJvuwy9ZShTP
Ai7eoKdlVG3V2wFlr2S3RaaPD9n6Nt/2XExdN1J2EhC989iRyTrIxoCFL0EgVkkj
tDCpgTXebtx53NSLgQBykDuQWXr2tZ4V+hcUub0isFRdgXdKJGk1lH8ogf+HhocK
Q1lA2mzRqh4neTbwEz5uESOaWRiUUdeFPojKkwwTEK37Ecphu232h92KFBb/W/gA
euv+x0fjmDnG0cEHqmp91VgQFv//FyAvzeUmUURdhwh6JsrkBFd/lTDcDe4s0U73
E3X2SegrlEZ1RBe10M32bNFjmtv40WJ/EQ1VDwHtw1M7ZPdXJ0liGBAzWyF/bt3P
CUkVlEyldL4crxZ988Z8GSV2TeHh0ppndmPPYrCLnkfVwyphLrggfsRyAMmaD2q9
rlfYF+4oP9iRYDPrrNlAmwu4O5r3PZvlwRnmafzzLLx3/ogcilog+JEQIrjpmFw6
VxyzT+IPzkgM1ohe8nXVxCYMCAk4t693ORN4BA1Tr2XYPDpzO+9NBrtsWG1cERjs
MFAVH/8s4Vb3zjIGJbuk
=6ypb
-----END PGP SIGNATURE-----

--bnkpovf32onb7nkm--
