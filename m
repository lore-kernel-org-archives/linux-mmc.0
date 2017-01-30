From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v5 0/13] arm64: allwinner: a64: Enable MMC support
Date: Mon, 30 Jan 2017 12:06:29 +0100
Message-ID: <20170130110629.i4q73p5svvd7nly2@lukather>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bi5wtywif5bmdxgc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org


--bi5wtywif5bmdxgc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 10:38:32PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> Here is a new attempt at getting the MMC controllers running, following t=
he
> work done by Andre.
>=20
> This has been tested on a board with one SDIO device (a Marvell WiFi chip)
> and a Kingston eMMC with 1.8V IOs.
>=20
> For SDIO, the HS DDR mode works just fine. That serie also enables the
> SDR104 mode to work on the devices that are capable of this.
>=20
> For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> moment, but since it's significantly more complex, and at the same time
> Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> any benefits. If there's any at some point, this can be added later.
>=20
> Let me know what you think,
> Maxime

Applied the DT bits with Chen-Yu's Acked-by.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bi5wtywif5bmdxgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYjx41AAoJEBx+YmzsjxAgQ6EP/RxQXfQC5HXfdQXN7aGpTTc1
3rckLrjgL00SxHwjKw4jTTrBlWycGpmLO668z3xZ7dXkdPHkaR56161U78BqELop
CYLGTjhPbZjvCvPugwZ/u7QlADiaTwVUhKwmkI5pxeU7ARtLRfhNYbyaUpZmyFXy
rAPosMb1/D45dwvGC8pKxj1gHOB3O4c3gtr+1mpKkHFlKeJBa7VVsiUN6cBbNr3G
rSWKzEHOD6+P7ICTvrv2Mxu6dgfE7TMX8fZH3dnYBAdFeN00XUCjVe6qZR+p7Ltf
mr5Cf4WI/DKjOWubJnJaUSxkVqcc9TrndGpcHrXQfCzE+jpcuq3GuML9JTiKuZyD
crjLG5i3X7p+Fcs+PZt63Ewca2K5/DggxCkYPBFIRalPlf/PidDTrCSFqFS5yere
6Uo1QIVEDEITu1JLtfxMNaH6HWV/1T8NuALVGeKyJ3aVJGiGZocituYtPod6EkK8
R8p1XxqPhvINHGJJ6eCdRcLa1Hzu3Y7DXHJnZFfkssQddutBM32uZsB1ePnrr4Iy
VKh1iMCcHUVO/Nu4mmF9NrWXEdfm/W7eu2e5W8ldLj3rudFtxpXkdt+dgTfLwPxV
CSx/011wP5XCELMCmPeUf10M2M/Oumiiy72D3DmulE5ekwasDQiduDbDFRaL/Srr
NBDru2cOhgj7uYtTrGln
=wzRI
-----END PGP SIGNATURE-----

--bi5wtywif5bmdxgc--
