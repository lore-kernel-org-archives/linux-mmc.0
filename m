From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 0/13] arm64: allwinner: a64: Enable MMC support
Date: Fri, 27 Jan 2017 22:27:06 +0100
Message-ID: <20170127212706.c65js5aw7itugfky@lukather>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
 <e4133504-8bc7-a9ac-209d-3d8cba119fed@heig-vd.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bftvt4nsmv4cs76e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e4133504-8bc7-a9ac-209d-3d8cba119fed@heig-vd.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Vaussard <florian.vaussard@heig-vd.ch>
Cc: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org


--bftvt4nsmv4cs76e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Fri, Jan 27, 2017 at 11:37:27AM +0100, Florian Vaussard wrote:
> Hi Maxime,
>=20
> On 01/26/2017 10:05 AM, Maxime Ripard wrote:
> > Hi,
> >=20
> > Here is a new attempt at getting the MMC controllers running, following=
 the
> > work done by Andre.
> >=20
> > This has been tested on a board with one SDIO device (a Marvell WiFi ch=
ip)
> > and a Kingston eMMC with 1.8V IOs.
> >=20
> > For SDIO, the HS DDR mode works just fine. That serie also enables the
> > SDR104 mode to work on the devices that are capable of this.
> >=20
> > For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> > moment, but since it's significantly more complex, and at the same time
> > Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> > any benefits. If there's any at some point, this can be added later.
> >=20
> > Let me know what you think,
> > Maxime
> >=20
>=20
> FWIW I tested this series and got decent throughput (190 Mbps in UDP) wit=
h a
> Marvell SDIO Wifi chip. The board becomes unresponsive between 30 to 60 m=
inutes
> of iperf torture, but I strongly suspect a hardware issue underneath. Fee=
l free
> to add my Tested-by on the MMC patches if you need it.

Thanks for testing!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bftvt4nsmv4cs76e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYi7spAAoJEBx+YmzsjxAgs0QQALFIKvXGwhYyU7w1qwSGeZ84
vNIWGfGtu/N2Uc2g/pTo+laJViZ7UUmMhwPcIfiI0YmN6iEs0Vl1FxDy7aO/+75O
X1gdmwVwMMD8eHTtnBCT0I9IJ3LGQEB+LW4wrEwyv5jNmPc+VScD4kknC3Ngq5ry
7QPJc47+zpi1ChAGSzV9er1LamLAC5EyzHwVn2McAToJsQc5WEOvJCiHh+XZgV6N
fbNfVCMDQZMmFQiHsMS7s10T70n/YcDEpWZUq1KMMr7gP5L5B4dZ12EjLU7vjVF1
UVqmV6uBEVEzo9dpsBmeJaSeIZNb5KG4RnY92p1f3OHE4gUji4c1+0J3e0vw/rQn
xZjqd+OS6NmGG0BdgfnXBI+0SUJ8nkd2kPrAF9NBhBe83QGhX59TP8kxbSIVgAuN
RNOpbtSHDWWQ2XTWcEI7T2Z8wUHJWDeKFC1IYREaXywGGGxLmVU7chlZXkVmcxA2
xH6gAoZE71+W8QaI9/H+uI9idQtwP2bpFR4EvqPBaNxKzfV07GgRZmBBdrpdhV6T
pWsqoixxWoYzKcvjRlW0efcVKCGUV37ceyGu/Wc8Ypz8KMVBcTj84VJIn6ZVdvYy
zsy6S6zFq6/99ID+60A2JqZmp+1tG6uSVvJfwpiwhrUA2RnXbAkYLicbFlmaownf
Y2SWqBm+QyWvAzqOmrph
=nWp3
-----END PGP SIGNATURE-----

--bftvt4nsmv4cs76e--
